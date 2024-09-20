variable "vpc_cidr_block" {
  type = string 
  default = false
}

variable "tag_vpc" {
  type = string
  default = false 
}

variable "tag_igw" {
  type = string
  default = false
}

variable "public_subnet_cidr" {
  type = list(string)
  default = [ ]
}

variable "private_subnet_cidr" {
  type = list(string)
  default = [ ]
}

variable "private_subnet_db_cidr" {
  type = list(string)
  default = [ ]
}

variable "azs" {
  type = list(string)
  default = [ ]
}

variable "public_subnets_tag" {
  description = "Resource tag name"
  type        = string
  default     = null
}

variable "tag_nat" {
  type = string
  default = null 
}

variable "nat_connectivity_type" {
  type = string
  default = null 
}

variable "route_table_tag" {
  type = string
  default = null
}