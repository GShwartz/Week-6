# ==================================================== #
#                        Main                          #
# ==================================================== #
variable "rg_name" {
  description = "Resource Group Name"
  default     = "Staging"

}

variable "location" {
  description = "Set Location"
  default     = "East US"

}

# ==================================================== #
#                       Network                        #
# ==================================================== #
variable "virtual_network_name" {
  description = "Name for the Virtual Network"
  default     = "WeightTracker-Vnet"

}

variable "db_dns_zone_name" {
  description = "DNS Name for Flexible server"
  default     = "weightdb"

}

variable "command_nic_ip_configuration_name" {
  description = "Name of the NIC attached to Command VM"
  default     = "Command"
}

##### Load Balancer #####
variable "lb_backend_ap_ip_configuration_name" {
  description = "Name the NIC to be shown under the load balancer backend address pool"
  default     = "AppServer-NIC"

}

# ==================================================== #
#                      Platforms                       #
# ==================================================== #
# Windows Server 2022 SKU used to build VMs
# Windows Server Source Image Preferences
variable "win_server_publisher" {
  type    = string
  default = "MicrosoftWindowsServer"

}

variable "win_server_offer" {
  type    = string
  default = "WindowsServer"

}

variable "windows_2022_sku" {
  type        = string
  description = "Windows Server 2022 SKU used to build VMs"
  default     = "2019-Datacenter"

}

variable "win_server_os_version" {
  type    = string
  default = "latest"

}

# Windows Server 2019 SKU used to build VMs
variable "windows_2019_sku" {
  type        = string
  description = "Windows Server 2019 SKU used to build VMs"
  default     = "2019-Datacenter"
}

##### Linux OS Profile #####
variable "publisher" {
  description = "OS Publisher"
  default     = "Canonical"

}

variable "offer" {
  description = "Source"
  default     = "0001-com-ubuntu-server-focal"

}

variable "linux_sku" {
  description = "Distribution"
  default     = "20_04-lts-gen2"

}

variable "os_version" {
  description = "Version"
  default     = "latest"

}

##### WebApp VM Platform #####
variable "webapp_vm_admin_user" {
  description = "VM Admin User"
  default     = "gstudent"

}

variable "webapp_vm_admin_password" {
  description = "VM Admin Password"
  default     = "SelaBootcamp4!"

}

variable "webapp_vm_type_b1s" {
  description = "VM Type (Usually Standard_B1s)"
  default     = "Standard_B1s"

}

variable "webapp_vm_type_b1ms" {
  description = "VM Type (Usually Standard_B1s)"
  default     = "Standard_B1ms"

}

variable "webapp_storage_os_disk_name" {
  description = "Disk Name"
  default     = "WeightTrackerVM-Disk"

}

variable "managed_disk_type" {
  description = "Managed Disk Type"
  default     = "Standard_LRS"

}

variable "webapp_create_option" {
  description = "Create Option"
  default     = "FromImage"

}

variable "webapp_disk_catch" {
  description = "Disk Catch"
  default     = "ReadWrite"

}

variable "webapp_disk_size_gb" {
  description = "Disk Size GB"
  default     = 127

}

variable "vm_disk_name" {
  description = "Disk Name"
  default     = "Disk"

}

variable "webapp_vm_name" {
  description = "Name of the WebApp Virtual Machine"
  default     = "WeightTrackerVM"

}

variable "webapp_vm_computer_name" {
  description = "Name of the Computer inside the webapp VM"
  default     = "webapp"

}

##### Terminal VM Platform #####
variable "command_vm_computer_name" {
  description = "Name of the Computer inside the terminal VM"
  default     = "Command"

}

variable "command_vm_name" {
  description = "Name of the Terminal VM"
  default     = "CMD"

}

variable "command_vm_admin_password" {
  description = "Command Admin Password"
  default     = "SelaBootcamp4!"

}

variable "db_user" {
  description = "Database User"
  default     = "postgres"

}

variable "db_password" {
  description = "Database Password"
  default     = "p@ssw0rd42"

}

variable "vault_object_id" {
  description = "Object ID for Key Vault"
  default     = "1cd9518e-559e-43c6-a82b-8b5e06e59e71"

}

