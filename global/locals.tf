locals {
  company = "nxr"
  domain  = "authflow"

  common_tags = merge(var.tags, {
    product     = "authflow"
    managed-by  = "terraform"
    environment = "global"
    owner       = "platform-team"
    cost-centre = "nexora-platform"
  })
}
