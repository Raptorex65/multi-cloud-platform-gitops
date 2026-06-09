# Argo Rollouts Canary Flow

```mermaid
flowchart TD

Deploy[New API Version]

Deploy --> Canary20

Canary20["20% Traffic"]

Canary20 --> Pause1

Pause1 --> Canary50

Canary50["50% Traffic"]

Canary50 --> Pause2

Pause2 --> Promote

Promote["100% Traffic"]

Promote --> Stable

Stable["New Stable Version"]
```

## Description

API deployments use Argo Rollouts.

Traffic is gradually shifted:

20% → 50% → 100%

The rollout is integrated with the NGINX Ingress Controller.

```
```
