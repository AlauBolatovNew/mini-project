module "frontend_autoscaling_group" {
  source = "./autoscaling"

  autoscaling_group_name = "frontend"
  vpc_zone_identifier    = var.vpc_zone_identifier
  security_groups        = var.security_groups
}

module "backend_autoscaling_group" {
  source = "./autoscaling"

  autoscaling_group_name = "backend"
  vpc_zone_identifier    = var.vpc_zone_identifier
  security_groups        = var.security_groups
}