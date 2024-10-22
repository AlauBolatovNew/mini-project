resource "aws_cloudwatch_metric_alarm" "r_aws_cloudwatch_metric_alarm" {
  alarm_name          = var.alarm_name
  comparison_operator = var.comparison_operator
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = var.threshold
  alarm_description   = "This metric monitors the CPU utilization"
  alarm_actions       = var.alarm_actions
  dimensions = {
    autoscaling_group_name = var.autoscaling_group_name
  }
}
