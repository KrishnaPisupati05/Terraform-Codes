# Resource Group

resource "azurerm_resource_group" "Automated-tasks" {
  name     = "Automated-tasks"
  location = "Central India"
}

# # PostgreSQL Server
# resource "azurerm_postgresql_server" "example" {
#   name                         = "examplepgserver"
#   location                     = azurerm_resource_group.example.location
#   resource_group_name          = azurerm_resource_group.example.name
#   sku_name                     = "B_Gen5_1"
#   storage_mb                   = 5120
#   version                      = "11"
#   administrator_login          = "postgresadmin"
#   administrator_login_password = "your-password"
#   ssl_enforcement              = "Enabled"
# }

# # PostgreSQL Database
# resource "azurerm_postgresql_database" "example" {
#   name                       = "exampledb"
#   resource_group_name        = azurerm_resource_group.example.name
#   server_name                = azurerm_postgresql_server.example.name
#   charset                    = "UTF8"
#   collation                  = "English_UnitedStates.1252"
# }
