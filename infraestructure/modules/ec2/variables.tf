variable "ami" {
  type    = string
  default = null
}

variable "instance_type" {
  type    = string
  default = null
}

variable "key_name" {
  type    = string
  default = null 
}

variable "security_group_ec2_public" {
  type = list(string)
  default = [ ]
}

variable "security_group_ec2_public_bastion" {
  type = list(string)
  default = [ ]
}

variable "depens_on_ec2_var" {
  type = list(string)
  default = [ ]
}

variable "public_subnets_ec2" {
  type = string
  default = null
}

variable "private_subnets_ec2" {
  type = string
  default = null 
}

variable "depends_on_ec2" {
  type = list(string)
  default = [ ]
}