module "resource_group" {
  source = "git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/resource-group?ref=v0.1.2"

  company   = local.company
  domain    = local.domain
  component = "shared"
  location  = var.location
  tags      = local.common_tags
}