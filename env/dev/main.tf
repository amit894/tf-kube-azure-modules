module "networking" {
  source  = "../../modules/networking"
  location = local.region
  vnet_cidr = local.vnet_cidr
  aks_subnet_cidr = local.aks_subnet_cidr
  gateway_subnet_cidr = local.gateway_subnet_cidr
  bastion_subnet_cidr = local.bastion_subnet_cidr

}

module "compute" {
  source  = "../../modules/compute"
  location = local.region
  prefix = local.prefix
  bastion_subnet_id = module.networking.bastion_subnet_id

}
