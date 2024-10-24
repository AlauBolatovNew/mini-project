variable "listener_arn" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "host_header_values" {
  type = list(string)
}

variable "priority" {
  type = number
}