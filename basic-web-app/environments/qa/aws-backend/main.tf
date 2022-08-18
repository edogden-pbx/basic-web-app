# Provider Requirements

terraform {
  #############################################################
  ## AFTER RUNNING TERRAFORM APPLY (WITH LOCAL BACKEND)
  ## YOU WILL UNCOMMENT THIS CODE THEN RERUN TERRAFORM INIT
  ## TO SWITCH FROM LOCAL BACKEND TO REMOTE AWS BACKEND
  #############################################################
  # backend "s3" {
  #   bucket         = "devops-directive-tf-state"
  #   key            = "basic-web-app/environments/qa/aws-backend/terraform.tfstate" # LOCAL PATH TO TERRAFORM STATE FILE
  #   region         = "eu-west-1"
  #   dynamodb_table = "devops-terraform-state-locking"
  #   encrypt        = true
  # }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.14"
    }
  }
}

# Create backend

module "aws_backend" {
  source = "../../../modules/aws_backend"
}