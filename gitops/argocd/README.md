# Repository Structure

The GitOps repository is organized to separate infrastructure, deployment definitions, and environment-specific configurations.

```text
multi-cloud-platform-gitops
│
├── docs/
│
├── gitops/
│   ├── apps/
│   │   └── microservices-platform/
│   │       ├── aws/
│   │       └── azure/
│   │
│   ├── argocd/
│   │   └── applications/
│   │       ├── dev/
│   │       ├── stage/
│   │       └── prod/
│   │
│   └── README.md
│
├── helm/
│   ├── api/
│   ├── frontend/
│   └── worker/
│
└── infra/
    ├── aws/
    └── azure/
```

## Environment Layout

Argo CD is a **GitOps controller**. Each environment contains its own Argo CD application definitions.

```text
dev/
├── api-azure-dev.yaml
├── frontend-dev.yaml
├── worker-dev.yaml
└── shared-ingress-dev.yaml

stage/
├── api-azure-stage.yaml
├── frontend-azure-stage.yaml
├── worker-azure-stage.yaml
└── ingress-stage.yaml

prod/
├── api-azure-prod.yaml
├── frontend-prod.yaml
├── worker-azure-prod.yaml
└── ingress-prod.yaml
```

This structure enables independent deployment and promotion of workloads across Development, Stage, and Production environments.

---

# GitOps Architecture

The platform follows the GitOps model where Git acts as the single source of truth.

```text
Git Repository
      │
      ▼
   Argo CD
      │
      ▼
 Kubernetes
      │
      ▼
 Running Workloads
```

Any change committed to Git is automatically reconciled by Argo CD and applied to the Kubernetes cluster.

## Core Principles

* Git is the source of truth.
* Kubernetes manifests are never modified manually.
* Argo CD continuously reconciles desired and actual state.
* Configuration drift is automatically corrected.
* Environment promotion is performed through Git commits.

---

# App-of-Apps Pattern

The platform uses the Argo CD App-of-Apps pattern.

Instead of manually creating every application, a single root application deploys and manages all child applications.

```text
root-dev.yaml
        │
        ├── api-azure-dev
        ├── frontend-dev
        ├── worker-dev
        └── ingress-dev
```

```text
root-stage.yaml
        │
        ├── api-azure-stage
        ├── frontend-azure-stage
        ├── worker-azure-stage
        └── ingress-stage
```

```text
root-prod.yaml
        │
        ├── api-azure-prod
        ├── frontend-prod
        ├── worker-azure-prod
        └── ingress-prod
```

## Benefits

* Single command platform bootstrap
* Centralized deployment management
* Consistent environment structure
* Simplified onboarding
* Easier multi-environment scaling

---

# Shared Ingress Architecture

Each environment uses a shared ingress resource that routes traffic to platform services.

```text
Ingress
   │
   ├── /            → Frontend
   └── /api         → API
```

Examples:

```text
DEV
/dev/api  → API
/         → Frontend
```

```text
STAGE
/stage/api → API
/          → Frontend
```

```text
PROD
/prod/api → API
/         → Frontend
```

Using a shared ingress reduces complexity and provides a centralized entry point for all services within an environment.

---

# Helm-Based Application Packaging

Every application is packaged as an independent Helm chart.

```text
helm/
├── api/
├── frontend/
└── worker/
```

Each chart contains:

```text
Chart.yaml
values.yaml
templates/
```

Environment-specific settings are stored in dedicated values files.

```text
values-azure-dev.yaml
values-azure-stage.yaml
values-azure-prod.yaml
```

This approach enables the same chart to be promoted across environments while only changing configuration and image tags.

---

# Multi-Environment Deployment Strategy

The platform follows a promotion-based deployment model.

```text
DEV
 │
 ├── Validate
 │
 ▼
STAGE
 │
 ├── Validate
 │
 ▼
PROD
```

The same container image is promoted through environments after validation.

Example:

```text
Image Tag: ec81846

DEV    ✓ Tested
STAGE  ✓ Validated
PROD   ✓ Released
```

This ensures production deployments use previously validated artifacts and minimizes deployment risk.
