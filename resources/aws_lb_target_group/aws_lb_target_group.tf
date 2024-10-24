resource "aws_lb_target_group" "aws_lb_target_group" {
  name     = var.name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}