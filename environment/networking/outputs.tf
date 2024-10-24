output "private_subnets_ids" {
  value = [module.aws_subnet_private_a.subnet_id, module.aws_subnet_private_b.subnet_id, module.aws_subnet_private_c.subnet_id]
}

output "public_subnets_ids" {
  value = [module.aws_subnet_public_a.subnet_id, module.aws_subnet_public_b.subnet_id, module.aws_subnet_public_c.subnet_id]
}

output "vpc_id" {
  value = module.aws_vpc.vpc_id
}

output "ssh_id" {
  value = [module.aws_security_group.ssh_id]
}
