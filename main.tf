module "networking" {
  source = "./environment/networking"
}

module "frontend_autoscaling_group" {
  source = "./environment/autoscaling"

  autoscaling_group_name = "frontend"
  vpc_zone_identifier    = module.networking.subnets_ids
  security_groups        = module.networking.ssh_id
}

module "backend_autoscaling_group" {
  source = "./environment/autoscaling"

  autoscaling_group_name = "backend"
  vpc_zone_identifier    = module.networking.subnets_ids
  security_groups        = module.networking.ssh_id
}

module "loadbalancer" {
  source = "./environment/loadbalancer"

  subnets                    = module.networking.subnets_ids
  security_groups            = module.networking.ssh_id
  frontend_autoscaling_group = module.frontend_autoscaling_group.name
  backend_autoscaling_group  = module.backend_autoscaling_group.name
  vpc_id                     = module.networking.vpc_id
}
