resource "proxmox_virtual_environment_container" "nixos_lxc" {
  for_each = var.nixos_lxc

  node_name = each.value.node_name

  initialization {
    hostname = each.value.hostname == null ? each.key : each.value.hostname

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

    dns {
      domain = each.value.domain
      server = "10.2.5.2"
    }
  }

  console {
    type = "console"
  }

  cpu {
    cores = each.value.cpu_cores
  }

  memory {
    dedicated = each.value.memory_dedicated
  }

  disk {
    datastore_id = each.value.disk_datastore_id
    size         = each.value.disk_size
  }

  network_interface {
    name    = each.value.network_interface_name
    vlan_id = each.value.network_interface_vlan_id
  }

  operating_system {
    type             = "nixos"
    template_file_id = "local:vztmpl/nixos-system-x86_64-linux.tar.xz"
  }

  features {
    nesting = each.value.features_nesting
  }

  provisioner "local-exec" {
    command = "cd $(git rev-parse --show-toplevel) && deploy .#${each.key}}"
  }
}
