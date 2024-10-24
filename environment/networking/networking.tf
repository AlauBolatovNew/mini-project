module "aws_vpc" {
  source     = "../../resources/aws_vpc"
  cidr_block = "10.10.0.0/16"
}

module "aws_internet_gateway" {
  source = "../../resources/aws_internet_gateway"

  vpc_id                    = module.aws_vpc.vpc_id
  aws_internet_gateway_name = "my_internet_gateway"
}

resource "aws_route_table" "example" {
  vpc_id = module.aws_vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.aws_internet_gateway.gateway_id
  }

  tags = {
    Name = "public_route"
  }
}

module "aws_default_route_table" {
  source = "../../resources/aws_default_route_table"

  default_route_table_id = module.aws_vpc.default_route_table_id

  routes = [{
    cidr_block = module.aws_vpc.cidr_block
    gateway_id = "local"
  }]
}

module "aws_subnet_private_a" {
  source = "../../resources/aws_subnet"

  subnet_name       = "aws_subnet_private_a"
  subnet_cidr_block = "10.10.1.0/24"
  vpc_id            = module.aws_vpc.vpc_id
  availability_zone = "us-east-2a"
}

module "aws_subnet_private_b" {
  source = "../../resources/aws_subnet"

  subnet_name       = "aws_subnet_private_b"
  subnet_cidr_block = "10.10.2.0/24"
  vpc_id            = module.aws_vpc.vpc_id
  availability_zone = "us-east-2b"
}

module "aws_subnet_private_c" {
  source = "../../resources/aws_subnet"

  subnet_name       = "aws_subnet_private_c"
  subnet_cidr_block = "10.10.3.0/24"
  vpc_id            = module.aws_vpc.vpc_id
  availability_zone = "us-east-2c"
}

module "aws_subnet_public_a" {
  source = "../../resources/aws_subnet"

  subnet_name       = "aws_subnet_public_a"
  subnet_cidr_block = "10.10.4.0/24"
  vpc_id            = module.aws_vpc.vpc_id
  availability_zone = "us-east-2a"
}

resource "aws_route_table_association" "a" {
  subnet_id      = module.aws_subnet_public_a.subnet_id
  route_table_id = aws_route_table.example.id
}

module "aws_subnet_public_b" {
  source = "../../resources/aws_subnet"

  subnet_name       = "aws_subnet_public_b"
  subnet_cidr_block = "10.10.5.0/24"
  vpc_id            = module.aws_vpc.vpc_id
  availability_zone = "us-east-2b"
}

resource "aws_route_table_association" "b" {
  subnet_id      = module.aws_subnet_public_b.subnet_id
  route_table_id = aws_route_table.example.id
}

module "aws_subnet_public_c" {
  source = "../../resources/aws_subnet"

  subnet_name       = "aws_subnet_public_c"
  subnet_cidr_block = "10.10.6.0/24"
  vpc_id            = module.aws_vpc.vpc_id
  availability_zone = "us-east-2c"
}

resource "aws_route_table_association" "c" {
  subnet_id      = module.aws_subnet_public_c.subnet_id
  route_table_id = aws_route_table.example.id
}

module "aws_security_group" {
  source = "../../resources/aws_security_group"

  vpc_id = module.aws_vpc.vpc_id
}
