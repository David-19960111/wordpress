output "rds_db_hostname" {
  value = aws_db_instance.my_db.endpoint
}