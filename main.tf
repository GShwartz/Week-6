# Configure Resource Group
resource "azurerm_resource_group" "weight_tracker_rg" {
  name     = var.rg_name
  location = var.location

  tags = {
    environment = "Test"
    name        = "Testing_grounds"

  }

  lifecycle {
    prevent_destroy = false

  }

}


