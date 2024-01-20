resource "null_resource" "test" {
}

module "supernode" {
  count = var.supernode_count

  source = "./modules/supernode"

  supernode_name = "${var.domain_name}_${count.index}"

  prefix_ipv4_id          = data.netbox_prefix.primary_ipv4.id
  prefix_ipv6_id          = netbox_available_prefix.domain_ipv6.id
  loopback_prefix_ipv6_id = netbox_prefix.loopback_ipv6.id
}
