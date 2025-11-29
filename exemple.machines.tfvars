vms = {
  adcs01 = {
    name         = "adcs01"
    os_type      = "windows"
    template     = "tpl-windows-server-2022"
    bios         = "ovmf"
    fw_interface = "lan"

    cores     = 2
    memory_mb = 4096

    disks = [
      {
        slot    = "sata0"
        size_gb = 50
        storage = "data"
      }
    ]

    networks = [
      {
        model    = "virtio"
        bridge   = "vmbr0"
        vlan_tag = 20
      }
    ]

    ciuser     = "Administrateur"
    cipassword = "Password123!"
    ipconfig   = "ip=192.168.1.1/24,gw=192.168.1.254"
    nameserver = "1.1.1.1 8.8.8.8"
  }
  VL-TEST = {
    name      = "VL-TEST"
    os_type   = "linux"
    template  = "tmpl-debian-13"
    bios      = "seabios"
    fw_interface = "lan"

    cores     = 2
    memory_mb = 1024

    disks = [
      {
        slot    = "sata0"
        size_gb = 32
        storage = "data"
      }
    ]

    networks = [
      {
        model        = "e1000"
        bridge       = "vmbr0"
        vlan_tag     = 50
      }
    ]

    ciuser     = "root"
    cipassword = "Admin123!"
    ipconfig   = "ip=192.168.1.2/24,gw=192.168.1.254"
    nameserver = "1.1.1.1 8.8.8.8"
  }
}
