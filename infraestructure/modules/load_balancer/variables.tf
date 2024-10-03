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

variable "vpc_id" {
  type        = string
  description = "VPC ID"
  default = null 
}

variable "security_group_alb" {
  type = list(string)
  default = null 
} 

variable "subnets_public_alb" {
  type = list(string)
  default = null 
}