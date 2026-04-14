## Project Structure

This platform is split into two repositories:

- multi-cloud-platform-app  
  → application services, Docker images, CI pipelines

- multi-cloud-platform-gitops  
  → infrastructure, Kubernetes manifests, GitOps, and environment management

---

# 15. Repo 2 README starter text

## `multi-cloud-platform-gitops/README.md`

```md
# Multi-Cloud Platform GitOps

This repository contains platform, infrastructure, and GitOps definitions for the multi-cloud microservices platform project.

## Scope

- AWS infrastructure definitions
- Azure infrastructure definitions
- GitOps application structure
- Argo CD bootstrap and applications
- environment overlays for dev, stage, and prod
- Vault, observability, ingress, certs, and rollout platform definitions

## Cloud Model

- AWS = primary production path
- Azure = equivalent secondary implementation

## Current Sprint

Sprint 0:
- repository bootstrap
- folder structure for AWS, Azure, and GitOps layout
- architecture and documentation placeholders