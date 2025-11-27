variable "name" {
  type = string
}

variable "vmid" {
  type = number
}

variable "node" {
  type = string
}

variable "pool" {
  type    = string
  default = ""
}

variable "template" {
  type = string
}

variable "clone_type" {
  type    = string
  default = "full"
}

variable "bios" {
  type    = string
  default = "seabios"
}

variable "cores" {
  type = number
}

variable "sockets" {
  type    = number
  default = 1
}

variable "memory_mb" {
  type = number
}

variable "balloon_mb" {
  type    = number
  default = 0
}

variable "disks" {
  type = list(object({
    slot    = string
    size_gb = number
    storage = string
  }))
  default = []
}

variable "dvd" {
  type = object({
    enabled  = bool
    iso_file = string
    storage  = string
  })
  default = null
}

variable "cloudinit_disk_enabled" {
  type    = bool
  default = true
}

variable "cloudinit_disk_slot" {
  type    = string
  default = "scsi2"
}

variable "cloudinit_storage" {
  type    = string
  default = "local-lvm"
}

variable "networks" {
  type = list(object({
    model    = string
    bridge   = string
    vlan_tag = number
  }))
  default = []
}

variable "ipconfig" {
  type    = string
  default = null
}

variable "nameserver" {
  type    = string
  default = null
}

variable "ciuser" {
  type    = string
  default = null
}

variable "cipassword" {
  type    = string
  default = null
}

variable "sshkeys" {
  type    = string
  default = null
}
