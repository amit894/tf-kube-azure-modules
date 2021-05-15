resource "azurerm_network_interface" "nic-worker-2" {
  name                            = "${var.prefix-worker-2}-nic"
  location                        = "${var.location}"
  resource_group_name             = "${var.resource_group_name}"

  ip_configuration {
    name                          = "${var.prefix-worker-2}-ip-2"
    subnet_id                     =  "${var.aks_subnet_id}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm-worker-2" {
  name                  = "${var.prefix-worker-2}"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group_name}"
  network_interface_ids = ["${azurerm_network_interface.nic-worker-2.id}"]
  vm_size               = "Standard_B2s"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.prefix-worker-2}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
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
