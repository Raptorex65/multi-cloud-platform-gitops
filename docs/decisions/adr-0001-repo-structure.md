# ADR-0001: Two-repository project structure

## Status
Accepted

## Context
The project needs to separate application build concerns from infrastructure and deployment control concerns, while keeping repository sprawl low enough for a portfolio project.

## Decision
Use two repositories:

1. multi-cloud-microservices-app
   - application source code
   - Dockerfiles
   - CI build logic
   - image publishing

2. multi-cloud-platform-gitops
   - AWS and Azure infrastructure layout
   - GitOps configuration
   - Argo CD definitions
   - deployment environments
   - platform services such as Vault and observability

## Consequences
- cleaner separation of CI and CD responsibilities
- easier interview explanation
- lower complexity than a three-repository design
- better maintainability than a single monorepo for this specific project scope