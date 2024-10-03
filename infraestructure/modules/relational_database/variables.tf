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

variable "db_subnet_group_name" {
  type    = string
  default = null 
}

variable "vpc_security_group_ids" {
  type = list(string)
  description = "List of VPC SG's."
  default = []
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of VPC subnet IDs."
  default     = []
}

