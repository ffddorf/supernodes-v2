data "netbox_prefix" "primary_ipv4" {
  prefix = var.primary_prefix_ipv4
}

data "netbox_prefix" "primary_ipv6" {
  prefix = var.primary_prefix_ipv6
}

resource "netbox_available_prefix" "domain_ipv6" {
  description      = "Supernode IPv6 addresses ${var.domain_name}"
  prefix_length    = 56
  status           = "reserved"
  parent_prefix_id = data.netbox_prefix.primary_ipv6.id

  tags = toset(var.tags)
}

resource "netbox_prefix" "loopback_ipv6" {
  prefix      = cidrsubnet(netbox_available_prefix.domain_ipv6.prefix, 8, 0)
  description = "Supernode IPv6 loopback addresses ${var.domain_name}"
  status      = "reserved"

  tags = toset(var.tags)
}
