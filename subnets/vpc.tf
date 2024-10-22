resource "aws_subnet" "my_subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr_block
}

resource "aws_security_group" "ssh" {
  name   = "${var.subnet_name}_allow_ssh"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Adjust this to limit access to your IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "aws_launch_template" {
  source = "../aws/aws_launch_template"

  autoscaling_group_name = "${"${var.subnet_name}"}-Instance"
  security_groups        = [aws_security_group.ssh.id]
}

module "aws_autoscaling_group" {
  source = "../aws/aws_autoscaling_group"

  autoscaling_group_name = var.subnet_name
  vpc_zone_identifier    = [aws_subnet.my_subnet.id]
  aws_launch_template_id = module.aws_launch_template.aws_launch_template_id
}

module "aws_autoscaling_policy_scale_out" {
  source = "../aws/aws_autoscaling_policy"

  name                   = "scale_out"
  autoscaling_group_name = module.aws_autoscaling_group.autoscaling_group_name
}

module "aws_autoscaling_policy_scale_in" {
  source = "../aws/aws_autoscaling_policy"

  name                   = "scale_in"
  autoscaling_group_name = module.aws_autoscaling_group.autoscaling_group_name
}

module "aws_cloudwatch_metric_alarm_cpu_high" {
  source = "../aws/aws_cloudwatch_metric_alarm"

  alarm_name             = "cpu_high"
  comparison_operator    = "GreaterThanOrEqualToThreshold"
  threshold              = "70"
  alarm_actions          = [module.aws_autoscaling_policy_scale_out.arn]
  autoscaling_group_name = module.aws_autoscaling_group.autoscaling_group_name
}

module "aws_cloudwatch_metric_alarm_cpu_low" {
  source = "../aws/aws_cloudwatch_metric_alarm"

  alarm_name             = "cpu_low"
  comparison_operator    = "LessThanOrEqualToThreshold"
  threshold              = "30"
  alarm_actions          = [module.aws_autoscaling_policy_scale_in.arn]
  autoscaling_group_name = module.aws_autoscaling_group.autoscaling_group_name
}
