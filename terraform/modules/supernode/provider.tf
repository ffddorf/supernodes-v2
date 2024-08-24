terraform {
  required_providers {
    netbox = {
      source = "e-breuninger/netbox"
    }
    proxmox = {
      source  = "Telmate/proxmox"
      version = "~> 3.0.1"
    }
    iphelpers = {
      source  = "ffddorf/iphelpers"
      version = "~> 1.0.0"
    }
    macaddress = {
      source  = "ivoronin/macaddress"
      version = "~> 0.3.2"
    }
  }
}
