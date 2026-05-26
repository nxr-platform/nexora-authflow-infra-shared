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
  source = "git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/subnet?ref=v0.3.3"

  resource_group_name = module.resource_group.name
  vnet_name           = module.network.name
  subnets             = var.subnets
  nsg_ids             = module.nsg.nsg_ids
  route_table_ids     = module.route-table.route_table_ids
  tags                = local.common_tags
}

module "nsg" {
  source = "git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/nsg?ref=v0.4.0"

  resource_group_name = module.resource_group.name
  location            = var.location
  nsgs                = var.nsgs
  tags                = local.common_tags
}

module "route-table" {
  source = "git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/route-table?ref=v0.5.0"

  resource_group_name = module.resource_group.name
  location            = var.location
  route_tables        = var.route_tables
  tags                = local.common_tags
}

module "private-dns" {
  source = "git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/private-dns?ref=v0.6.1"

  resource_group_name = module.resource_group.name
  dns_zones           = var.dns_zones
  vnet_id             = module.network.id
  tags                = local.common_tags
}