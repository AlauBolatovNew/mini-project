variable "autoscaling_group_name" {
  type = string
}

variable "vpc_zone_identifier" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}