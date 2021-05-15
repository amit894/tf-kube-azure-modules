variable "prefix" {
  description = "Prefix to be used for resources to will be created"
  default = "test-app"
}

variable "location" {
  description = "Region name where rg will be hosted"
  default = "eastus"
}

variable "bastion_subnet_id" {
  description = "Region name where rg will be hosted"
  default = ["10.1.2.0/24"]
}
