## Orangebox MAAS Terraform

Terraform project template to deploy and commission nodes on Orangebox.

**To modify the network:**

Change the `maas_subnet` resources in the `main.tf` file:

```
resource "maas_subnet" "oam-subnet" {
  cidr      = "172.27.84.0/23"
  fabric    = maas_fabric.default.id
  vlan      = maas_vlan.oam-vlan.vid
  name      = "oam_subnet"
  gateway_ip = "172.27.85.254"
  dns_servers = [
    "1.1.1.1",
  ]
  ip_ranges {
    type    = "reserved"
    start_ip = "172.27.84.1"
    end_ip  = "172.27.84.20"
  }
  ip_ranges {
    type    = "dynamic"
    start_ip = "172.27.84.51"
    end_ip  = "172.27.84.99"
  }
}

resource "maas_subnet" "external-subnet" {
  cidr      = "172.27.86.0/23"
  fabric    = maas_fabric.default.id
  vlan      = maas_vlan.external-vlan.vid
  name      = "external_subnet"
  gateway_ip = "172.27.87.254"
  dns_servers = [
    "1.1.1.1",
  ]
  ip_ranges {
    type    = "reserved"
    start_ip = "172.27.86.1"
    end_ip  = "172.27.87.200"
  }
}
```

**To modify the buckets configuration:**

Change the `machine_data` variable in the `variables.tfvars` file, following the template:

```
machine_data = {
  node01 = {
    name           = "node1",
    power_pass     = "Password1+",
    power_address  = "172.27.84.11",
    mac_address    = "b8:ae:ed:7b:f3:99"
    pxe_mac_address = "b8:ae:ed:7b:f3:99"
    id_path        = "/dev/sdb"
    nic_name       = "enp0s25"
    partitions = [
      {
        "size_gigabytes" = 1,
        fs_type       = "fat32",
        "label"         = "efi",
        "bootable"      = true,
        "mount_point"   = "/boot/efi"
      },
      {
        "size_gigabytes" = 110,
        "fs_type"       = "ext4",
        "label"         = "root",
        "bootable"      = false,
        "mount_point"   = "/"
      },
      {
        "size_gigabytes" = 20,
        "label"         = "ceph"
        "fs_type"       = "",
        "bootable"      = false,
        "mount_point"   = ""
      },
      {
        "size_gigabytes" = 9,
        "label"         = "ceph"
        "fs_type"       = "",
        "bootable"      = false,
        "mount_point"   = ""
      },
      {
        "size_gigabytes" = 1,
        "label"         = "ceph"
        "fs_type"       = "",
        "bootable"      = false,
        "mount_point"   = ""
      }
    ]
  }
  # other machines
}
```

## TODO

* Improve JSON generation automation

## Limitations
* Right now terraform-maas-provider lack of some features (bcache support, ecc)
