variable "aws_region" {
  description = "AWS region for backend resources"
  type        = string
}

variable "project_name" {
  description = "Project name used in resource naming"
  type        = string
}

variable "environment" {
  description = "Bootstrap environment label"
  type        = string
  default     = "shared"
}

variable "owner" {
  description = "Owner tag value"
  type        = string
}

variable "terraform_state_bucket_name" {
  description = "Globally unique S3 bucket name for Terraform remote state"
  type        = string
}

variable "terraform_lock_table_name" {
  description = "DynamoDB table name for Terraform state locking"
  type        = string
}