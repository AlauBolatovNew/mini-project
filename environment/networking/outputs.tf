output "subnets_ids" {
  value = [module.aws_subnet_a.subnet_id, module.aws_subnet_b.subnet_id, module.aws_subnet_c.subnet_id]
}

output "vpc_id" {
  value = module.aws_vpc.vpc_id
}

output "ssh_id" {
  value = [module.aws_security_group.ssh_id]
}
