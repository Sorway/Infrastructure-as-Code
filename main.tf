locals {
  vms_normalized = {
    for k, v in var.vms : k => {
      name        = v.name
      vmid        = v.vmid
      os_type      = v.os_type
      fw_interface = try(v.fw_interface, "")
      bios        = try(v.bios, null)
      node        = coalesce(try(v.node, null), var.default_node)
      pool        = try(v.pool, null)

      template   = v.template
      clone_type = try(v.clone_type, "full")

      cores      = v.cores
      sockets    = try(v.sockets, 1)
      memory_mb  = v.memory_mb
      balloon_mb = try(v.balloon_mb, 0)

      disks = [
        for d in try(v.disks, []) : {
          slot    = d.slot
          size_gb = d.size_gb
          storage = coalesce(try(d.storage, null), var.default_storage)
          ssd     = try(d.ssd, false)
        }
      ]

      networks = [
        for n in try(v.networks, []) : {
          model    = n.model
          bridge   = n.bridge
          vlan_tag = try(n.vlan_tag, null)
        }
      ]

      dvd = v.dvd == null ? null : {
        enabled  = v.dvd.enabled
        iso_file = v.dvd.iso_file
        storage  = coalesce(try(v.dvd.storage, null), var.default_iso_storage)
      }

      ciuser     = try(v.ciuser, null)
      cipassword = try(v.cipassword, null)
      ipconfig  = try(v.ipconfig, null)
      nameserver = try(v.nameserver, null)
      sshkeys    = try(v.sshkeys, null)
    }
  }

  vm_ip_cidrs = {
    for name, v in local.vms_normalized : name =>
      element(
        split("=", element(split(",", v.ipconfig), 0)),
        1
      )
  }

  fortigate_objects = {
    for name, v in local.vms_normalized : name => {
      os_type = v.os_type
      subnet = "${element(split("/", local.vm_ip_cidrs[name]), 0)} 255.255.255.255"
      associated_interface = v.fw_interface
    }
    if v.ipconfig != ""
  }
}

module "VirtualMachine" {
  source = "./modules/vm"

  for_each = local.vms_normalized

  name        = each.value.name
  vmid        = each.value.vmid
  bios        = each.value.bios
  node        = each.value.node
  pool        = each.value.pool

  template   = each.value.template
  clone_type = each.value.clone_type

  cores      = each.value.cores
  sockets    = each.value.sockets
  memory_mb  = each.value.memory_mb
  balloon_mb = each.value.balloon_mb

  disks = each.value.disks
  networks  = each.value.networks
  dvd   = each.value.dvd

  ciuser     = each.value.ciuser
  cipassword = each.value.cipassword
  ipconfig  = each.value.ipconfig
  nameserver = each.value.nameserver
  sshkeys    = each.value.sshkeys
}

module "FortiGate" {
  source = "./modules/fortigate"

  vm_objects         = local.fortigate_objects
  linux_group_name   = var.fortigate_linux_group
  windows_group_name = var.fortigate_windows_group

  vdomparam           = var.fortigate_vdom
}