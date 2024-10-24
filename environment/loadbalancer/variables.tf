variable "autoscaling_groups_names" {
  type = object({
    frontend_autoscaling_group_name = string,
    backend_autoscaling_group_name  = string
  })
}

variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}