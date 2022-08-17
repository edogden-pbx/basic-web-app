# Provider Requirements

terraform {
  backend "s3" {
    bucket         = "devops-directive-tf-state"
    key            = "basic-web-app/environments/qa/web-app/terraform.tfstate" # LOCAL PATH TO TERRAFORM STATE FILE
    region         = "eu-west-1"
    dynamodb_table = "devops-terraform-state-locking"
    encrypt        = true
  }
}

# Create WebApp

module "web_app" {
  source = "../../../modules/web_app"
}