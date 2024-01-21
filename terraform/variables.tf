variable "domain_name" {
  type        = string
  description = "Name of the supernode domain"
  default     = "dev"
}

variable "tags" {
  type        = list(string)
  description = "Tags for the resources"
  default     = []
}

variable "supernode_count" {
  type        = number
  description = "Number of supernodes for this domain"
  default     = 2
}

variable "primary_prefix_ipv4" {
  type        = string
  description = "Prefix to issue primary IPv4 addresses from"
  default     = "45.151.166.0/24"
}

variable "primary_prefix_ipv6" {
  type        = string
  description = "Prefix to issue primary IPv6 addresses from"
  default     = "2001:678:b7c::/48"
}

variable "ssh_github_users" {
  type        = list(string)
  description = "Users to gather SSH public keys from GitHub for"
  default     = ["mraerino", "nomaster"]
}
