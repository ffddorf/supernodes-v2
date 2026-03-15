
data "netbox_devices" "core_routers" {
  filter {
    name  = "tags"
    value = var.core_router_tag
  }

  filter {
    name  = "status"
    value = "active"
  }
}

data "netbox_ip_addresses" "core_router_addrs_v4" {
  for_each = {
    for dev in data.netbox_devices.core_routers.devices :
    dev.device_id => dev.primary_ipv4
  }

  filter {
    name  = "ip_address"
    value = each.value
  }
}

data "netbox_ip_addresses" "core_router_addrs_v6" {
  for_each = {
    for dev in data.netbox_devices.core_routers.devices :
    dev.device_id => dev.primary_ipv6
  }

  filter {
    name  = "ip_address"
    value = each.value
  }
}

data "netbox_asn" "ffddorf_public" {
  asn = "207871"
}
