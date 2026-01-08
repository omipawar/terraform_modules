resource "aws_instance" "vm" {
  tags = {
    Name = "amazon-linux"
  }
  ami                    = var.amazon_linux_ami
  key_name               = var.ec2_keypair
  vpc_security_group_ids = [var.vpc_security_group_id]
  subnet_id              = var.subnet_id
  instance_type          = var.instance_type
  user_data              = <<-EOF
  #!/bin/bash
  sudo -i
  yum install httpd -y
  systemctl start httpd
  systemctl enable httpd
  echo "Hi! Welcome to terraform module." > /var/www/html/index.html
  EOF
}
