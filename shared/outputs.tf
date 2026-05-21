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
  value       = module.subnet.subnet_ids
}

output "subnet_address_prefixes" {
  description = "Map of subnet names to address prefixes"
  value       = module.subnet.subnet_address_prefixes
}