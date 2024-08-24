module "supernode" {
  count = var.supernode_count

  source = "./modules/supernode"

  supernode_name = "${var.domain_name}-${count.index}"

  public_ipv4_prefix_id = data.netbox_prefix.primary_ipv4.id
  domain_ipv4_id        = netbox_prefix.domain_ipv4.id
  domain_ipv6_id        = netbox_prefix.domain_ipv6.id
  domain_vrf_id         = data.netbox_vrf.mesh.id

  vm_ssh_keys = local.ssh_keys
}
