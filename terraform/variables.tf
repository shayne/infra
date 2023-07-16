variable "nixos_cts" {
  description = "Map of NixOS LXC container definitions"
  type = map(object({
    hostname                  = optional(string)
    domain                    = optional(string, "home.ss.ht")
    node_name                 = optional(string, "pve0")
    cpu_cores                 = optional(number, 2)
    memory_dedicated          = optional(number, 4096)
    disk_datastore_id         = optional(string, "array")
    disk_size                 = optional(number, 8)
    network_interface_name    = optional(string, "eth0")
    network_interface_vlan_id = optional(number, 3)
    features_nesting          = optional(bool, true)
  }))
}
