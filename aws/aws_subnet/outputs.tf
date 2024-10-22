output "subnet_id" {
  value = aws_subnet.my_subnet.id
}

output "ssh_id" {
  value = aws_security_group.ssh.id
}