variable "region" {
  description = "variable for project wordpress"
  type        = string
  default     = false
}

variable "vpc_cidr_block" {
  type    = string
  default = false
}

variable "tag_vpc" {
  type    = string
  default = false
}

variable "tag_igw" {
  type    = string
  default = false
}

variable "public_subnet_cidr" {
  type    = list(string)
  default = []
}

variable "private_subnet_cidr" {
  type    = list(string)
  default = []
}

variable "private_subnet_db_cidr" {
  type    = list(string)
  default = []
}

variable "azs" {
  type    = list(string)
  default = []
}

variable "public_subnets_tag" {
  description = "Resource tag name"
  type        = string
  default     = null
}

variable "tag_nat" {
  type    = string
  default = null
}

variable "nat_connectivity_type" {
  type    = string
  default = null
}

variable "route_table_tag" {
  type    = string
  default = null
}

#Security Groups
variable "vpc_id" {
  type        = string
  description = "VPC ID"
  default     = null
}

variable "sg_name" {
  type        = string
  description = "Security group name"
  default     = null
}

variable "sg_ingress" {
  type        = any
  description = "Map containing SG's ingress rules"
  default     = {}
}

variable "sg_egress" {
  type        = any
  description = "Map containing SG's egress rules"
  default     = {}
}

#Load Balancer
variable "lb_name" {
  type    = string
  default = false
}

variable "lb_load_balancer_type" {
  type    = string
  default = false
}

variable "lb_ip_address_type" {
  type    = string
  default = false
}

variable "lb_tg_name" {
  type    = string
  default = false
}

variable "lb_tg_port" {
  type    = number
  default = null
}

variable "lb_tg_protocol" {
  type    = string
  default = false
}

variable "lb_tg_target_type" {
  type    = string
  default = false
}

variable "lb_listner_port" {
  type    = number
  default = null
}

variable "lb_listner_protocol" {
  type    = string
  default = null
}

variable "lb_tg_att_target_id" {
  type = string
  default = null
}

variable "security_group_alb" {
  type    = list(string)
  default = []
}


variable "subnets_public_alb" {
  type    = list(string)
  default = []
}

#Relational Database 
variable "db_engine" {
  type    = string
  default = null
}

variable "db_engine_version" {
  type    = string
  default = null
}

variable "db_name" {
  type    = string
  default = null
}

variable "db_storage_type" {
  type    = string
  default = null
}

variable "db_allocated_storage" {
  type    = number
  default = null
}

variable "db_identifier" {
  type    = string
  default = null
}

variable "db_username" {
  type    = string
  default = null
}

variable "db_password" {
  type    = string
  default = null
}

variable "db_instance_class" {
  type    = string
  default = null
}

variable "db_availability_zone" {
  type    = string
  default = null
}

variable "db_subnet_group_name" {
  type    = string
  default = null
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of VPC SG's."
  default     = []
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of VPC subnet IDs."
  default     = []
}

#Elastic File Systems 
variable "efs_creation_token" {
  type    = string
  default = null
}

variable "efs_performance_mode" {
  type    = string
  default = null
}

variable "efs_throughput_mode" {
  type    = string
  default = null
}

variable "tag_efs" {
  type    = string
  default = null
}

variable "efs_var_sg_one" {
  type    = list(string)
  default = []
}

variable "efs_subnets_data" {
  type    = list(string)
  default = []
}

#Auto Scaling group
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
  type    = list(string)
  default = []
}

variable "key_name" {
  type    = string
  default = null
}

variable "ami_id" {
  type    = string
  default = null
}

variable "root_block_device_volume_size" {
  type    = number
  default = null
}

variable "root_block_device_encrypted" {
  type    = bool
  default = false
}

variable "ebs_block_device_encrypted" {
  type    = bool
  default = false
}

variable "ebs_block_device_volume_size" {
  type    = number
  default = null
}

variable "asg_health_check_grace_period" {
  type    = number
  default = null
}

variable "asg_max_size" {
  type    = number
  default = null
}

variable "asg_min_size" {
  type    = number
  default = null
}

variable "asg_desired_capacity" {
  type    = number
  default = null
}

variable "tag_name" {
  type    = string
  default = null
}

variable "tag_value" {
  type    = string
  default = null
}

variable "tag_propagate_at_launch" {
  type    = bool
  default = false
}

variable "vpc_zone" {
  type    = list(string)
  default = null
}

variable "alb_id" {
  type    = string
  default = null
}

variable "target_group" {
  type    = string
  default = null
}

#Elastic cloud computing 
variable "ami" {
  type    = string
  default = null
}

variable "instance_type" {
  type    = string
  default = null
}

variable "security_group_ec2_public" {
  type    = list(string)
  default = []
}

variable "security_group_ec2_public_bastion" {
  type    = list(string)
  default = []
}

variable "depens_on_ec2_var" {
  type    = list(string)
  default = []
}

variable "public_subnets_ec2" {
  type    = list(string)
  default = []
}

variable "private_subnets_ec2" {
  type    = list(string)
  default = []
}

variable "depends_on_ec2" {
  type    = list(string)
  default = []
}