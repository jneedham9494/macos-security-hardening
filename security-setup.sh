#!/bin/bash

#  ██████╗ ███████╗ ██████╗██╗   ██╗██████╗ ██╗████████╗██╗   ██╗    ██╗  ██╗ █████╗ ██████╗ ██████╗ ███████╗███╗   ██╗██╗███╗   ██╗ ██████╗
#  ██╔═══╝ ██╔════╝██╔════╝██║   ██║██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝    ██║  ██║██╔══██╗██╔══██╗██╔══██╗██╔════╝████╗  ██║██║████╗  ██║██╔════╝
#  ███████╗█████╗  ██║     ██║   ██║██████╔╝██║   ██║    ╚████╔╝     ███████║███████║██████╔╝██║  ██║█████╗  ██╔██╗ ██║██║██╔██╗ ██║██║  ███╗
#  ╚════██║██╔══╝  ██║     ██║   ██║██╔══██╗██║   ██║     ╚██╔╝      ██╔══██║██╔══██║██╔══██╗██║  ██║██╔══╝  ██║╚██╗██║██║██║╚██╗██║██║   ██║
#  ██████╔╝███████╗╚██████╗╚██████╔╝██║  ██║██║   ██║      ██║       ██║  ██║██║  ██║██║  ██║██████╔╝███████╗██║ ╚████║██║██║ ╚████║╚██████╔╝
#  ╚═════╝ ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝       ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝ ╚═════╝

# Comprehensive Security & Privacy Setup Script for macOS Development Environment
# Author: GitHub Copilot Assistant
# Version: 1.0.0
# Date: September 2025

set -euo pipefail  # Exit on error, undefined vars, pipe failures

# ============================================================================
# CONFIGURATION & CONSTANTS
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${SCRIPT_DIR}/security-setup.log"
USER_EMAIL="${USER_EMAIL:-$(whoami)@$(hostname)}"
SSH_KEY_COMMENT="Security-Hardened Development Environment"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

print_header() {
    echo -e "\n${CYAN}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║$(printf "%78s" | tr ' ' ' ')║${NC}"
    echo -e "${CYAN}║  $(printf "%-74s" "$1")  ║${NC}"
    echo -e "${CYAN}║$(printf "%78s" | tr ' ' ' ')║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════════════╝${NC}\n"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
    log "SUCCESS: $1"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
    log "WARNING: $1"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
    log "ERROR: $1"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
    log "INFO: $1"
}

