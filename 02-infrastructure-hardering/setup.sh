#!/bin/bash

#NOTE: in the code i wrote comments for better understanding 

# set up pipefail flags
set -euo pipefail 
IFS=$'\n\t'

#user's variables
NEW_USER="operator"
SSH_PORT="2222"
LOG_FILE="/var/log/server_hardening.log"
PUB_KEY="${SSH_PUB_KEY:-${1:-}}"


RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

#function for logging
log() {
    local message
    message="[$(date +'%Y-%m-%d %H:%M:%S')] $1"
    echo -e "${GREEN}${message}${NC}"
    echo "${message}" | sudo tee -a "$LOG_FILE" > /dev/null
}


error_exit() {
    echo -e "${RED}[ERROR] $(date +'%Y-%m-%d %H:%M:%S') $1${NC}" >&2
    exit 1
}

cleanup() {
    log "${YELLOW}Script cleanup performed.${NC}"
}
trap cleanup EXIT SIGINT SIGTERM

#check privileges before start
check_root() {
    if [[ $EUID -ne 0 ]]; then
       error_exit "This script must be executed with sudo privileges"
    fi
    touch "$LOG_FILE" && chmod 600 "$LOG_FILE"
}

check_port() {
    log "Checking if port $SSH_PORT is available..."
    if command -v ss >/dev/null; then
        if ss -lnt | grep -q ":$SSH_PORT "; then
            error_exit "Port $SSH_PORT is already in use!"
        fi
    fi
}

update_system() {
    log "Updating system (non-interactive)..."
    #use export because apt asks questions
    export DEBIAN_FRONTEND=noninteractive
    apt update && apt upgrade -y
}

setup_user() {
    if [[ -z "$PUB_KEY" ]]; then
        log "${YELLOW}[INFO] No SSH key provided via environment (SSH_PUB_KEY) or argument.${NC}"
        log "Please paste your public SSH key (starting with ssh-rsa/ssh-ed25519):"
        read -r PUB_KEY        
        if [[ -z "$PUB_KEY" ]]; then
            error_exit "SSH Public Key is required but not provided. Aborting."
        fi
    fi

    log "Setting up user: $NEW_USER..."
    
    if id "$NEW_USER" &>/dev/null; then
        log "${YELLOW}User $NEW_USER already exists.${NC}"
    else
        useradd -m -s /bin/bash "$NEW_USER"
        usermod -aG sudo "$NEW_USER"
        log "User $NEW_USER created."
    fi

    local user_home="/home/$NEW_USER"
    mkdir -p "$user_home/.ssh"
    
    # secure write public key
    echo "$PUB_KEY" > "$user_home/.ssh/authorized_keys"
    
    chown -R "$NEW_USER:$NEW_USER" "$user_home/.ssh"
    chmod 700 "$user_home/.ssh"
    chmod 600 "$user_home/.ssh/authorized_keys" 
    
    # Set up ACL (Access Control List) for log
    if command -v setfacl >/dev/null; then
        setfacl -m u:"$NEW_USER":r "$LOG_FILE" || log "${YELLOW}Warning: ACL setup failed.${NC}"
    fi
    
    log "SSH keys and ACL permissions deployed for $NEW_USER."
}
harden_ssh() {
    log "Hardening SSH configuration..."
    local ssh_config="/etc/ssh/sshd_config"
    cp "$ssh_config" "${ssh_config}.bak"
    replace_or_add() {
        local param=$1
        local value=$2
        if grep -q "^#\?${param}" "$ssh_config"; then
            sed -i "s/^#\?${param}.*/${param} ${value}/" "$ssh_config"
        else
            echo "${param} ${value}" >> "$ssh_config"
        fi
    }

    replace_or_add "Port" "$SSH_PORT"
    replace_or_add "PermitRootLogin" "no"
    replace_or_add "PasswordAuthentication" "no"

    if /usr/sbin/sshd -t; then
        systemctl restart ssh
        log "SSH configured successfully on port $SSH_PORT"
    else
        cp "${ssh_config}.bak" "$ssh_config"
        error_exit "SSH config validation failed! Reverted to backup."
    fi
}

configure_firewall() {
    log "Configuring UFW firewall..."
    ufw --force reset #reset
    ufw default deny incoming
    ufw default allow outgoing
    ufw allow "$SSH_PORT/tcp"
    ufw allow 80/tcp
    ufw allow 443/tcp
    ufw --force enable
}

#set up auditd and create 3 basic rules
setup_auditing() {
    log "Installing and configuring Auditd..."
    apt install -y auditd audispd-plugins
        
    echo "-w /etc/shadow -p wa -k identity" > /etc/audit/rules.d/hardening.rules
    echo "-w /etc/sudoers -p wa -k priv_esc" >> /etc/audit/rules.d/hardening.rules
    echo "-w /etc/ssh/sshd_config -p wa -k ssh_config" >> /etc/audit/rules.d/hardening.rules
    
    service auditd restart
    log "Auditing rules applied successfully."
}

#main function
main() {
    check_root
    check_port
    log "Starting hardering process..."
    
    update_system
    setup_user
    harden_ssh
    configure_firewall

    log "System secured successfully!"
    local ip_addr
    ip_addr=$(hostname -I | awk '{print $1}')
    log "Login: ssh -p $SSH_PORT $NEW_USER@$ip_addr"
}

main "$@"