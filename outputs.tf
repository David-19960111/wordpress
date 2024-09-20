#Elastic cloud computing
output "instance_state" {
  description = "State of the instance ec2"
  value = module.ec2.instance_state
}

output "instance_public_dns" {
  description = "The public DNS address of the ec2 instance"
  value = module.ec2.instance_public_dns
}

output "instance_public_ip" {
  description = "The public Ip adress of the ec2 instance"
  value = module.ec2.instance_public_ip
}

#Elastic Fyle Systems 
output "efs_id" {
  value       = module.efs.efs_id
}

output "efs_dns_name" {
  value = module.efs.efs_dns_name
}

#Load Balancer
output "alb_dns" {
  value = module.load_balancer.alb_dns
}

output "alb_zone_id" {
  value = module.load_balancer.alb_zone_id
}

output "alb_tg_arn" {
  value = module.load_balancer.alb_tg_arn
}

#Networking
output "vpc_id" {
  description = "id of vpc"
  value = module.vpc.vpc_id 
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "private_subnet_db_id" {
  value = module.vpc.private_subnet_db_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}

#Relational DataBase
output "rds_db_hostname" {
  value = module.rds.rds_db_hostname
}

#Security Groups
output "security_group_id" {
  value = module.alb_public_sg.security_group_id
}