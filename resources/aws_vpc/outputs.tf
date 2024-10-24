output "vpc_id" {
  value = aws_vpc.aws_vpc.id
}

output "default_route_table_id" {
  value = aws_vpc.aws_vpc.default_route_table_id
}

output "cidr_block" {
  value = aws_vpc.aws_vpc.cidr_block
}
