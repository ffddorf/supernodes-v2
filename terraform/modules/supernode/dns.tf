data "cloudflare_zone" "ffddorf" {
  filter = {
    name = "ffddorf.net"
  }
}

resource "cloudflare_dns_record" "vpn" {
  for_each = {
    A    = split("/", netbox_available_ip_address.primary_ipv4.ip_address)[0]
    AAAA = split("/", netbox_available_ip_address.primary_ipv6.ip_address)[0]
  }

  zone_id = data.cloudflare_zone.ffddorf.zone_id
  name    = "supernode-${var.supernode_name}.ffddorf.net"
  type    = each.key
  content = each.value
  ttl     = 300
}
