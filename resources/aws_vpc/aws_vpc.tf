resource "aws_vpc" "r_aws_vpc" {
  cidr_block = var.cidr_block
}

module "aws_internet_gateway" {
  source = "../aws_internet_gateway"

  vpc_id                    = aws_vpc.r_aws_vpc.id
  aws_internet_gateway_name = "my_internet_gateway"
}

module "aws_default_route_table" {
  source = "../aws_default_route_table"

  default_route_table_id = aws_vpc.r_aws_vpc.default_route_table_id

  routes = [{
    cidr_block = aws_vpc.r_aws_vpc.cidr_block
    gateway_id = "local"
    }, {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.aws_internet_gateway.gateway_id
  }]
}