# Global resources — Front Door, ACR, DNS Zone
# This root configuration calls modules only.
# No resource blocks directly in this file.

module "resource_group" {
  source = "git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/resource-group?ref=v0.1.2"

  company   = local.company
  domain    = local.domain
  component = "global"
  location  = var.location
  tags      = local.common_tags
}
