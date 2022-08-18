# Terraform WebApp Module

This module will deploy the resources required for a basic WebApp using Terraform.

## Requirements

- AWS account (with deploy permissions)
- Terraform v1.2.x
- AWS CLI
- AWS Vault (Optional)

## Whats deployed?

- TBW

## AWS IAM Permissions

TBW

## Run Commands

1. Setup your AWS config and follow the on screen setup

    (Skip this setp if already setup)

    `aws configure`

2. Set your variables

    This can be done at run time in the CLI or defined in a tfvars file

    | Variable | Description | Default | Type |
    |---|---|---|---|
    | aws_region | AWS region to be deployed | `eu-west-1` | string |
    | environment | Environment name for tagging | - | string |
    TBW

    Note: `devops-` has been added as a prefix in the defaults to allow for multi team working

3. Run the terraform commands

    `terraform init`
    
    `terraform apply`