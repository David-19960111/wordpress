output "vpc_id" {
  description = "id of vpc"
  value = aws_vpc.my_vpc.id 
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.*.id
}

output "private_subnet_db_id" {
  value = aws_subnet.private_db_subnets.*.id
  sensitive = true
}

output "private_subnet_id" {
  value = aws_subnet.private_subnets.*.id
  sensitive = true 
}