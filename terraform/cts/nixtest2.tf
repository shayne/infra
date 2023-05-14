resource "proxmox_virtual_environment_container" "nixtest2" {
  node_name = "pve0"

  initialization {
    hostname = "nixtest2"

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKxq71dQw4zBQAe3mtfiNwuCwP0Lu8x9PdRVxy2+T8Pw"
      ]
    }
  }

  console {
    type = "console"
  }

  cpu {
    cores = 1
  }

  memory {
    dedicated = 1024
  }

  disk {
    datastore_id = "array"
    size         = 8
  }

  network_interface {
    name    = "eth0"
    vlan_id = 3
  }

  operating_system {
    type             = "nixos"
    template_file_id = "local:vztmpl/nixos-system-x86_64-linux.tar.xz"
  }

  features {
    nesting = true
  }
}

