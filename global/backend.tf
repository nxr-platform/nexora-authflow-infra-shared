terraform {
  backend "azurerm" {
    resource_group_name  = "nxr-authflow-tfstate-rg"
    storage_account_name = "nxrauthflowtfstate"
    container_name       = "tfstate"
    key                  = "authflow/global/global.tfstate"
    use_oidc             = true
  }
}
