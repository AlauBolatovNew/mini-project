resource "aws_vpc" "aws_vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "my_vpc"
  }
}