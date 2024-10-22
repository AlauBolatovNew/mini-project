resource "aws_autoscaling_group" "aws_autoscaling_groups" {
  desired_capacity = 1
  max_size         = 5
  min_size         = 1
  launch_template {
    id      = var.aws_launch_template_id
    version = "$Latest"
  }
  vpc_zone_identifier = var.vpc_zone_identifier

  tag {
    key                 = "Name"
    value               = var.autoscaling_group_name
    propagate_at_launch = true
  }
}
