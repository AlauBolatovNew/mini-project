variable "alarm_name" {
  type = string
}

variable "comparison_operator" {
  type = string
}

variable "threshold" {
  type = string
}

variable "alarm_actions" {
  type = list(string)
}

variable "autoscaling_group_name" {
  type = string
}
