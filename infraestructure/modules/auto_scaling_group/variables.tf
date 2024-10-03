variable "launch_conf_name" {
  type    = string
  default = null
}

variable "launch_conf_instance_type" {
  type    = string
  default = null
}

variable "launch_conf_volume_type" {
  type    = string
  default = null
}

variable "asg_name" {
  type    = string
  default = null
}

variable "asg_health_check_type" {
  type    = string 
  default = null 
}

variable "security_group_asg_public" {
  type = list(string)
  default = [ ]
}

variable "key_name" {
  type = string
  default = null
}

variable "ami_id" {
  type = string
  default = null
}

variable "root_block_device_volume_size" {
  type = number
  default = null
}

variable "root_block_device_encrypted" {
  type = bool
  default = false
}

variable "ebs_block_device_encrypted" {
  type = bool
  default = false
}

variable "ebs_block_device_volume_size" {
  type = number
  default = null
}

variable "asg_health_check_grace_period" {
  type = number
  default = null 
}

variable "asg_max_size" {
  type = number
  default = null 
}

variable "asg_min_size" {
  type = number
  default = null  
}

variable "asg_desired_capacity" {
  type = number
  default = null 
}

variable "tag_name" {
  type = string
  default = null
}

variable "tag_value" {
  type = string
  default = null
}

variable "tag_propagate_at_launch" {
  type = bool
  default = false 
}

variable "vpc_zone" {
  type = string
  default = null 
}

variable "alb_id" {
  type = string
  default = null 
}

variable "target_group" {
  type = string
  default = null 
}