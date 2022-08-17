# Provider Requirements

terraform {
  #############################################################
  ## AFTER RUNNING TERRAFORM APPLY (WITH LOCAL BACKEND)
  ## YOU WILL UNCOMMENT THIS CODE THEN RERUN TERRAFORM INIT
  ## TO SWITCH FROM LOCAL BACKEND TO REMOTE AWS BACKEND
  #############################################################
  # backend "s3" {
  #   bucket         = var.backend_bucket
  #   key            = "basic-web-app/environments/qa/aws-backend/terraform.tfstate" # LOCAL PATH TO TERRAFORM STATE FILE
  #   region         = var.backend_aws_region
  #   dynamodb_table = var.backend_dynamodb_table
  #   encrypt        = true
  # }
}

# Create backend

module "aws_backend" {
  source = "../../../modules/aws_backend"

  backend_aws_region = var.backend_aws_region
  backend_bucket = var.backend_bucket
  backend_dynamodb_table = var.backend_dynamodb_table
}