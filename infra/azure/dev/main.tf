locals {
  resource_prefix = "${var.project_name}-${var.cloud}-${var.environment}"
  common_tags = {
    project     = var.project_name
    environment = var.environment
    cloud       = var.cloud
    owner       = var.owner
    managed_by  = "terraform"
  }
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = local.common_tags
}

module "network" {
  source   = "../../modules/azure-network"
  rg_name  = azurerm_resource_group.main.name
  location = azurerm_resource_group.main.location
  prefix   = local.resource_prefix
  tags     = local.common_tags
}

module "aks" {
  source        = "../../modules/azure-aks"
  rg_name       = azurerm_resource_group.main.name
  location      = azurerm_resource_group.main.location
  prefix        = local.resource_prefix
  aks_subnet_id = module.network.aks_subnet_id
  tags          = local.common_tags
}

module "acr" {
  source = "../../modules/azure-acr"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  prefix              = local.resource_prefix
  common_tags         = local.common_tags
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = module.acr.acr_id
  role_definition_name = "AcrPull"
  principal_id         = module.aks.kubelet_identity_object_id
}

module "multi-cloud-platform-dev-kv" {
  source = "../../modules/azure-keyvault"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  common_tags         = local.common_tags
}