data "netbox_prefix" "lan6" {
  prefix = var.domain_ipv6_prefix
}

resource "netbox_available_ip_address" "primary_ipv6" {
  status = "active"

  description = "Primary Address ${var.supernode_name}"

  prefix_id = data.netbox_prefix.lan6.id

  object_type  = "virtualization.vminterface"
  interface_id = netbox_interface.br0.id

  tags = toset(var.tags)
}
