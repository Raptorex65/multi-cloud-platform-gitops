# AWS Terraform Backend Bootstrap

This Terraform configuration bootstraps the AWS remote backend resources used by the multi-cloud platform project.

## Resources created

- S3 bucket for Terraform state
- DynamoDB table for state locking

## Notes

- This bootstrap uses local state intentionally.
- After these resources are created, AWS environment roots can be configured to use the S3 backend with DynamoDB locking.