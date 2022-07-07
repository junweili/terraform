variable "vra_url" {
    default = "https://ca.api.mgmt.cloud.vmware.com"
}

variable "vra_refresh_token" {
  description = "API key"
  type        = string
  sensitive   = true  
}

variable shared_resources {
    type        = bool
    default     = true
}

variable operation_timeout {
    default = 60
}

variable machine_naming_template {
    default = null
}

variable placement_policy {
    default = "DEFAULT"
}

variable extensibility_expression {
    default = ""
}

variable "project_name" {
    default = "vra-junwei"
}

variable project_description {
    default = "fix"
}

variable administrator_roles {
    default = "fritz@vcac-mail.eng.vmware.com"
}

variable member_roles {
    default = "fritz@vcac-mail.eng.vmware.com"
}

variable viewer_roles {
    default = "fritz@vcac-mail.eng.vmware.com"
}

variable "custom_properties" {
    type = map(string)
    default = {
        "CustomAzureSecurityGroup": null,
        "CustomAzureRessourceGroup": null
    }
}
