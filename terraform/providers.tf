terraform {
  required_providers {
    netbox = {
      source  = "e-breuninger/netbox"
      version = "5.0.0"
    }
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc04"
    }
  }
}

provider "netbox" {
  server_url = "https://netbox.freifunk-duesseldorf.de"
}

provider "proxmox" {
  pm_api_url = "https://pve.freifunk-duesseldorf.de/api2/json"
}
