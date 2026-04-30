data "netbox_prefixes" "potential_management_nets" {
  filter {
    name  = "vlan_id"
    value = data.netbox_vlan.public_vms.id
  }
}

locals {
  # hacky way to find the subnet which is ipv6 with a prefix length of 64
  management_net = one([for pfx in data.netbox_prefixes.potential_management_nets.prefixes : pfx
    if length(regexall(".+/64", pfx.prefix)) > 0
  ])
}

data "iphelpers_eui64_address" "supernode_management" {
  mac_address = macaddress.vm["eth0"].address
  prefix      = trimsuffix(local.management_net.prefix, "/64")
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
