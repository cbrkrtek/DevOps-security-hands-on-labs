# 🛡️ DevOps & Security Hands-on Labs

[![DevSecOps Full Pipeline](https://github.com/cbrkrtek/DevOps-security-hands-on-labs/actions/workflows/devsecops-pipeline.yml/badge.svg)](https://github.com/cbrkrtek/DevOps-security-hands-on-labs/actions/workflows/devsecops-pipeline.yml)
![Python Version](https://img.shields.io/badge/python-3.11-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Docker](https://img.shields.io/badge/Docker-Enabled-blue?logo=docker)
![Security](https://img.shields.io/badge/Security-Hardened-orange?logo=guardant)
![Gitleaks](https://img.shields.io/badge/Secrets-Protected-green?logo=git)

## 📌 Project Overview
This repository is a dedicated laboratory for my transition into **DevSecOps Engineering**. It documents my practical journey from a **SOC Analyst** (completing Yandex Practicum in June 2026) to a Junior DevOps professional by September 2026. 

The core mission is to build security tools that aren't just functional, but **hardened**, **automated**, and **observable**.

## 🏗️ Lab Structure

### [Lab 01: Container Security & Microservices](./01-ssl-scanner-service)
**Goal:** Production-ready SSL/TLS Scanner with advanced container hardening.
* **Tech:** Python 3.11, Docker (Multi-stage), Redis, **Gitleaks**, **Bandit**, **Hadolint**, **Trivy**.
* **Key Achievement:** : Implemented a multi-layered security gate and network isolation for backend services.

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

#### 📦 Sub-lab 8: `08-terragrunt-architecture`
* **Goal:** Manage multi-environment (Dev/Stage/Prod) infrastructure layouts without duplicating Terraform code.
* **Tech:** Terragrunt, Remote State Inheritance, DRY Architectures.
* **Key Achievement:** Orchestrated a multi-tier environment deployment using Terragrunt to keep root modules completely clean and isolate configuration parameters.

#### 📦 Sub-lab 9: `09-gitops-pipeline`
* **Goal:** Fully automate infrastructure validation and execution through a secure CI/CD system.
* **Tech:** GitHub Actions, Yandex IAM OIDC, Automation Workflows.
* **Key Achievement:** Built a "Plan-on-PR" GitOps workflow that reviews dry-runs via automated PR commentary and applies state changes on code merge.

#### 📦 Sub-lab 10: `10-iac-security-gates`
* **Goal:** Implement Shift-Left security controls to capture IaC misconfigurations before deployment.
* **Tech:** `tflint`, **Trivy IaC Scanner**, `tfsec`, Code Quality Gates.
* **Key Achievement:** Enforced automated pipeline security blocks that reject changes containing open administration ports or broad privilege grants.

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

---
## 🛡️ DevSecOps Pipeline (CI/CD)
The project utilizes GitHub Actions to implement a "Stop-the-World" policy. A build only succeeds if it passes all 4 security gates:
1. **Linting** (Hadolint)
2. **SAST** (Bandit)
3. **Secrets** (Gitleaks)
4. **SCA** (Trivy)

### Pipeline Security Gate Example (YAML):
```
- name: Run Gitleaks
  uses: gitleaks/gitleaks-action@v2
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

- name: Security Scan (Bandit)
  run: bandit -r ./app -f txt
```

## 🛠️ System Architecture & Security Controls
| Layer    | Component           | Security Control                                      |
|----------|---------------------|-------------------------------------------------------|
| Compute  | Python 3.11 Scanner | Runtime isolation, Non-root (UID 1000), Resource Limits|
| Storage  | Redis (Stateful)    | Internal Bridge Network, Auth (Password), No public ports|
| Data     | domains.txt         | Configuration Decoupling, Read-Only Volume             |
| Pipeline | GitHub Actions      | Automated SAST/SCA/Secret Detection                   |

## 🚀 Quick Start

### 🧪 Lab 01: Deploying the SSL Scanner
To run the containerized scanner with Redis, follow these steps:

1. **Prepare Environment:**
Create a local folder for the project and navigate into it.
```
mkdir test_folder && cd test_folder
```
Then clone the repository and move to the service directory.
```
git clone [https://github.com/cbrkrtek/DevOps-security-hands-on-labs.git]
cd DevOps-security-hands-on-labs/01-ssl-scanner-service/
```
**Configure secrets:** create a `.env` file to store your database password (this file is ignored by Git for security).
```bash
echo "REDIS_PASSWORD=YOUR_PASSWORD" > .env
```
**Launch:**
Start the hardened infrastructure in detached mode.
```
docker-compose up --build -d
```
**Monitor:**
Verify the scanner is working and communicating with the isolated Redis.
```
docker-compose logs -f app-scanner
```

### 🐧 Lab 02: Hardening a Linux Server
To secure a fresh Ubuntu/Debian instance using the automated security baseline:
**Clone the Tools:**
```
git clone [https://github.com/cbrkrtek/DevOps-security-hands-on-labs.git]
cd DevOps-security-hands-on-labs/02-infrastructure-hardening/
```
**Execute Hardering:**
Make the script executable and run it with sudo privileges.

```
chmod +x setup.sh
sudo ./setup.sh
```

### 📊 Lab 03: Deploying Local Observability Stack
This lab contains a dual-layer setup: an **Ansible Playbook** for target configuration and a **Docker Compose Stack** for local visualization.
1. **Move to the project folder:**
   ```bash
   cd DevOps-security-hands-on-labs/03-observability-management/
   ```
2. **The Ansible Playbook Layer:**
   The `monitoring.yml` playbook is stored in the repository to automate Node Exporter provisioning on the managed webservers group.

3. **Launch the Docker Containers:**
   Start the pre-configured Prometheus and Grafana stack on your host machine:
   ```bash
   docker compose up -d
   ```
4. **Access UI & Import Dashboard:**
* **Prometheus:** `http://localhost:9090` (Verify target `192.168.0.112:9100` is UP)
* **Grafana:** `http://localhost:3000` (Credentials: `admin` / `admin`)
* Import `dashboard.json` via Grafana UI to view live charts.
## 🚀 2026 Roadmap (September Readiness)

As per my Technical Learning Plan, the journey continues toward full-stack DevSecOps proficiency:

* 📅 [June] Advanced Infrastructure as Code & Cloud Hardening (Yandex Cloud):
    * **State & Code Architecture:** Transitioning from local state files to an enterprise-grade cloud architecture using secure **S3 Remote Backend** with active **State Locking** via YDB.
    * **Advanced HCL & Terragrunt:** Mastering dry, dynamic configurations using HCL expressions (`for_each`, `dynamic blocks`), built-in functions, and orchestrating multi-environment setups (Dev/Stage/Prod) using **Terragrunt**.
    * **Zero Trust Cloud Networking:** Designing isolated VPC architectures with private subnets, explicit egress routing via **Yandex VPC Gateways (NAT)**, and strict L3/L4 traffic filtering.
    * **GitOps & IaC Security Gates:** Automating infrastructure changes through a secure GitHub Actions pipeline using **Plan-on-PR workflows** and enforcing pre-flight security scans via **Trivy IaC** and **TFLint**.

* 📅 [July] Container Orchestration & Kubernetes Security (EKS):
    * Managed K8s: Deploying and hardening Amazon EKS clusters.
    * Network Policies: Implementing pod-to-pod isolation and EKS security best practices.
    * Policy as Code: Enforcing security standards with Kyverno or OPA/Gatekeeper.

* 📅 [August] Runtime Security & Observability:
    * Threat Detection: Monitoring system calls and anomalous behavior with Falco.
    * Cloud SIEM: Centralizing logs and security events using AWS CloudWatch and OpenSearch/Grafana.

---

## ⚖️ License
Licensed under the MIT License.
