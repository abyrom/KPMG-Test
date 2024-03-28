resource "azurerm_virtual_machine" "web" {
  name                  = "web-vm"
  location              = module.network.azurerm_resource_group.kpmg_rg.location
  resource_group_name   = module.network.azurerm_resource_group.kpmg_rg.name
  network_interface_ids = [azurerm_network_interface.web.id]
  vm_size               = "Standard_B1s"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "web-vm"
    admin_username = "adminuser"
  }
}
resource "azurerm_network_interface" "web" {
  name                = "web-nic"
  location            = module.network.azurerm_resource_group.kpmg_rg.location
  resource_group_name = module.network.azurerm_resource_group.kpmg_rg.name

  ip_configuration {
    name                          = "web-nic-config"
    subnet_id                     = azurerm_subnet.web.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web.id
  }
}

resource "azurerm_public_ip" "web" {
  name                = "web-ip"
  location            = module.network.azurerm_resource_group.kpmg_rg.location
  resource_group_name = module.network.azurerm_resource_group.kpmg_rg.name
  allocation_method   = "Dynamic"
}

output "ip_address" {
  value = azurerm_public_ip.web.ip_address
}
