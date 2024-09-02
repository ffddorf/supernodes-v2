terraform {
  required_providers {
    netbox = {
      source  = "e-breuninger/netbox"
      version = "3.9.0"
    }
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
}

provider "netbox" {
  server_url = "https://netbox.freifunk-duesseldorf.de"
}

provider "proxmox" {
  pm_api_url = "https://pve.freifunk-duesseldorf.de/api2/json"
}
