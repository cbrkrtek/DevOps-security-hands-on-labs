# 🛡️ Linux Server Hardening & IaC Automation

![Bash](https://img.shields.io/badge/Language-Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Ubuntu](https://img.shields.io/badge/OS-Ubuntu%20%2F%20Debian-E9433F?style=for-the-badge&logo=ubuntu&logoColor=white)
![Security](https://img.shields.io/badge/Focus-DevSecOps-red?style=for-the-badge)

This repository contains a professional Bash script designed to automate the security hardening process for Debian/Ubuntu-based servers. It follows the **Infrastructure as Code (IaC)** principle to ensure consistent and reproducible security baselines.

## 🛡️ Hardening Features

- **System Provisioning:** Non-interactive package updates to minimize human error.
- **Identity & Access Management:** - Automated creation of a dedicated sudo-user.
    - Deployment of SSH Public Key authentication.
- **SSH Hardening (SSHD):**
    - Moves SSH service to a non-standard port (TCP 2222).
    - Disables `root` login to prevent administrative hijacking.
    - Disables password-based authentication (MFA-ready baseline).
- **Network Security:** - Configures **UFW** with a "Default Deny" policy.
    - Restricts incoming traffic to essential ports only.
- **Intrusion Detection:** Deploys **Fail2Ban** to automatically mitigate brute-force attempts.

## 🚀 Quick Start

### 1. Prerequisites
Ensure you have generated an SSH key pair on your local machine:
```bash
ssh-keygen -t ed25519 -C "admin@example.com"
```
### 2.Configuration
Edit the variable block at the top of `setup.sh`:
```bash
NEW_USER="operator"
SSH_PORT="2222"
PUB_KEY="ssh-ed25519 AAAAC3..." # Your public key goes here
```
### 3.Execution
Upload the script to your server and run
```bash
chmod +x setup.sh
sudo ./setup.sh
```
## ⚠️ Important Disclaimer
This script disables password login. **Do not close your current terminal session** until you have verified access in a new window:

## 📈 Roadmap
* Integration with vulnerability scanner **Trivy**
* Automatic configuration Docker Security (Rootless mode)
* Configuring system log monitoring via Logwatch
