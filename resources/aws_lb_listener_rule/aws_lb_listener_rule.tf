resource "aws_lb_listener_rule" "aws_lb_listener_rule" {
  listener_arn = var.listener_arn
  priority     = var.priority

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }

  condition {
    host_header {
      values = var.host_header_values
    }
  }
}
