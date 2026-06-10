# AWS Infrastructure

## Overview

This directory contains environment deployments for AWS.

The AWS platform was built to demonstrate:

* Kubernetes provisioning with EKS
* Container registry integration with ECR
* GitOps deployment workflows
* Progressive delivery concepts

---

## Components

### Networking

Provided by:

modules/aws-network

Features:

* Public and private subnets
* NAT Gateway
* Route table separation

---

## Container Registry

Provided by:

modules/aws-ecr

Stores application images.

Examples:

* multi-cloud/api
* multi-cloud/frontend
* multi-cloud/worker

---

## Kubernetes Platform

Provided by:

modules/aws-eks

Features:

* Managed node groups
* IAM Roles for Service Accounts
* OIDC integration

---

## Cluster Addons

Provided by:

modules/aws-eks-addons

Installed:

* AWS Load Balancer Controller
* EBS CSI Driver
* Managed Addons

---

## GitOps

Applications are deployed through:

Argo CD

Repository:

multi-cloud-platform-gitops

---

## Lessons Learned

Key findings during implementation:

* ALB Controller requires careful dependency ordering
* OIDC integration is mandatory for IRSA
* Addons often require explicit Terraform dependencies
* GitOps simplifies deployment consistency across environments
