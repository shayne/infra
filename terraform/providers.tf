terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.18.2"
    }
  }
}

provider "proxmox" {
  endpoint = "https://pve0.home.ss.ht:8006/"
  insecure = true
  # pm_api_url      = "https://pve0.home.ss.ht:8006/api2/json"
  # pm_tls_insecure = true
}

