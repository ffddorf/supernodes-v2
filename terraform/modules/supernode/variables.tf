variable "supernode_name" {
  type        = string
  description = "Name of the Supernode"
}

variable "tags" {
  type        = list(string)
  description = "Tags for the resources"
  default     = []
}

variable "public_ipv4_prefix_id" {
  type        = string
  description = "ID of the prefix to assign a public IPv4 address from"
}

variable "domain_ipv4_id" {
  type        = string
  description = "ID of the Domain IPv4 prefix"
}

variable "domain_ipv6_id" {
  type        = string
  description = "ID of the Domain IPv6 prefix"
}

variable "domain_vrf_id" {
  type        = string
  description = "ID of the VRF for this domain"
}

variable "management_prefix_ipv6" {
  type        = string
  description = "Prefix to use for the statically assigned IPv6 management address"
  default     = "2001:678:b7c:205::/64"
}

variable "vm_target_node" {
  type        = string
  description = "Node to launch VM on"
  default     = "pm2"
}

variable "vm_template_name" {
  type        = string
  description = "Existing VM to use as template for cloning new VM"
  default     = "debian12-guest-agent"
}

variable "vm_storage_pool_name" {
  type        = string
  description = "Storage pool to use for the VM root disk"
  default     = "system"
}

variable "vm_resource_pool" {
  type        = string
  description = "Proxmox pool to create VM in"
  default     = "Supernodes2.0"
}

variable "vm_ssh_keys" {
  type        = list(string)
  description = "Public keys to grant access to"
}

variable "vm_cluster_name" {
  type        = string
  description = "Cluster to assign the VM to"
  default     = "pve1"
}

variable "vm_role_name" {
  type        = string
  description = "Name of an existing Netbox device role to assign to the VM"
  default     = "Supernode v2"
}
