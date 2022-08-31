terraform {

  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~>2.62"
      configuration_aliases = [azurerm.hub,azurerm.link]
    }
  }
}

resource "azurerm_virtual_network_peering" "vnettohub" {
  name                         = "Link${var.vnet_name}ToHub${var.vnet_hub_name}"
  resource_group_name          = var.rg_name
  virtual_network_name         = var.vnet_name
  remote_virtual_network_id    = var.vnet_hub_id # 5dfe0195-f1a0-4893-978c-86157636407d
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = true
  provider                     = azurerm.link
}

resource "azurerm_virtual_network_peering" "hubtovnet" {
  name                         = "Hub${var.vnet_name}tolink${var.vnet_hub_name}"
  resource_group_name          = var.rg_hub_name #"HUB-VNET-RG"
  virtual_network_name         = var.vnet_hub_name #"HUB-VNET"
  remote_virtual_network_id    = var.vnet_remote_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  provider                     = azurerm.hub //provider da hub corp
}


