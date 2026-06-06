locals {
  company   = "nxr"
  domain    = "authflow"
  component = "global"

  common_tags = merge(var.tags, {
    product     = "authflow"
    managed-by  = "terraform"
    environment = "global"
    owner       = "platform-team"
    cost-centre = "nexora-platform"
  })
}

module "naming" {
  source = "git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/naming?ref=v0.0.0"

  company   = local.company
  domain    = local.domain
  component = local.component
  location  = var.location
}

module "resource_group" {
  source = "git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/resource-group?ref=v0.1.4"

  name     = module.naming.names.resource_group
  location = var.location
  tags     = local.common_tags
}