terraform {
  required_providers {
    netbox = {
      source = "e-breuninger/netbox"
    }
    proxmox = {
      source = "Telmate/proxmox"
      # newer versions have issues with granular permission on a token
      # https://github.com/Telmate/terraform-provider-proxmox/issues/784
      version = "<= 2.9.14"
    }
    iphelpers = {
      source  = "ffddorf/iphelpers"
      version = "~> 1.0.0"
    }
  }
}
