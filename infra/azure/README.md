# Azure Infrastructure

## Overview

This directory contains Azure deployments used for the AKS GitOps platform.

The Azure implementation became the primary Kubernetes platform for the GitOps phase of the project.

---

## Components

### Networking

Provided by:

modules/azure-network

Creates:

* Resource Group
* Virtual Network
* AKS Subnet

---

## Container Registry

Provided by:

modules/azure-acr

Stores:

* API images
* Frontend images
* Worker images

AKS is granted pull permissions using role assignments.

---

## Kubernetes Platform

Provided by:

modules/azure-aks

Features:

* Managed Kubernetes
* System node pools
* Managed Identity integration

---

## GitOps Platform

Installed on AKS:

* Argo CD
* Argo Rollouts
* NGINX Ingress Controller

---

## Multi-Environment Deployment

Namespaces:

* microservices-dev
* microservices-stage
* microservices-prod

Applications:

* API
* Frontend
* Worker

---

## Progressive Delivery

API deployments use:

Argo Rollouts Canary Strategy

Traffic routing:

NGINX Ingress Controller

Deployment flow:

dev
↓
stage
↓
prod

Container image promotion occurs by updating image tags in GitOps repositories.

---

## Lessons Learned

Key findings:

* Single-node AKS clusters are insufficient for multiple environments
* Stage and production namespaces require additional node capacity
* Ingress host conflicts must be considered when sharing ingress controllers
* GitOps provides excellent visibility into deployment state
* Argo Rollouts integrates cleanly with NGINX traffic routing
