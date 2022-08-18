# Provider Requirements

# terraform {
#   backend "s3" {
#     bucket         = "devops-directive-tf-state"
#     key            = "basic-web-app/environments/qa/web-app/terraform.tfstate" # LOCAL PATH TO TERRAFORM STATE FILE
#     region         = "eu-west-1"
#     dynamodb_table = "devops-terraform-state-locking"
#     encrypt        = true
#   }
# }

terraform {
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

variable "bucket_name" {}
variable "domain" {}

# Create WebApp

module "web_app" {
  source = "../../../modules/web_app"

  environment = local.environment
  bucket_name = var.bucket_name
  domain = var.domain
}