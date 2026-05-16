locals {
  company = "nxr"
  domain  = "authflow"

  common_tags = merge(var.tags, {
    product     = "authflow"
    managed-by  = "terraform"
    environment = "shared"
    owner       = "platform-team"
    cost-centre = "nexora-platform"
  })
}
