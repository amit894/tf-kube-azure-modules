variable "prefix" {
  description = "Prefix to be used for resources to will be created"
  default = "test-app"
}

variable "location" {
  description = "Region name where rg will be hosted"
  default = "eastus"
}

variable "vnet_cidr" {
  description = "CIDR of the VNET for hosting"
  default = ["10.0.0.0/16"]

}

variable "aks_subnet_cidr" {
  description = "CIDR of the aks subnet for hosting"
  default = ["10.0.0.0/24"]
}

variable "gateway_subnet_cidr" {
  description = "CIDR of the gateway subnet for hosting"
  default = ["10.0.1.0/24"]
}

variable "bastion_subnet_cidr" {
  description = "CIDR of the gateway subnet for hosting"
  default = ["10.0.2.0/24"]
}

variable "my_public_ip" {
  default = "49.207.224.48/32"
}
