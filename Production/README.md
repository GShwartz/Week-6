# Production Environment
## Virtual Network Topology
<img src="https://i.postimg.cc/8znHcXJx/production-vnet-topology.jpg"> <br />

## Installation
  * Install Terraform (https://learn.hashicorp.com/tutorials/terraform/install-cli)
  * Install Azure CLI (https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
  * Run Powershell & login to your Azure account with az login (a web browser will open to sign you in)
  * (Optional) Apply new alias to terraform by typing in PowerShell: New-Alias -Name "tf" -Value "terraform" 
  * Navigate to Environment directory
  * Apply IAAC with terraform apply 

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.0.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.0.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_availability_set.availability_set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/availability_set) | resource |
| [azurerm_lb.load_balancer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.backend_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_nat_rule.nat_rule_ssh](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_nat_rule) | resource |
| [azurerm_lb_outbound_rule.outbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_outbound_rule) | resource |
| [azurerm_lb_probe.rdp_probe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_probe.web_probe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.web](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_linux_virtual_machine.linux-command](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.linux_command-nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface.nics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_backend_address_pool_association.apps_nics_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_backend_address_pool_association) | resource |
| [azurerm_network_interface_security_group_association.linux_terminal_nic_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_interface_security_group_association.nics_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.apps_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.db_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.linux_command_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_postgresql_flexible_server.server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_postgresql_flexible_server_configuration.dbconf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_database.database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_private_dns_zone.dbdns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.zone_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.linux_command_pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.load_balancer_pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.weight_prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.app_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.db_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.linux_command_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.apps_subnet_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.db_subnet_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.linux_command_subnet_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_machine.weight_tracker](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_client_config.client_cfg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_command_nic_ip_configuration_name"></a> [command\_nic\_ip\_configuration\_name](#input\_command\_nic\_ip\_configuration\_name) | Name of the NIC attached to Command VM | `string` | `"Command"` | no |
| <a name="input_command_vm_admin_password"></a> [command\_vm\_admin\_password](#input\_command\_vm\_admin\_password) | Command Admin Password | `string` | `"SelaBootcamp4!"` | no |
| <a name="input_command_vm_computer_name"></a> [command\_vm\_computer\_name](#input\_command\_vm\_computer\_name) | Name of the Computer inside the terminal VM | `string` | `"controller"` | no |
| <a name="input_command_vm_name"></a> [command\_vm\_name](#input\_command\_vm\_name) | Name of the Terminal VM | `string` | `"Controller"` | no |
| <a name="input_db_dns_zone_name"></a> [db\_dns\_zone\_name](#input\_db\_dns\_zone\_name) | DNS Name for Flexible server | `string` | `"weightdb"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Database Password | `string` | `"p@ssw0rd42"` | no |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user) | Database User | `string` | `"postgres"` | no |
| <a name="input_instances"></a> [instances](#input\_instances) | Number of VM Instances | `number` | `3` | no |
| <a name="input_lb_backend_ap_ip_configuration_name"></a> [lb\_backend\_ap\_ip\_configuration\_name](#input\_lb\_backend\_ap\_ip\_configuration\_name) | Name the NIC to be shown under the load balancer backend address pool | `string` | `"WebServer-NIC"` | no |
| <a name="input_linux_sku"></a> [linux\_sku](#input\_linux\_sku) | Distribution | `string` | `"20_04-lts-gen2"` | no |
| <a name="input_location"></a> [location](#input\_location) | Set Location | `string` | `"East US"` | no |
| <a name="input_managed_disk_type"></a> [managed\_disk\_type](#input\_managed\_disk\_type) | Managed Disk Type | `string` | `"Standard_LRS"` | no |
| <a name="input_offer"></a> [offer](#input\_offer) | Source | `string` | `"0001-com-ubuntu-server-focal"` | no |
| <a name="input_os_version"></a> [os\_version](#input\_os\_version) | Version | `string` | `"latest"` | no |
| <a name="input_publisher"></a> [publisher](#input\_publisher) | OS Publisher | `string` | `"Canonical"` | no |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | Resource Group Name | `string` | `"Production"` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | Name for the Virtual Network | `string` | `"WeightTracker-Vnet"` | no |
| <a name="input_vm_disk_name"></a> [vm\_disk\_name](#input\_vm\_disk\_name) | Disk Name | `string` | `"Disk"` | no |
| <a name="input_webapp_create_option"></a> [webapp\_create\_option](#input\_webapp\_create\_option) | Create Option | `string` | `"FromImage"` | no |
| <a name="input_webapp_disk_catch"></a> [webapp\_disk\_catch](#input\_webapp\_disk\_catch) | Disk Catch | `string` | `"ReadWrite"` | no |
| <a name="input_webapp_disk_size_gb"></a> [webapp\_disk\_size\_gb](#input\_webapp\_disk\_size\_gb) | Disk Size GB | `number` | `127` | no |
| <a name="input_webapp_storage_os_disk_name"></a> [webapp\_storage\_os\_disk\_name](#input\_webapp\_storage\_os\_disk\_name) | Disk Name | `string` | `"WeightTrackerVM-Disk"` | no |
| <a name="input_webapp_vm_admin_password"></a> [webapp\_vm\_admin\_password](#input\_webapp\_vm\_admin\_password) | VM Admin Password | `string` | `"SelaBootcamp4!"` | no |
| <a name="input_webapp_vm_admin_user"></a> [webapp\_vm\_admin\_user](#input\_webapp\_vm\_admin\_user) | VM Admin User | `string` | `"gstudent"` | no |
| <a name="input_webapp_vm_computer_name"></a> [webapp\_vm\_computer\_name](#input\_webapp\_vm\_computer\_name) | Name of the Computer inside the webapp VM | `string` | `"webapp"` | no |
| <a name="input_webapp_vm_type_b1ms"></a> [webapp\_vm\_type\_b1ms](#input\_webapp\_vm\_type\_b1ms) | VM Type (Usually Standard\_B1s) | `string` | `"Standard_B1ms"` | no |
| <a name="input_webapp_vm_type_b1s"></a> [webapp\_vm\_type\_b1s](#input\_webapp\_vm\_type\_b1s) | VM Type (Usually Standard\_B1s) | `string` | `"Standard_B1s"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_command_vm_password"></a> [command\_vm\_password](#output\_command\_vm\_password) | n/a |
| <a name="output_webapp_vm_admin_password"></a> [webapp\_vm\_admin\_password](#output\_webapp\_vm\_admin\_password) | n/a |
<!-- END_TF_DOCS -->

# Estimated Costs
<img src="https://i.postimg.cc/dQg0bf93/production-costs.jpg"> <br />
