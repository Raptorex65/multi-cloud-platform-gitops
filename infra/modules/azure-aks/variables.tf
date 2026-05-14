variable "rg_name" {
  description = "Azure resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "prefix" {
  description = "resource prefix"
  type        = string
}

variable "aks_subnet_id" {
  description = "subnet id"
  type        = string
}

variable "tags" {
  description = "tags"
  type        = map(string)
}

