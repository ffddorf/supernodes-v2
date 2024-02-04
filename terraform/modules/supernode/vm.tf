locals {
  vm_name = "supernode-${var.supernode_name}"
}

resource "proxmox_vm_qemu" "supernode" {
  name        = local.vm_name
  target_node = var.vm_target_node
  pool        = var.vm_resource_pool
  desc        = "Supernode v2 - ${var.supernode_name}"

  clone      = var.vm_template_name
  full_clone = false

  cores   = 2
  sockets = 1
  memory  = 1024

  disk {
    type    = "scsi"
    storage = var.vm_storage_pool_name
    size    = "4G"
  }

  scsihw   = "virtio-scsi-pci"
  boot     = "c"
  bootdisk = "virtio0"

  vga {
    type   = "serial0"
    memory = 0
  }

  serial {
    id   = 0
    type = "socket"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  cloudinit_cdrom_storage = var.vm_storage_pool_name

  agent     = 1
  os_type   = "cloud-init"
  ipconfig0 = "ip=dhcp,ip6=auto"
  ciuser    = "admin"
  sshkeys   = join("\n", var.vm_ssh_keys)

  define_connection_info = false

  lifecycle {
    ignore_changes = [
      define_connection_info,
    ]
  }
}

data "netbox_cluster" "vm_cluster" {
  name = var.vm_cluster_name
}

data "netbox_device_role" "supernode" {
  name = var.vm_role_name
}

locals {
  size_constants = {
    G = 1024 * 1024 * 1024
    M = 1024 * 1024
    K = 1024
  }
  disk_size_parts = regex("^([0-9]+)([GMK])$", proxmox_vm_qemu.supernode.disk[0].size)
  disk_size_bytes = parseint(local.disk_size_parts[0], 10) * local.size_constants[local.disk_size_parts[1]]
}

resource "netbox_virtual_machine" "supernode" {
  site_id    = data.netbox_cluster.vm_cluster.site_id
  cluster_id = data.netbox_cluster.vm_cluster.id
  name       = local.vm_name
  status     = "staged"
  role_id    = data.netbox_device_role.supernode.id

  vcpus        = proxmox_vm_qemu.supernode.cores
  memory_mb    = proxmox_vm_qemu.supernode.memory
  disk_size_gb = local.disk_size_bytes / local.size_constants.G

  tags = toset(var.tags)

  lifecycle {
    ignore_changes = [
      status,
      custom_fields,
    ]
  }
}

resource "netbox_interface" "eth0" {
  virtual_machine_id = netbox_virtual_machine.supernode.id

  name        = "eth0"
  mac_address = proxmox_vm_qemu.supernode.network[0].macaddr

  tags = toset(var.tags)
}
