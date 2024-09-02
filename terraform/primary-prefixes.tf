data "netbox_prefix" "primary_ipv4" {
  prefix = var.primary_prefix_ipv4
}

data "netbox_prefix" "ipv6_container" {
  prefix = var.primary_prefix_ipv6
}

resource "netbox_prefix" "domain_ipv6" {
  prefix      = cidrsubnet(data.netbox_prefix.ipv6_container.prefix, 8, var.domain_id)
  description = "Supernode IPv6 addresses ${var.domain_name}"
  status      = "active"

  tags = toset(var.tags)
}

output "domain_ipv6_prefix" {
  value = netbox_prefix.domain_ipv6.prefix
}

data "netbox_vrf" "mesh" {
  name = "Mesh"
}

resource "netbox_prefix" "domain_ipv4" {
  prefix      = cidrsubnet("10.0.0.0/8", 8, var.domain_id)
  description = "Supernode client subnet ${var.domain_name}"
  status      = "active"

  vrf_id = data.netbox_vrf.mesh.id
}
