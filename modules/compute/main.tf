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

resource "azurerm_resource_group" "compute" {
  name     = "${var.prefix}-resources"
  location = "${var.location}"
}


resource "azurerm_public_ip" "bastion_ip" {
  name                = "${var.prefix}-bastion-ip"
  resource_group_name = azurerm_resource_group.compute.name
  location            = "${var.location}"
  allocation_method   = "Static"
}


resource "azurerm_network_interface" "nic-bastion" {
  name                = "${var.prefix}-bastion-nic"
  location            = "${var.location}"
  resource_group_name = azurerm_resource_group.compute.name

  ip_configuration {
    name                          = "${var.prefix}-bastion-ip"
    subnet_id                     = "${var.bastion_subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.bastion_ip.id}"

  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = "${var.location}"
  resource_group_name   = azurerm_resource_group.compute.name
  network_interface_ids = ["${azurerm_network_interface.nic-bastion.id}"]
  vm_size               = "Standard_DS1_v2"

  delete_os_disk_on_termination = true

  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "dev"
  }
}
