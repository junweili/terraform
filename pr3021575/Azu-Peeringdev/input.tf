variable "rg_name" {
    type = string
    description = "resource group da vnet spoke criada"
}

variable "rg_hub_name" {
    type = string
    description = "resource group da vnet hub criada"
}

variable "vnet_name" {
    type = string
    description = "nome da vnet spoke criada"
}

variable "vnet_hub_name" {
    type = string
    description = "nome da vnet hub criada"
}

variable "vnet_hub_id" {
    type = string
    description = "id da vnet do hub corp"
}

variable "vnet_remote_id" {
    type = string
    description = "id da vnet do link spoke"
}

