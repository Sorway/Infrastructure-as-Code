# Proxmox

variable "proxmox_api_url" {
  description = "URL de l'API Proxmox (ex: https://pve01.example.local:8006/api2/json)"
  type        = string
}

variable "proxmox_username" {
  description = "Utilisateur Proxmox (ex: root@pam ou terraform@pve)"
  type        = string
}

variable "proxmox_password" {
  description = "Mot de passe Proxmox"
  type        = string
  sensitive   = true
}

variable "proxmox_tls_insecure" {
  description = "Autoriser les certificats non valides"
  type        = bool
  default     = true
}

variable "proxmox_node" {
  description = "Nom du node Proxmox (ex: pve01)"
  type        = string
}

variable "proxmox_storage" {
  description = "Storage Proxmox pour le disque (ex: local-lvm)"
  type        = string
}

variable "proxmox_bridge" {
  description = "Bridge réseau Proxmox (ex: vmbr0)"
  type        = string
}

variable "vm_vlan_tag" {
  description = "VLAN tag (0 = pas de VLAN)"
  type        = number
  default     = 0
}

# VM Windows

variable "template_name" {
  description = "Nom du template Windows Server 2022 sur Proxmox"
  type        = string
}

variable "bios" {
  description = "Type de BIOS"
  type        = string
  default     = "ovmf"
}

variable "vm_name" {
  description = "Nom de la VM"
  type        = string
}

variable "vmid" {
  description = "ID de la VM sur Proxmox"
  type        = number
}

variable "vm_cores" {
  description = "Nombre de vCPU"
  type        = number
  default     = 4
}

variable "vm_memory" {
  description = "RAM en MB"
  type        = number
  default     = 8192
}

variable "vm_disk_size_gb" {
  description = "Taille disque système en Go"
  type        = number
  default     = 80
}

# Windows / Admin local

variable "win_admin_username" {
  description = "Compte local admin Windows (cloud-init)"
  type        = string
  default     = "Administrator"
}

variable "win_admin_password" {
  description = "Mot de passe admin Windows"
  type        = string
  sensitive   = true
}

# Réseau (IP + DNS)

variable "ip_address" {
  description = "Adresse IP de la VM (ex: 192.168.1.1)"
  type        = string
}

variable "ip_prefix" {
  description = "Prefixe CIDR (ex: 24 pour /24)"
  type        = number
}

variable "gateway" {
  description = "Passerelle par défaut"
  type        = string
}

variable "dns_servers" {
  description = "Liste de serveurs DNS"
  type        = list(string)
}