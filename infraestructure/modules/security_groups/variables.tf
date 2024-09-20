variable "vpc_id" {
  type        = string
  description = "VPC ID"
  default = null
}

variable "sg_name" {
  type        = string
  description = "Security group name"
  default = null 
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

variable "sg_name_tag" {
  type = string
  description = "Security group name tag"
  default = false
}