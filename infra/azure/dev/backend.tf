terraform {
  backend "azurerm" {
    resource_group_name  = "multi-cloud-platform-shared-tfstate-rg"
    storage_account_name = "multicloudtfstate01"
    container_name       = "tfstate-container"
    key                  = "azure/dev/terraform.tfstate"
  }
}