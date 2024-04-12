variable "frontend_app_name" {
    description = "app name"
    default = "name"
  
}
variable "backend_app_name" {
    description = "app name"
    default = "name"
  
}
variable "project_name" {
    default = "name"
  
}
variable "cpu" {
    description = "cpu size"
    default = 10
}
variable "memory" {
    description = "container memory size"
    default = 512
  
}

variable "cluster_name" {
    description = "Cluster name"
    default = "cluster_name"
}
variable "backend_port" {
    description = "port of the backnd app"
    default = 80
  
}
variable "frontend_port" {
    description = "port of the frontend app"
    default = 80
  
}
variable "region" {
  type = string
  default = "us-east-1"
}

variable "VPC_cidr" {
  type = string
  default = "10.10.0.0/16" 
}


variable "subnet_priv1_cidr" {
  type = string
  default = "10.10.0.0/20"
}

variable "subnet_priv2_cidr" {
  type = string
  default = "10.10.16.0/20"
}

variable "subnet_pub1_cidr" {
  type = string
  default = "10.10.32.0/20"
} 

variable "subnet_pub2_cidr" {
  type = string
  default = "10.10.80.0/20"
}  

variable "AZ1" {
  type = string
  default = "us-east-1a"
}

variable "AZ2" {
  type = string
  default = "us-east-1b"
}