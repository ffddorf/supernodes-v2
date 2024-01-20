terraform {
  required_providers {
    netbox = {
      source  = "e-breuninger/netbox"
      version = "3.7.6"
    }
  }
}

provider "netbox" {
  server_url = "https://netbox.freifunk-duesseldorf.de"
}