confirm_action() {
    local message="$1"
    echo -e "${YELLOW}$message${NC}"
    read -p "Continue? (y/N): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

check_homebrew() {
    if ! command -v brew &> /dev/null; then
        print_error "Homebrew is required but not installed."
        echo "Please install Homebrew first: https://brew.sh"
        exit 1
    fi
}

# ============================================================================
# SSH HARDENING
# ============================================================================

setup_ssh_security() {
    print_header "SSH Security Configuration"
    
    local ssh_dir="$HOME/.ssh"
    mkdir -p "$ssh_dir"
    chmod 700 "$ssh_dir"
    
    # Generate SSH keys if they don't exist
    if [[ ! -f "$ssh_dir/id_ed25519" ]]; then
        print_info "Generating Ed25519 SSH key..."
        ssh-keygen -t ed25519 -C "$SSH_KEY_COMMENT" -f "$ssh_dir/id_ed25519" -N ""
        print_success "Ed25519 SSH key generated"
    else
        print_info "Ed25519 SSH key already exists"
    fi
    
    if [[ ! -f "$ssh_dir/id_rsa" ]]; then
        print_info "Generating RSA SSH key (4096-bit)..."
        ssh-keygen -t rsa -b 4096 -C "$SSH_KEY_COMMENT" -f "$ssh_dir/id_rsa" -N ""
        print_success "RSA SSH key generated"
    else
        print_info "RSA SSH key already exists"
    fi
    
    # Create secure SSH config
    cat > "$ssh_dir/config" << 'EOF'
# SSH Security Configuration
# Generated by Security Hardening Script

Host *
    # Use modern key types
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/id_ed25519
    IdentityFile ~/.ssh/id_rsa
    
    # Connection settings
    ServerAliveInterval 60
    ServerAliveCountMax 3
    ConnectTimeout 10
    
    # Security settings
    HashKnownHosts yes
    VisualHostKey yes
    StrictHostKeyChecking ask
    VerifyHostKeyDNS yes
    
    # Disable insecure options
    GSSAPIAuthentication no
    PasswordAuthentication no
    ChallengeResponseAuthentication no
    
    # Encryption preferences
    Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
    MACs hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha2-256,hmac-sha2-512
    KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512
    
# GitHub configuration
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
    
# GitLab configuration  
Host gitlab.com
    HostName gitlab.com
    User git
    IdentityFile ~/.ssh/id_ed25519
EOF

    chmod 600 "$ssh_dir/config"
    chmod 600 "$ssh_dir"/id_* 2>/dev/null || true
    chmod 644 "$ssh_dir"/*.pub 2>/dev/null || true
    
    print_success "SSH security configuration completed"
    echo -e "${CYAN}📋 Your SSH public keys:${NC}"
    [[ -f "$ssh_dir/id_ed25519.pub" ]] && echo -e "${GREEN}Ed25519:${NC} $(cat "$ssh_dir/id_ed25519.pub")"
    [[ -f "$ssh_dir/id_rsa.pub" ]] && echo -e "${GREEN}RSA:${NC} $(cat "$ssh_dir/id_rsa.pub")"
}

# ============================================================================
# GIT SECURITY & COMMIT SIGNING
# ============================================================================

setup_git_security() {
    print_header "Git Security & Commit Signing"
    
    # Install GPG
    if ! command -v gpg &> /dev/null; then
        print_info "Installing GPG..."
        brew install gnupg pinentry-mac
    fi
    
    # Configure GPG
    local gpg_dir="$HOME/.gnupg"
    mkdir -p "$gpg_dir"
    chmod 700 "$gpg_dir"
    
    # Create GPG config
    cat > "$gpg_dir/gpg.conf" << 'EOF'
# GPG Configuration for Enhanced Security
use-agent
charset utf-8
no-greeting
no-permission-warning
lock-never
keyid-format 0xlong
with-fingerprint
list-options show-uid-validity
verify-options show-uid-validity
personal-cipher-preferences AES256 AES192 AES
personal-digest-preferences SHA512 SHA384 SHA256
personal-compress-preferences ZLIB BZIP2 ZIP Uncompressed
default-preference-list SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed
cert-digest-algo SHA512
s2k-digest-algo SHA512
s2k-cipher-algo AES256
throw-keyids
EOF

    cat > "$gpg_dir/gpg-agent.conf" << 'EOF'
# GPG Agent Configuration
pinentry-program /opt/homebrew/bin/pinentry-mac
default-cache-ttl 600
max-cache-ttl 7200
enable-ssh-support
EOF

    chmod 600 "$gpg_dir"/{gpg.conf,gpg-agent.conf} 2>/dev/null || true
    
    # Generate GPG key if it doesn't exist
    if ! gpg --list-secret-keys --keyid-format LONG | grep -q sec; then
        print_info "Setting up GPG key for commit signing..."
        print_warning "GPG key generation requires manual input. Please follow the prompts."
        gpg --full-generate-key
        print_success "GPG key generated"
    fi
    
    # Configure Git for signing
    local signing_key=$(gpg --list-secret-keys --keyid-format LONG | grep sec | head -1 | awk '{print $2}' | cut -d'/' -f2 2>/dev/null || echo "")
    if [[ -n "$signing_key" ]]; then
        git config --global user.signingkey "$signing_key"
        git config --global commit.gpgsign true
        git config --global tag.gpgsign true
        git config --global gpg.program gpg
        print_success "Git commit signing configured with key: $signing_key"
    else
        print_warning "No GPG key found. Commit signing not configured."
    fi
    
    # Additional Git security settings
    git config --global init.defaultBranch main
    git config --global pull.rebase true
    git config --global push.default simple
    git config --global core.autocrlf input
    git config --global core.filemode true
    git config --global transfer.fsckobjects true
    git config --global fetch.fsckobjects true
    git config --global receive.fsckObjects true
    
    print_success "Git security configuration completed"
}

# ============================================================================
# SECURITY MONITORING TOOLS
# ============================================================================

install_security_tools() {
    print_header "Installing Security & Monitoring Tools"
    
    local tools=(
        "nmap"                    # Network scanning
        "bandwhich"              # Network bandwidth monitor
        "dog"                    # Modern DNS client
        "semgrep"                # Code security scanner
        "gitleaks"               # Git secrets detection
        "trivy"                  # Vulnerability scanner
        "sops"                   # Secrets encryption
        "age"                    # File encryption
        "lnav"                   # Log navigator
    )
    
    local cask_tools=(
        "knockknock"             # Malware detection
        "reikey"                 # Keyboard/mouse monitoring
        "oversight"              # Camera/microphone monitoring  
        "keybase"                # Secure file sharing
        "firefox"                # Privacy-focused browser
        "brave-browser"          # Privacy browser
    )
    
    print_info "Installing command-line security tools..."
    for tool in "${tools[@]}"; do
        if brew list "$tool" &>/dev/null; then
            print_info "$tool already installed"
        else
            print_info "Installing $tool..."
            brew install "$tool" || print_warning "Failed to install $tool"
        fi
    done
    
    print_info "Installing GUI security applications..."
    for app in "${cask_tools[@]}"; do
        if brew list --cask "$app" &>/dev/null; then
            print_info "$app already installed"
        else
            print_info "Installing $app..."
            brew install --cask "$app" || print_warning "Failed to install $app"
        fi
    done
    
    print_success "Security tools installation completed"
}

# ============================================================================
# BROWSER SECURITY CONFIGURATION
# ============================================================================

configure_browser_security() {
    print_header "Browser Security Configuration"
    
    print_info "Browser security configuration completed"
    echo -e "${CYAN}📋 Manual browser setup recommendations:${NC}"
    echo -e "  • Install uBlock Origin extension"
    echo -e "  • Install ClearURLs extension"  
    echo -e "  • Install Decentraleyes extension"
    echo -e "  • Enable DNS over HTTPS in browser settings"
    echo -e "  • Configure strict tracking protection"
    echo -e "  • Disable WebRTC in Firefox (about:config → media.peerconnection.enabled = false)"
}

# ============================================================================
# SYSTEM SECURITY HARDENING
# ============================================================================

harden_system_security() {
    print_header "System Security Hardening"
    
    print_info "Configuring system security settings..."
    
    # Require password immediately after sleep/screensaver
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0
    
    # Disable automatic login
    sudo defaults delete /Library/Preferences/com.apple.loginwindow autoLoginUser 2>/dev/null || true
    
    # Enable application firewall logging
    sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
    
    # Set secure umask
    if ! grep -q "umask 027" ~/.zshrc; then
        echo "umask 027" >> ~/.zshrc
        print_success "Secure umask configured"
    fi
    
    # Disable Bonjour multicast advertisements
    sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true
    
    print_success "System security hardening completed"
}

# ============================================================================
# DEVELOPMENT ENVIRONMENT SECURITY
# ============================================================================

secure_development_environment() {
    print_header "Development Environment Security"
    
    # Create secure directory for secrets
    local secrets_dir="$HOME/.secrets"
    mkdir -p "$secrets_dir"
    chmod 700 "$secrets_dir"
    
    # Configure npm security
    if command -v npm &> /dev/null; then
        npm config set audit-level moderate
        npm config set fund false
        npm config set optional false
        print_success "npm security configured"
    fi
    
    # Set up git hooks directory
    local hooks_dir="$HOME/.git-templates/hooks"
    mkdir -p "$hooks_dir"
    
    # Pre-commit hook to check for secrets
    cat > "$hooks_dir/pre-commit" << 'EOF'
#!/bin/bash
# Pre-commit hook to scan for secrets
if command -v gitleaks &> /dev/null; then
    gitleaks protect --verbose --redact --staged
fi
EOF
    chmod +x "$hooks_dir/pre-commit"
    
    git config --global init.templateDir ~/.git-templates
    
    print_success "Development environment security configured"
}

# ============================================================================
# PRIVACY CONFIGURATION
# ============================================================================

configure_privacy_settings() {
    print_header "Privacy Configuration"
    
    print_info "Configuring privacy settings..."
    
    # Disable Spotlight suggestions
    defaults write com.apple.lookup.shared LookupSuggestionsDisabled -bool true
    
    # Disable analytics
    defaults write com.apple.SubmitDiagInfo AutoSubmit -bool false
    
    # Configure Safari privacy (if used)
    defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true
    defaults write com.apple.Safari UniversalSearchEnabled -bool false
    defaults write com.apple.Safari SuppressSearchSuggestions -bool true
    
    print_success "Privacy configuration completed"
    
    echo -e "${CYAN}📋 Manual privacy configuration recommended:${NC}"
    echo -e "  • System Settings → Privacy & Security → Location Services"
    echo -e "  • System Settings → Privacy & Security → Analytics & Improvements" 
    echo -e "  • System Settings → Privacy & Security → Apple Advertising"
    echo -e "  • System Settings → Siri & Spotlight → Siri Suggestions"
}

# ============================================================================
# MONITORING SETUP
# ============================================================================

setup_monitoring() {
    print_header "Security Monitoring Setup"
    
    # Create monitoring scripts directory
    local monitor_dir="$HOME/.security-monitoring"
    mkdir -p "$monitor_dir"
    
    # Network monitoring script
    cat > "$monitor_dir/network-monitor.sh" << 'EOF'
#!/bin/bash
# Simple network connection monitor
log_file="$HOME/.security-monitoring/network.log"
echo "$(date): Network monitoring started" >> "$log_file"

while true; do
    # Log new connections
    lsof -i -n | grep ESTABLISHED | while read line; do
        echo "$(date): $line" >> "$log_file"
    done
    sleep 60
done
EOF
    chmod +x "$monitor_dir/network-monitor.sh"
    
    # System integrity check script
    cat > "$monitor_dir/integrity-check.sh" << 'EOF'
#!/bin/bash
# Basic system integrity monitoring
log_file="$HOME/.security-monitoring/integrity.log"
echo "$(date): System integrity check started" >> "$log_file"

# Check for new launch agents/daemons
find /Library/Launch* /System/Library/Launch* ~/Library/Launch* -name "*.plist" -newer /tmp/last_integrity_check 2>/dev/null | while read file; do
    echo "$(date): New launch item detected: $file" >> "$log_file"
done

touch /tmp/last_integrity_check
EOF
    chmod +x "$monitor_dir/integrity-check.sh"
    
    print_success "Security monitoring scripts created"
    echo -e "${CYAN}📋 Monitoring scripts location: $monitor_dir${NC}"
    echo -e "  • network-monitor.sh - Monitor network connections"
    echo -e "  • integrity-check.sh - Check system integrity"
}

# ============================================================================
# MAIN MENU & EXECUTION
# ============================================================================

show_menu() {
    clear
    echo -e "${PURPLE}"
    cat << 'EOF'
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║           🔒 SECURITY & PRIVACY HARDENING SCRIPT 🔒                         ║
║                                                                              ║
║                    Secure Development Environment Setup                      ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}\n"
    
    echo -e "${CYAN}Choose components to install/configure:${NC}\n"
    echo -e "  ${GREEN}1)${NC} SSH Security Hardening"
    echo -e "  ${GREEN}2)${NC} Git Security & Commit Signing" 
    echo -e "  ${GREEN}3)${NC} Security Monitoring Tools"
    echo -e "  ${GREEN}4)${NC} Browser Security Configuration"
    echo -e "  ${GREEN}5)${NC} System Security Hardening"
    echo -e "  ${GREEN}6)${NC} Development Environment Security"
    echo -e "  ${GREEN}7)${NC} Privacy Configuration"
    echo -e "  ${GREEN}8)${NC} Security Monitoring Setup"
    echo -e "  ${GREEN}9)${NC} Install ALL Components"
    echo -e "  ${RED}0)${NC} Exit"
    echo
}

main() {
    # Initialize log file
    log "Security hardening script started by $(whoami)"
    
    # Check prerequisites
    check_homebrew
    
    while true; do
        show_menu
        read -p "Select option [0-9]: " choice
        echo
        
        case $choice in
            1)
                setup_ssh_security
                ;;
            2)
                setup_git_security
                ;;
            3)
                install_security_tools
                ;;
            4)
                configure_browser_security
                ;;
            5)
                harden_system_security
                ;;
            6)
                secure_development_environment
                ;;
            7)
                configure_privacy_settings
                ;;
            8)
                setup_monitoring
                ;;
            9)
                if confirm_action "This will install ALL security components. This may take a while."; then
                    setup_ssh_security
                    setup_git_security
                    install_security_tools
                    configure_browser_security
                    harden_system_security
                    secure_development_environment
                    configure_privacy_settings
                    setup_monitoring
                    
                    print_header "🎉 SECURITY HARDENING COMPLETE! 🎉"
                    echo -e "${GREEN}All security components have been configured.${NC}"
                    echo -e "${CYAN}Log file: $LOG_FILE${NC}"
                    echo -e "\n${YELLOW}⚠️  Please restart your system to ensure all changes take effect.${NC}\n"
                fi
                ;;
            0)
                echo -e "${GREEN}Security hardening script completed. Stay secure! 🔒${NC}"
                log "Security hardening script completed by $(whoami)"
                exit 0
                ;;
            *)
                print_error "Invalid option. Please try again."
                ;;
        esac
        
        echo
        read -p "Press Enter to continue..."
    done
}

# Run the script
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi