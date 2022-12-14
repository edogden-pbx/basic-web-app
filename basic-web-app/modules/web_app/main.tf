#############################################################
## This template will create a basic WebApp
#############################################################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.14"
    }
  }
}

provider "aws" {
  region = var.aws_region
}