variable "backend_autoscaling_group" {
  type = string
}

variable "frontend_autoscaling_group" {
  type = string
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