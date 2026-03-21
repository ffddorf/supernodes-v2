resource "macaddress" "vm" {
  for_each = toset(["eth0", "eth1"])
}

resource "netbox_interface" "eth0" {
  virtual_machine_id = netbox_virtual_machine.supernode.id

  name = "eth0"
  tags = toset(var.tags)
}

resource "netbox_mac_address" "eth0" {
  mac_address  = macaddress.vm["eth0"].address
  interface_id = netbox_interface.eth0.id
  object_type  = "virtualization.vminterface"
}

data "netbox_vlan" "batbone" {
  vid = var.batbone_vlan
}

resource "netbox_interface" "eth1" {
  virtual_machine_id = netbox_virtual_machine.supernode.id

  name        = "eth1"
  description = "Batbone"

  mode          = "access"
  untagged_vlan = data.netbox_vlan.batbone.id

  // todo: set bridge membership

  tags = toset(var.tags)
}

resource "netbox_mac_address" "eth1" {
  mac_address  = macaddress.vm["eth1"].address
  interface_id = netbox_interface.eth1.id
  object_type  = "virtualization.vminterface"
}

resource "netbox_interface" "lo" {
  virtual_machine_id = netbox_virtual_machine.supernode.id
  name               = "lo"

  tags = toset(var.tags)
}

moved {
  from = netbox_interface.br0
  to   = netbox_interface.br-client
}

resource "netbox_interface" "br-client" {
  virtual_machine_id = netbox_virtual_machine.supernode.id

  name        = "br-client"
  description = "client bridge"

  tags = toset(var.tags)
}

resource "netbox_interface" "br-mesh" {
  virtual_machine_id = netbox_virtual_machine.supernode.id

  name        = "br-mesh"
  description = "mesh bridge"

  tags = toset(var.tags)
}
