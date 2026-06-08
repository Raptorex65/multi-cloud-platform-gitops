# Azure Terraform Backend Bootstrap

This Terraform configuration bootstraps the Azure remote backend resources used by the multi-cloud platform project.

## Resources created

- Azure Resource Group for Terraform state
- Azure Storage Account for Terraform state
- Blob Container for `.tfstate` files

## Purpose

Terraform environment roots under `infra/azure/*` use this backend to store remote state.

Example backend usage:

```hcl
backend "azurerm" {
  resource_group_name  = "<backend-resource-group>"
  storage_account_name = "<storage-account-name>"
  container_name       = "<container-name>"
  key                  = "azure/dev/terraform.tfstate"
}

Notes
This bootstrap uses local state intentionally.
After the backend resources are created, Azure environment roots can be configured to use the Azure Storage backend.
Do not delete the backend storage account before destroying the infrastructure that depends on its remote state.
If backend access fails during destroy, Terraform may create errored.tfstate; recover carefully before running further apply/destroy operations.
Typical commands
terraform init
terraform plan
terraform apply
Recovery reminder

If a destroy operation fails because Terraform cannot write to the backend, check:

terraform state list
terraform init -reconfigure
terraform plan

If Terraform writes an errored.tfstate, do not run terraform apply immediately. First reconcile the state.