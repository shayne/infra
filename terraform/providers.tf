terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0"
    }
    tailscale = {
      source  = "tailscale/tailscale"
      version = ">= 0"
    }
  }
}

variable "proxmox_username" {}
variable "proxmox_password" {}

provider "proxmox" {
  endpoint = "https://pve0.home.ss.ht:8006/"
  insecure = true
  username = var.proxmox_username
  password = var.proxmox_password
}

variable "tailscale_api_key" {}

provider "tailscale" {
  api_key = var.tailscale_api_key
  tailnet = "shaynesweeney@gmail.com"
}
