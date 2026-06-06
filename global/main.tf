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

module "acr" {
  source = "git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/acr?ref=v0.9.0"

  name                          = module.naming.names.acr
  resource_group_name           = module.resource_group.name
  location                      = var.location
  admin_enabled                 = var.acr_admin_enabled
  sku                           = var.acr_sku
  public_network_access_enabled = var.acr_public_network_access_enabled
  georeplications               = var.acr_georeplications
  tags                          = local.common_tags
}