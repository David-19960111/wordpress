output "instance_state" {
  description = "State of the instance ec2"
  value = aws_instance.bastion.instance_state  # Sin índice
}

output "instance_public_dns" {
  value = aws_instance.bastion.public_dns  # Sin índice
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value = aws_instance.bastion.public_ip  # Sin índice
}
