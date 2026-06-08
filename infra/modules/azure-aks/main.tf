resource "azurerm_kubernetes_cluster" "main" {
  name                = "${var.prefix}-aks"
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = "${var.prefix}-aks"
  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  default_node_pool {
    name           = "system"
    node_count     = 1
    vm_size        = "Standard_B2s"
    vnet_subnet_id = var.aks_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }

  tags = var.tags
}