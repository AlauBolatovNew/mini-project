variable "autoscaling_group_name" {
  type = string
}

variable "security_groups" {
  type = list(string)
}

variable "associate_public_ip_address" {
  type = bool
}