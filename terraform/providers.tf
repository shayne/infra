terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "~> 2.9"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://pve0.home.ss.ht:8006/api2/json"
  pm_tls_insecure = true
}
