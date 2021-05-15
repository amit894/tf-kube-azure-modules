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

variable "aks_subnet_id" {
  description = "Region name where rg will be hosted"
  default = ["10.1.2.0/24"]
}

variable "prefix-master-1" {
  default = "master-1"
}

variable "prefix-worker-1" {
  default = "worker-1"
}

variable "prefix-worker-2" {
  default = "worker-2"
}

variable "resource_group_name"  {
  default = "test"
}
