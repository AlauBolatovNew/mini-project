resource "aws_internet_gateway" "aws_internet_gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.aws_internet_gateway_name
  }
}
