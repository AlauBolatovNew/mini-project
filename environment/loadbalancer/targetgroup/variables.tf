variable "vpc_id" {
  type = string
}

variable "name" {
  type = string
}

variable "autoscaling_group" {
  type = string
}

variable "listener_arn" {
  type = string
}

variable "priority" {
  type = number
}

variable "host_header_values" {
  type = list(string)
}