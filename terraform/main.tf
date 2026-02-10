resource "proxmox_virtual_environment_container" "aboutme_container" {
  node_name = var.pve_node
  vm_id     = var.container_vmid

  initialization {
    hostname = var.container_hostname

    ip_config {
      ipv4 {
        address = var.container_ip
        gateway = var.container_gateway
      }
    }

    user_account {
      keys     = var.ssh_public_key_path != "" ? [file(var.ssh_public_key_path)] : []
      password = var.container_password
    }
  }

  network_interface {
    name   = var.network_name
    bridge = var.network_bridge
  }

  operating_system {
    template_file_id = var.os_template
    type             = var.os_type
  }

  cpu {
    cores = var.container_cores
  }

  memory {
    dedicated = var.container_memory
    swap      = var.container_swap
  }

  disk {
    datastore_id = var.disk_storage
    size         = var.disk_size
  }

  features {
    nesting = true
  }

  unprivileged = true
  started      = true
}
