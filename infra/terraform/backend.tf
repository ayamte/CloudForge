terraform {
  backend "azurerm" {
    resource_group_name  = "rg-cloudforge-dev"
    storage_account_name = "cloudforgestorageaccount"
    container_name       = "tfstate"
    key                  = "cloudforge-dev.tfstate"
  }
}