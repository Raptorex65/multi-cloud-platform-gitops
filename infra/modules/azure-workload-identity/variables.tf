variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "prefix" {
  type = string
}

variable "oidc_issuer_url" {
  type = string
}

variable "key_vault_id" {
  type = string
}