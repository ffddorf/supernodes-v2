resource "proxmox_vm_qemu" "supernode" {
  name        = "supernode-${var.supernode_name}"
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
