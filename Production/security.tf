# Create NSG for App-Servers
resource "azurerm_network_security_group" "apps_nsg" {
  location            = var.location
  name                = "App-Servers-NSG"
  resource_group_name = azurerm_resource_group.weight_prod.name

  # Allow SSH Access
  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 22
    destination_address_prefix = "10.0.1.0/24"

    # Allow Access ONLY from this CIDR source
    source_address_prefix = "10.0.10.0/28"
  }

  # Allow HTTP on port 8080
  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 8080
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.1.0/24"
  }

  # Deny Everything Else
  security_rule {
    name                       = "Deny_All"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.1.0/24"

  }

  depends_on = [azurerm_virtual_network.vnet]

}

# Create NSG for Linux Command VMs
resource "azurerm_network_security_group" "linux_command_nsg" {
  location            = var.location
  name                = "Linux_CMD-NSG"
  resource_group_name = azurerm_resource_group.weight_prod.name
  depends_on          = [azurerm_virtual_network.vnet]

  # Allow SSH Access
  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 22
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.10.0/29"
  }

  # Deny Everything Else
  security_rule {
    name                       = "Deny_All"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.10.0/29"

  }

}

# Create NSG for DB Servers
resource "azurerm_network_security_group" "db_nsg" {
  location            = var.location
  name                = "Databases-NSG"
  resource_group_name = azurerm_resource_group.weight_prod.name

  # Allow DB Port Access
  security_rule {
    name                       = "PostgreSQL"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefixes    = azurerm_subnet.app_subnet.address_prefixes
    destination_address_prefix = "10.0.2.0/28"

  }

  # Deny Everything Else
  security_rule {
    name                       = "Deny_All"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.2.0/28"

  }

  depends_on = [azurerm_virtual_network.vnet, azurerm_subnet.app_subnet]
}

#### Network ####
# Link App-Servers subnet to NSG
resource "azurerm_subnet_network_security_group_association" "apps_subnet_nsg" {
  network_security_group_id = azurerm_network_security_group.apps_nsg.id
  subnet_id                 = azurerm_subnet.app_subnet.id

}

# Link Linux Command VMs subnet to NSG
resource "azurerm_subnet_network_security_group_association" "linux_command_subnet_nsg" {
  network_security_group_id = azurerm_network_security_group.linux_command_nsg.id
  subnet_id                 = azurerm_subnet.linux_command_subnet.id

}

# Link DB Subnet to NSG
resource "azurerm_subnet_network_security_group_association" "db_subnet_nsg" {
  network_security_group_id = azurerm_network_security_group.db_nsg.id
  subnet_id                 = azurerm_subnet.db_subnet.id

}

# Link App-Servers NIC to Apps NSG
resource "azurerm_network_interface_security_group_association" "nics_nsg" {
  count                     = 3
  network_interface_id      = azurerm_network_interface.nics[count.index].id
  network_security_group_id = azurerm_network_security_group.apps_nsg.id

}

# Link Linux Terminal NIC to Command NSG
resource "azurerm_network_interface_security_group_association" "linux_terminal_nic_nsg" {
  network_interface_id      = azurerm_network_interface.linux_command-nic.id
  network_security_group_id = azurerm_network_security_group.linux_command_nsg.id

}

#### Load Balancer ####
# Create a Load Balancer rule for HTTP access
resource "azurerm_lb_rule" "web" {
  backend_port                   = 8080
  frontend_ip_configuration_name = "PublicIPAddress"
  frontend_port                  = 8080
  loadbalancer_id                = azurerm_lb.load_balancer.id
  name                           = "Web"
  protocol                       = "Tcp"
  probe_id                       = azurerm_lb_probe.web_probe.id
  disable_outbound_snat          = true
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool.id]

  depends_on = [azurerm_lb.load_balancer]

}

# Create a Load Balancer NAT Rule
resource "azurerm_lb_nat_rule" "nat_rule_ssh" {
  name                           = "SSH"
  resource_group_name            = azurerm_resource_group.weight_prod.name
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"
  frontend_port                  = 22
  loadbalancer_id                = azurerm_lb.load_balancer.id
  protocol                       = "Tcp"

  depends_on = [azurerm_lb.load_balancer]
}

# Create a Load Balancer Outbound rule
resource "azurerm_lb_outbound_rule" "outbound" {
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
  loadbalancer_id         = azurerm_lb.load_balancer.id
  name                    = "Any"
  protocol                = "All"

  frontend_ip_configuration {
    name = "PublicIPAddress"
  }

  depends_on = [azurerm_lb.load_balancer]

}

# Create Azure Key Vault
#resource "azurerm_key_vault" "vault" {
#  location                   = var.location
#  name                       = "WightTVault"
#  resource_group_name        = azurerm_resource_group.weight_prod.name
#  sku_name                   = "standard"
#  tenant_id                  = data.azurerm_client_config.client_cfg.tenant_id
#  soft_delete_retention_days = 7
#  purge_protection_enabled   = false
#  enable_rbac_authorization  = true
#  access_policy {
#    object_id = var.vault_object_id
#    tenant_id = data.azurerm_client_config.client_cfg.tenant_id
#
#    key_permissions = [
#      "Get", "Backup", "Create", "Import", "List", "Recover", "Restore", "Update", "Verify",
#    ]
#
#    secret_permissions = [
#      "Backup", "Delete", "Get", "List", "Recover", "Restore", "Set",
#    ]
#
#    storage_permissions = [
#      "Backup", "Delete", "Get", "List", "Recover", "RegenerateKey", "Restore", "Set", "Update",
#    ]
#
#  }
#}