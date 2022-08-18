# Provider Requirements

terraform {
#   backend "s3" {
#     bucket         = "devops-directive-tf-state"
#     key            = "basic-web-app/environments/qa/web-app/terraform.tfstate" # LOCAL PATH TO TERRAFORM STATE FILE
#     region         = "eu-west-1"
#     dynamodb_table = "devops-terraform-state-locking"
#     encrypt        = true
#   }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.14"
    }
  }
}

# Local vars

locals {
  environment = "qa"
}

# Declare vars for web_app

variable "bucket_name" {}
variable "domain" {}
variable "create_dns_zone" {}

# Create WebApp

module "web_app" {
  source = "../../../modules/web_app"

  environment = local.environment
  bucket_name = var.bucket_name
  domain = var.domain
  create_dns_zone = var.create_dns_zone
}