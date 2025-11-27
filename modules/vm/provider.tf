terraform {
  required_version = ">= 1.4.0"

  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
    }
  }
}