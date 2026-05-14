# 🛡️ DevOps & Security Hands-on Labs

![Build & Security Scan](https://github.com/cbrkrtek/DevOps-security-hands-on-labs/actions/workflows/docker-build.yml/badge.svg)
![Python Version](https://img.shields.io/badge/python-3.11-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## 📌 Project Overview
This repository is a dedicated laboratory for my transition into **DevSecOps Engineering**. It documents my practical journey from a **SOC Analyst** (completing Yandex Practicum in June 2026) to a Junior DevOps professional by September 2026. 

The core mission is to build security tools that aren't just functional, but **hardened**, **automated**, and **observable**.

## 🏗️ Lab Structure

### [Lab 01: Container Security & Microservices](./01-ssl-scanner-service)
**Goal:** Production-ready SSL/TLS Scanner with advanced container hardening.
* **Tech:** Python 3.11, Docker (Multi-stage), Redis, Trivy.
* **Key Achievement:** Implemented a **Shift-Left** security pipeline with automated CVE mitigation and non-root execution.

### [Lab 02: Linux Infrastructure Hardening](./02-infrastructure-hardening)
**Goal:** Automated security baseline for cloud/on-premise Linux instances.
* **Tech:** Bash, OpenSSH, UFW, Fail2Ban.
* **Key Achievement:** Created an idempotent script that enforces a "Default Deny" network posture and disables insecure authentication methods.

---
## 🛡️ Detailed Lab Logs

### 🐍 Lab 01: Container Security — Hardened Microservice Architecture
**Focus:** Supply Chain Security and Runtime Isolation.

* **Multi-Stage Build Strategy:** Leveraged a two-stage Dockerfile (`builder` vs `final`). This drastically reduces the attack surface by ensuring that build-time dependencies and compilers never reach production.
* **Principle of Least Privilege (PoLP):** Implemented a non-root execution model. The application runs under a dedicated `appuser` (UID 1000), mitigating "container escape" risks.
* **Software Composition Analysis (SCA):** Integrated **Trivy** into the CI/CD pipeline to enforce a **Zero-Vulnerability Policy**. The build fails automatically if any `HIGH` or `CRITICAL` CVEs are detected.
* **Microservices Orchestration:** Resilient environment using **Docker Compose** with integrated **Healthchecks** and private bridge networking for database isolation.


### 🐧 Lab 02: Infrastructure Hardening — Automated OS Security
**Focus:** Reducing the attack surface of a fresh Linux installation.

* **Automated Hardening:** Scripted configuration of `sshd_config` to eliminate brute-force vectors (custom port, disabling passwords).
* **Network Segregation:** Implementing **UFW** with a "Default Deny" policy, opening only essential ports (2222, 80, 443).
* **Active Defense:** Deployment of **Fail2Ban** to automatically jail IP addresses exhibiting malicious behavior.
* **Identity Management:** Automated creation of a dedicated `sudo` user with SSH-key-only access, following the **Principle of Least Privilege**.


---
## 🛠️ System Architecture & Security Controls

The project follows a **microservices pattern** orchestrated via Docker Compose.

| Layer | Component | Security Control |
| :--- | :--- | :--- |
| **Compute** | Python 3.11 Scanner | Runtime isolation, Non-root (UID 1000) |
| **Storage** | Redis (Stateful) | Isolated bridge network, No host port binding |
| **Pipeline** | GitHub Actions | Automated SAST/SCA via Trivy |
| **Network** | Docker Bridge | Strict service-to-service communication only |

## 🛡️ DevSecOps Pipeline (CI/CD)
The project utilizes **GitHub Actions** to implement a "Shift Left" security strategy. Every commit is subjected to an automated security audit before it can be considered production-ready.

### The Build Gate (`docker-build.yml`)
The pipeline implements a "Stop-the-World" policy:
1. **Static Analysis:** (Coming soon) Bandit for Python SAST.
2. **Container Scanning:** **Trivy** scans the image for OS and Library vulnerabilities.
3. **Severity Gate:** The build **fails automatically** if any `HIGH` or `CRITICAL` vulnerabilities are detected.

```yaml
- name: Run Trivy vulnerability scanner
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: 'ssl-scanner:multi'
    severity: 'CRITICAL,HIGH'
    exit-code: '1'
```

## 🚀 Quick Start

### 🧪 Lab 01: Deploying the SSL Scanner
To run the containerized scanner with Redis, you must create a folder, where you want to clone this repository. I created `test_folder` for easy understanding.
```bash
cd test_folder
git clone https://github.com/cbrkrtek/DevOps-security-hands-on-labs.git
cd .\DevOps-security-hands-on-labs\01-ssl-scanner-service\
docker-compose up --build -d
# Check progress
docker logs -f 01-ssl-scanner-service-app-scanner-1
```
### 🐧 Lab 02: Hardening a Linux Server
To secure a fresh Ubuntu/Debian instance, you must create a folder, where you want to clone this repository. I created `test_folder` for easy understanding. 
```bash
cd test_folder
git clone https://github.com/cbrkrtek/DevOps-security-hands-on-labs.git
cd .\DevOps-security-hands-on-labs\02-infrastructure-hardering\
chmod +x setup.sh
sudo ./setup.sh
```

## 🚀 2026 Roadmap (September Readiness)
As per my Technical Learning Plan:
* **[June] Infrastructure as Code & Cloud Hardening:**
	* Deploying hardened instances via Terraform & Ansible.
	* **Cloud IAM & VPC Design:** Implementing private networking and strict access policies.
	* **Secret Management:** Integration with Cloud Secret Manager or HashiCorp Vault.
* **[July] Kubernetes Hardening:** Implementing Network Policies and Admission Controllers (Kyverno/OPA).
	* Managed K8s (EKS/AKS/YC Managed Service) security settings.
	* Admission Controllers & Cloud Registry Scanning.
* **[August] Runtime Security:**
	* Falco for threat detection.
	* **Cloud SIEM Integration:** Collecting logs from infrastructure into a central dashboard.
## ⚖️ License
Licensed under the **MIT License.**
