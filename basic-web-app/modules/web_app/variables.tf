# General Variables

variable "aws_region" {
  description = "AWS region for provider"
  type        = string
  default     = "eu-west-1"
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
}

# Web Server Variables

variable "ami" {
  description = "Amazon machine image to use for ec2 instance"
  type        = string
  default     = "ami-0d71ea30463e0ff8d"
}

variable "instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "min_instances" {
  description = "Min Number of instances"
  type        = number
  default     = "2"
}

variable "max_instances" {
  description = "Max Number of instances"
  type        = number
  default     = "5"
}

# S3 Variables

variable "bucket_name" {
  description = "name of s3 bucket for app data"
  type        = string
}

# Route 53 Variables

variable "domain" {
  description = "Domain for website"
  type        = string
}

# Network Variables

variable "cidr" {
  description = "CIDR block for VPC"
  type        = string
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "Private Subnet CIDR Blocks"
  type        = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  description = "Public Subnet CIDR Blocks"
  type        = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "vpc_azs" {
  description = "AZs for VPC"
  type        = list(string)
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}



