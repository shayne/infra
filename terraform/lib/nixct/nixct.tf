variable "hostname" {
  type = string
}

variable "node_name" {
  type    = string
  default = "pve0"
}

variable "cpu_cores" {
  type    = number
  default = 2
}

variable "memory_dedicated" {
  type    = number
  default = 4096
}

variable "disk_datastore_id" {
  type    = string
  default = "array"
}

variable "disk_size" {
  type    = number
  default = 8
}

variable "network_interface_name" {
  type    = string
  default = "eth0"
}

variable "network_interface_vlan_id" {
  type    = number
  default = 3
}

variable "features_nesting" {
  type    = bool
  default = true
}

resource "proxmox_virtual_environment_container" "syncthing" {
  node_name = var.node_name

  initialization {
    hostname = var.hostname

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
    cores = var.cpu_cores
  }

  memory {
    dedicated = var.memory_dedicated
  }

  disk {
    datastore_id = var.disk_datastore_id
    size         = var.disk_size
  }

  network_interface {
    name    = var.network_interface_name
    vlan_id = var.network_interface_vlan_id
  }

  operating_system {
    type             = "nixos"
    template_file_id = "local:vztmpl/nixos-system-x86_64-linux.tar.xz"
  }

  features {
    nesting = var.features_nesting
  }
}
