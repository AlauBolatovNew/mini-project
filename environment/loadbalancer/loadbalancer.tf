module "aws_lb" {
  source = "../../resources/aws_lb"

  subnets         = var.subnets
  security_groups = var.security_groups
}

module "aws_lb_listener" {
  source = "../../resources/aws_lb_listener"

  load_balancer_arn = module.aws_lb.arn
}

module "targetgroup_backend" {
  source = "./targetgroup"

  vpc_id             = var.vpc_id
  name               = "backend"
  autoscaling_group  = var.autoscaling_groups_names.backend_autoscaling_group_name
  listener_arn       = module.aws_lb_listener.arn
  priority           = 101
  host_header_values = ["reviews-api.alau.site"]
}

module "targetgroup_frontend" {
  source = "./targetgroup"

  vpc_id             = var.vpc_id
  name               = "frontend"
  autoscaling_group  = var.autoscaling_groups_names.frontend_autoscaling_group_name
  listener_arn       = module.aws_lb_listener.arn
  priority           = 100
  host_header_values = ["reviews.alau.site"]
}
