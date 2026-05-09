# Multi-Cloud Platform (GitOps)

This platform is split into two repositories:

- multi-cloud-platform-app  
  → application services, Docker images, CI pipelines

- multi-cloud-platform-gitops  
  → infrastructure, Kubernetes manifests, GitOps, and environment management

This repository contains the **infrastructure, platform, and GitOps definitions** for the multi-cloud microservices platform. We can define this repo as **platform layer** of a multi-cloud microservices system. It is responsible for:
- infrastructure provisioning (Terraform)
- Kubernetes deployment definitions (Helm)
- GitOps automation (Argo CD)
- environment management

This repo contains everything related to deployment and platform control:
```text
  •	Kubernetes manifests or Helm values 
  •	Argo CD applications 
  •	Argo Rollouts manifests 
  •	environment overlays 
  •	AWS and Azure deployment definitions 
  •	ingress config 
  •	HPA 
  •	requests/limits 
  •	Vault integration manifests 
  •	monitoring stack manifests 
  •	IaC for AWS and Azure 
  •	docs and architecture diagrams 
```
---
## ⚙️ Platform Stack

- AWS EKS (Kubernetes)
- Argo CD (GitOps controller)
- Helm (application packaging)
- AWS ALB Controller (Ingress)
- Amazon ECR (container registry)

---

## 🧠 Core Idea

This project follows a **GitOps architecture**:

```text
Git = source of truth
Argo CD = deployment engine
Kubernetes = runtime
```
No component deploys directly to the cluster except Argo CD.
This repo contains everything related to running the system, not building it.
```text
✔ infrastructure (AWS/Azure)
✔ Kubernetes manifests
✔ Helm charts
✔ Argo CD applications
✔ environment configuration
```

```md
## Deployment Flow

Developer pushes code
        ↓
GitHub Actions builds image
        ↓
Image pushed to ECR (tag = git SHA)
        ↓
CI updates GitOps repo (values.yaml)
        ↓
Argo CD detects change
        ↓
Cluster automatically updates

## Argo CD (App of Apps)
We use the App of Apps pattern:

root-app
  ↓
creates:
  api
  frontend
  worker
  ingress

Bootstrap:

kubectl apply -f gitops/argocd/root-app.yaml

## Full Platform Bootstrap

Environments
  - dev
  - stage
  - prod

Each environment defines:
  - values files
  - ingress routing
  - deployment configuration
  
terraform apply
aws eks update-kubeconfig ...

kubectl apply -f gitops/argocd/root-app.yaml

👉 This recreates the entire platform.