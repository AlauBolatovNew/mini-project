provider "aws" {
  region = "us-east-2"
}

module "aws_vpc" {
  source     = "./aws/aws_vpc"
  cidr_block = "10.10.0.0/16"
}

module "frontend_subnet_a" {
  source = "./aws/aws_subnet"

  subnet_name       = "frontend_a"
  subnet_cidr_block = "10.10.1.0/24"
  vpc_id            = module.aws_vpc.vpc_id
  availability_zone = "us-east-2a"
}

module "frontend_subnet_b" {
  source = "./aws/aws_subnet"

  subnet_name       = "frontend_b"
  subnet_cidr_block = "10.10.2.0/24"
  vpc_id            = module.aws_vpc.vpc_id
  availability_zone = "us-east-2b"
}

module "frontend_subnet_c" {
  source = "./aws/aws_subnet"

  subnet_name       = "frontend_c"
  subnet_cidr_block = "10.10.3.0/24"
  vpc_id            = module.aws_vpc.vpc_id
  availability_zone = "us-east-2c"
}

module "frontend_autoscaling_group" {
  source = "./aws/aws_autoscaling_group"

  autoscaling_group_name = "frontend"

  vpc_zone_identifier = [module.frontend_subnet_a.subnet_id, module.frontend_subnet_b.subnet_id, module.frontend_subnet_c.subnet_id]
  security_groups     = [module.frontend_subnet_a.ssh_id]
}

module "backend_subnet_a" {
  source = "./aws/aws_subnet"

  subnet_name       = "backend_a"
  subnet_cidr_block = "10.10.4.0/24"
  vpc_id            = module.aws_vpc.vpc_id
  availability_zone = "us-east-2a"
}

module "backend_subnet_b" {
  source = "./aws/aws_subnet"

  subnet_name       = "backend_b"
  subnet_cidr_block = "10.10.5.0/24"
  vpc_id            = module.aws_vpc.vpc_id
  availability_zone = "us-east-2b"
}

module "backend_subnet_c" {
  source = "./aws/aws_subnet"

  subnet_name       = "backend_c"
  subnet_cidr_block = "10.10.6.0/24"
  vpc_id            = module.aws_vpc.vpc_id
  availability_zone = "us-east-2c"
}

module "backend_autoscaling_group" {
  source = "./aws/aws_autoscaling_group"

  autoscaling_group_name = "backend"

  vpc_zone_identifier = [module.backend_subnet_a.subnet_id, module.backend_subnet_b.subnet_id, module.backend_subnet_c.subnet_id]
  security_groups     = [module.backend_subnet_a.ssh_id]
}

resource "aws_lb" "test" {
  name               = "test-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.frontend_subnet_a.ssh_id]
  subnets            = [module.frontend_subnet_a.subnet_id, module.frontend_subnet_b.subnet_id, module.frontend_subnet_c.subnet_id]
}

resource "aws_lb_listener" "test" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_target_group" "frontend_autoscaling_group" {
  name     = "frontend-autoscaling-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.aws_vpc.vpc_id
}

resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = module.frontend_autoscaling_group.name
  lb_target_group_arn    = aws_lb_target_group.frontend_autoscaling_group.arn
}

resource "aws_lb_listener_rule" "reviews_to_frontend" {
  listener_arn = aws_lb_listener.test.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_autoscaling_group.arn
  }

  condition {
    path_pattern {
      values = ["/reviews"]
    }
  }
}

resource "aws_route53_zone" "example_zone" {
  name = aws_lb.test.dns_name
}

resource "aws_route53_record" "reviews_to_load_balancer" {
  zone_id = aws_route53_zone.example_zone.zone_id
  name    = "reviews.${aws_lb.test.dns_name}"
  type    = "CNAME"
  ttl     = 5

  weighted_routing_policy {
    weight = 10
  }

  set_identifier = "frontend"
  records        = ["${aws_lb.test.dns_name}/reviews"]
}

# resource "aws_lb_listener_rule" "reviews-api_to_backend" {
#   listener_arn = aws_lb_listener.test.arn
#   priority     = 101

#   action {
#     type             = "forward"
#     target_group_arn = module.backend_autoscaling_group.target_group_arn
#   }

#   condition {
#     path_pattern {
#       values = ["/reviews-api"]
#     }
#   }
# }
