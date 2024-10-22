provider "aws" {
  region = "us-east-2"
}

module "aws_vpc" {
  source = "./aws/aws_vpc"

  cidr_block = "10.10.0.0/16"
}

module "aws_internet_gateway" {
  source = "./aws/aws_internet_gateway"

  vpc_id                    = module.aws_vpc.vpc_id
  aws_internet_gateway_name = "my_internet_gateway"
}

module "aws_default_route_table" {
  source = "./aws/aws_default_route_table"

  default_route_table_id = module.aws_vpc.default_route_table_id

  cidr_block = module.aws_vpc.cidr_block

  gateway_id = module.aws_internet_gateway.aws_internet_gateway_id
}

resource "aws_default_route_table" "example" {
  default_route_table_id = module.aws_vpc.default_route_table_id

  route {
    cidr_block = module.aws_vpc.my_vpc.cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

module "frontend_subnet" {
  source = "./subnets"

  subnet_name       = "frontend"
  subnet_cidr_block = "10.10.1.0/24"
  vpc_id            = aws_vpc.my_vpc.id
}

module "backend_subnet" {
  source = "./subnets"

  subnet_name       = "backend"
  subnet_cidr_block = "10.10.2.0/24"
  vpc_id            = aws_vpc.my_vpc.id
}
