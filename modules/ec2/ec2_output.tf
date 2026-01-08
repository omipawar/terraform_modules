output "ec2_pub_ip" {
  value = aws_instance.vm.public_ip
}
