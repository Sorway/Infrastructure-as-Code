variable "vm_objects" {
  description = "VMs à créer sur le FortiGate (adresse + OS + interface)"
  type = map(object({
    subnet              = string
    os_type             = string
    associated_interface = optional(string)
  }))
}

variable "linux_group_name" {
  type    = string
  default = "VM_Linux"
}

variable "windows_group_name" {
  type    = string
  default = "VM_Windows"
}

variable "linux_color" {
  type    = number
  default = 28
}

variable "windows_color" {
  type    = number
  default = 18
}

variable "vdomparam" {
  type    = string
  default = ""
}
