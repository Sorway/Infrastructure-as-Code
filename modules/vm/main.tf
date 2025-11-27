resource "proxmox_vm_qemu" "vm" {
  name        = var.name
  vmid        = var.vmid
  target_node = var.node

  pool = var.pool != "" ? var.pool : null

  clone      = var.template
  full_clone = var.clone_type == "full" ? true : false

  bios     = var.bios
  os_type  = "cloud-init"
  agent    = 1
  scsihw   = "virtio-scsi-single"
  bootdisk = "scsi0"

  cpu {
    cores   = var.cores
    sockets = var.sockets
    type    = "qemu64"
  }

  memory  = var.memory_mb
  balloon = var.balloon_mb

  # Disque (DATA)
  dynamic "disk" {
    for_each = var.disks
    content {
      slot    = disk.value.slot
      type    = "disk"
      storage = disk.value.storage
      size    = "${disk.value.size_gb}G"
    }
  }

  # CD-ROM / ISO
  dynamic "disk" {
    for_each = var.dvd == null || var.dvd.enabled == false ? [] : [var.dvd]
    content {
      slot    = "ide2"
      type    = "cdrom"
      storage = disk.value.storage
    }
  }

  # Disque Cloud-init
  dynamic "disk" {
    for_each = var.cloudinit_disk_enabled ? [1] : []
    content {
      slot    = var.cloudinit_disk_slot
      type    = "cloudinit"
      storage = var.cloudinit_storage
    }
  }

  # Réseau
  dynamic "network" {
    for_each = { for idx, network in var.networks : idx => network }
    content {
      id     = network.key
      model  = network.value.model
      bridge = network.value.bridge
      tag    = network.value.vlan_tag
    }
  }

  # Cloud-init
  ipconfig0  = var.ipconfig
  nameserver = var.nameserver
  ciuser     = var.ciuser
  cipassword = var.cipassword
  sshkeys    = var.sshkeys
}
