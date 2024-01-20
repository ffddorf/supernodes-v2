variable "supernode_name" {
  type        = string
  description = "Name of the Supernode"
}

variable "tags" {
  type        = list(string)
  description = "Tags for the resources"
  default     = []
}

variable "prefix_ipv4_id" {
  type        = string
  description = "ID of the Supernode IPv4 prefix"
}

variable "prefix_ipv6_id" {
  type        = string
  description = "ID of the Supernode IPv6 prefix"
}

variable "loopback_prefix_ipv6_id" {
  type        = string
  description = "ID of the Loopback Supernode IPv6 prefix"
}
