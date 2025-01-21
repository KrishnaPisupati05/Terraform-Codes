resource "azurerm_resource_group" "appgrp" {
  name     = "app-grp"
  location = local.resource_location
}

resource "azurerm_service_plan" "serviceplan" {
  for_each = var.webapp_environment.production.serviceplan
  name                = each.key
  resource_group_name = azurerm_resource_group.appgrp.name
  location            = local.resource_location
  os_type             = each.value.os_type
  sku_name            = each.value.sku
}

resource "azurerm_windows_web_app" "webapp" {
  for_each = var.webapp_environment.production.serviceapp
  name                = each.key
  resource_group_name = azurerm_resource_group.appgrp.name
  location            = local.resource_location
  service_plan_id     = azurerm_service_plan.serviceplan[each.value].id
  
  site_config {
    always_on=false
     
    application_stack {
      current_stack="dotnet"
      dotnet_version="v8.0"
  }
  }  
}














# resource "azurerm_virtual_network" "app_network" {
#   name                = local.virtual_network.name
#   location            = local.resource_location
#   resource_group_name = azurerm_resource_group.appgrp.name
#   address_space       = local.virtual_network.address_prefixes 
# }

# resource "azurerm_subnet" "app_network_subnets" {
#   for_each = {
#     "websubnet01" = ["10.0.0.0/24"]
#     "appsubnet01" = ["10.0.1.0/24"]
#   }
#   name                 = each.key
#   resource_group_name  = azurerm_resource_group.appgrp.name
#   virtual_network_name = azurerm_virtual_network.app_network.name
#   address_prefixes     = each.value
# }

# resource "azurerm_network_interface" "webinterfaces" {
#   count = 2
#   name                = "webinterface0${count.index+1}"
#   location            = local.resource_location
#   resource_group_name = azurerm_resource_group.appgrp.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.app_network_subnets["websubnet01"].id # Need to take the key value here
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id = azurerm_public_ip.webip[count.index].id
#   }
# }

# resource "azurerm_public_ip" "webip" {
#   count = 2
#   name                = "webip0${count.index+1}"
#   resource_group_name = azurerm_resource_group.appgrp.name
#   location            = local.resource_location
#   allocation_method   = "Static"
# }

# resource "azurerm_network_security_group" "app_nsg" {
#   name                = "app-nsg"
#   location            = local.resource_location
#   resource_group_name = azurerm_resource_group.appgrp.name

#   security_rule {
#     name                       = "AllowRDP"
#     priority                   = 300
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "3389"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }

# resource "azurerm_subnet_network_security_group_association" "subnet_appnsg" {
#   for_each = azurerm_subnet.app_network_subnets
#   subnet_id                 = azurerm_subnet.app_network_subnets[each.key].id   # Taking each.key from the subnet
#   network_security_group_id = azurerm_network_security_group.app_nsg.id
# }


# resource "azurerm_subnet" "websubnet01" {
#   name                 = local.subnets[0].name
#   resource_group_name  = azurerm_resource_group.appgrp.name
#   virtual_network_name = azurerm_virtual_network.app_network.name
#   address_prefixes     = local.subnets[0].address_prefixes
# }

# resource "azurerm_subnet" "appsubnet01" {
#   name                 = local.subnets[1].name
#   resource_group_name  = azurerm_resource_group.appgrp.name
#   virtual_network_name = azurerm_virtual_network.app_network.name
#   address_prefixes     = local.subnets[1].address_prefixes
# }

# resource "azurerm_network_interface" "webinterface01" {
#   name                = "webinterface01"
#   location            = local.resource_location
#   resource_group_name = azurerm_resource_group.appgrp.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.websubnet01.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id = azurerm_public_ip.webip01.id
#   }
# }

# resource "azurerm_public_ip" "webip01" {
#   name                = "webip01"
#   resource_group_name = azurerm_resource_group.appgrp.name
#   location            = local.resource_location
#   allocation_method   = "Static"
# }


# resource "azurerm_network_interface" "appinterface01" {
#   name = "appinterface01"
#   location = local.resource_location
#   resource_group_name = azurerm_resource_group.appgrp.name

#   ip_configuration {
#     name = "internal2"
#     subnet_id = azurerm_subnet.appsubnet01.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id = azurerm_public_ip.appip01.id
#   }
# }

# resource "azurerm_public_ip" "appip01" {
#   name = "appip01"
#   resource_group_name = azurerm_resource_group.appgrp.name
#   location = local.resource_location
#   allocation_method = "Static"
# }

# resource "azurerm_network_security_group" "app_nsg" {
#   name                = "app-nsg"
#   location            = local.resource_location
#   resource_group_name = azurerm_resource_group.appgrp.name

#   security_rule {
#     name                       = "AllowRDP"
#     priority                   = 300
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "3389"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }

# resource "azurerm_subnet_network_security_group_association" "websubnet01_appnsg" {
#   subnet_id                 = azurerm_subnet.websubnet01.id
#   network_security_group_id = azurerm_network_security_group.app_nsg.id
# }



# resource "azurerm_subnet_network_security_group_association" "appsubnet01_appnsg" {
#   subnet_id                 = azurerm_subnet.appsubnet01.id
#   network_security_group_id = azurerm_network_security_group.app_nsg.id
# }

