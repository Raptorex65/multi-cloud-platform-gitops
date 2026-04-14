variable "location" {
  description = "Azure region for backend resources"
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

variable "terraform_storage_account_name" {
  description = "Globally unique Azure Storage Account name for Terraform remote state"
  type        = string
}

variable "terraform_storage_container_name" {
  description = "Container name for Terraform remote state"
  type        = string
}