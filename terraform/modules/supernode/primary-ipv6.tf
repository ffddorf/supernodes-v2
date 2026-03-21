data "netbox_prefix" "lan6" {
  prefix = var.domain_ipv6_prefix
}

resource "netbox_available_ip_address" "primary_ipv6" {
  status = "active"

  description = "Primary Address ${var.supernode_name}"

  prefix_id = data.netbox_prefix.lan6.id

  object_type  = "virtualization.vminterface"
  interface_id = netbox_interface.br-client.id

  tags = toset(var.tags)
}

resource "netbox_ip_address" "anycast_v6" {
  ip_address  = var.anycast_prefix_v6
  status      = "active"
  role        = "anycast"
  description = "DNS anycast on supernode ${var.supernode_name}"

  virtual_machine_interface_id = netbox_interface.lo.id
}
