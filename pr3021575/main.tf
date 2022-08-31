# Azurerm Provider configuration VRA
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  alias = "link"
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id2
  client_id       = var.client_id2
  client_secret   = var.client_secret2
  tenant_id       = var.tenant_id2
  alias = "hub"
}

data "azurerm_virtual_network" "vnetspoke" {
  name                = var.vnet_name
  resource_group_name = var.rg_name
  provider            = azurerm.link
}
data "azurerm_virtual_network" "vnethub" {
  name                = var.vnet_hub_name
  resource_group_name = var.rg_hub_name
  provider            = azurerm.hub
}

module "peering" {
  source = "./Azu-Peeringdev"
  rg_name = data.azurerm_virtual_network.vnetspoke.resource_group_name
  rg_hub_name = data.azurerm_virtual_network.vnethub.resource_group_name
  vnet_name = data.azurerm_virtual_network.vnetspoke.name
  vnet_hub_name = data.azurerm_virtual_network.vnethub.name
  vnet_hub_id = data.azurerm_virtual_network.vnethub.id
  vnet_remote_id = data.azurerm_virtual_network.vnetspoke.id
  providers = {
    azurerm.hub = azurerm.hub
    azurerm.link = azurerm.link
  }
}
