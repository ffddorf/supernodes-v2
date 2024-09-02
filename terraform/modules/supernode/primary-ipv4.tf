resource "netbox_available_prefix" "primary_ipv4" {
  description = "Primary Address ${var.supernode_name}"
  status      = "active"

  parent_prefix_id = var.public_ipv4_prefix_id
  prefix_length    = 32

  tags = toset(var.tags)
}

resource "netbox_available_ip_address" "primary_ipv4" {
  status = "active"

  description = "Primary Address ${var.supernode_name}"

  prefix_id = netbox_available_prefix.primary_ipv4.id

  object_type  = "virtualization.vminterface"
  interface_id = netbox_interface.eth0.id

  tags = toset(var.tags)
}

resource "netbox_available_ip_address" "lan_ipv4" {
  status = "active"

  description = "LAN Address ${var.supernode_name}"

  prefix_id = var.domain_ipv4_id
  vrf_id    = var.domain_vrf_id

  object_type  = "virtualization.vminterface"
  interface_id = netbox_interface.br0.id

  tags = toset(var.tags)
}
