# 🛡️ DevOps & Security Hands-on Labs

![Build & Security Scan](https://github.com/cbrkrtek/DevOps-security-hands-on-labs/actions/workflows/docker-build.yml/badge.svg)
![Python Version](https://img.shields.io/badge/python-3.11-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## 📌 Project Overview
This repository is a dedicated laboratory for my transition into **DevSecOps Engineering**. It documents my practical journey from a **SOC Analyst** (completing Yandex Practicum in June 2026) to a Junior DevOps professional by September 2026. 

The core mission is to build security tools that aren't just functional, but **hardened**, **automated**, and **observable**.

## 🛠️ Tech Stack
* **Language:** Python 3.11 (Socket, Logging)
* **Infrastructure:** Docker, Docker Compose (Multi-stage builds)
* **Database:** Redis (Alpine-based, Persistent Storage)
* **Security:** Trivy (Vulnerability Scanning), Bandit (SAST - Upcoming)
* **OS:** Linux (Hardened Slim images)
  
## 🏗️ System Architecture

The project follows a **microservices pattern** orchestrated via Docker Compose.

| Layer | Component | Security Control |
| :--- | :--- | :--- |
| **Compute** | Python 3.11 Scanner | Runtime isolation, Non-root (UID 1000) |
| **Storage** | Redis (Stateful) | Isolated bridge network, No host port binding |
| **Pipeline** | GitHub Actions | Automated SAST/SCA via Trivy |
| **Network** | Docker Bridge | Strict service-to-service communication only |

## 🛡️ Security Implementation & Compliance

This lab implements the following **DevSecOps** best practices:

* **Supply Chain Security:** Automated SCA (Software Composition Analysis) using **Trivy**. The CI/CD pipeline enforces a **Zero-Vulnerability Policy** for HIGH and CRITICAL risks.
* **Attack Surface Reduction:** * **Multi-Stage Builds:** Final production image contains zero build tools (compilers, pip cache).
    * **Distroless-like Hardening:** All unnecessary binaries (apt, package managers) are purged from the runtime layer.
* **Principle of Least Privilege (PoLP):** Container process is sandboxed under a dedicated `appuser`. No root privileges are granted to the application runtime.
* **Network Hardening:** Redis is strictly internal. Access is restricted to the scanner service within a private Docker subnet.

---

## 🛠️ Lab Log: Milestone 1 — Container Security (May)

### 🐍 SSL/TLS Scanner & Multi-Stage Build
**Goal:** Create a production-ready security tool and containerize it using industry-standard hardening techniques.

**Key Engineering Decisions:**
* **Multi-Stage Build:** Leveraged a two-stage Dockerfile (`builder` vs `final`). This reduced the attack surface by excluding build tools and cache from the production image.
* **Non-Root Execution:** Implemented the **Principle of Least Privilege** by creating and using `appuser`. This mitigates "container escape" risks by ensuring the process doesn't run with UID 0.
* **Kernel Isolation:** Ensured proper process isolation via Linux Namespaces, resulting in the application running as PID 1 within its own namespace.
* **Base Image Hardening:** Switched to `python:3.11-slim` and forced package upgrades to minimize CVE exposure.
* **Image Optimization:** Using python:3.11-slim in combination with Multi-stage build allowed us to reduce the image size and remove unnecessary attack vectors (build utilities are not included in production).
* **Docker Compose Orchestration:** The entire lab is deployed with a single `docker-compose up --build -d` command, demonstrating infrastructure automation skills.
* **Active CVE Mitigation:** Implemented automated patching within the Dockerfile to resolve **HIGH** severity vulnerabilities (e.g., CVE-2026-24049) identified by Trivy.
---

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
## 📊 Artifact Audit Report

**Date:** May 7, 2026  
**Status:** **PASSED** 
| Tool | Target | Result |
| :--- | :--- | :--- |
| **Trivy** | `ssl-scanner:latest` | 0 HIGH / 0 CRITICAL |
| **Docker-slim**| Image Footprint | ~190MB (Optimized) |

> **Audit Note:** Vulnerabilities CVE-2026-24049 and CVE-2026-23949 were successfully mitigated by forcing library upgrades in the Docker build layer.

## 🚀 Quick Start
1. Clone the repo.
2. Run `docker-compose up --build -d`.
3. Check the logs: `docker logs app-scanner-1`.

## 🚀 2026 Roadmap (September Readiness)
As per my Technical Learning Plan:
* **[June] Infrastructure as Code:** Deploying hardened Linux servers in Yandex Cloud or Azure using Terraform & Ansible.
* **[July] Kubernetes Hardening:** Implementing Network Policies and Admission Controllers (Kyverno/OPA).
* **[August] Runtime Security:** Real-time threat detection using Falco and SIEM integration.
## ⚖️ License
Licensed under the **MIT License.**
