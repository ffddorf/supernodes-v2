module "supernode" {
  count = var.supernode_count

  source = "./modules/supernode"

  supernode_name = "${var.domain_name}-${count.index}"

  prefix_ipv4_id          = data.netbox_prefix.primary_ipv4.id
  prefix_ipv6_id          = netbox_available_prefix.domain_ipv6.id
  loopback_prefix_ipv6_id = netbox_prefix.loopback_ipv6.id

  vm_ssh_keys = local.ssh_keys
}
