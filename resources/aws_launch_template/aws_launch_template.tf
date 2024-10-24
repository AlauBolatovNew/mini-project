resource "aws_launch_template" "aws_insance_template" {
  name_prefix   = "example-template"
  image_id      = "ami-0ea3c35c5c3284d82"
  instance_type = "t2.micro"
  key_name      = "dontdelete"

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip_address
    security_groups             = var.security_groups
  }

  user_data = base64encode(
    <<EOF
#!/bin/bash
sudo apt update
sudo apt install -y apache2
cd /var/www
sudo chmod 777 html
cd html
echo "<html><h1>${var.autoscaling_group_name}_index.html</h1></html>" > index.html
EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.autoscaling_group_name}-Instance"
    }
  }
}
