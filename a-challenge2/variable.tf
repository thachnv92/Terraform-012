variable "vpc_cidr_block" {
  type = string
  default = "172.172.0.0/16"
}

variable "vpc_name" {
  type = string
  default = "Terraform-VPC"
}

variable "internet_gateway_name" {
  type = string
  default = "Terraform-Internet-Gateway"
}

variable "route_table_name" {
  type = string
  default = "Terraform-Route-Table"
}

variable "subnet_cidr_block" {
  type = string
  default = "172.172.0.0/24"
}

variable "subnet_zone" {
  type = string
  default = "ap-southeast-1b"
}

variable "subnet_name" {
  type = string
  default = "Terraform-Subnet"
}

variable "network_interface_private_ips" {
  type = map
  default = {
    db_server  = ["172.172.0.100"]
    web_server = ["172.172.0.101"]
  }
}

variable "network_interface_name" {
  type = string
  default = "Terraform-Network-Interface"
}

variable "instance_ami" {
  type = map
  default = {
    db_server  = "ami-0e5182fad1edfaa68"
    web_server = "ami-0e5182fad1edfaa68"
  }
}

variable "instance_type" {
  type = map
  default = {
    db_server  = "t2.micro"
    web_server = "t2.small"
  }
}

variable "instance_cpu_credits" {
  type = string
  default = "unlimited"
}

variable "instance_db_name" {
  type = map
  default = {
    db_server  = "Terraform-DB-Server"
    web_server = "Terraform-Web-Server"
  }
}
