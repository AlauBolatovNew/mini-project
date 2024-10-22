variable "autoscaling_group_name" {
  type = string
}

variable "vpc_zone_identifier" {
  type = list(string)
}

variable "aws_launch_template_id" {
  type = string
}