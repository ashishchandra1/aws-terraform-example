variable "aws_region" {
  description = "Region for the VPC"
  default = "eu-central-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "172.16.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "172.16.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  default = "172.16.2.0/24"
}

variable "public_subnet_az" {
  description =  "Availability zone for Public Subnet"
  default = "eu-central-1a"
}

variable "private_subnet_az" {
  description =  "Availability zone for Private Subnet"
  default = "eu-central-1b"
}

variable "availability_zones" {
  default     = "eu-central-1a, eu-central-1b"
  description = "List of availability zones "
}

variable "ami" {
  description = "Ubuntu 18.04 Bionic AMI"
  default = "ami-009c174642dba28e4"
}

variable "instance_type" {
  description = "Instance type to be used to spawn the instance"
  default = "t2.micro"
}

variable "alb_name" {
  default     = "myALB"
  description = "The name of the Application loadbalancer"
}

variable "aws_alb_target_group_port" {
  default = 80
}

variable "alb_port" {
  default = 80
}

variable "health_check_protocol" {
  default = "HTTP"
}
