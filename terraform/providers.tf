terraform {
  required_providers {
    netbox = {
      source  = "registry.opentofu.org/e-breuninger/netbox"
      version = "5.3.0"
    }
    netboxbgp = {
      source  = "registry.terraform.io/ffddorf/netbox-bgp"
      version = "= 0.1.0-rc8"
    }
    proxmox = {
      source  = "registry.opentofu.org/Telmate/proxmox"
      version = "= 3.0.2-rc07"
    }
    cloudflare = {
      source  = "registry.opentofu.org/cloudflare/cloudflare"
      version = "5.18.0"
    }
  }
}

provider "netbox" {
  server_url = "https://netbox.freifunk-duesseldorf.de"
}

provider "netboxbgp" {
  server_url = "https://netbox.freifunk-duesseldorf.de"
}

provider "proxmox" {
  pm_api_url = "https://pve.freifunk-duesseldorf.de/api2/json"
}

provider "cloudflare" {}
