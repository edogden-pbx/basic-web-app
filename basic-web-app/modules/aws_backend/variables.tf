# Remote backend

variable "backend_aws_region" {
  description = "AWS region for terraform remote backend"
  type        = string
  default     = "eu-west-1"
}

variable "backend_bucket" {
  description = "S3 bucket for terraform remote backend"
  type        = string
  default     = "devops-directive-tf-state"
}

variable "backend_dynamodb_table" {
  description = "DynamoDB table for terraform remote backend"
  type        = string
  default     = "devops-terraform-state-locking"
}