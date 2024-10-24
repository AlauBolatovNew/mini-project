module "aws_lb_target_group" {
  source = "../../../resources/aws_lb_target_group"
  
  name     = "${var.name}-autoscaling-group"
  vpc_id   = var.vpc_id
}

module "aws_autoscaling_attachment" {
  source = "../../../resources/aws_autoscaling_attachment"
  
  autoscaling_group_name = var.autoscaling_group
  lb_target_group_arn    = module.aws_lb_target_group.arn
}

module "aws_lb_listener_rule" {
    source = "../../../resources/aws_lb_listener_rule"
    
    listener_arn        = var.listener_arn
    target_group_arn    = module.aws_lb_target_group.arn
    host_header_values  = var.host_header_values
    priority            = var.priority
}
