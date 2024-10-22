resource "aws_launch_template" "aws_insance_template" {
  name_prefix   = "example-template"
  image_id      = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = "dontdelete"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.security_groups
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.autoscaling_group_name}-Instance"
    }
  }
}

resource "aws_autoscaling_group" "aws_autoscaling_groups" {
  desired_capacity = 1
  max_size         = 5
  min_size         = 1
  launch_template {
    id      = aws_launch_template.aws_insance_template.id
    version = "$Latest"
  }
  vpc_zone_identifier = var.vpc_zone_identifier

  tag {
    key                 = "Name"
    value               = var.autoscaling_group_name
    propagate_at_launch = true
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "cpu_high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"
  alarm_description   = "This metric monitors the CPU utilization"
  alarm_actions       = [aws_autoscaling_policy.scale_out.arn]
  dimensions = {
    autoscaling_group_name = "${aws_autoscaling_group.aws_autoscaling_groups.name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "cpu_low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"
  alarm_description   = "This metric monitors the CPU utilization"
  alarm_actions       = [aws_autoscaling_policy.scale_in.arn]
  dimensions = {
    autoscaling_group_name = "${aws_autoscaling_group.aws_autoscaling_groups.name}"
  }
}

resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale_out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.aws_autoscaling_groups.name
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "scale_in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.aws_autoscaling_groups.name
}
