resource "netbox_available_ip_address" "primary_ipv6" {
  status = "active"

  description = "Primary Address ${var.supernode_name}"

  prefix_id = var.domain_ipv6_id

  object_type  = "virtualization.vminterface"
  interface_id = netbox_interface.br0.id

  tags = toset(var.tags)
}
