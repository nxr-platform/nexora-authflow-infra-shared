module "resource_group" {
  source = "git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/resource-group?ref=v0.1.3"

  company   = local.company
  domain    = local.domain
  component = "shared"
  location  = var.location
  tags      = local.common_tags
}

module "network" {
  source = "git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/network?ref=v0.2.0"

  resource_group_name = module.resource_group.name
  domain              = local.domain
  company             = local.company
  component           = "shared"
  location            = var.location
  vnet_address_space  = var.vnet_address_space
  tags                = local.common_tags
}

module "subnet" {
  source = "git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/subnet?ref=v0.3.0"

  resource_group_name = module.resource_group.name
  vnet_name           = module.network.name
  subnets             = var.subnets
  tags                = local.common_tags
}

module "nsg" {
  source = "git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/nsg?ref=v0.4.0"

  resource_group_name = module.resource_group.name
  location            = var.location
  nsgs                = var.nsgs
  tags                = local.common_tags
}


