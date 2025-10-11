locals {
  vm_name = "supernode-${var.supernode_name}"
  cores   = 2
  memory  = 2048
}

resource "proxmox_vm_qemu" "supernode" {
  name         = local.vm_name
  target_nodes = [var.vm_target_node]
  pool         = var.vm_resource_pool
  description  = "Supernode v2 - ${var.supernode_name}"

  clone      = var.vm_template_name
  full_clone = false

  cpu {
    cores   = local.cores
    sockets = 1
  }
  memory = local.memory

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "system"
        }
      }
    }

    scsi {
      scsi0 {
        disk {
          size    = "10G"
          storage = "system"
        }
      }
    }
  }

  scsihw   = "virtio-scsi-pci"
  boot     = "c"
  bootdisk = "scsi0"

  vga {
    type   = "serial0"
    memory = 0
  }

  serial {
    id   = 0
    type = "socket"
  }

  network {
    id      = 0
    model   = "virtio"
    bridge  = "vmbr0"
    tag     = var.vlan_id
    macaddr = macaddress.vm["eth0"].address
  }

  network {
    id      = 1
    model   = "virtio"
    bridge  = "vmbr0"
    tag     = var.batbone_vlan
    macaddr = macaddress.vm["eth1"].address
  }

  agent     = 1
  os_type   = "cloud-init"
  ipconfig0 = "ip=${netbox_available_prefix.primary_ipv4.prefix},gw=0.0.0.0,ip6=auto"
  ciuser    = "admin"
  sshkeys   = join("\n", var.vm_ssh_keys)

  define_connection_info = false

  lifecycle {
    ignore_changes = [
      define_connection_info,
      clone,
    ]
  }
}

data "netbox_cluster" "vm_cluster" {
  name = var.vm_cluster_name
}

data "netbox_device_role" "supernode" {
  name = var.vm_role_name
}

resource "netbox_virtual_machine" "supernode" {
  site_id    = data.netbox_cluster.vm_cluster.site_id
  cluster_id = data.netbox_cluster.vm_cluster.id
  name       = local.vm_name
  status     = "staged"
  role_id    = data.netbox_device_role.supernode.id

  vcpus     = local.cores
  memory_mb = local.memory

  tags = toset(var.tags)

  lifecycle {
    ignore_changes = [
      status,
      custom_fields,
    ]
  }

  local_context_data = jsonencode({
    dhcp_range = {
      start_address = local.dhcp_range_start_address
      end_address   = local.dhcp_range_end_address
    }
  })
}
