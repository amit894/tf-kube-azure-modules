terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "networking" {
  name     = "${var.prefix}-networking"
  location = "${var.location}"
}

  resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = "${var.vnet_cidr}"
  location            = "${var.location}"
  resource_group_name = azurerm_resource_group.networking.name
}


  resource "azurerm_subnet" "bastion-subnet" {
  name                 = "bastion-subnet"
  resource_group_name  = azurerm_resource_group.networking.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = "${var.bastion_subnet_cidr}"
}


  resource "azurerm_subnet" "gateway-subnet" {
  name                 = "gateway-subnet"
  resource_group_name  = azurerm_resource_group.networking.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = "${var.gateway_subnet_cidr}"
}


  resource "azurerm_subnet" "aks-subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.networking.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = "${var.aks_subnet_cidr}"
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.prefix}-nsg"
  location            = "${var.location}"
  resource_group_name = azurerm_resource_group.networking.name
}

resource "azurerm_network_security_rule" "nsg-inbound" {
  name                        = "${var.prefix}-ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = var.my_public_ip
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.networking.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_subnet_network_security_group_association" "bastion-subnet-nsg" {
  subnet_id                 = azurerm_subnet.bastion-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "aks-subnet-nsg" {
  subnet_id                 = azurerm_subnet.aks-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
