# Provider Requirements

terraform {
  backend "s3" {
    bucket         = var.backend_bucket
    key            = "basic-web-app/environments/qa/web-app/terraform.tfstate" # LOCAL PATH TO TERRAFORM STATE FILE
    region         = var.backend_aws_region
    dynamodb_table = var.backend_dynamodb_table
    encrypt        = true
  }
}

# Create WebApp

module "web_app" {
  source = "../../../modules/web_app"


}