resource "macaddress" "eth0" {}

resource "netbox_interface" "eth0" {
  virtual_machine_id = netbox_virtual_machine.supernode.id

  name        = "eth0"
  mac_address = macaddress.eth0.address

  tags = toset(var.tags)
}
