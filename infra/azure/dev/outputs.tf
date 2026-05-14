output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "aks_name" {
  value = module.aks.aks_name
}

output "aks_get_credentials_command" {
  value = "az aks get-credentials --resource-group ${azurerm_resource_group.main.name} --name ${module.aks.aks_name}"
}