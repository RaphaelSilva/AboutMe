terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.50.0"
    }
  }

  backend "pg" {}
}

provider "proxmox" {
  endpoint = var.pve_host
  api_token = "${var.pve_token_id}=${var.pve_token_secret}"
  insecure  = true
}
