resource "netbox_available_vlan" "batbone" {
  name        = "batbone ${var.domain_name}"
  status      = "active"
  description = "Batbone VLAN for ${var.domain_name}"

  group_id = var.batbone_vlan_group_id
  site_id  = data.netbox_site.local.id
}
