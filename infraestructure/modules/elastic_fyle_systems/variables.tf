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
  type = string
  default = null
}

variable "efs_var_sg_one" {
  type = list(string)
  default = []
}

variable "efs_subnets_data" {
  type = list(string)
  default = []
}