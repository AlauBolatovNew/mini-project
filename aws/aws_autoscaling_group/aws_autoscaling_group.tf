module "aws_launch_template" {
  source = "../aws_launch_template"

  autoscaling_group_name = "${"${var.autoscaling_group_name}"}-Instance"
  security_groups        = var.security_groups
}


resource "aws_autoscaling_group" "r_aws_autoscaling_group" {
  desired_capacity = 1
  max_size         = 5
  min_size         = 1
  launch_template {
    id      = module.aws_launch_template.aws_launch_template_id
    version = "$Latest"
  }
  vpc_zone_identifier = var.vpc_zone_identifier

  tag {
    key                 = "Name"
    value               = var.autoscaling_group_name
    propagate_at_launch = true
  }
}

module "aws_autoscaling_policy_scale_out" {
  source = "../aws_autoscaling_policy"

  name                   = "scale_out"
  autoscaling_group_name = aws_autoscaling_group.r_aws_autoscaling_group.name
}

module "aws_autoscaling_policy_scale_in" {
  source = "../aws_autoscaling_policy"

  name                   = "scale_in"
  autoscaling_group_name = aws_autoscaling_group.r_aws_autoscaling_group.name
}

module "aws_cloudwatch_metric_alarm_cpu_high" {
  source = "../aws_cloudwatch_metric_alarm"

  alarm_name             = "cpu_high"
  comparison_operator    = "GreaterThanOrEqualToThreshold"
  threshold              = "70"
  alarm_actions          = [module.aws_autoscaling_policy_scale_out.arn]
  autoscaling_group_name = aws_autoscaling_group.r_aws_autoscaling_group.name
}

module "aws_cloudwatch_metric_alarm_cpu_low" {
  source = "../aws_cloudwatch_metric_alarm"

  alarm_name             = "cpu_low"
  comparison_operator    = "LessThanOrEqualToThreshold"
  threshold              = "30"
  alarm_actions          = [module.aws_autoscaling_policy_scale_in.arn]
  autoscaling_group_name = aws_autoscaling_group.r_aws_autoscaling_group.name
}
