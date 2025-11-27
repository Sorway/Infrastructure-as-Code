output "vms_info" {
  value = {
    for k, m in module.VirtualMachine : k => {
      id   = m.vm_id
      name = m.vm_name
      node = m.vm_node
      ip   = m.vm_ip
    }
  }
}
