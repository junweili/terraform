# Configure the Microsoft Azure Provider
provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x. 
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}
    alias = "azure1"
}

provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x. 
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}
    alias = "azure2"
}

# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "myterraformgroup1" {
    name     = var.rg_name1
    provider            = azurerm.azure1
}

# Create virtual network
data "azurerm_virtual_network" "myterraformnetwork1" {
    name                = "myVnet1"
    address_space       = ["10.0.0.0/16"]
    resource_group_name = azurerm_resource_group.myterraformgroup1.name
    provider            = azurerm.azure1
}

# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "myterraformgroup2" {
    name     = var.rg_name2
    provider            = azurerm.azure2
}

# Create virtual network
data "azurerm_virtual_network" "myterraformnetwork2" {
    name                = "myVnet2"
    address_space       = ["10.0.0.0/16"]
    resource_group_name = azurerm_resource_group.myterraformgroup2.name
    provider            = azurerm.azure2
}
