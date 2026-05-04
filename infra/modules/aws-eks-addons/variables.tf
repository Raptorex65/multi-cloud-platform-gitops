variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID used by the EKS cluster"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "cluster_version" {
  type        = string
  description = "EKS cluster version"
}

variable "oidc_provider_arn" {
  type        = string
  description = "OIDC provider ARN for IRSA"
}

variable "oidc_provider_url" {
  type        = string
  description = "OIDC provider URL for IRSA"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
  default     = {}
}

variable "enable_ebs_csi" {
  type    = bool
  default = true
}

variable "enable_vpc_cni" {
  type    = bool
  default = true
}

variable "enable_kube_proxy" {
  type    = bool
  default = true
}

variable "enable_coredns" {
  type    = bool
  default = true
}

variable "enable_alb_controller" {
  type    = bool
  default = false
}

variable "alb_controller_namespace" {
  type    = string
  default = "kube-system"
}

variable "alb_controller_service_account_name" {
  type    = string
  default = "aws-load-balancer-controller"
}