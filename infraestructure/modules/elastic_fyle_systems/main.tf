resource "aws_efs_file_system" "my_efs" {
  creation_token = var.efs_creation_token
  performance_mode = var.efs_performance_mode
  throughput_mode = var.efs_throughput_mode
  encrypted = true
  tags = {
    Name = var.tag_efs
  }
}

resource "aws_efs_mount_target" "target_one" {
  file_system_id = aws_efs_file_system.my_efs.id
  subnet_id = var.efs_subnets_data[*]
  security_groups = var.efs_var_sg_one
}

resource "aws_efs_mount_target" "target_two" {
  file_system_id = aws_efs_file_system.my_efs.id
  subnet_id = var.efs_subnets_data[*]
  security_groups = var.efs_var_sg_one
}