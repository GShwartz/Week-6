output "webapp_vm_admin_password" {
  value     = var.webapp_vm_admin_password
  sensitive = true

}

output "command_vm_password" {
  value     = var.command_vm_admin_password
  sensitive = true

}
