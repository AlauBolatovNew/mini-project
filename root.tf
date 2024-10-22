provider "aws" {
  region = "us-east-2"
}

module "aws_vpc" {
  source = "./aws/aws_vpc"

  cidr_block = "10.10.0.0/16"
}

module "frontend_subnet" {
  source = "./subnets"

  subnet_name       = "frontend"
  subnet_cidr_block = "10.10.1.0/24"
  vpc_id            = module.aws_vpc.vpc_id
}

module "backend_subnet" {
  source = "./subnets"

  subnet_name       = "backend"
  subnet_cidr_block = "10.10.2.0/24"
  vpc_id            = module.aws_vpc.vpc_id
}