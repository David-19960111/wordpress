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
  count = length(var.efs_subnets_data) > 0 ? 1 : 0  # Solo crea si hay subredes
  file_system_id = aws_efs_file_system.my_efs.id
  subnet_id = var.efs_subnets_data[0]  # Usa la primera subred
  security_groups = var.efs_var_sg_one
}

resource "aws_efs_mount_target" "target_two" {
  count = length(var.efs_subnets_data) > 1 ? 1 : 0  # Solo crea si hay al menos dos subredes
  file_system_id = aws_efs_file_system.my_efs.id
  subnet_id = var.efs_subnets_data[1]  # Usa la segunda subred
  security_groups = var.efs_var_sg_one
}
