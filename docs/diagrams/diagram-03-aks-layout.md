# AKS Namespace Layout

```mermaid
flowchart TD

AKS[AKS Cluster]

AKS --> ArgoCD
AKS --> NGINX
AKS --> Rollouts

AKS --> DEV
AKS --> STAGE
AKS --> PROD

DEV --> API_DEV
DEV --> FRONTEND_DEV
DEV --> WORKER_DEV

STAGE --> API_STAGE
STAGE --> FRONTEND_STAGE
STAGE --> WORKER_STAGE

PROD --> API_PROD
PROD --> FRONTEND_PROD
PROD --> WORKER_PROD
```

## Description

A single AKS cluster hosts all environments.

Environment isolation is achieved through Kubernetes namespaces.

Additional node capacity was required when dev and stage workloads ran simultaneously.

```
```
