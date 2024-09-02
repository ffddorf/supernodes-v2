resource "macaddress" "eth0" {}

resource "netbox_interface" "eth0" {
  virtual_machine_id = netbox_virtual_machine.supernode.id

  name        = "eth0"
  mac_address = macaddress.eth0.address

  tags = toset(var.tags)
}

resource "netbox_interface" "lo" {
  virtual_machine_id = netbox_virtual_machine.supernode.id
  name               = "lo"

  tags = toset(var.tags)
}

resource "netbox_interface" "br0" {
  virtual_machine_id = netbox_virtual_machine.supernode.id

  name        = "br0"
  description = "client bridge"

  tags = toset(var.tags)
}
