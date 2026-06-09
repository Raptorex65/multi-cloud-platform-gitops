# GitOps Deployment Flow

```mermaid
flowchart LR

Dev[Developer]

CodeRepo[Application Repository]

CI[GitHub Actions]

Registry[ACR / ECR]

GitOps[GitOps Repository]

ArgoCD[Argo CD]

Cluster[AKS / EKS]

Dev --> CodeRepo

CodeRepo --> CI

CI --> Registry

CI --> GitOps

GitOps --> ArgoCD

ArgoCD --> Cluster
```

## Description

Container images are built in the application repository.

Deployment manifests are updated in the GitOps repository.

Argo CD continuously reconciles the cluster with Git.

```
```
