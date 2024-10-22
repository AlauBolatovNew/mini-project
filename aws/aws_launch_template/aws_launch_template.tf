resource "aws_launch_template" "aws_insance_template" {
  name_prefix   = "example-template"
  image_id      = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = "dontdelete"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.security_groups
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.autoscaling_group_name}-Instance"
    }
  }
}
