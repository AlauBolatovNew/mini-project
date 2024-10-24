module "aws_vpc" {
  source     = "../../aws/aws_vpc"
  cidr_block = "10.10.0.0/16"
}

module "frontend_subnet_a" {
  source = "../../aws/aws_subnet"

  subnet_name       = "frontend_a"
  subnet_cidr_block = "10.10.1.0/24"
  vpc_id            = module.aws_vpc.vpc_id
  availability_zone = "us-east-2a"
}

module "frontend_subnet_b" {
  source = "../../aws/aws_subnet"

  subnet_name       = "frontend_b"
  subnet_cidr_block = "10.10.2.0/24"
  vpc_id            = module.aws_vpc.vpc_id
  availability_zone = "us-east-2b"
}

module "frontend_subnet_c" {
  source = "../../aws/aws_subnet"

  subnet_name       = "frontend_c"
  subnet_cidr_block = "10.10.3.0/24"
  vpc_id            = module.aws_vpc.vpc_id
  availability_zone = "us-east-2c"
}

module "aws_security_group" {
  source = "../../aws/aws_security_group"

  vpc_id            = module.aws_vpc.vpc_id
}