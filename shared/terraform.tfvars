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

route_tables = {
  "aks" = {
    routes = [
      {
        name                      = "force-outbound-via-appgw"
        address_prefix            = "0.0.0.0/0" # all traffic not destined for other subnets goes to app gateway
        next_hop_type             = "VirtualAppliance" # force traffic to go through app gateway
        next_hop_in_ip_address    = "10.0.10.4" # Expected to be static/reserved in app gateway module
      },
      {
        name                      = "keep-vnet-local"
        address_prefix            = "10.0.0.0/16" 
        next_hop_type             = "VnetLocal" # traffic to other subnets in the VNet stays within Azure's network and doesn't go through the app gateway
        next_hop_in_ip_address    = null 
      }
    ]
  }
  app-gateway = {
    routes = [
      {
        name                      = "allow-internet-outbound"
        address_prefix            = "0.0.0.0/0" 
        next_hop_type             = "Internet" 
        next_hop_in_ip_address    = null 
      }
    ]
  }
  "private-endpoints" = {
    routes = [
      {
        name                      = "drop-internet-traffic"
        address_prefix            = "0.0.0.0/0" 
        next_hop_type             = "None" 
        next_hop_in_ip_address    = null 
      }
    ]
  }
  postgresql = {
      routes = [
       {
        name                      = "drop-internet-traffic"
        address_prefix            = "0.0.0.0/0"
        next_hop_type             = "None"
        next_hop_in_ip_address    = null
      }
    ]
  }
  redis = {
      routes = [
       {
        name                      = "drop-internet-traffic"
        address_prefix            = "0.0.0.0/0"
        next_hop_type             = "None"
        next_hop_in_ip_address    = null
      }
    ]
  }
}