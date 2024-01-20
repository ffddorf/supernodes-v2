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

variable "management_prefix_ipv6" {
  type        = string
  description = "Prefix to use for the statically assigned IPv6 management address"
  default     = "2001:678:b7c:201::/64"
}

variable "vm_target_node" {
  type        = string
  description = "Node to launch VM on"
  default     = "pm2"
}

variable "vm_template_name" {
  type        = string
  description = "Existing VM to use as template for cloning new VM"
  default     = "debian12"
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
