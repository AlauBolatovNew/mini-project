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
    cidr_blocks = ["0.0.0.0/0"] # Adjust this to limit access to your IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "frontend_auto_scaling_group" {
  source = "../aws/autoscaling_groups"

  autoscaling_group_name = "${var.subnet_name}"
  security_groups        = [aws_security_group.ssh.id]
  vpc_zone_identifier    = [aws_subnet.my_subnet.id]
}