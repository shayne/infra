resource "proxmox_virtual_environment_vm" "devvm" {
  name        = "devvm"

  node_name = "pve0"

  bios = "ovmf"

  boot_order = ["hostpci0"]

  tablet_device = false

  cpu {
    cores = 24
    type  = "host"
  }

  memory {
    dedicated = 8192
    floating  = 16384
  }

  agent {
    enabled = true
  }

  network_device {
    vlan_id     = 3
    mac_address = "52:54:00:4F:29:0A"
  }

  operating_system {
    type = "l26"
  }

  serial_device {}

  hostpci {
    device   = "hostpci0"
    id       = "0000:03:00.0"
    rom_file = "OVMF_CODE-pure-efi.fd"
  }

  efi_disk {
    datastore_id = "array"
    file_format = "raw"
    pre_enrolled_keys = false
  }
}
