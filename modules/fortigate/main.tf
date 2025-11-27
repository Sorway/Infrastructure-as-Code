locals {
  linux_vms = {
    for name, vm in var.vm_objects : name => vm
    if lower(vm.os_type) == "linux"
  }

  windows_vms = {
    for name, vm in var.vm_objects : name => vm
    if lower(vm.os_type) == "windows"
  }
}

resource "fortios_firewall_address" "vm" {
  for_each = var.vm_objects

  vdomparam = var.vdomparam != "" ? var.vdomparam : null

  name   = each.key
  type   = "ipmask"
  subnet = each.value.subnet

  color      = lower(each.value.os_type) == "linux" ? var.linux_color : var.windows_color
  visibility = "enable"

  associated_interface = try(each.value.associated_interface, "") != "" ? each.value.associated_interface : null
}

resource "fortios_firewall_addrgrp" "linux_group" {
  count = length(local.linux_vms) > 0 ? 1 : 0

  lifecycle {
    prevent_destroy = true
  }

  vdomparam = var.vdomparam != "" ? var.vdomparam : null

  name  = var.linux_group_name
  color = var.linux_color

  dynamic "member" {
    for_each = {
      for name, vm in fortios_firewall_address.vm : name => vm
      if contains(keys(local.linux_vms), name)
    }

    content {
      name = member.value.name
    }
  }
}

resource "fortios_firewall_addrgrp" "windows_group" {
  count = length(local.windows_vms) > 0 ? 1 : 0

  lifecycle {
    prevent_destroy = true
  }

  vdomparam = var.vdomparam != "" ? var.vdomparam : null

  name  = var.windows_group_name
  color = var.windows_color

  dynamic "member" {
    for_each = {
      for name, vm in fortios_firewall_address.vm : name => vm
      if contains(keys(local.windows_vms), name)
    }

    content {
      name = member.value.name
    }
  }
}
