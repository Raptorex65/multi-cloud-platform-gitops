
resource "azurerm_user_assigned_identity" "eso" {
  location            = var.location
  name                = "${var.prefix}-eso-identity"
  resource_group_name = var.resource_group_name

    tags = var.common_tags
}

resource "azurerm_federated_identity_credential" "eso" {
  name                      = "${var.prefix}-eso-federated-credential"
  user_assigned_identity_id = azurerm_user_assigned_identity.eso.id

  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = var.oidc_issuer_url
  subject                   = "system:serviceaccount:microservices-dev:external-secrets"
}

resource "azurerm_role_assignment" "kv_secrets_user" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.eso.principal_id
}