terraform {
  required_providers {
    vra = {
      source  = "vmware/vra"
    }
  }
  required_version = ">= 0.5.1"
}

provider "vra" {
  url           = var.vra_url
  refresh_token = var.vra_refresh_token
  insecure      = true
}

resource "vra_project" "projet" {
  name        = var.project_name
  description = var.project_description

  custom_properties = var.custom_properties

  shared_resources = var.shared_resources

dynamic "administrator_roles" {
  for_each = var.administrator_roles != null ? [0] : []
  content {
    email = var.administrator_roles
    type  = "group"
  }
}

dynamic "member_roles" {
  for_each = var.member_roles != null ? [0] : []
  content {
    email = var.member_roles
    type  = "group"
  }
}

dynamic "viewer_roles" {
  for_each = var.viewer_roles != null ? [0] : []
  content {
    email = var.viewer_roles
    type  = "group"
  }
}

  operation_timeout = var.operation_timeout

  machine_naming_template = var.machine_naming_template

  placement_policy = var.placement_policy

  constraints {
    extensibility {
      expression = var.extensibility_expression
      mandatory  = true
    }
  }
}
