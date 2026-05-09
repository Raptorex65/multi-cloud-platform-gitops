
## Argo CD Configuration
This folder defines how applications are deployed using Argo CD.

## 🧠 Core Concept
Argo CD is a **GitOps controller**:

```text
Git → desired state
Argo CD → enforces state
Kubernetes → runtime
```

## 📦 Applications
Each file represents one deployable unit:

  - api-dev.yaml
  - frontend-dev.yaml
  - worker-dev.yaml
  - shared-ingress-dev.yaml

## Sync Policy
All apps use:
```text
syncPolicy:
  automated:
    prune: true
    selfHeal: true
```
Meaning:
  - auto deploy changes
  - remove unused resources
  - fix drift automatically

## App of Apps Pattern
We use a root application:

root-app.yaml
  ↓
deploys all child applications

This allows:

  - full platform bootstrap
  - centralized control
  - scalable architecture

# Deployment
kubectl apply -f root-app.yaml


# Shared Ingress

This defines how external traffic enters the platform.
We use **ONE shared ingress** instead of per-service ingress.
Ingress → AWS Load Balancer Controller → ALB

## 🔀 Routing

```text
/       → frontend
/api    → api
/health → api
```