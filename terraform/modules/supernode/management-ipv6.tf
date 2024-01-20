data "netbox_prefix" "management_net" {
  prefix = var.management_prefix_ipv6
}

resource "netbox_available_ip_address" "management_ipv6" {
  status = "active"

  description = "Management Address ${var.supernode_name}"

  prefix_id = data.netbox_prefix.management_net.id
  // TODO: set interface_id

  tags = toset(var.tags)
}
