# Platform Overview

```mermaid
flowchart TD

Developer --> GitHub

GitHub --> GitHubActions

GitHubActions --> ACR
GitHubActions --> ECR

GitHubActions --> GitOpsRepo

GitOpsRepo --> ArgoCD

ArgoCD --> AKS
ArgoCD --> EKS

AKS --> API
AKS --> Frontend
AKS --> Worker

EKS --> API2
EKS --> Frontend2
EKS --> Worker2
```

## Description

High-level view of the Multi-Cloud GitOps Platform.

The application repository builds container images while the platform repository manages deployment state through GitOps.

```
```
