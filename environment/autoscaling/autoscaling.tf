module "aws_launch_template" {
  source = "../../aws_launch_template"

  autoscaling_group_name = "${var.autoscaling_group_name}-Instance"
  security_groups        = var.security_groups
}

module "aws_autoscaling_group" {
  source = "../../aws/aws_autoscaling_group"

  autoscaling_group_name = var.autoscaling_group_name
  vpc_zone_identifier    = var.vpc_zone_identifier
  aws_launch_template_id = module.aws_launch_template.id
}

module "aws_autoscaling_policy_scale_out" {
  source = "../../aws_autoscaling_policy"

  name                   = "scale_out"
  autoscaling_group_name = "${var.autoscaling_group_name}"
}

module "aws_autoscaling_policy_scale_in" {
  source = "../../aws_autoscaling_policy"

  name                   = "scale_in"
  autoscaling_group_name = "${var.autoscaling_group_name}"
}

module "aws_cloudwatch_metric_alarm_cpu_high" {
  source = "../../aws_cloudwatch_metric_alarm"

  alarm_name             = "cpu_high"
  comparison_operator    = "GreaterThanOrEqualToThreshold"
  threshold              = "70"
  alarm_actions          = [module.aws_autoscaling_policy_scale_out.arn]
  autoscaling_group_name = "${var.autoscaling_group_name}"
}

module "aws_cloudwatch_metric_alarm_cpu_low" {
  source = "../../aws_cloudwatch_metric_alarm"

  alarm_name             = "cpu_low"
  comparison_operator    = "LessThanOrEqualToThreshold"
  threshold              = "30"
  alarm_actions          = [module.aws_autoscaling_policy_scale_in.arn]
  autoscaling_group_name = "${var.autoscaling_group_name}"
}
