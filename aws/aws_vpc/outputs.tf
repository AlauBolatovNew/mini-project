output "vpc_id" {
  value = aws_vpc.r_aws_vpc.id
}

output "default_route_table_id" {
  value = aws_vpc.r_aws_vpc.default_route_table_id
}
