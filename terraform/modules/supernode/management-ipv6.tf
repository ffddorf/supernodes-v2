data "netbox_prefix" "management_net" {
  prefix = var.management_prefix_ipv6
}

data "iphelpers_eui64_address" "supernode_management" {
  mac_address = proxmox_vm_qemu.supernode.network[0].macaddr
  prefix      = trimsuffix(data.netbox_prefix.management_net.prefix, "/64")
}

resource "netbox_ip_address" "management_ipv6" {
  ip_address = "${data.iphelpers_eui64_address.supernode_management.ipv6_address}/64"
  status     = "slaac"

  description = "Management Address ${var.supernode_name}"


  tags = toset(var.tags)
}
