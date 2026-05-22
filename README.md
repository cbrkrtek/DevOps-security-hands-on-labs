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

### 📊 Lab 03: Infrastructure Observability — Hybrid & Automated Monitoring
**Focus:** Infrastructure Visibility, Telemetry, and Infrastructure as Code (IaC).

* **Ansible Automation (Target Prep):**
    * Developed an automated, idempotent Ansible playbook (`monitoring.yml`) to provision the target environment. It configures prerequisites, installs `prometheus-node-exporter`, and ensures the telemetry service is securely enabled and running under systemd.
* **Hybrid Core Architecture:**
    * Implemented a multi-host monitoring pipeline. While the target Linux server is managed and prepared via Ansible inside VirtualBox, the aggregation (Prometheus) and visualization (Grafana) layers run in isolated Docker containers on the host machine to overcome nested network blocks.
* **Grafana Dashboard-as-Code:**
    * Designed a comprehensive local security dashboard to track CPU, Memory, and Network traffic in real-time. Created a static `dashboard.json` blueprint following GitOps principles for instant, reproducible visualization.
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

* 📅 [June] Infrastructure as Code (IaC) & AWS Cloud Hardening:
    * Automated Provisioning: Deploying hardened Amazon Linux 2023 instances via Terraform & Ansible.
    * Cloud Architecture: Designing secure AWS VPCs with private subnets, NAT Gateways, and strict Security Groups.
    * Identity & Access: Implementing the Principle of Least Privilege using AWS IAM Roles and Policies.
    * Secret Management: Transitioning from local .env files to AWS Secrets Manager.

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
