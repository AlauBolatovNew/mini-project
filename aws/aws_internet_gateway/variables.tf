variable "vpc_id" {
  type = string
}

variable "aws_internet_gateway_name" {
  type = string
}

variable "routes" {
  type = list(object({
    destination_cidr_block = string
    gateway_id             = string
  }))
}
