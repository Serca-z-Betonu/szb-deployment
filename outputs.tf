output "ec2_public_ip" {
  value = aws_instance.my_node.public_ip
}