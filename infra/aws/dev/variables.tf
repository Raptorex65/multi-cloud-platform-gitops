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

variable "cloud" {
  description = "Cloud provider"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Public Subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private Subnets"
  type        = list(string)
}

variable "cluster_version" {
  description = "EKS Kubernetes version"
  type        = string
}

variable "node_instance_type" {
  description = "Instance type for EKS managed node group"
  type        = string
}

variable "node_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 2
}

variable "ecr_repository_names" {
  description = "ECR repo names input"
  type        = list(string)
}
