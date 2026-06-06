locals {
  company   = "nxr"
  domain    = "authflow"
  component = "shared"

  common_tags = merge(var.tags, {
    product     = "authflow"
    managed-by  = "terraform"
    environment = "shared"
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
module "network" {
  source = "git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/network?ref=v0.2.1"

  name                = module.naming.names.vnet
  resource_group_name = module.resource_group.name
  location            = var.location
  vnet_address_space  = var.vnet_address_space
  tags                = local.common_tags
}

module "nsg" {
  source = "git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/nsg?ref=v0.4.1"

  resource_group_name = module.resource_group.name
  location            = var.location
  nsgs                = var.nsgs
  tags                = local.common_tags
}

module "subnets" {
  source = "git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/subnet?ref=v0.3.4"

  resource_group_name = module.resource_group.name
  vnet_name           = module.network.name
  subnets             = var.subnets
  nsg_ids             = module.nsg.nsg_ids
  route_table_ids     = module.route-table.route_table_ids
  tags                = local.common_tags
}


module "route-table" {
  source = "git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/route-table?ref=v0.5.1"

  resource_group_name = module.resource_group.name
  location            = var.location
  route_tables        = var.route_tables
  tags                = local.common_tags
}

module "private-dns" {
  source = "git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/private-dns?ref=v0.6.2"

  resource_group_name = module.resource_group.name
  dns_zones           = var.dns_zones
  vnet_id             = module.network.id
  tags                = local.common_tags
}