# variables.tf

# Proxmox Connection Settings
variable "pve_host" {
  description = "IP or URL of Proxmox (e.g., https://192.168.1.10:8006/)"
  type        = string
}

variable "pve_token_id" {
  description = "API Token ID (e.g., root@pam!terraform)"
  type        = string
  sensitive   = true
}

variable "pve_token_secret" {
  description = "API Token Secret"
  type        = string
  sensitive   = true
}

# Proxmox Node Configuration
variable "pve_node" {
  description = "Proxmox node name (e.g., pve)"
  type        = string
  default     = "pve"
}

# Container Configuration
variable "container_vmid" {
  description = "VMID for the container"
  type        = number
  default     = 200
}

variable "container_hostname" {
  description = "Hostname for the container"
  type        = string
  default     = "aboutme"
}

variable "container_password" {
  description = "Password for the container root user"
  type        = string
  sensitive   = true
}

# Network Configuration
variable "container_ip" {
  description = "IP address for the container (CIDR format, e.g., 192.168.1.200/24)"
  type        = string
}

variable "container_gateway" {
  description = "Gateway for the container"
  type        = string
}

variable "network_bridge" {
  description = "Network bridge"
  type        = string
  default     = "vmbr0"
}

# OS Template
variable "os_template" {
  description = "OS Template (e.g., local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst)"
  type        = string
}

# Resources
variable "container_cores" {
  description = "CPU cores"
  type        = number
  default     = 1
}

variable "container_memory" {
  description = "RAM in MB"
  type        = number
  default     = 512
}

variable "container_swap" {
  description = "Swap in MB"
  type        = number
  default     = 512
}

# Storage
variable "disk_storage" {
  description = "Storage datastore (e.g., local-lvm)"
  type        = string
  default     = "local-lvm"
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 4
}

# SSH Configuration
variable "ssh_public_key" {
  description = "SSH Public Key string (not path)"
  type        = string
  default     = ""
}

variable "ssh_public_key_path" {
  description = "Path to the SSH Public Key file (e.g., ~/.ssh/id_rsa.pub)"
  type        = string
  default     = ""
}

variable "network_name" {
  description = "Name of the network interface (e.g., eth0)"
  type        = string
}

variable "os_type" {
  description = "Operating system type (e.g., ubuntu)"
  type        = string
}

