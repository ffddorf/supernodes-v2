resource "netbox_available_prefix" "primary_ipv6" {
  description = "Primary Address ${var.supernode_name}"
  status      = "reserved"

  parent_prefix_id = var.loopback_prefix_ipv6_id
  prefix_length    = 128

  tags = toset(var.tags)
}

resource "netbox_available_ip_address" "primary_ipv6" {
  status = "active"

  description = "Primary Address ${var.supernode_name}"

  prefix_id = netbox_available_prefix.primary_ipv6.id
  // TODO: set interface_id

  tags = toset(var.tags)
}
