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

  virtual_machine_interface_id = netbox_interface.eth0.id

  tags = toset(var.tags)
}

resource "netbox_primary_ip" "supernode" {
  ip_address_id      = netbox_ip_address.management_ipv6.id
  ip_address_version = 6
  virtual_machine_id = netbox_virtual_machine.supernode.id
}
