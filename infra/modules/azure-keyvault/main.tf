data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "mc-vault" {
  name                        = "mc-platform-dev-kv"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled    = false
  rbac_authorization_enabled  = true
  sku_name = "standard"

  tags = var.common_tags
}

resource "azurerm_role_assignment" "kv_admin" {
  scope                = azurerm_key_vault.mc-vault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}