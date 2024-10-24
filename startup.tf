module "networking" {
  source = "./environment/networking"
}

module "frontend_autoscaling_group" {
  source = "./environment/autoscaling"

  autoscaling_group_name = "frontend"
  vpc_zone_identifier = module.networking.subnets_ids
  security_groups     = module.networking.ssh_id
}

module "backend_autoscaling_group" {
  source = "./environment/autoscaling"

  autoscaling_group_name = "backend"
  vpc_zone_identifier = module.networking.subnets_ids
  security_groups     = module.networking.ssh_id
}

# resource "aws_lb" "test" {
#   name               = "test-lb"
#   internal           = false
#   load_balancer_type = "application"
#   subnets            = module.networking.subnets_ids
#   security_groups    = module.networking.ssh_id
# }

# resource "aws_lb_listener" "listener" {
#   load_balancer_arn = aws_lb.test.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type = "fixed-response"

#     fixed_response {
#       content_type = "text/plain"
#       message_body = "Not Found"
#       status_code  = "404"
#     }
#   }
# }

# resource "aws_lb_target_group" "frontend_autoscaling_group" {
#   name     = "frontend-autoscaling-group"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = module.networking.vpc_id
# }

# resource "aws_lb_target_group" "backend_autoscaling_group" {
#   name     = "backend-autoscaling-group"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = module.networking.vpc_id
# }

# resource "aws_autoscaling_attachment" "example_frontend" {
#   autoscaling_group_name = module.frontend_autoscaling_group.name
#   lb_target_group_arn    = aws_lb_target_group.frontend_autoscaling_group.arn
# }

# resource "aws_autoscaling_attachment" "example_backend" {
#   autoscaling_group_name = module.backend_autoscaling_group.name
#   lb_target_group_arn    = aws_lb_target_group.backend_autoscaling_group.arn
# }

# resource "aws_lb_listener_rule" "reviews_to_frontend" {
#   listener_arn = aws_lb_listener.listener.arn
#   priority     = 100

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.frontend_autoscaling_group.arn
#   }

#   condition {
#     host_header {
#       values = ["reviews.alau.site"]
#     }
#   }
# }

# resource "aws_lb_listener_rule" "reviews_to_backend" {
#   listener_arn = aws_lb_listener.listener.arn
#   priority     = 101

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.backend_autoscaling_group.arn
#   }

#   condition {
#     host_header {
#       values = ["reviews-api.alau.site"]
#     }
#   }
# }
