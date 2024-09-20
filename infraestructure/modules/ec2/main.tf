resource "aws_instance" "bastion" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = var.public_subnets_ec2
    associate_public_ip_address = true
    vpc_security_group_ids = var.security_group_ec2_public_bastion
    tags = {
        Name: "bastion_instance"
    }

    connection {
        type        = "ssh"
        user        = "ec2-user"  # Replace with the appropriate username for your EC2 instance
        private_key = file("wordpress.pem")  # Replace with the path to your private key
        host        = self.public_ip
    }
    
    provisioner "file" {
        source = "wordpress.pem"
        destination = "wordpress.pem" 
    }

    provisioner "remote-exec" {
        inline = [
            "cd /home/ec2-user/",
            "chmod 400 wordpress.pem",
        ]
        on_failure = fail
    }

}

resource "aws_instance" "setup_server" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = var.private_subnets_ec2
  vpc_security_group_ids = var.security_group_ec2_public
  associate_public_ip_address = false
  tags = {
    Name ="setup_server_instance"
  }
  depends_on = [var.depens_on_ec2_var]
  user_data = file("${path.module}/script.sh")
}