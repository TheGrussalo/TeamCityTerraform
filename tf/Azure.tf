# Configure the Azure Provider
provider "azurerm" { 
}

# Create a resource group
resource "azurerm_resource_group" "network" {
  name     = "grussterraform"
  location = "West Europe"
}

resource "azurerm_servicebus_namespace" "grussservicebus" {
  name                = "grussservicebus"
  location            = "${azurerm_resource_group.network.location}"
  resource_group_name = "${azurerm_resource_group.network.name}"
  sku                 = "standard"
  tags {
    source = "terraform"
  }
}

resource "azurerm_servicebus_topic" "servicebustopic" {
  name                = "grussservicebustopic"
  resource_group_name = "${azurerm_resource_group.network.name}"
  namespace_name      = "${azurerm_servicebus_namespace.grussservicebus.name}"
  enable_partitioning = true
}




