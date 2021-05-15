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
  name     = "${var.prefix}-resources"
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
