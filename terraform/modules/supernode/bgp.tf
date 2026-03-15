data "netboxbgp_prefix_lists" "default" {
  name = ["default"]
}

locals {
  pfxlist_default = {
    for pfxl in data.netboxbgp_prefix_lists.default.results :
    pfxl.family => pfxl.id
  }
}

resource "netboxbgp_prefix_list" "node" {
  for_each = {
    "v4" = "ipv4"
    "v6" = "ipv6"
  }

  name   = "supernode-${var.supernode_name}"
  family = each.value
}

resource "netboxbgp_prefix_list_rule" "node_v4" {
  action      = "permit"
  index       = 1
  prefix_list = netboxbgp_prefix_list.node["v4"].id
  prefix      = netbox_available_prefix.primary_ipv4.id
  description = "v4 NAT IP of supernode-${var.supernode_name}"
}

resource "netboxbgp_prefix_list_rule" "node_v6" {
  action      = "permit"
  index       = 1
  prefix_list = netboxbgp_prefix_list.node["v6"].id
  prefix      = data.netbox_prefix.lan6.id
  description = "v6 prefix of supernode-${var.supernode_name}"
}

resource "netboxbgp_session" "cores_to_node_v4" {
  for_each = var.bgp_peers

  local_as       = var.bgp_asn_id
  remote_as      = var.bgp_asn_id
  local_address  = each.value.v4_id
  remote_address = netbox_available_ip_address.primary_ipv4.id

  prefix_list_out = local.pfxlist_default["ipv4"]
  prefix_list_in  = netboxbgp_prefix_list.node["v4"].id

  site   = var.site_id
  device = each.value.id

  name        = "${each.key}-supernode-${var.supernode_name}-v4"
  description = "supernode-${var.supernode_name}"
}

resource "netboxbgp_session" "cores_to_node_v6" {
  for_each = var.bgp_peers

  local_as       = var.bgp_asn_id
  remote_as      = var.bgp_asn_id
  local_address  = each.value.v6_id
  remote_address = netbox_ip_address.management_ipv6.id

  prefix_list_out = local.pfxlist_default["ipv6"]
  prefix_list_in  = netboxbgp_prefix_list.node["v6"].id

  site   = var.site_id
  device = each.value.id

  name        = "${each.key}-supernode-${var.supernode_name}-v6"
  description = "supernode-${var.supernode_name}"
}

resource "netboxbgp_session" "node_to_cores_v4" {
  for_each = var.bgp_peers

  local_as       = var.bgp_asn_id
  remote_as      = var.bgp_asn_id
  local_address  = netbox_available_ip_address.primary_ipv4.id
  remote_address = each.value.v4_id

  prefix_list_out = netboxbgp_prefix_list.node["v4"].id
  prefix_list_in  = local.pfxlist_default["ipv4"]

  site   = var.site_id
  device = each.value.id

  name        = "supernode-${var.supernode_name}-${each.key}-v4"
  description = each.key
}

resource "netboxbgp_session" "node_to_cores_v6" {
  for_each = var.bgp_peers

  local_as       = var.bgp_asn_id
  remote_as      = var.bgp_asn_id
  local_address  = netbox_ip_address.management_ipv6.id
  remote_address = each.value.v6_id

  prefix_list_out = netboxbgp_prefix_list.node["v6"].id
  prefix_list_in  = local.pfxlist_default["ipv6"]

  site   = var.site_id
  device = each.value.id

  name        = "supernode-${var.supernode_name}-${each.key}-v6"
  description = each.key
}
