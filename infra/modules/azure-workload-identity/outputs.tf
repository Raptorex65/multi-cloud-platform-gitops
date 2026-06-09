output "client_id" {
  value = azurerm_user_assigned_identity.eso.client_id
}

output "principal_id" {
  value = azurerm_user_assigned_identity.eso.principal_id
}

output "identity_id" {
  value = azurerm_user_assigned_identity.eso.id
}