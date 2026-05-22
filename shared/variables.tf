variable "location" {
  description = "Azure region"
  type        = string
  default     = "uksouth"

  validation {
    condition     = contains(["uksouth", "ukwest", "westeurope"], var.location)
    error_message = "location must be uksouth, ukwest, or westeurope"
  }
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default     = {}
}

variable "vnet_address_space" {
  description = "Address space for the shared VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  description = "Map of subnets to create in the shared VNet"
  type = map(object({
    address_prefix = string
    delegation     = optional(string)
  }))
}

variable "nsgs" {
  description = "Map of NSGs to create with their security rules"
  type = map(object({
    security_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
}

variable "nsg_ids" {
  description = "Map of subnet names to NSG IDs to associate. Optional — subnets without an entry get no NSG."
  type        = map(string)
  default     = {}
}