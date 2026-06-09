# Repository Relationship

```mermaid
flowchart LR

AppRepo[multi-cloud-microservices-app]

PlatformRepo[multi-cloud-platform-gitops]

Actions[GitHub Actions]

Registry[ACR / ECR]

ArgoCD[Argo CD]

AppRepo --> Actions

Actions --> Registry

Actions --> PlatformRepo

PlatformRepo --> ArgoCD
```

## Description

The project follows a two-repository model.

Application concerns:

* source code
* Dockerfiles
* CI pipelines

Platform concerns:

* Terraform
* Helm charts
* Argo CD
* GitOps manifests

```
```
