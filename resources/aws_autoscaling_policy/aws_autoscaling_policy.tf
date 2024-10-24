resource "aws_autoscaling_policy" "r_aws_autoscaling_policy" {
  name                   = var.name
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = var.autoscaling_group_name
}
