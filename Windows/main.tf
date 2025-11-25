resource "proxmox_vm_qemu" "win2022" {
  name        = var.vm_name
  target_node = var.proxmox_node

  clone      = var.template_name
  full_clone = true

  bios = var.bios

  # Template Windows Server 2022 configuré pour cloud-init
  os_type  = "cloud-init"
  agent    = 1
  scsihw   = "virtio-scsi-single"
  bootdisk = "sata0"

  cpu {
    cores   = var.vm_cores
    sockets = 1
    type    = "qemu64"
  }
  memory  = var.vm_memory

  # Disque système
  disk {
    slot    = "sata0"
    size    = "${var.vm_disk_size_gb}G"
    type    = "disk"
    storage = var.proxmox_storage
  }

  # Disque cloud-init
  disk {
    slot    = "sata1"
    type    = "cloudinit"
    storage = var.proxmox_storage
  }

  # Réseau
  network {
    id     = 0
    model  = "e1000"
    bridge = var.proxmox_bridge
    tag    = var.vm_vlan_tag
  }

  # Config cloud-init côté Proxmox
  ipconfig0 = "ip=${var.ip_address}/${var.ip_prefix},gw=${var.gateway}"

  # DNS côté Proxmox
  nameserver = join(" ", var.dns_servers)

  # User / password pour cloud-init (Cloudbase-Init dans le template Windows)
  ciuser     = var.win_admin_username
  cipassword = var.win_admin_password
}
