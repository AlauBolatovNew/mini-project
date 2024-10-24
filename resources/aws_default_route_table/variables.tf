variable "default_route_table_id" {
  type = string
}

variable "routes" {
  type = list(object({
    cidr_block = string
    gateway_id = string
  }))
}
