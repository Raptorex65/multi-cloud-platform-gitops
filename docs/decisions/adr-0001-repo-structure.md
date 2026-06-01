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

# ADR-0002: GitOps deployment model

## Status

Accepted

## Context

The project requires a deployment mechanism capable of:

* maintaining environment consistency
* tracking deployment history
* supporting multiple environments
* reducing manual cluster operations

Traditional push-based deployment approaches require CI systems to have direct access to Kubernetes clusters.

## Decision

Use GitOps as the deployment model.

Argo CD continuously monitors the Git repository and reconciles desired state against the running cluster state.

Application deployments are performed by updating manifests in Git rather than directly interacting with the cluster.

## Consequences

Benefits:

* declarative deployments
* full audit trail through Git history
* simplified rollback
* environment consistency
* reduced operational complexity

Trade-offs:

* additional Git repository management
* Argo CD operational overhead
* longer learning curve compared to imperative deployments

# ADR-0003: Progressive delivery using Argo Rollouts

## Status

Accepted

## Context

Production deployments should minimize deployment risk.

Standard Kubernetes Deployments provide rolling updates but do not offer advanced progressive delivery capabilities.

The project requires:

* canary deployments
* controlled traffic shifting
* automated rollback capability
* production-like deployment practices

## Decision

Use Argo Rollouts for API deployments.

Traffic management is integrated with the NGINX Ingress Controller.

Rollout strategy:

20% → 50% → 100%

Traffic is gradually shifted from the stable version to the canary version.

## Consequences

Benefits:

* safer deployments
* production-grade release process
* deployment visibility
* traffic-based rollout control

Trade-offs:

* additional controller in the cluster
* increased deployment complexity
* ingress integration requirements

# ADR-0004: Namespace-based environment isolation

## Status

Accepted

## Context

The platform contains multiple deployment environments:

* dev
* stage
* prod

Each environment requires separation while sharing the same Kubernetes cluster.

Creating dedicated clusters for each environment would increase operational cost and management overhead.

## Decision

Use namespace-based isolation.

Namespaces:

* microservices-dev
* microservices-stage
* microservices-prod

Applications are deployed independently into their corresponding namespaces.

## Consequences

Benefits:

* reduced cloud cost
* simplified management
* environment separation
* easier promotion workflows

Trade-offs:

* shared cluster resources
* scheduling contention under limited node capacity
* additional namespace management

# ADR-0005: Modular Terraform architecture

## Status

Accepted

## Context

The project provisions infrastructure across AWS and Azure.

A monolithic Terraform configuration would become difficult to maintain as the platform grows.

The project requires:

* reusable infrastructure components
* consistent patterns
* environment independence
* maintainability

## Decision

Use reusable Terraform modules.

AWS modules:

* aws-network
* aws-ecr
* aws-eks
* aws-eks-addons

Azure modules:

* azure-network
* azure-acr
* azure-aks

Environment folders consume modules and provide environment-specific configuration.

## Consequences

Benefits:

* code reuse
* reduced duplication
* easier maintenance
* cleaner architecture

Trade-offs:

* additional module abstraction
* more variables and outputs to manage
* increased initial design effort

# ADR-0006: Single AKS cluster with namespace-based environment separation

## Status

Accepted

## Context

The platform requires three environments:

* dev
* stage
* prod

Several deployment models were considered:

### Option 1

Dedicated AKS cluster per environment.

```text
AKS-DEV
AKS-STAGE
AKS-PROD
```

### Option 2

Single AKS cluster with namespace separation.

```text
AKS

├── microservices-dev
├── microservices-stage
└── microservices-prod
```

The project is intended as a portfolio and learning platform while still following realistic platform engineering practices.

Operating multiple AKS clusters would significantly increase:

* cloud cost
* Terraform complexity
* operational overhead
* cluster maintenance effort

## Decision

Use a single AKS cluster.

Environment isolation is achieved through namespaces:

```text
microservices-dev
microservices-stage
microservices-prod
```

Argo CD manages applications independently for each environment.

Ingress definitions, Helm values, and application manifests remain environment specific.

## Implementation Experience

During testing, the initial AKS deployment used a single node.

When dev and stage workloads were deployed simultaneously, several pods entered a Pending state because insufficient cluster resources were available.

Examples included:

* API Rollout pods
* Frontend pods
* Worker pods

The cluster was scaled from:

```text
1 node
```

to

```text
2 nodes
```

which resolved scheduling constraints.

This demonstrated that namespace isolation does not eliminate resource competition inside a shared cluster.

## Consequences

Benefits:

* lower cloud cost
* simpler infrastructure
* easier management
* reduced Terraform footprint
* easier GitOps management

Trade-offs:

* environments share cluster resources
* noisy-neighbor effects are possible
* capacity planning becomes important
* additional node scaling may be required as environments grow

## Future Considerations

For larger workloads or production-scale deployments, the architecture could evolve toward:

```text
AKS-DEV
AKS-STAGE
AKS-PROD
```

or

```text
Shared Non-Production Cluster
    ├── dev
    └── stage

Dedicated Production Cluster
    └── prod
```

The current architecture is considered the best balance between cost, simplicity, and operational experience for this project.
