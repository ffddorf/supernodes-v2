data "netbox_site" "local" {
  name = var.site_name
}

module "supernode" {
  count = var.supernode_count

  source = "./modules/supernode"

  supernode_name = "${var.domain_name}-${count.index}"

  public_ipv4_prefix_id = data.netbox_prefix.primary_ipv4.id
  domain_ipv4_id        = netbox_prefix.domain_ipv4.id
  domain_ipv6_id        = netbox_prefix.domain_ipv6.id
  domain_vrf_id         = data.netbox_vrf.mesh.id
  site_id               = data.netbox_site.local.id
  batbone_vlan          = netbox_available_vlan.batbone.vid

  vm_ssh_keys = local.ssh_keys
}
