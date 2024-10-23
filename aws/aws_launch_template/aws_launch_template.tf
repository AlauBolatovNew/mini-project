resource "aws_launch_template" "r_aws_insance_template" {
  name_prefix   = "example-template"
  image_id      = "ami-0ea3c35c5c3284d82"
  instance_type = "t2.micro"
  key_name      = "dontdelete"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.security_groups
  }

  user_data = base64encode(
    <<EOF
#!/bin/bash
sudo apt update
sudo apt install -y apache2
echo "RewriteEngine On
RewriteRule ^reviews$ /reviews.html [L]" | sudo tee /var/www/html/.htaccess
cd /var/www
sudo chmod 777 html
cd html
echo "<html><h1>${var.autoscaling_group_name}_index.html</h1></html>" > index.html
echo "<html><h1>${var.autoscaling_group_name}_reviews.html</h1></html>" > reviews.html
sudo systemctl restart apache2
sudo a2enmod rewrite
echo "<Directory /var/www/html>
    AllowOverride All
</Directory>" | sudo tee /etc/apache2/conf-available/rewrite.conf
sudo a2enconf rewrite
echo "RewriteEngine On
RewriteRule ^reviews$ /reviews.html [L]" | sudo tee /var/www/html/.htaccess
sudo systemctl restart apache2
EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.autoscaling_group_name}-Instance"
    }
  }
}
