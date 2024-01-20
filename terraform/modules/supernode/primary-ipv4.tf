resource "netbox_available_prefix" "primary_ipv4" {
  description = "Primary Address ${var.supernode_name}"
  status      = "reserved"

  parent_prefix_id = var.prefix_ipv4_id
  prefix_length    = 32

  tags = toset(var.tags)
}

resource "netbox_available_ip_address" "primary_ipv4" {
  status = "active"

  description = "Primary Address ${var.supernode_name}"

  prefix_id = netbox_available_prefix.primary_ipv4.id
  // TODO: set interface_id

  tags = toset(var.tags)
}
