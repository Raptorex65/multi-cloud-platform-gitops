output "terraform_state_bucket_name" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "Name of the S3 bucket used for Terraform state"
}

output "terraform_lock_table_name" {
  description = "Name of the DynamoDB table used for Terraform state locking"
  value       = aws_dynamodb_table.terraform_lock.name
}

output "aws_region" {
  description = "AWS region where backend resources were created"
  value       = var.aws_region
}