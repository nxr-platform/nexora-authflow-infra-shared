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