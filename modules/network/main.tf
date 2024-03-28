resource "azurerm_resource_group" "kpmg_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "kpmg_network" {
  name                = "my-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.kpmg_rg.location
  resource_group_name = azurerm_resource_group.kpmg_network.name
}

resource "azurerm_subnet" "web" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.kpmg_rg.name
  virtual_network_name = azurerm_virtual_network.kpmg_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "app" {
  name                 = "app-subnet"
  resource_group_name  = azurerm_resource_group.kpmg_rg.name
  virtual_network_name = azurerm_virtual_network.kpmg_network.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "db" {
  name                 = "db-subnet"
  resource_group_name  = azurerm_resource_group.kpmg_rg.name
  virtual_network_name = azurerm_virtual_network.kpmg_network.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_network_security_group" "web" {
  name                = "web-nsg"
  location            = azurerm_resource_group.kpmg_rg.location
  resource_group_name = azurerm_resource_group.kpmg_network.name

  security_rule {
    name                       = "HTTP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "app" {
  name                = "app-nsg"
  location            = azurerm_resource_group.kpmg_rg.location
  resource_group_name = azurerm_resource_group.kpmg_network.name

  security_rule {
    name                       = "AppPort"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3000"
    source_address_prefix      = "${azurerm_subnet.web.address_prefixes[0]}"
    destination_address_prefix = "*"
  }
}
