output "remote_s3" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "remote_table" {
  value = aws_dynamodb_table.terraform_locks.name
}