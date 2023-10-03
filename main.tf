terraform {
  required_providers {
    maas = {
      source  = "maas/maas"
      version = "~>1.0"
    }
  }
}

provider "maas" {
  api_version = "2.0"
  api_key     = "2sHTKcNm6yJXcmSPPV:tNWNbUq5wMm2FnGz8E:HbvzT6EF5jWL6j7rjdKzQXPyF5WApufx"
  api_url     = "http://192.168.188.22:5240/MAAS"
}

#
# Spaces
#
resource "maas_space" "oam-space" {
  name = "oam-space"
}

resource "maas_space" "external-space" {
  name = "external-space"
}

#
# Fabrics
#

resource "maas_fabric" "default" {
  name = "default"
}
#
# VLANs
#

resource "maas_vlan" "oam-vlan" {
  fabric  = maas_fabric.default.id
  dhcp_on = true
  vid     = 1
  name    = "tf-vlan1"
  space   = maas_space.oam-space.name
}

resource "maas_vlan" "external-vlan" {
  fabric = maas_fabric.default.id
  vid    = 2
  name   = "tf-vlan2"
  space  = maas_space.external-space.name
}

#
# Subnets
#

resource "maas_subnet" "oam-subnet" {
  cidr       = "172.27.84.0/23"
  fabric     = maas_fabric.default.id
  vlan       = maas_vlan.oam-vlan.vid
  name       = "oam_subnet"
  gateway_ip = "172.27.85.254"
  dns_servers = [
    "1.1.1.1",
  ]
  ip_ranges {
    type     = "reserved"
    start_ip = "172.27.84.1"
    end_ip   = "172.27.84.20"
  }
  ip_ranges {
    type     = "dynamic"
    start_ip = "172.27.84.51"
    end_ip   = "172.27.84.99"
  }
}


resource "maas_subnet" "external-subnet" {
  cidr       = "172.27.86.0/23"
  fabric     = maas_fabric.default.id
  vlan       = maas_vlan.external-vlan.vid
  name       = "external_subnet"
  gateway_ip = "172.27.87.254"
  dns_servers = [
    "1.1.1.1",
  ]
  ip_ranges {
    type     = "reserved"
    start_ip = "172.27.86.1"
    end_ip   = "172.27.87.200"
  }
}


# machines

variable "machine_data" {
  type = map(any)
}


resource "maas_machine" "node" {
  for_each   = var.machine_data
  power_type = "amt"
  power_parameters = {
    power_pass    = each.value.power_pass
    power_address = each.value.power_address
  }
  pxe_mac_address = each.value.pxe_mac_address
}

resource "maas_block_device" "sdb" {
  for_each       = var.machine_data
  machine        = maas_machine.node[each.key].id
  size_gigabytes = 200
  name           = each.value.name
  id_path        = each.value.id_path
  dynamic "partitions" {
    for_each = each.value.partitions
    content {
      size_gigabytes = partitions.value.size_gigabytes
      fs_type        = partitions.value.fs_type
      label          = partitions.value.label
      bootable       = partitions.value.bootable
      mount_point    = partitions.value.mount_point
    }
  }

}

resource "maas_network_interface_physical" "nics" {
  for_each    = var.machine_data
  machine     = maas_machine.node[each.key].id
  mac_address = each.value.mac_address
  name        = each.value.nic_name
}
