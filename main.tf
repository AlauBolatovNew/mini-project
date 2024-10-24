module "networking" {
  source = "./environment/networking"
}

# module "autoscalings" {
#   source = "./environment/autoscalings"

#   vpc_zone_identifier = module.networking.subnets_ids
#   security_groups     = module.networking.ssh_id
# }

# module "loadbalancer" {
#   source = "./environment/loadbalancer"

#   subnets                  = module.networking.subnets_ids
#   security_groups          = module.networking.ssh_id
#   autoscaling_groups_names = module.autoscalings.names
#   vpc_id                   = module.networking.vpc_id
# }
