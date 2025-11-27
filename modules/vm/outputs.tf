output "vm_id" {
  value = proxmox_vm_qemu.vm.id
}

output "vm_name" {
  value = proxmox_vm_qemu.vm.name
}

output "vm_node" {
  value = proxmox_vm_qemu.vm.target_node
}

output "vm_ip" {
  value = try(proxmox_vm_qemu.vm.default_ipv4_address, null)
}