data "netbox_vlan_group" "core" {
  name       = var.vlan_group_name
  scope_type = "dcim.site"
  scope_id   = var.site_id
}

data "netbox_vlan" "public_vms" {
  group_id = data.netbox_vlan_group.core.id
  vid      = var.vlan_id
}

resource "netbox_available_prefix" "primary_ipv4" {
  description = "Primary Address ${var.supernode_name}"
  status      = "active"
  site_id     = var.site_id
  vlan_id     = data.netbox_vlan.public_vms.id

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

data "netbox_prefix" "lan4" {
  prefix = var.domain_ipv4_prefix
}

resource "netbox_available_ip_address" "lan_ipv4" {
  status = "active"

  description = "LAN Address ${var.supernode_name}"

  prefix_id = data.netbox_prefix.lan4.id
  vrf_id    = var.domain_vrf_id

  object_type  = "virtualization.vminterface"
  interface_id = netbox_interface.br0.id

  tags = toset(var.tags)
}

locals {
  dhcp_range = cidrsubnet(
    var.domain_ipv4_prefix,
    var.domain_dhcp_range_prefix_length_increment,
    var.supernode_index + 1,
  )
  dhcp_range_start_address = cidrhost(local.dhcp_range, 0)
  dhcp_range_end_address   = cidrhost(local.dhcp_range, -1)
}

resource "netbox_ip_range" "dhcp" {
  description   = "DHCP range for Supernode ${var.supernode_name}"
  start_address = "${local.dhcp_range_start_address}/32"
  end_address   = "${local.dhcp_range_end_address}/32"
}
