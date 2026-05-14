resource "azurerm_virtual_network" "main" {
  name = "${var.prefix}-vnet"
  address_space = ["10.20.0.0/16"]
  location = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "aks" {
  name                 = "${var.prefix}-aks-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.20.1.0/24"]
}


