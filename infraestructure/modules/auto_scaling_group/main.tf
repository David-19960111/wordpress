resource "aws_launch_configuration" "my-launch-config" {
  name_prefix     = var.launch_conf_name
  image_id        = var.ami_id
  instance_type   = var.launch_conf_instance_type
  key_name = var.key_name
  security_groups = var.security_group_asg_public

  root_block_device {
    volume_type = var.launch_conf_volume_type
    volume_size = var.root_block_device_volume_size
    encrypted   = var.root_block_device_encrypted
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = var.launch_conf_volume_type
    volume_size = var.ebs_block_device_volume_size
    encrypted   = var.ebs_block_device_encrypted
  }

  lifecycle {
    create_before_destroy = true
  }
  user_data = filebase64("${path.module}/webserver_script.sh")
}

resource "aws_autoscaling_group" "my_asg" {
  name = var.asg_name
  vpc_zone_identifier = var.vpc_zone[*]
  health_check_type   = var.asg_health_check_type
  health_check_grace_period = var.asg_health_check_grace_period
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  desired_capacity          = var.asg_desired_capacity 
  depends_on = [var.alb_id]
  target_group_arns = var.target_group[*]
  launch_configuration = aws_launch_configuration.my-launch-config.name
  tag {
    key                 = var.tag_name
    value               = var.tag_value
    propagate_at_launch = var.tag_propagate_at_launch
  }
}