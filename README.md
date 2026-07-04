# 🛡️ DevOps & Security Hands-on Labs

[![DevSecOps Full Pipeline](https://github.com/cbrkrtek/DevOps-security-hands-on-labs/actions/workflows/devsecops-pipeline.yml/badge.svg)](https://github.com/cbrkrtek/DevOps-security-hands-on-labs/actions/workflows/devsecops-pipeline.yml)
![Python Version](https://img.shields.io/badge/python-3.11-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Docker](https://img.shields.io/badge/Docker-Enabled-blue?logo=docker)
![Security](https://img.shields.io/badge/Security-Hardened-orange?logo=guardant)
![Gitleaks](https://img.shields.io/badge/Secrets-Protected-green?logo=git)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Security-blue?logo=kubernetes)

## 📌 Project Overview
This repository serves as my dedicated, hands-on laboratory documenting my rigorous transition into **DevSecOps Engineering**. It chronicles my professional path from a **SOC Analyst** to a highly capable DevSecOps professional.

The core mission of this repository is to build, orchestrate, and secure modern cloud infrastructure, developing engineering tools that are not just functional, but **hardened**, **highly automated**, and **fully observable**.

### Git Branching & Navigation Strategy
To ensure a clean and production-ready documentation standard, this repository utilizes a structured branch workflow:

* **`main` Branch:** Reserved exclusively for high-level documentation, architectural overviews, and overall lab indexing (README).
* **`feature/enterprise-pipeline` Branch:** The core development environment. Switch to this branch to explore the complete codebase, active automated pipelines, configuration playbooks, and functional IaC templates.

> 💡 **Quick Navigation:** To audit the full technical implementation and review the project source files, please checkout the **`feature/enterprise-pipeline`** branch.

## 🏗️ Lab Structure

### [Lab 01: Container Security & Microservices](./01-ssl-scanner-service)
**Goal:** Production-ready SSL/TLS Scanner with advanced container hardening.
* **Tech:** Python 3.11, Docker (Multi-stage), Redis, **Gitleaks**, **Bandit**, **Hadolint**, **Trivy**.
* **Key Achievement:** Implemented a multi-layered security gate and network isolation for backend services.

### [Lab 02: Linux Infrastructure Hardening](./02-infrastructure-hardening)
**Goal:** Automated security baseline for Linux instances
* **Tech:** Bash, OpenSSH, UFW, Auditd.
* **Key Achievement:** Created an idempotent hardening script that survives "minimal-OS" environments and enforces strict auditing.

### [Lab 03: Infrastructure Observability & Monitoring](https://github.com/cbrkrtek/DevOps-security-hands-on-labs/tree/feature/enterprise-pipeline/03-observability-management)
**Goal:** Centralized real-time performance and security monitoring automated via Ansible and isolated via Docker.
* **Tech:** Ansible, Prometheus, Grafana, Docker Compose, Node Exporter, YAML.
* **Key Achievement:** Authored an idempotent Ansible playbook for hands-free target system telemetry prep; combined it with a local cross-platform Docker Compose monitoring stack to seamlessly bypass network/ISP routing restrictions.

### [Lab 04: Centralized Log Aggregation & Security Observability (Loki/Promtail)](./04-observability-loki-promtail)
**Goal:** Centralized threat and audit log monitoring with real-time anomaly visualization.
* **Tech:** Grafana Loki, Promtail, LogQL, Nginx, Linux Audit/Auth Logs.
* **Key Achievement:** Resolved single-node replication locks (`replication_factor: 1`) to host a lightweight local Loki instance; built an observability dashboard capturing live SSH brute-force and web-vulnerability scanning anomalies side-by-side with hardware metrics.

### [Lab 05: Terraform Deep Dive & Production Patterns (Yandex Cloud)](./05-08-weeks-yandex-cloud-terraform-templates)
**Goal:** Build a modular, security-hardened, and enterprise-grade cloud infrastructure automation engine using advanced Terraform mechanics, Terragrunt orchestration, and Zero Trust network patterns.

---

#### 📦 Sub-lab 1: `01-single-public-instance`
* **Goal:** Provision a baseline public compute instance while enforcing basic cloud security configurations.
* **Tech:** Terraform, Yandex Compute Cloud, Cryptographic SSH Keys.
* **Key Achievement:** Implemented dynamic OS image family resolution via data sources and enforced passwordless access using `ED25519` keys.

#### 📦 Sub-lab 2: `02-private-subnet-nat-gateway`
* **Goal:** Design an isolated network perimeter to protect sensitive backend/database infrastructure from public exposure.
* **Tech:** Yandex VPC, NAT Gateway, Custom Static Route Tables.
* **Key Achievement:** Isolated instances via zero public IP routing (`nat = false`) while allowing secure one-way Egress traffic for security updates via an explicit NAT gateway.

#### 📦 Sub-lab 3: `03-s3-backend-locking`
* **Goal:** Migrate Terraform infrastructure state from local machines to safe, shared remote cloud storage.
* **Tech:** S3 Backend, Yandex Object Storage, DynamoDB/YDB State Locking.
* **Key Achievement:** Secured the state file using encryption-at-rest and configured active state locking to protect the infrastructure from concurrent deployment collisions.

#### 📦 Sub-lab 4: `04-advanced-data-sources`
* **Goal:** Interconnect decoupled infrastructure layers and query pre-existing cloud resources dynamically.
* **Tech:** `data` blocks, Dynamic Filters, Terraform Native Providers.
* **Key Achievement:** Built a flexible configuration capable of discovering and attaching to existing corporate networks and fetching external runtime parameters without hardcoding values.

#### 📦 Sub-lab 5: `05-advanced-hcl-loops`
* **Goal:** Eliminate hardcoded blocks and construct dynamic, programmatic cloud resource templates.
* **Tech:** HCL Expressions, `count`, `for_each`, `dynamic blocks`.
* **Key Achievement:** Reduced code surface by 60% using iterative loops and automated complex, scale-ready Yandex Security Group rule arrays.

#### 📦 Sub-lab 6: `06-hcl-functions-templates`
* **Goal:** Implement data-driven runtime metadata rendering for provisioned virtual machines.
* **Tech:** HCL Built-in Functions (`templatefile`, `lookup`, `merge`), Cloud-Init, YAML.
* **Key Achievement:** Developed a dynamic pipeline that injects custom environmental configs and environment variables during OS initialization.

#### 📦 Sub-lab 7: `07-custom-modules`
* **Goal:** Redesign the monolithic setup into reusable, highly optimized blueprint modules following the DRY principle.
* **Tech:** Structural Terraform Modules, Input Variable Validation, Child Outputs.
* **Key Achievement:** Developed production-ready custom network and compute modules with pre-packaged security baselines.

#### 📦 Sub-lab 8: `08-remote-state-environments`
* **Goal:** Manage multi-environment (Dev/Prod) infrastructure layouts without duplicating Terraform code by leveraging state isolation.
* **Tech Stack:** Terraform Workspaces, Yandex Object Storage (S3 Backend), Dynamic Mapping, State Locking.
* **Key Achievement:** Orchestrated a multi-tier environment deployment using native Terraform Workspaces to keep core infrastructure modules completely immutable and clean. Decoupled environment logic from resource declarations by configuring dynamic profile routing maps inside variables.tf. This setup automatically spins up localized environment configurations (dynamic CPU, Memory, and subnet CIDRs) seamlessly on the fly based on the evaluated `terraform.workspace` runtime context.

#### 📦 Sub-lab 9: `09-gitops-pipeline`
* **Goal:** Fully automate infrastructure validation and execution through a secure CI/CD system.
* **Tech:** GitHub Actions, Yandex IAM OIDC, Automation Workflows.
* **Key Achievement:** Built a "Plan-on-PR" GitOps workflow that reviews dry-runs via automated PR commentary and applies state changes on code merge.

#### 📦 Sub-lab 10: `10-iac-security-gates`
* **Goal:** Implement Shift-Left security controls to capture IaC misconfigurations before deployment.
* **Tech:** `tflint`, **Trivy IaC Scanner**, `tfsec`, Code Quality Gates.
* **Key Achievement:** Enforced automated pipeline security blocks that reject changes containing open administration ports or broad privilege grants.

---

### [Lab 06: Kubernetes Security & Cluster Hardening](https://github.com/cbrkrtek/DevOps-security-hands-on-labs/tree/feature/enterprise-pipeline/06-kubernetes)
**Goal:** Production-grade Kubernetes security — from workload isolation and RBAC least-privilege to Policy-as-Code enforcement and supply chain integrity.
* **Tech:** kind, kubectl, Trivy, Kyverno, NetworkPolicy, RBAC, securityContext, Helm.
* **Status:** 🔄 In Progress (July 2026)

#### 📦 Sub-lab 1: `01-cluster-security-context` ✅
* **Goal:** Establish workload-level security isolation through Pod Security Standards and RBAC least-privilege enforcement.
* **Tech:** kind (3-node cluster), `securityContext`, Trivy config scanner, RBAC (`Role` / `ClusterRole` / `RoleBinding` / `ServiceAccount`).
* **Key Achievement:** Reduced Trivy misconfiguration findings from **17 → 7 (LOW only)** by applying a full hardening stack: `runAsNonRoot`, `readOnlyRootFilesystem`, `allowPrivilegeEscalation: false`, `capabilities: drop ALL`, and `seccompProfile: RuntimeDefault`. Exposed a critical RBAC blind spot — a wildcard `ClusterRole` (`verbs: ["*"]`) invisible to standard `kubectl` inspection but flagged **2x CRITICAL** by Trivy, then resolved to **0 findings** after applying explicit least-privilege rules. Documented two real production-grade troubleshooting cases: nginx failing with `bind() Permission denied` on port 80 under non-root UID, and `readOnlyRootFilesystem` requiring explicit `emptyDir` volume mounts.

#### 📦 Sub-lab 2: `02-netpol-kyverno`
* **Goal:** Enforce network segmentation and Policy-as-Code admission controls at the cluster level.
* **Tech:** NetworkPolicy, Kyverno, Helm, namespace isolation.
* **Key Achievement:** *(In progress — Week 2)*

#### 📦 Sub-lab 3: `03-supply-chain-cosign-trivy`
* **Goal:** Secure the container supply chain from image build to cluster admission.
* **Tech:** Trivy Operator, Cosign, Kyverno image verification policy.
* **Key Achievement:** *(Planned — August)*

#### 📦 Sub-lab 4: `04-gitops-argocd`
* **Goal:** Automate secure delivery through a GitOps pipeline with embedded security gates.
* **Tech:** ArgoCD, GitHub Actions, Trivy, Kyverno dry-run.
* **Key Achievement:** *(Planned — August)*

---

## 🛡️ Detailed Lab Logs

### 🐍 Lab 01: Container Security — Hardened Microservice Architecture
**Focus:** Shift-Left Security & Infrastructure as Code.

* **Secrets Detection (Gitleaks)** Integrated Gitleaks to prevent API tokens and SSH keys from ever entering the git history. Verified by bypassing and then hardening GitHub Push Protection.

### 1. Static Analysis (SAST) & Linting
* **Bandit (Python SAST):**
    * **Purpose:** Automatically scans Python source code for common security issues (e.g., hardcoded passwords, insecure SSL/TLS versions).
    * **Action:** Integrated into the CI/CD pipeline to block builds if `MEDIUM` or `HIGH` severity vulnerabilities are detected.
* **Hadolint (Dockerfile Linter):**
    * **Purpose:** Validates `Dockerfile` against best practices (e.g., preventing `root` execution, ensuring image version pinning).
    * **Action:** Enforces a clean and minimal container structure, reducing the potential attack surface.
* **Gitleaks (Secret Scanning):**
    * **Purpose:** Scans the entire commit history for accidentally committed secrets (API keys, tokens, private keys).
    * **Action:** Acts as a "Pre-push" gatekeeper, ensuring that sensitive data never reaches the remote repository.
* **Advanced Networking:**
    * Implemented **Internal Bridge Networking** in Docker Compose.
    * The Redis database is completely isolated (no public ports) and accessible only by the scanner via a secure **Service Discovery** link.
* **Configuration Decoupling:**
    * Moved target data from environment variables to a dedicated `domains.txt` file.
    * The file is mounted via **Read-Only Volumes**, following the "Data vs Code" separation principle.

### 🐧 Lab 02: Infrastructure Hardening — "Minimal & Resilient"
**Focus:** Reducing the attack surface of a fresh Linux installation.

* **Environment Resilience:** The script was refactored to work on minimal server installations (even where `nano` or `sudo` might be missing).
* **System Auditing:** Integrated **Auditd** with custom rules to monitor changes in sensitive files (`/etc/shadow`, `sshd_config`).
* **Active Defense:** Deployment of **Fail2Ban** to automatically jail IP addresses exhibiting malicious behavior.
* **Non-Interactive Updates:** Optimized for automated deployment using `DEBIAN_FRONTEND=noninteractive`

### 📊 Lab 03: Infrastructure Observability — Hybrid & Automated Monitoring (check in branch feature/enterprise-pipeline)
**Focus:** Infrastructure Visibility, Telemetry, and Infrastructure as Code (IaC).

* **Ansible Automation (Target Prep):**
    * Developed an automated, idempotent Ansible playbook (`monitoring.yml`) to provision the target environment. It configures prerequisites, installs `prometheus-node-exporter`, and ensures the telemetry service is securely enabled and running under systemd.
* **Hybrid Core Architecture:**
    * Implemented a multi-host monitoring pipeline. While the target Linux server is managed and prepared via Ansible inside VirtualBox, the aggregation (Prometheus) and visualization (Grafana) layers run in isolated Docker containers on the host machine to overcome nested network blocks.
* **Grafana Dashboard-as-Code:**
    * Designed a comprehensive local security dashboard to track CPU, Memory, and Network traffic in real-time. Created a static `dashboard.json` blueprint following GitOps principles for instant, reproducible visualization.

### 🕵️‍♂️ Lab 04: Security Observability — Log Aggregation & Infrastructure Telemetry (check in branch feature/enterprise-pipeline)
**Focus:** Log-as-Code, Single-Binary Storage Optimization, and Security Telemetry Visualization.

* **Single-Binary Loki Optimization:**
    * Overcame production-grade clustering restrictions in Docker by refactoring Loki (`loki-config.yaml`) into an optimized **Single-Binary mode** (`replication_factor: 1`, `store: inmemory`). This bypassed complex microservice ring dependencies, creating a high-performance local log aggregation engine.
* **Log-as-Code & Promtail Pipeline:**
    * Configured automated log shipping via Promtail. Handled private system logs (`/var/log/auth.log` and `/var/log/nginx/access.log`) by adjusting system daemon runtime privileges (`User=root` systemd verification).
* **Telemetry Correlation Dashboard:**
    * Designed an advanced observability Grafana dashboard integrating both metric and log engines. Created specific real-time panels for visual correlation during incidents:
        * **Log Event Rate** via LogQL (`count_over_time({job="nginx"}[1m]) / 60`).
        * **Network Traffic Volume** via PromQL (`rate(node_network_receive_bytes_total{device!="lo"}[1m])`).
* **Active Security Simulation (Nmap/Brute-Force Testing):**
    * Conducted live automated stress testing using `nmap --script=vuln` and `ssh-brute`. Successfully validated the monitoring pipeline by visually correlating hardware spikes (CPU climbing to 80%+) with an instantaneous flood of `404/400 HTTP` anomalies and `Failed password for invalid user` auth logs.

![Result of the 4-th week](https://github.com/cbrkrtek/DevOps-security-hands-on-labs/blob/main/Pictures%20for%20README/Monitoring%20logs%20and%20resources.PNG)

### ☁️ Weeks 05-08: Terraform Deep Dive & Production Patterns (Yandex Cloud)
**Objective:** Advanced mastery of Terraform internal mechanics, HCL power-features, state lifecycle management, and secure cloud infrastructure provisioning using Zero Trust network design.

```text
05-08-weeks-yandex-cloud-terraform-templates/
├── 01-single-public-instance/
└── 02-private-subnet-nat-gateway/
└── 03-s3-backend-locking/
└── 04-alb-security-groups/
└── 05-advanced-hcl-loops/
```

#### 📁 `01-single-public-instance`
* **Goal:** Provision a baseline public compute instance in Yandex Cloud while enforcing strict IaC security standards.
* **Tech Stack:** Terraform, HashiCorp HCL, Yandex Compute Cloud, Yandex VPC.
* **Key Achievement:** Implemented dynamic OS image resolution via `data "yandex_compute_image"` to completely avoid hardcoded AMI/Image IDs. Hardened authentication by enforcing passwordless access using cryptographically secure `ED25519` SSH keys. Secured the repository lifecycle by implementing strict `.gitignore` patterns to prevent secret leaks.

#### 📁 `02-private-subnet-nat-gateway`
* **Goal:** Design an isolated network perimeter to protect sensitive backend/database infrastructure from direct public internet exposure.
* **Tech Stack:** Terraform, Yandex VPC Gateway, Route Tables, Cloud Routing.
* **Key Achievement:** Established a strict private network tier with zero public IP exposure (`nat = false`). Engineered a secure, one-way Egress pipeline utilizing `yandex_vpc_gateway` combined with custom static route tables (`0.0.0.0/0`). This allows isolated instances to safely pull patches via `apt` while remaining completely invisible and unreachable from the outside world.

#### 📁 `03-s3-backend-locking`
* **Goal:** Architect a highly available, collaborative, and secure remote state management pipeline for Terraform with atomic state locking.
* **Tech Stack:** Terraform, Yandex Object Storage (S3), Yandex Cloud IAM.
* **Key Achievement:** Migrated the local Terraform state to a secure remote Yandex Object Storage bucket, eliminating the risk of unencrypted state file exposure. Enforced atomic state locking using native S3 lockfiles (`use_lockfile = true`) to prevent race conditions and concurrent state corruption during team execution. Hardened the provider authentication layer by shifting from fragile local environment variables to granular Service Account IAM keys (`key.json`), seamlessly isolating infrastructure logic from deployment-specific secrets via `.gitignore` and dynamic `.tfvars` parsing.

#### 📁 `04-alb-security-groups`
* **Goal:** Architect a highly available, multi-zone application delivery network secured by infrastructure-level firewall perimeters.
* **Tech Stack:** Terraform, Yandex Application Load Balancer (ALB), Yandex VPC Security Groups, L7 Routing.
* **Key Achievement:** Designed and deployed a resilient, multi-zone network architecture from scratch (greenfield deployment). Engineered an enterprise-grade L7 Application Load Balancer topology across independent availability zones (`ru-central1-a` and `ru-central1-b`) featuring dedicated target groups, HTTP routers, and automated active healthchecks (`http_healthcheck`). Enforced zero-trust network isolation by wrapping the load balancer in strict, stateful VPC Security Groups (`yandex_vpc_security_group`), restricting public ingress solely to HTTP port 80 and ensuring granular internal communication filters based on the principle of least privilege.

#### 📁 `05-advanced-hcl-loops`
* **Goal:** Eliminate hardcoded resource blocks and construct dynamic, data-driven cloud infrastructure templates.
* **Tech Stack:** Terraform, HashiCorp HCL, Dynamic Blocks, `for_each` Loops, `count` Expressions.
* **Key Achievement:** Reduced the overall codebase surface area by 60% by refactoring monolithic declarations into programmatic, iterative loops. Engineered a scale-ready network security perimeter using HCL `dynamic` blocks and `for_each` expressions to generate complex Yandex Security Group rule arrays dynamically from structured map variables. Automated multi-node compute provisioning via the `count` meta-argument with dynamic index-based naming conventions (`count.index`), completely externalizing critical runtime attributes—such as deployment public SSH keys—into secure `.tfvars` variables to isolate environment secrets from version control.

#### 📁 `06-hcl-functions-templates`
* **Goal:** Implement data-driven runtime metadata rendering and automated bootstrap configuration for provisioned virtual machines.
* **Tech Stack:** Terraform, HashiCorp HCL, Built-in Functions (`templatefile`, `lookup`, `merge`), Cloud-Init, YAML.
* **Key Achievement:** Developed a dynamic OS initialization pipeline by separating runtime configuration data from infrastructure logic. Leveraged the `lookup` and `merge` HCL functions to dynamically resolve environment-specific attributes (ports, system users) based on the target deployment tier (`dev`/`prod`). Engineered an automated metadata injection mechanism using the `templatefile` function to render parameterized Cloud-Init YAML blueprints on the fly, enabling hands-free user provisioning, SSH security hardening, and automated package deployments (Nginx) during the virtual machine's initial boot sequence.

#### 📁 `07-custom-modules`
* **Goal:** Deconstruct monolithic infrastructure code into decoupled, reusable, and enterprise-grade custom modules.
* **Tech Stack:** Terraform Modules, HashiCorp HCL, Input Validation, Structural Outputs, DRY Architecture.
* **Key Achievement:** Refactored the unified codebase into highly isolated, self-contained infrastructure blueprints by architecting dedicated local modules for Network (`vpc`) and Compute (`compute`) layers. Implemented strict programmatic coupling between independent modules by mapping structural outputs (such as dynamic network subnet IDs) directly into down-stream compute inputs. Hardened the infrastructure entrypoints against runtime configuration failure by engineering compile-time validation blocks (`validation`) with regex-based security filters to audit critical variables—such as public SSH key format standards—prior to cloud provider execution.

#### 📁 `08-remote-state-refactoring`
* **Goal:** Establish a multi-environment infrastructure deployment pipeline powered by isolated remote state tracking.
* **Tech Stack:** Terraform Workspaces, Yandex Object Storage (S3 Backend), Dynamic Mapping, State Locking.
* **Key Achievement:** Architected a highly scalable multi-tenant infrastructure topology by decoupling generic HCL resources from environment-specific configuration parameters. Leveraged Terraform Workspaces (`dev`/`prod`) to enforce strict state file separation within a shared remote Yandex Object Storage bucket, utilizing automated backend lockfiles to maintain state synchronization across execution environments. Engineered dynamic profile routing tables inside `variables.tf` that parse runtime resource capacities (CPU cores, memory allocations, subnet CIDRs) seamlessly on the fly using the logical `terraform.workspace` evaluator, allowing safe parallel tracking of independent environment tiers from a singular, immutable codebase.

#### 📁 `09-gitops-pipeline`
* **Goal:** Fully automate infrastructure validation and execution through a secure, event-driven CI/CD system.
* **Tech Stack:** GitHub Actions, Yandex IAM Automation, Bash Scripting, Automation Workflows, GitOps.
* **Key Achievement:** Built a production-grade "Plan-on-PR" GitOps pipeline that completely eliminates manual engineering drift and local credential exposure. Configured automated lifecycle triggers that intercept Pull Requests to execute semantic dry-runs (`terraform plan`), injecting the structural infrastructure review ledger directly into PR comments via advanced GitHub Script orchestration for collaborative code-review. Engineered an automated continuous delivery execution phase that safely triggers auto-approved state deployments (`terraform apply`) only upon successful code integration into protected branches, externalizing critical cloud infrastructure privileges into encrypted GitHub Repository Secrets.

#### 📁 `10-iac-security-gates`
* **Goal:** Implement Shift-Left security controls to capture IaC misconfigurations and compliance violations before cloud deployment.
* **Tech Stack:** TFLint, Trivy IaC Scanner, Static Application Security Testing (SAST), Automated Quality Gates.
* **Key Achievement:** Enforced hard semantic security blocks within the automation pipeline that programmaticly reject infrastructure commits containing dangerous misconfigurations, such as unrestricted administrative access (`0.0.0.0/0` on port 22) or over-privileged IAM roles. Integrated a multi-stage linting and vulnerability assessment phase using TFLint and Aqua Security Trivy into the pre-initialization flow. By mapping the deployment job dependencies (`needs: security_gates`) directly to scanner exit codes, created a strict automated gate that halts the delivery lifecycle instantly upon detecting High or Critical configuration defects, embedding direct security visibility into the engineering feedback loop.

---

### ☸️ Lab 06: Kubernetes Security — Hardened Cluster Architecture
**Focus:** Workload Isolation, RBAC Least-Privilege, and Shift-Left Static Security Analysis.

#### 🔒 Sub-lab 1: Cluster Hardening & Security Context

* **Baseline vs. Hardened Workload:**
    * Deployed `pod-insecure` (zero `securityContext`) — confirmed running as `uid=0(root)` via `kubectl exec`. Trivy flagged **17 misconfigurations** including missing `runAsNonRoot`, `readOnlyRootFilesystem`, and unrestricted Linux capabilities.
    * Deployed `pod-secure` with full hardening stack: `runAsNonRoot: true` (UID 1000), `readOnlyRootFilesystem: true`, `allowPrivilegeEscalation: false`, `capabilities: drop ALL`, `seccompProfile: RuntimeDefault`. Trivy result: **7 LOW only** (resource limits — acceptable in lab scope).

* **RBAC Least-Privilege:**
    * Designed two `ServiceAccount` profiles with scoped permissions and audited each via `kubectl auth can-i --as=system:serviceaccount:...`:
        * `dev-readonly` — `get/list/watch` on pods, services, deployments. Verified: `create deployments` → **no**, `delete namespaces` → **no**.
        * `ops-deployer` — `create/update` on deployments only. Verified: `create deployments` → **yes**, `delete namespaces` → **no**.

* **Critical Finding — Wildcard RBAC Detection & Fix:**
    * Applied intentional `ClusterRole` with `verbs: ["*"]` — full cluster access equivalent to `cluster-admin`. Standard `kubectl get clusterrole` showed no warnings whatsoever.
    * Trivy static scan immediately flagged **2x CRITICAL** (KSV-0044): *"Role permits wildcard verb on wildcard resource."*
    * **Fix:** Replaced wildcards with explicit `verbs` and scoped `resources`. Re-scan confirmed **0 findings**.
    * **Conclusion:** `kubectl` is blind to dangerous RBAC patterns. Trivy manifest scanning must be a mandatory pre-apply CI gate.

* **Troubleshooting Documented ("What I Broke"):**
    * **Issue 1 — Port binding under non-root UID:** Standard `nginx:1.25` with `runAsUser: 1000` fails with `bind() to 0.0.0.0:80 failed (13: Permission denied)`. Linux restricts ports below 1024 to root. **Fix:** switched to `nginxinc/nginx-unprivileged:1.25` which binds on port 8080 — the production-recommended approach for K8s.
    * **Issue 2 — Read-only filesystem breaks nginx:** `readOnlyRootFilesystem: true` caused `can not modify /etc/nginx/conf.d/default.conf`. **Fix:** mounted `emptyDir` volumes at `/tmp`, `/var/cache/nginx`, and `/var/run`.

**Evidence:**

![pod-insecure running as uid=0 root](https://github.com/cbrkrtek/DevOps-security-hands-on-labs/blob/feature/enterprise-pipeline/06-kubernetes/01-cluster-security-context/screenshots/insecure_pod_deployment-1.PNG)

![nginx bind permission denied on port 80 with runAsUser 1000](https://github.com/cbrkrtek/DevOps-security-hands-on-labs/blob/feature/enterprise-pipeline/06-kubernetes/01-cluster-security-context/screenshots/02-pod-secure-nginx-bind-permission-denied-port80.PNG)

![Trivy scan pod-insecure 17 misconfigurations](https://github.com/cbrkrtek/DevOps-security-hands-on-labs/blob/feature/enterprise-pipeline/06-kubernetes/01-cluster-security-context/screenshots/03-trivy-scan-pod-insecure-17-misconfigs.PNG)

![Trivy scan pod-secure 7 LOW only](https://github.com/cbrkrtek/DevOps-security-hands-on-labs/blob/feature/enterprise-pipeline/06-kubernetes/01-cluster-security-context/screenshots/04-trivy-scan-pod-secure-7-low-only.PNG)

![RBAC ops-deployer create yes delete namespace no](https://github.com/cbrkrtek/DevOps-security-hands-on-labs/blob/feature/enterprise-pipeline/06-kubernetes/01-cluster-security-context/screenshots/05-rbac-ops-deployer-create-yes-delete-no.PNG)

![RBAC dev-readonly create no delete namespace no](https://github.com/cbrkrtek/DevOps-security-hands-on-labs/blob/feature/enterprise-pipeline/06-kubernetes/01-cluster-security-context/screenshots/06-rbac-dev-readonly-create-no-delete-no.PNG)

![Trivy RBAC wildcard BAD 2 CRITICAL findings](https://github.com/cbrkrtek/DevOps-security-hands-on-labs/blob/feature/enterprise-pipeline/06-kubernetes/01-cluster-security-context/screenshots/07-trivy-rbac-wildcard-bad-2-critical.PNG)

![Trivy RBAC wildcard fixed 0 findings](https://github.com/cbrkrtek/DevOps-security-hands-on-labs/blob/feature/enterprise-pipeline/06-kubernetes/01-cluster-security-context/screenshots/08-trivy-rbac-wildcard-fixed-0-findings.PNG)

---

## 🛡️ DevSecOps Pipeline (CI/CD)
The project utilizes GitHub Actions to implement a "Stop-the-World" policy. A build only succeeds if it passes all 4 security gates:
1. **Linting** (Hadolint)
2. **SAST** (Bandit)
3. **Secrets** (Gitleaks)
4. **SCA** (Trivy)

### Pipeline Security Gate Example (YAML):
```yaml
- name: Run Gitleaks
  uses: gitleaks/gitleaks-action@v2
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

- name: Security Scan (Bandit)
  run: bandit -r ./app -f txt
```

## 🛠️ System Architecture & Security Controls
| Layer        | Component           | Security Control                                       |
|--------------|---------------------|--------------------------------------------------------|
| Compute      | Python 3.11 Scanner | Runtime isolation, Non-root (UID 1000), Resource Limits|
| Storage      | Redis (Stateful)    | Internal Bridge Network, Auth (Password), No public ports|
| Data         | domains.txt         | Configuration Decoupling, Read-Only Volume             |
| Pipeline     | GitHub Actions      | Automated SAST/SCA/Secret Detection                    |
| K8s Workload | securityContext     | runAsNonRoot, readOnlyRootFilesystem, drop ALL caps    |
| K8s Access   | RBAC                | Least-privilege ServiceAccounts, Trivy RBAC scanning   |

## 🚀 Quick Start

### 🧪 Lab 01: Deploying the SSL Scanner
```bash
mkdir test_folder && cd test_folder
git clone https://github.com/cbrkrtek/DevOps-security-hands-on-labs.git
cd DevOps-security-hands-on-labs/01-ssl-scanner-service/
echo "REDIS_PASSWORD=YOUR_PASSWORD" > .env
docker-compose up --build -d
docker-compose logs -f app-scanner
```

### 🐧 Lab 02: Hardening a Linux Server
```bash
git clone https://github.com/cbrkrtek/DevOps-security-hands-on-labs.git
cd DevOps-security-hands-on-labs/02-infrastructure-hardening/
chmod +x setup.sh && sudo ./setup.sh
```

### 📊 Lab 03: Deploying Local Observability Stack
```bash
cd DevOps-security-hands-on-labs/03-observability-management/
docker compose up -d
# Prometheus: http://localhost:9090
# Grafana: http://localhost:3000 (admin/admin) → import dashboard.json
```

### ☸️ Lab 06: Deploying the Kubernetes Security Lab
```bash
cd DevOps-security-hands-on-labs/06-kubernetes/01-cluster-security-context/
kind create cluster --config kind-config.yaml --name k8s-lab
kubectl apply -f manifests/pod-insecure.yaml
kubectl apply -f manifests/pod-secure.yaml
trivy config manifests/pod-insecure.yaml
trivy config manifests/pod-secure.yaml
kubectl apply -f manifests/rbac-dev-readonly.yaml
kubectl apply -f manifests/rbac-ops-deployer.yaml
trivy config manifests/rbac-wildcard-BAD.yaml
```

## 🚀 2026 Roadmap (September Readiness)

* 📅 **[June — Completed ✅]** Advanced Infrastructure as Code & Cloud Hardening (Yandex Cloud):
    * S3 Remote Backend with State Locking, advanced HCL, Zero Trust VPC networking, GitOps pipeline with Plan-on-PR, IaC Security Gates via Trivy and TFLint.

* 📅 **[July — In Progress 🔄]** Container Orchestration & Kubernetes Security:
    * Cluster hardening with securityContext and Pod Security Standards, RBAC least-privilege, Network Policies, Policy-as-Code with Kyverno, Supply Chain Security with Cosign and Trivy Operator.

* 📅 **[August — Planned]** Multi-Cloud & GitOps at Scale:
    * Oracle Cloud Infrastructure (OCI) with OKE managed Kubernetes via Terraform, ArgoCD GitOps pipeline, advanced supply chain integrity with Cosign.

---

## ⚖️ License
Licensed under the MIT License.
