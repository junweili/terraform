# Azurerm Provider configuration using VRA
provider "azurerm" {
  features {}
  #CloudZone
}
variable "rg_name" {
    type    = string
  }
  variable "name" { 
    type = string
  }
  variable "topico" { 
    type = string
  }
  variable "tags_custom" {
    description = "Tags customizadas"
    type        = map(any)
    default     = {}
  }
module "DataRG" {
  source = "./Azu-DataRG"
  rg_name = var.rg_name
}
resource "azurerm_eventhub_namespace" "eventhub" {
  name                = var.name
  location = module.DataRG.rg_out.location
  resource_group_name = module.DataRG.rg_out.name
  sku                 = "Standard"
  capacity            = 2
  tags = var.tags_custom
}
resource "azurerm_eventhub" "aevent" {
  name                = var.topico
  namespace_name      = azurerm_eventhub_namespace.eventhub.name
  resource_group_name = module.DataRG.rg_out.name
  partition_count     = 2
  message_retention   = 1
}
resource "azurerm_eventhub_authorization_rule" "example" {
  name                = "authrule"
  namespace_name      = azurerm_eventhub_namespace.eventhub.name
  eventhub_name       = azurerm_eventhub.aevent.name
  resource_group_name = module.DataRG.rg_out.name
  listen              = true
  send                = false
  manage              = false
}
