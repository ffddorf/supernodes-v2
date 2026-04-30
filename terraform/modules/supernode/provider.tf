terraform {
  required_providers {
    netbox = {
      source = "registry.opentofu.org/e-breuninger/netbox"
    }
    netboxbgp = {
      source = "registry.terraform.io/ffddorf/netbox-bgp"
    }
    proxmox = {
      source  = "registry.opentofu.org/Telmate/proxmox"
      version = "~> 3.0.0"
    }
    iphelpers = {
      source  = "registry.terraform.io/ffddorf/iphelpers"
      version = "~> 1.0.0"
    }
    macaddress = {
      source  = "registry.opentofu.org/ivoronin/macaddress"
      version = "~> 0.3.2"
    }
    cloudflare = {
      source = "registry.opentofu.org/cloudflare/cloudflare"
    }
  }
}
