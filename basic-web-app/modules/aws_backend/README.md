# Terraform AWS S3 Remote Backend Module

This module will setup the resources required for using AWS S3 as a remote backend for terraform.

## Requirements

- AWS account (with deploy permissions)
- Terraform v1.2.x
- AWS CLI
- AWS Vault (Optional)

## Whats deployed?

- S3 bucket
- DynamoDB Table

## AWS IAM Permissions

Create a role with the following permissions

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::<NAME OF BUCKET>"
    },
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"],
      "Resource": "arn:aws:s3:::<NAME OF BUCKET>/basic-web-app/*"
    }
  ]
}
```

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:DeleteItem",
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:Query",
        "dynamodb:UpdateItem"
      ],
      "Resource": "arn:aws:dynamodb:*:*:table/<NAME OF TABLE>"
    }
  ]
}
```

## Run Commands

1. Setup your AWS config and follow the on screen setup

    (Skip this setp if already setup)

    `aws configure`

2. Set your variables

    This can be done at run time in the CLI or defined in a tfvars file

    | Variable | Description | Default | Type |
    |---|---|---|---|
    | backend_aws_region | AWS region for terraform remote backend | `eu-west-1` | string |
    | backend_bucket | S3 bucket for terraform remote backend | `devops-directive-tf-state` | string |
    | backend_dynamodb_table | DynamoDB table for terraform remote backend | `devops-terraform-state-locking` | string |

    Note: `devops-` has been added as a prefix in the defaults to allow for multi team working

3. Run the terraform commands

    `terraform init`
    
    `terraform apply`