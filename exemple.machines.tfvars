vms = {
  ad01 = {
    name      = "ad01"
    template  = "tpl-windows-server-2022"
    bios      = "ovmf"

    cores     = 2
    memory_mb = 4096

    disks = [
      {
        slot    = "sata0"
        size_gb = 50
        storage = "data"
      }
    ]

    nics = [
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
}
