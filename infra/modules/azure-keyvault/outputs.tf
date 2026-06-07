output "key_vault_id" {
  value = azurerm_key_vault.mc-vault.id
}

output "key_vault_name" {
  value = azurerm_key_vault.mc-vault.name
}

output "key_vault_uri" {
  value = azurerm_key_vault.mc-vault.vault_uri
}