terraform {
  backend "s3" {
    bucket         = "multi-cloud-platform-tfstate-bucket59-eu-west-1"
    region         = "eu-west-1"
    dynamodb_table = "multi-cloud-platform-tflock"
    encrypt        = true
    key            = "aws/dev/terraform.tfstate"
  }
}