variable "public_vpc_zone_identifier" {
  type = list(string)
}

variable "private_vpc_zone_identifier" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}

