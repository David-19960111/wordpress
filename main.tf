terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source = "./infraestructure/modules/networking"

  vpc_cidr_block = "10.0.0.0/16"
  tag_vpc        = "wordpress_vpc"

  public_subnet_cidr     = ["10.0.0.0/24", "10.0.1.0/24"]
  private_subnet_cidr    = ["10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_db_cidr = ["10.0.4.0/24", "10.0.5.0/24"]
  azs                    = ["us-east-2a", "us-east-2b"]
  public_subnets_tag     = "subnets_public_tag"

  tag_igw = "wordpress_igw"

  #NAT Gateway
  tag_nat               = "my_nat"
  nat_connectivity_type = "public"

  #Route Table
  route_table_tag = "my_route_table"
}

#Load Balancer
module "load_balancer" {
  source = "./infraestructure/modules/load_balancer"

  lb_name               = "my-lb"
  lb_load_balancer_type = "application"
  lb_ip_address_type    = "ipv4"
  lb_tg_name            = "my-alb-tg"
  lb_tg_port            = 80
  lb_tg_protocol        = "HTTP"
  lb_tg_target_type     = "instance"
  lb_listner_port       = 80
  lb_listner_protocol   = "HTTP"
  lb_tg_att_target_id = module.ec2.instance_public_ip 
  vpc_id                = module.vpc.vpc_id
  security_group_alb    = [module.webserver_public_sg.security_group_id, module.ssh_sg.security_group_id, module.alb_public_sg.security_group_id]
  subnets_public_alb    = module.vpc.public_subnet_id
}

module "asg" {
  source = "./infraestructure/modules/auto_scaling_group"

  launch_conf_name              = "webserver_launch_config"
  launch_conf_instance_type     = "t2.micro"
  launch_conf_volume_type       = "gp2"
  asg_name                      = "myasg"
  asg_health_check_type         = "ALB"
  security_group_asg_public     = [module.webserver_public_sg.security_group_id, module.ssh_sg.security_group_id]
  key_name                      = "Wordpress"
  ami_id                        = "ami-037774efca2da0726"
  root_block_device_volume_size = 10
  root_block_device_encrypted   = true
  ebs_block_device_volume_size  = 5
  ebs_block_device_encrypted    = true
  asg_health_check_grace_period = 300
  asg_max_size                  = 4
  asg_min_size                  = 1
  asg_desired_capacity          = 2
  tag_name                      = "asg_webserver"
  tag_value                     = "my_asg"
  tag_propagate_at_launch       = true

  vpc_zone = element(module.vpc.private_subnet_id, 0)
  alb_id       = module.load_balancer.alb_zone_id
  target_group = module.load_balancer.alb_tg_arn
}

# Application Load Balancer
module "alb_public_sg" {
  source  = "./infraestructure/modules/security_groups"
  vpc_id  = module.vpc.vpc_id
  sg_name = "wordpress-public-sg-alb"

  sg_ingress = {
    rule-1 = {
      description = "Allow HTTP requests"
      from_port   = 80
      to_port     = 80
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
    rule-2 = {
      description = "Allow HTTPS requests"
      from_port   = 443
      to_port     = 443
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  sg_egress = {
    rule-1 = {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  sg_name_tag = "sg-tag"
}

# Web Server
module "webserver_public_sg" {
  source  = "./infraestructure/modules/security_groups"
  vpc_id  = module.vpc.vpc_id
  sg_name = "wordpress-public-sg"

  sg_ingress = {
    rule-1 = {
      description = "Allow HTTP requests"
      from_port   = 80
      to_port     = 80
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
    rule-2 = {
      description = "Allow HTTPS requests"
      from_port   = 443
      to_port     = 443
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
    rule-3 = {
      description = "Allow SSH requests"
      from_port   = 22
      to_port     = 22
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  sg_egress = {
    rule-1 = {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  sg_name_tag = "sg-tag"
}

# Relational DataBase
module "rds_sg" {
  source = "./infraestructure/modules/security_groups"

  vpc_id  = module.vpc.vpc_id
  sg_name = "wordpress-rds-sg"

  sg_ingress = {
    rule-1 = {
      description = "Allow all inbound traffic to RDS"
      from_port   = 3306
      to_port     = 3306
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  sg_egress = {
    rule-1 = {
      description = "Allow all outbound traffic RDS"
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  sg_name_tag = "sg-tag"
}

# SSH
module "ssh_sg" {
  source = "./infraestructure/modules/security_groups"

  vpc_id  = module.vpc.vpc_id
  sg_name = "wordpress-ssh-sg"

  sg_ingress = {
    rule-1 = {
      description = "Allow all inbound traffic to SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  sg_egress = {
    rule-1 = {
      description = "Allow all outbound traffic SSH"
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  sg_name_tag = "sg-tag"
}

#efs
module "efs_sg" {
  source = "./infraestructure/modules/security_groups"

  vpc_id  = module.vpc.vpc_id
  sg_name = "wordpress-efs-sg"

  sg_ingress = {
    rule-1 = {
      description = "Allow all inbound traffic to SSH"
      from_port   = 2049
      to_port     = 2049
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  sg_egress = {
    rule-1 = {
      description = "Allow all outbound traffic SSH"
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  sg_name_tag = "sg-tag"
}

module "ssm_sops" {
  source = "./infraestructure/modules/systems_manager_sops"
}

#Database
module "rds" {
  source = "./infraestructure/modules/relational_database"

  #Config parameters
  db_name              = "travelapps"
  db_identifier        = "travelapp-identifier"
  db_username          = module.ssm_sops.DB_USERNAME_SOPS
  db_password          = module.ssm_sops.DB_PASSWORD_SOPS
  db_engine            = "mysql"
  db_engine_version    = "8.0.33"
  db_instance_class    = "db.t3.micro"
  db_allocated_storage = 20
  db_storage_type      = "gp2"

  #Networking parameters
  subnet_ids             = module.vpc.public_subnet_id
  vpc_security_group_ids = [module.rds_sg.security_group_id]

  #DB subnet group
  db_subnet_group_name = "wordpress-group"
}

#Elastic File Systems 

module "efs" {
  source = "./infraestructure/modules/elastic_fyle_systems"

  efs_creation_token   = "efs"
  efs_performance_mode = "generalPurpose"
  efs_throughput_mode  = "elastic"
  tag_efs              = "efs_for_wordpress"
  efs_var_sg_one       = [module.efs_sg.security_group_id, module.alb_public_sg.security_group_id, module.rds_sg.security_group_id]
  efs_subnets_data     = module.vpc.private_subnet_db_id
}

#Elastic computing cloud 

module "ec2" {
  source = "./infraestructure/modules/ec2"

  ami                               = "ami-037774efca2da0726"
  instance_type                     = "t2.micro"
  key_name                          = "wordpress"
  security_group_ec2_public         = [module.alb_public_sg.security_group_id, module.webserver_public_sg.security_group_id, module.ssh_sg.security_group_id]
  security_group_ec2_public_bastion = [module.webserver_public_sg.security_group_id, module.ssh_sg.security_group_id]
  depens_on_ec2_var                 = []
  public_subnets_ec2 = element(module.vpc.public_subnet_id, 0)
  private_subnets_ec2               = element(module.vpc.private_subnet_id, 0)
  depends_on_ec2                    = [module.efs.efs_id, module.rds.rds_db_hostname]
}
