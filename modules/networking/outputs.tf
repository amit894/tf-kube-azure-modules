output "bastion_subnet_id" {
  value = azurerm_subnet.bastion-subnet.id
}

output "aks_subnet_id" {
  value = azurerm_subnet.aks-subnet.id
}

output "bastion_subnet_nsg_id" {
  value = azurerm_network_security_group.nsg.id
}

output "my_public_ip" {
  value = var.my_public_ip
}
