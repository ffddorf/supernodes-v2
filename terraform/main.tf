data "netbox_site" "local" {
  name = var.site_name
}

data "netbox_cluster" "pve" {
  name = var.vm_cluster
}

data "netbox_devices" "cluster_nodes" {
  filter {
    name  = "cluster_id"
    value = data.netbox_cluster.pve.cluster_id
  }
}

locals {
  vm_node_names = sort([for d in data.netbox_devices.cluster_nodes.devices : lower(d.name)])
}

module "supernode" {
  count = var.supernode_count

  source = "./modules/supernode"

  supernode_name  = "${var.domain_name}-${count.index}"
  supernode_index = count.index

  public_ipv4_prefix_id = data.netbox_prefix.primary_ipv4.id
  domain_ipv4_prefix    = netbox_prefix.domain_ipv4.prefix
  domain_ipv6_prefix    = netbox_prefix.domain_ipv6.prefix
  domain_vrf_id         = data.netbox_vrf.mesh.id
  site_id               = data.netbox_site.local.id
  batbone_vlan          = netbox_available_vlan.batbone.vid

  vm_ssh_keys    = local.ssh_keys
  vm_target_node = local.vm_node_names[count.index % length(local.vm_node_names)]
}
