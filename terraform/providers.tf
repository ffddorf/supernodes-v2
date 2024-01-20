terraform {
  required_providers {
    netbox = {
      source  = "e-breuninger/netbox"
      version = "3.7.6"
    }
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.11"
    }
  }
}

provider "netbox" {
  server_url = "https://netbox.freifunk-duesseldorf.de"
}

provider "proxmox" {
  pm_api_url = "https://pve.freifunk-duesseldorf.de/api2/json"
}
