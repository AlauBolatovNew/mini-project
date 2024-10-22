provider "aws" {
  region = "us-east-2"
}

module "aws_vpc" {
  source = "./aws/aws_vpc"

  cidr_block = "10.10.0.0/16"
}

module "frontend_subnet" {
  source = "./aws/aws_subnet"

  subnet_name       = "frontend"
  subnet_cidr_block = "10.10.1.0/24"
  vpc_id            = module.aws_vpc.vpc_id
}

module "frontend_autoscaling_group" {
  source = "./aws/aws_autoscaling_group"

  autoscaling_group_name = "frontend"

  vpc_zone_identifier    = [module.frontend_subnet.subnet_id]
  security_groups        = [module.frontend_subnet.ssh_id]
}

module "backend_subnet" {
  source = "./aws/aws_subnet"

  subnet_name       = "backend"
  subnet_cidr_block = "10.10.2.0/24"
  vpc_id            = module.aws_vpc.vpc_id
}

module "backend_autoscaling_group" {
  source = "./aws/aws_autoscaling_group"

  autoscaling_group_name = "backend"
  vpc_zone_identifier    = [module.backend_subnet.subnet_id]
  security_groups        = [module.backend_subnet.ssh_id]
}