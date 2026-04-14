locals {
  common_tags = {
    project     = var.project_name
    environment = var.environment
    owner       = var.owner
    managed_by  = "terraform"
    component   = "terraform-backend"
    cloud       = "azure"
  }
}

resource "azurerm_resource_group" "terraformbackend" {
  name     = "${var.project_name}-${var.environment}-tfstate-rg"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_storage_account" "tfstate" {
  name                          = var.terraform_storage_account_name
  resource_group_name           = azurerm_resource_group.terraformbackend.name
  location                      = var.location
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = true

  blob_properties {
    versioning_enabled = true
  }
  tags = local.common_tags
}

resource "azurerm_storage_container" "tfstate" {
  name                  = var.terraform_storage_container_name
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}