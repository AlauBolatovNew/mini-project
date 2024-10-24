output "subnets_ids" {
  value = [module.frontend_subnet_a.subnet_id, module.frontend_subnet_b.subnet_id, module.frontend_subnet_c.subnet_id]
}

output "vpc_id" {
  value = module.vpc_id.vpc_id
}

output "ssh_id" {
  value = [module.aws_security_group.ssh_id]
}
