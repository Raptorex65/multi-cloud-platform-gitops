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
