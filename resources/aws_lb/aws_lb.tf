resource "aws_lb" "aws_lb" {
  name               = "test-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = var.security_groups
}
