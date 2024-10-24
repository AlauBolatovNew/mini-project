module "networking" {
  source = "./environment/networking"
}

module "autoscalings" {
  source = "./environment/autoscalings"

  public_vpc_zone_identifier  = module.networking.public_subnets_ids
  private_vpc_zone_identifier = module.networking.public_subnets_ids
  security_groups             = module.networking.security_groups_id
}

module "loadbalancer" {
  source = "./environment/loadbalancer"

  subnets                  = module.networking.public_subnets_ids
  security_groups          = module.networking.security_groups_id
  autoscaling_groups_names = module.autoscalings.names
  vpc_id                   = module.networking.vpc_id
}
