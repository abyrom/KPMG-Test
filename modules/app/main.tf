# Virtual Machine for Application Tier
resource "azurerm_virtual_machine" "app" {
  name                  = "app-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.app.id]
  vm_size               = "Standard_B1s"

  # OS and other configuration omitted for brevity
}

# Network Interface for Application Tier
resource "azurerm_network_interface" "app" {
  name                = "app-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Configuration omitted for brevity
}

output "vm_name" {
  value = azurerm_virtual_machine.app.name
}
