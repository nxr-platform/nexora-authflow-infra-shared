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

# Outputs for Shared resources — VNet, subnets, Log Analytics
# Expose values needed by dependent layers via terraform_remote_state

# Outputs for Global resources — Front Door, ACR, DNS Zone
# Expose values needed by dependent layers via terraform_remote_state