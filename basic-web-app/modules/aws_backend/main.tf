#############################################################
## This template will create resources for a AWS remote backend
#############################################################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.14"
    }
  }
}

# This will run for AWS
provider "aws" {
  region = var.backend_aws_region
}

# Creates an S3 bucket for state files
resource "aws_s3_bucket" "terraform_state" {
  bucket        = var.backend_bucket
  force_destroy = true
}

# Enables versioning for S3 bucket
resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enables encryption for S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_bucket_encryption" {
  bucket = aws_s3_bucket.terraform_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Creates a DynamoDB tables for terraform locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.backend_dynamodb_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}