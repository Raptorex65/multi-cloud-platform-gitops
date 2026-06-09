# Infrastructure Layer

## Overview

This directory contains all Infrastructure as Code (IaC) definitions used to provision the Multi-Cloud GitOps Platform.

The infrastructure is deployed across AWS and Azure using Terraform and follows a modular design approach.

### Objectives

* Build Kubernetes platforms on AWS and Azure
* Demonstrate reusable Terraform module design
* Support GitOps deployments through Argo CD
* Enable progressive delivery using Argo Rollouts
* Maintain environment isolation (dev, stage, prod)

---

## Structure

infra/
├── aws/
│ ├── dev/
│ ├── stage/
│ └── prod/
│
├── azure/
│ ├── dev/
│ ├── stage/
│ └── prod/
│
└── modules/
├── aws-network/
├── aws-ecr/
├── aws-eks/
├── aws-eks-addons/
├── azure-network/
├── azure-acr/
└── azure-aks/

---

## Design Principles

### Modular Terraform

Infrastructure components are implemented as reusable Terraform modules.

Benefits:

* Reusability
* Reduced duplication
* Easier maintenance
* Independent testing

### Environment Isolation

Each environment maintains:

* Separate Terraform state
* Separate namespaces
* Independent deployment lifecycle

### GitOps

Application deployment is handled through Argo CD.

Terraform provisions the platform while Git repositories define desired application state.

---

## Cloud Platforms

### AWS

Primary services:

* VPC
* EKS
* ECR
* IAM
* ALB Controller
* EBS CSI Driver

### Azure

Primary services:

* VNet
* AKS
* ACR
* Managed Identity

---

## Related Components

Application deployment definitions:

gitops/

Helm charts:

helm/

Documentation:

docs/

---

## Azure Secret Management

The Azure platform includes centralized secret management using Azure Key Vault and External Secrets Operator.

Implemented components:

* Azure Key Vault
* Azure RBAC authorization
* User Assigned Managed Identity
* Federated Identity Credential
* AKS Workload Identity
* External Secrets Operator
* SecretStore
* ExternalSecret

Secret flow:

```text
Azure Key Vault
      ↓
External Secrets Operator
      ↓
Kubernetes Secret
      ↓
Application Pod
```

A test secret stored in Azure Key Vault was successfully synchronized into Kubernetes and consumed by the API pod as an environment variable.

Validation:

```bash
kubectl exec -n microservices-dev <api-pod> -- printenv APP_PASSWORD
```

Result:

```text
super-password-123
```

This confirms end-to-end secret synchronization without storing sensitive values in Git, Helm values, or Kubernetes manifests.

---