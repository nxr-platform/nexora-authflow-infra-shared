# Outputs for Global resources — Front Door, ACR, DNS Zone
# Expose values needed by dependent layers via terraform_remote_state

output "resource_group_name" {
  description = "The name of the global resource group"
  value       = module.resource_group.name
}

output "resource_group_location" {
  description = "The location of the global resource group"
  value       = module.resource_group.location
}

output "acr_id" {
  description = "The ID of the Container Registry"
  value       = module.acr.id
}

output "acr_name" {
  description = "The name of the Container Registry"
  value       = module.acr.name
}

output "acr_login_server" {
  description = "The login server URL of the Container Registry"
  value       = module.acr.login_server
}