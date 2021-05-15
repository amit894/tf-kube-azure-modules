locals {
  region = "southcentralus"
  prefix = "test-app"
  vnet_cidr = ["10.1.0.0/16"]
  aks_subnet_cidr = ["10.1.0.0/24"]
  gateway_subnet_cidr = ["10.1.1.0/24"]
  bastion_subnet_cidr = ["10.1.2.0/24"]

}
