resource "aws_subnet" "r_aws_subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.scidr_block
}