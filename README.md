# ETB101 Hybrid DevSecOps Platform

A hybrid cloud/edge DevSecOps platform reference implementation for **ETB101**, integrating AWS with an on‑prem/edge Kubernetes cluster and GitOps-based delivery.

---

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [How it works (high level)](#how-it-works-high-level)
- [Getting started](#getting-started)
- [CI/CD](#cicd)
- [DevSecOps controls](#devsecops-controls)
- [Observability](#observability)
- [Self-healing](#self-healing)
- [Troubleshooting ledger](#troubleshooting-ledger)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

This project aims to provide a consistent, secure, and repeatable way to:

- Provision infrastructure with Infrastructure as Code (IaC)
- Build/test/scan artifacts in CI
- Deploy to Kubernetes using GitOps
- Enforce security controls across code, supply chain, and runtime
- Operate with observability and operational guardrails

---

## Architecture

**Target hybrid model:**

- **Cloud (AWS):** VPC + EKS for cloud workloads, ECR for images
- **Edge/On‑prem:** Raspberry Pi Kubernetes cluster (k3s)
- **GitOps:** Argo CD reconciles desired state from Git

> Architecture is currently **WIP**. Recommended next step: add a diagram under `docs/architecture.png` and link it here.

---

## Tech Stack

- **AWS** (VPC, EKS, ECR)
- **Terraform**
- **Kubernetes** (k3s)
- **Argo CD** (GitOps)
- **GitHub Actions** (CI/CD)

---

## How it works (high level)

1. Developer opens a PR.
2. GitHub Actions runs quality + security checks.
3. On merge, CI builds artifacts/images and publishes them.
4. CD updates Kubernetes manifests/Helm values (or a GitOps repo path) and Argo CD applies changes.
5. Policies/scanners validate configuration and workloads.

---

## Getting started

### Clone

```bash
git clone https://github.com/zmanjith/ETB101-hybrid-devsecops-platform.git
cd ETB101-hybrid-devsecops-platform
```

### Prerequisites

- AWS account access (and permissions to create VPC/EKS/ECR as needed)
- A running k3s cluster (Raspberry Pi or other edge hardware)
- Terraform installed
- `kubectl` and optionally Helm installed
- Argo CD installed and reachable from your management network

> Add environment-specific setup notes under `docs/` as you implement components.

---

## CI/CD

Recommended pipelines (to be implemented/expanded):

- **PR checks**
  - lint + unit tests
  - SAST (e.g., CodeQL)
  - dependency scan/SBOM
  - IaC scan (Terraform/K8s manifests)
- **Main branch**
  - build + push container images
  - sign images (optional)
  - trigger GitOps deploy

---

## DevSecOps controls

Planned/typical controls for this platform:

- **SAST**: CodeQL or equivalent
- **Secrets scanning**: prevent committing credentials
- **Dependency scanning (SCA)**: identify vulnerable packages
- **IaC scanning**: Terraform + K8s policy checks
- **Container scanning**: scan images before deployment
- **Policy-as-code**: Gatekeeper/Kyverno to enforce cluster rules

---

## Observability

(To be implemented)

Suggested baseline:

- Metrics: Prometheus + Grafana
- Logs: Loki/ELK/OpenSearch
- Tracing: OpenTelemetry
- Alerting: Alertmanager integrated to email/Teams/Slack

---

## Self-healing

(To be implemented)

Examples of self-healing patterns:

- Kubernetes health probes + replica reconciliation
- Argo CD drift detection and auto-sync
- Pod disruption budgets + autoscaling

---

## Troubleshooting ledger

This section is intended to capture:

- common errors
- fixes/workarounds
- links to relevant issues and runbooks

Create runbooks under `docs/runbooks/` and link them here.

---

## Contributing

- Use feature branches
- Open a PR
- Ensure checks pass
- Request review

---

## License

Add a `LICENSE` file and update this section with the chosen license.
