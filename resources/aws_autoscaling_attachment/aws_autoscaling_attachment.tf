resource "aws_autoscaling_attachment" "aws_autoscaling_attachment" {
  autoscaling_group_name = var.autoscaling_group_name
  lb_target_group_arn    = var.lb_target_group_arn
}
