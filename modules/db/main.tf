# MySQL Server
resource "azurerm_mysql_server" "kpmgserver" {
  name                = "kpmg-mysql-server"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "B_Gen5_1"
  storage_mb          = 5120
  version             = "5.7"
  administrator_login = "adminuser"
  administrator_login_password = data.azurerm_key_vault_secret.mysql_password.value

  # SSL Enforcement
  ssl_enforcement_enabled = true

  # Public Network Access
  public_network_access_enabled = true
}

# MySQL Database
resource "azurerm_mysql_database" "kpmgdb" {
  name                = "my-database"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.kpmgserver.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

# Data source to retrieve secret from Azure Key Vault
data "azurerm_key_vault_secret" "mysql_password" {
  name         = "mysql-password-secret"  # Name of the secret in Azure Key Vault
  vault_uri    = "https://keyvault.vault.azure.net/"
}

