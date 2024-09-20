resource "aws_db_instance" "my_db" {
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  db_name              = var.db_name
  storage_type         = var.db_storage_type
  allocated_storage    = var.db_allocated_storage 
  identifier           = var.db_identifier
  username             = var.db_username
  password             = var.db_password 
  instance_class       = var.db_instance_class
  skip_final_snapshot  = true
  publicly_accessible  = false
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name 
  vpc_security_group_ids = var.vpc_security_group_ids
}

resource "aws_db_subnet_group" "my_db_subnet_group" {
  name =  var.db_subnet_group_name
  subnet_ids = var.subnet_ids
  tags = {
    Name = "${var.db_subnet_group_name}"
  }
}