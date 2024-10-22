resource "aws_subnet" "my_subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr_block
}

resource "aws_security_group" "ssh" {
  name   = "${var.subnet_name}_allow_ssh"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}