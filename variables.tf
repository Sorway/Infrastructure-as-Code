# Connexion Proxmox
variable "proxmox_api_url" {
  type        = string
  description = "URL API Proxmox, ex: https://pve1:8006/api2/json"
}

variable "pm_api_token_id" {
  type        = string
  description = "Token ID Proxmox"
}

variable "pm_api_token_secret" {
  type        = string
  description = "API token secret"
  sensitive   = true
}

# Bucket S3
variable "s3_endpoint" {
  description = "Endpoint S3 pour MinIO"
  type        = string
}

variable "s3_bucket" {
  description = "Nom du bucket S3 pour stocker le state Terraform"
  type        = string
}

variable "s3_key" {
  description = "Chemin/clé du fichier terraform.tfstate dans le bucket"
  type        = string
}

variable "s3_access_key" {
  description = "Access key MinIO"
  type        = string
  sensitive   = true
}

variable "s3_secret_key" {
  description = "Secret key MinIO"
  type        = string
  sensitive   = true
}


# Defaults cluster
variable "default_node" {
  type        = string
  description = "Proxmox node par défaut"
}

variable "default_pool" {
  type        = string
  description = "Pool Proxmox par défaut"
  default     = ""
}

variable "default_storage" {
  type        = string
  description = "Storage par défaut pour les disques"
}

variable "default_iso_storage" {
  type        = string
  description = "Storage par défaut pour les ISOs"
}

# Définition des VMs
variable "vms" {
  description = "VMs à déployer sur Proxmox"
  type = map(object({
    name   = string
    vmid   = optional(number)
    bios   = optional(string)
    template   = string
    clone_type = optional(string, "full")

    node        = optional(string)
    pool        = optional(string)

    cores      = number
    sockets    = optional(number, 1)
    memory_mb  = number
    balloon_mb = optional(number, 0)

    disks = optional(list(object({
      slot    = string      # ex: "scsi1", "sata1"
      size_gb = number
      storage = optional(string)
    })), [])

    networks = optional(list(object({
      model    = string
      bridge   = string
      vlan_tag = optional(number)
    })), [])

    dvd = optional(object({
      enabled  = bool
      iso_file = string
      storage  = optional(string)
    }), null)

    cloudinit_disk_enabled = optional(bool, false)
    cloudinit_disk_slot    = optional(string)
    cloudinit_storage      = optional(string)

    ipconfig  = optional(string)
    nameserver = optional(string)
    ciuser     = optional(string)
    cipassword = optional(string)
    sshkeys    = optional(string)
  }))
}