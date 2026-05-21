location           = "uksouth"
vnet_address_space = ["10.0.0.0/16"]
tags = {
  product     = "authflow"
  owner       = "platform-team"
  cost-centre = "nexora-platform"
}

subnets = {
  app-gateway       = { address_prefix = "10.0.10.0/24", delegation = null }
  aks               = { address_prefix = "10.0.20.0/24", delegation = null }
  postgresql        = { address_prefix = "10.0.30.0/28", delegation = "Microsoft.DBforPostgreSQL/flexibleServers" }
  redis             = { address_prefix = "10.0.40.0/28", delegation = null }
  private-endpoints = { address_prefix = "10.0.50.0/28", delegation = null }
}