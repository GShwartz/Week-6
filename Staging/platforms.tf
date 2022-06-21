# Create Linux Command VM
resource "azurerm_linux_virtual_machine" "linux-command" {
  name                            = "Linux_${var.command_vm_name}"
  computer_name                   = var.command_vm_computer_name
  admin_username                  = var.webapp_vm_admin_user
  admin_password                  = var.webapp_vm_admin_password
  location                        = var.location
  network_interface_ids           = [azurerm_network_interface.linux_command-nic.id]
  resource_group_name             = azurerm_resource_group.weight_tracker_rg.name
  size                            = var.webapp_vm_type_b1s
  disable_password_authentication = false

  os_disk {
    name                 = "Linux_CMD-${var.vm_disk_name}"
    caching              = var.webapp_disk_catch
    storage_account_type = var.managed_disk_type
  }

  source_image_reference {
    offer     = var.offer
    publisher = var.publisher
    sku       = var.linux_sku
    version   = var.os_version
  }

}

# Create Virtual Machines
resource "azurerm_virtual_machine" "weight_tracker" {
  count                 = 2
  location              = var.location
  name                  = "WebApp_Server-${count.index + 1}"
  network_interface_ids = [element(azurerm_network_interface.nics.*.id, count.index)]
  resource_group_name   = azurerm_resource_group.weight_tracker_rg.name
  vm_size               = var.webapp_vm_type_b1s

  storage_os_disk {
    create_option     = var.webapp_create_option
    name              = "WebApp_${count.index + 1}-${var.vm_disk_name}"
    caching           = var.webapp_disk_catch
    managed_disk_type = var.managed_disk_type
  }

  storage_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.linux_sku
    version   = var.os_version
  }

  os_profile {
    admin_username = var.webapp_vm_admin_user
    admin_password = var.webapp_vm_admin_password
    computer_name  = "webapp${count.index}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}


