output "instance_state" {
  description = "State of the instance ec2"
  value = aws_instance.bastion.*.instance_state
}

output "instance_public_dns" {
  description = "The public DNS address of the ec2 instance"
  value = aws_instance.bastion.*.instance_public_dns
}

output "instance_public_ip" {
  description = "The public Ip adress of the ec2 instance"
  value = aws_instance.bastion.*.public_ip
}