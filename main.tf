resource "azurerm_resource_group" "appgrp" {
  name     = "app-grp"
  location = local.resource_location
}

resource "azurerm_virtual_network" "app_network" {
  name                = local.virtual_network.name
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.appgrp.name
  address_space       = local.virtual_network.address_prefixes 
}


resource "azurerm_subnet" "app_network_subnets" {
  for_each = {
    websubnet01 = "10.0.0.0/24"
    appsubnet01 = "10.0.1.0/24"
  }
  name                 = each.key
  resource_group_name  = azurerm_resource_group.appgrp.name
  virtual_network_name = azurerm_virtual_network.app_network.name
  address_prefixes     = each.value
}

resource "azurerm_network_interface" "webinterface01" {
  name                = "webinterface01"
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.appgrp.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.websubnet01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.webip01.id
  }
}

resource "azurerm_public_ip" "webip01" {
  name                = "webip01"
  resource_group_name = azurerm_resource_group.appgrp.name
  location            = local.resource_location
  allocation_method   = "Static"
}


resource "azurerm_network_interface" "appinterface01" {
  name = "appinterface01"
  location = local.resource_location
  resource_group_name = azurerm_resource_group.appgrp.name

  ip_configuration {
    name = "internal2"
    subnet_id = azurerm_subnet.appsubnet01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.appip01.id
  }
}

resource "azurerm_public_ip" "appip01" {
  name = "appip01"
  resource_group_name = azurerm_resource_group.appgrp.name
  location = local.resource_location
  allocation_method = "Static"
}

resource "azurerm_network_security_group" "app_nsg" {
  name                = "app-nsg"
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.appgrp.name

  security_rule {
    name                       = "AllowRDP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "websubnet01_appnsg" {
  subnet_id                 = azurerm_subnet.websubnet01.id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
}



resource "azurerm_subnet_network_security_group_association" "appsubnet01_appnsg" {
  subnet_id                 = azurerm_subnet.appsubnet01.id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
}



