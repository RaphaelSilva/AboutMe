output "container_ip" {
  value = var.container_ip
  description = "The IP address of the created container"
}

output "container_id" {
  value = proxmox_virtual_environment_container.aboutme_container.vm_id
  description = "The VMID of the created container"
}
