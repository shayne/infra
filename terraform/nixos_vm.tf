resource "proxmox_virtual_environment_vm" "nixos_vm" {
  for_each = var.nixos_vm

  node_name = each.value.node_name

  name = each.key

  tablet_device = false

  clone {
    datastore_id = "array"
    vm_id        = 100
  }

  initialization {
    datastore_id = "array"

    # ip_config {
    #   ipv4 {
    #     address = "dhcp"
    #   }
    # }

    user_account {
      #   username = "root"
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKxq71dQw4zBQAe3mtfiNwuCwP0Lu8x9PdRVxy2+T8Pw"
      ]
    }
  }

  disk {
    interface    = "virtio0"
    datastore_id = each.value.disk_datastore_id
    size         = each.value.disk_size
  }

  cpu {
    cores = each.value.cpu_cores
    type  = "host"
  }

  memory {
    dedicated = each.value.memory_dedicated
  }

  agent {
    enabled = true
  }

  network_device {
    vlan_id = each.value.network_interface_vlan_id
  }

  operating_system {
    type = "l26"
  }

  serial_device {}

  provisioner "local-exec" {
    command = "sleep 5" # wait for DHCP
  }

  provisioner "local-exec" {
    command = "cd $(git rev-parse --show-toplevel) && deploy --hostname ${self.ipv4_addresses[1][0]} .#${each.key}}"
  }
}
