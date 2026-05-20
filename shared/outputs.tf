output "vnet_id" {
  description = "The ID of the shared VNet"
  value       = module.network.id
}

output "vnet_name" {
  description = "The name of the shared VNet"
  value       = module.network.name
}

output "vnet_address_space" {
  description = "The address space of the shared VNet"
  value       = module.network.address_space
}

output "resource_group_name" {
  description = "The name of the global resource group"
  value       = module.resource_group.name
}

output "resource_group_location" {
  description = "The location of the global resource group"
  value       = module.resource_group.location
}

output "subnet_ids" {
  description = "Map of subnet names to subnet IDs"
  value       = { for k, v in azurerm_subnet.subnet : k => v.id }
}

output "subnet_address_prefixes" {
  description = "Map of subnet names to address prefixes"
  value       = { for k, v in azurerm_subnet.subnet : k => v.address_prefixes[0] }
}

# Outputs for Shared resources — VNet, subnets, Log Analytics
# Expose values needed by dependent layers via terraform_remote_state

# Outputs for Global resources — Front Door, ACR, DNS Zone
# Expose values needed by dependent layers via terraform_remote_state