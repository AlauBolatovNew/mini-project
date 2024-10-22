variable "default_route_table_id" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "gateway_id" {
  type = string
}

resource "aws_default_route_table" "r_aws_default_route_table" {
  default_route_table_id = var.default_route_table_id

  route {
    cidr_block = var.cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }
}
