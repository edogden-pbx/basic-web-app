# Network

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "webApp-vpc"
  cidr = var.cidr

  azs             = var.vpc_azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  tags = {
    Terraform = "true"
    Environment = var.environment
  }
}

# data "aws_subnets" "default_subnet" {
#   filter {
#     name   = "vpc-id"
#     values = [module.vpc.vpc_id]
#   }
# }