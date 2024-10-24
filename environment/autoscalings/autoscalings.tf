module "frontend_autoscaling_group" {
  source = "./autoscaling"

  autoscaling_group_name      = "frontend"
  vpc_zone_identifier         = var.public_vpc_zone_identifier
  security_groups             = var.security_groups
  associate_public_ip_address = true
}

module "backend_autoscaling_group" {
  source = "./autoscaling"

  autoscaling_group_name      = "backend"
  vpc_zone_identifier         = var.private_vpc_zone_identifier
  security_groups             = var.security_groups
  associate_public_ip_address = true
}
