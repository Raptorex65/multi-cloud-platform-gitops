variable "resource_group_name" {
  description = "Azure resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
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

variable "cloud" {
  description = "Cloud provider"
  type        = string
}