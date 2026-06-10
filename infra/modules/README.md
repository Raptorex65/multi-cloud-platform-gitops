# Terraform Modules

## Overview

This directory contains reusable Terraform modules used to provision cloud infrastructure components for AWS and Azure.

The goal is to separate platform building blocks from environment-specific configuration.

---

# AWS Modules

## aws-network

Creates:

* VPC
* Public Subnets
* Private Subnets
* Internet Gateway
* NAT Gateway
* Route Tables

Outputs:

* VPC ID
* Subnet IDs

---

## aws-ecr

Creates:

* ECR repositories

Purpose:

Stores container images used by ECS and EKS workloads.

Outputs:

* Repository URL

---

## aws-eks

Creates:

* EKS Cluster
* Managed Node Group
* IAM Roles
* OIDC Provider

Outputs:

* Cluster Name
* Endpoint
* OIDC Issuer

---

## aws-eks-addons

Installs and configures:

* AWS Load Balancer Controller
* EBS CSI Driver
* Managed EKS Addons

Lessons learned:

Resource dependency ordering is critical.

EKS Cluster
↓
OIDC Provider
↓
IAM Roles
↓
Addons
↓
Load Balancer Controller

---

# Azure Modules

## azure-network

Creates:

* Resource Group
* Virtual Network
* Subnets

Outputs:

* VNet ID
* Subnet ID

---

## azure-acr

Creates:

* Azure Container Registry

Outputs:

* Login Server
* Registry Name

---

## azure-aks

Creates:

* AKS Cluster
* System Node Pool
* Managed Identity

Outputs:

* Cluster Name
* Identity Information

---

## azure-keyvault

Creates:

* Azure Key Vault
* RBAC-based authorization
* Key Vault Administrator role assignment

Purpose:

Provides centralized secret storage for AKS workloads.

Outputs:

* Key Vault ID
* Key Vault name
* Key Vault URI

---

## azure-workload-identity

Creates:

* User Assigned Managed Identity
* Federated Identity Credential
* Key Vault Secrets User role assignment

Purpose:

Allows Kubernetes workloads to access Azure resources without storing client secrets.

Used by:

* External Secrets Operator
* Azure Key Vault integration

Authentication flow:

```text
Kubernetes ServiceAccount
      ↓
Federated Credential
      ↓
User Assigned Managed Identity
      ↓
Azure Key Vault
```

---

# Naming Convention

Resource naming follows:

multi-cloud-platform-{environment}

Examples:

* multi-cloud-platform-dev
* multi-cloud-platform-stage
* multi-cloud-platform-prod

---

# Architecture Philosophy

Modules should:

* Have a single responsibility
* Expose only required outputs
* Remain environment agnostic
* Avoid hardcoded values

Environment-specific configuration belongs in:

infra/aws/*
infra/azure/*
