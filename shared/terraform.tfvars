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

nsgs = {
  "app-gateway" = {
    security_rules = [
      {
        name                       = "Allow-HTTP-Inbound"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "Internet"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-HTTPS-Inbound"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "Internet"
        destination_address_prefix = "*"
      }
    ]
  }

  aks = {
    security_rules = [
      {
        name                       = "Allow-AppGateway-Inbound"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "10.0.10.0/24"
        destination_address_prefix = "*"
      }
    ]
  }

  postgresql = {
    security_rules = [
      {
        name                       = "Allow-PostgreSQL-From-AKS"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "5432"
        source_address_prefix      = "10.0.20.0/24"
        destination_address_prefix = "*"
      }
    ]
  }

  redis = {
    security_rules = [
      {
        name                       = "Allow-Redis-From-AKS"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "6380"
        source_address_prefix      = "10.0.20.0/24"
        destination_address_prefix = "*"
      }
    ]
  }

  private-endpoints = {
    security_rules = [
      {
        name                       = "Allow-AKS-Inbound"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "10.0.20.0/24"
        destination_address_prefix = "*"
      }
    ]
  }
}