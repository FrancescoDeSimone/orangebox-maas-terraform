machine_data = {
  node01 = {
    name            = "node1",
    power_pass      = "Password1+",
    power_address   = "172.27.84.11",
    mac_address     = "b8:ae:ed:7b:f3:99"
    pxe_mac_address = "b8:ae:ed:7b:f3:99"
    id_path         = "/dev/sdb"
    nic_name        = "enp0s25"
    partitions = [
      {
        "size_gigabytes" = 1,
        fs_type        = "fat32",
        "label"          = "efi",
        "bootable"       = true,
        "mount_point"    = "/boot/efi"
      },
      {
        "size_gigabytes" = 110,
        "fs_type"        = "ext4",
        "label"          = "root",
        "bootable"       = false,
        "mount_point"    = "/"
      },
      {
        "size_gigabytes" = 20,
        "label"          = "ceph"
        "fs_type"        = "",
        "bootable"       = false,
        "mount_point"    = ""
        "label"          = "",
      },
      {
        "size_gigabytes" = 9,
        "label"          = "ceph"
        "fs_type"        = "",
        "bootable"       = false,
        "mount_point"    = ""
        "label"          = "",
      },
      {
        "size_gigabytes" = 1,
        "label"          = "ceph"
        "fs_type"        = "",
        "bootable"       = false,
        "mount_point"    = ""
        "label"          = "",
      }
    ]
  },
  node02 = {
    name            = "node2",
    power_pass      = "Password1+",
    power_address   = "172.27.84.12",
    mac_address     = "b8:ae:ed:7b:f2:95"
    pxe_mac_address = "b8:ae:ed:7b:f2:95"
    id_path         = "/dev/sdb"
    nic_name        = "enp0s25"
    partitions = [
      {
        "size_gigabytes" = 1,
        "fs_type"        = "fat32",
        "label"          = "efi",
        "bootable"       = true,
        "mount_point"    = "/boot/efi"
      },
      {
        "size_gigabytes" = 110,
        "fs_type"        = "ext4",
        "label"          = "root",
        "bootable"       = false,
        "mount_point"    = "/"
      },
      {
        "size_gigabytes" = 20,
        "label"          = "ceph"
        "fs_type"        = "",
        "bootable"       = false,
        "mount_point"    = ""
        "label"          = "",
      },
      {
        "size_gigabytes" = 9,
        "label"          = "cep"
        "fs_type"        = "",
        "bootable"       = false,
        "mount_point"    = ""
        "label"          = "",
      },
      {
        "size_gigabytes" = 1,
        "label"          = "ceph"
        "bootable"       = false,
        "fs_type"        = "",
        "mount_point"    = ""
        "label"          = "",
      }
    ]
  }
}
