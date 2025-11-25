proxmox_api_url      = "https://HOST:8006/api2/json"
proxmox_username     = "TOKEN_USER"
proxmox_password     = "TOKEN_SECRET"
proxmox_tls_insecure = true

proxmox_node    = "NODE"
proxmox_storage = "local-lvm"
proxmox_bridge  = "vmbr0"
vm_vlan_tag     = 0

template_name    = "windows-server-2022"
vm_name          = "WIN2022-SRV01"
vmid             = 100
vm_cores         = 2
vm_memory        = 4096
vm_disk_size_gb  = 40

win_admin_username = "Administrateur"
win_admin_password = "Password123!"

ip_address = "192.168.1.1"
ip_prefix  = 24
gateway    = "192.168.1.254"
dns_servers = [
  "1.1.1.1",
  "8.8.8.8"
]