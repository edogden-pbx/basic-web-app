# General Variables

variable "aws_region" {
  description = "AWS region for provider"
  type        = string
  default     = "eu-west-1"
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
