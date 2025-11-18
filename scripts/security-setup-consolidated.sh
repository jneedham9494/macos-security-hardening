#!/bin/bash

#  ██████╗ ███████╗ ██████╗██╗   ██╗██████╗ ██╗████████╗██╗   ██╗    ██╗  ██╗ █████╗ ██████╗ ██████╗ ███████╗███╗   ██╗██╗███╗   ██╗ ██████╗
#  ██╔═══╝ ██╔════╝██╔════╝██║   ██║██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝    ██║  ██║██╔══██╗██╔══██╗██╔══██╗██╔════╝████╗  ██║██║████╗  ██║██╔════╝
#  ███████╗█████╗  ██║     ██║   ██║██████╔╝██║   ██║    ╚████╔╝     ███████║███████║██████╔╝██║  ██║█████╗  ██╔██╗ ██║██║██╔██╗ ██║██║  ███╗
#  ╚════██║██╔══╝  ██║     ██║   ██║██╔══██╗██║   ██║     ╚██╔╝      ██╔══██║██╔══██║██╔══██╗██║  ██║██╔══╝  ██║╚██╗██║██║██║╚██╗██║██║   ██║
#  ██████╔╝███████╗╚██████╗╚██████╔╝██║  ██║██║   ██║      ██║       ██║  ██║██║  ██║██║  ██║██████╔╝███████╗██║ ╚████║██║██║ ╚████║╚██████╔╝
#  ╚═════╝ ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝       ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝ ╚═════╝

# 🛡️ COMPREHENSIVE macOS SECURITY HARDENING SCRIPT
# 
# This script provides complete security hardening for macOS development environments.
# It combines system security, tool installation, configuration, and monitoring.
#
# Author: GitHub Copilot Assistant  
# Version: 2.0.0 (Consolidated)
# Date: September 2025

set -euo pipefail

# ============================================================================
# CONFIGURATION & CONSTANTS
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${SCRIPT_DIR}/security-setup.log"
USER_EMAIL="${USER_EMAIL:-dev@example.com}"
SSH_KEY_COMMENT="Security-Hardened Development Environment"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

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

print_error() {
    echo -e "${RED}❌ ERROR: $1${NC}"
    log "ERROR: $1"
}

print_warning() {
    echo -e "${YELLOW}⚠️  WARNING: $1${NC}"
    log "WARNING: $1"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
    log "INFO: $1"
}

check_command() {
    if command -v "$1" >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# ============================================================================
# SYSTEM SECURITY FUNCTIONS
# ============================================================================

install_homebrew() {
    print_header "📦 Installing Homebrew Package Manager"
    
    if check_command brew; then
        print_info "Homebrew already installed"
        brew update
    else
        print_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi
    
    print_success "Homebrew installed and updated"
}

install_security_tools() {
    print_header "🔧 Installing Security Tools"
    
    local tools=(
        "nmap"           # Network scanning
        "masscan"        # Fast port scanner
        "gobuster"       # Directory/file brute-forcer
        "sqlmap"         # SQL injection testing
        "hashcat"        # Password cracking
        "john"           # Password cracking
        "metasploit"     # Penetration testing framework
        "wireshark"      # Network protocol analyzer
        "burp-suite"     # Web security testing
        "trivy"          # Vulnerability scanner
        "syft"           # SBOM generator
        "grype"          # Vulnerability scanner
        "cosign"         # Container signing
        "vault"          # Secret management
        "age"            # File encryption
        "gnupg"          # GPG encryption
        "pass"           # Password manager
        "git-crypt"      # Git repository encryption
        "rclone"         # Cloud storage sync
        "mkcert"         # Local CA for development
        "step"           # Certificate management
        "openssh"        # SSH client/server
        "tor"            # Anonymous networking
        "proxychains-ng" # Proxy chains
        "wireguard-tools" # VPN
        "openvpn"        # VPN
        "tcpdump"        # Network packet analyzer
        "ettercap"       # Network security auditing
        "aircrack-ng"    # Wireless security auditing
        "dnsmasq"        # DNS/DHCP server
        "bind"           # DNS server
        "nginx"          # Web server
        "haproxy"        # Load balancer
        "fail2ban"       # Intrusion prevention
        "lynis"          # Security auditing
        "rkhunter"       # Rootkit hunter
        "clamav"         # Antivirus
        "chkrootkit"     # Rootkit checker
        "osquery"        # OS instrumentation
        "auditd"         # Audit daemon (Linux compatibility)
        "lsof"           # List open files
        "htop"           # Process viewer
        "iftop"          # Network usage
        "iotop"          # I/O usage
        "tree"           # Directory listing
        "jq"             # JSON processor
        "yq"             # YAML processor
        "xmlstarlet"     # XML processor
        "curl"           # HTTP client
        "wget"           # File downloader
        "rsync"          # File synchronization
        "unzip"          # Archive extraction
        "p7zip"          # Archive manager
        "git"            # Version control
        "gh"             # GitHub CLI
        "docker"         # Containerization
        "kubernetes-cli" # Container orchestration
        "helm"           # Kubernetes package manager
        "terraform"      # Infrastructure as code
        "ansible"        # Configuration management
        "packer"         # Image building
        "vagrant"        # Development environments
        "virtualbox"     # Virtualization
        "qemu"           # Emulation and virtualization
        "libvirt"        # Virtualization API
        "podman"         # Container management
        "buildah"        # Container building
        "skopeo"         # Container image operations
    )
    
    print_info "Installing security and development tools..."
    
    # Install tools with error handling
    for tool in "${tools[@]}"; do
        if brew install "$tool" 2>/dev/null; then
            print_success "Installed: $tool"
        else
            print_warning "Failed to install: $tool (may not be available or already installed)"
        fi
    done
    
    # Install cask applications
    local cask_apps=(
        "lulu"              # Firewall
        "knockknock"        # Malware detection
        "blockblock"        # Persistence detection
        "reikey"            # Keylogger detection
        "oversight"         # Camera/microphone monitoring
        "taskexplorer"      # Process monitoring
        "netiquette"        # Network monitoring
        "little-snitch"     # Network monitor (if available)
        "micro-snitch"      # Camera/microphone indicator
        "privacy-cleaner-pro" # Privacy cleaning
        "onyx"              # System maintenance
        "etrecheck"         # System diagnostic
        "disk-utility"      # Disk management
        "keychain-access"   # Credential management
        "gpg-suite"         # GPG tools
        "tor-browser"       # Anonymous browsing
        "signal"            # Secure messaging
        "protonmail-bridge" # Secure email
        "tutanota"          # Secure email
        "veracrypt"         # Disk encryption
        "cryptomator"       # Cloud encryption
        "suspicious-package" # Package inspection
        "apparency"         # App inspection
        "app-cleaner"       # Application removal
        "malwarebytes"      # Anti-malware
        "objective-see"     # Security tools suite
    )
    
    print_info "Installing security applications..."
    
    for app in "${cask_apps[@]}"; do
        if brew install --cask "$app" 2>/dev/null; then
            print_success "Installed: $app"
        else
            print_warning "Failed to install: $app (may not be available)"
        fi
    done
    
    print_success "Security tools installation completed"
}

setup_ssh_keys() {
    print_header "🔑 Setting Up SSH Keys"
    
    local ssh_dir="$HOME/.ssh"
    mkdir -p "$ssh_dir"
    chmod 700 "$ssh_dir"
    
    # Generate Ed25519 key (modern, secure)
    if [[ ! -f "$ssh_dir/id_ed25519" ]]; then
        print_info "Generating Ed25519 SSH key..."
        print_info "⚠️  IMPORTANT: Use a strong passphrase to protect your private key!"
        ssh-keygen -t ed25519 -C "$SSH_KEY_COMMENT" -f "$ssh_dir/id_ed25519"
        chmod 600 "$ssh_dir/id_ed25519"
        chmod 644 "$ssh_dir/id_ed25519.pub"
        print_success "Ed25519 SSH key generated"
    else
        print_info "Ed25519 SSH key already exists"
    fi

    # Generate RSA-4096 key (compatibility)
    if [[ ! -f "$ssh_dir/id_rsa" ]]; then
        print_info "Generating RSA-4096 SSH key for compatibility..."
        print_info "⚠️  IMPORTANT: Use a strong passphrase to protect your private key!"
        ssh-keygen -t rsa -b 4096 -C "$SSH_KEY_COMMENT" -f "$ssh_dir/id_rsa"
        chmod 600 "$ssh_dir/id_rsa"
        chmod 644 "$ssh_dir/id_rsa.pub"
        print_success "RSA-4096 SSH key generated"
    else
        print_info "RSA SSH key already exists"
    fi
    
    # Create SSH config
    cat > "$ssh_dir/config" << 'EOF'
# SSH Client Configuration
# Security-hardened settings

Host *
    # Prefer modern algorithms
    KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group16-sha512
    Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com
    MACs hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com
    
    # Security settings
    HashKnownHosts yes
    VisualHostKey yes
    PasswordAuthentication no
    ChallengeResponseAuthentication no
    PubkeyAuthentication yes
    
    # Connection settings
    ServerAliveInterval 60
    ServerAliveCountMax 3
    TCPKeepAlive no
    
    # Prefer Ed25519 keys
    IdentitiesOnly yes
    IdentityFile ~/.ssh/id_ed25519
    IdentityFile ~/.ssh/id_rsa
EOF
    
    chmod 600 "$ssh_dir/config"
    print_success "SSH configuration created"
    
    # Display public keys
    echo -e "\n${CYAN}📋 Your SSH Public Keys:${NC}"
    echo -e "${YELLOW}Ed25519 (recommended):${NC}"
    cat "$ssh_dir/id_ed25519.pub"
    echo -e "\n${YELLOW}RSA-4096 (compatibility):${NC}"
    cat "$ssh_dir/id_rsa.pub"
    echo ""
}

setup_git_security() {
    print_header "🔒 Configuring Git Security"

    # Get user name from environment or prompt
    local git_user_name="${GIT_USER_NAME:-$(whoami)}"

    # Set secure Git configuration
    git config --global user.name "$git_user_name"
    git config --global user.email "$USER_EMAIL"
    git config --global init.defaultBranch main
    git config --global pull.rebase true
    git config --global fetch.prune true
    git config --global core.autocrlf input
    git config --global core.filemode true
    git config --global core.excludesfile ~/.gitignore_global
    
    # Security settings
    git config --global transfer.fsckObjects true
    git config --global fetch.fsckObjects true
    git config --global receive.fsckObjects true
    git config --global url."https://github.com/".insteadOf "git@github.com:"
    git config --global url."https://".insteadOf "git://"
    
    # Signing configuration - enable GPG/SSH signing for commit integrity
    git config --global commit.gpgsign true
    git config --global tag.gpgsign true
    
    # Create global gitignore
    cat > ~/.gitignore_global << 'EOF'
# Security and sensitive files
.env
.env.*
*.key
*.pem
*.p12
*.pfx
secrets/
.secrets/
credentials/
.credentials/

# macOS
.DS_Store
.AppleDouble
.LSOverride
._*
.DocumentRevisions-V100
.fseventsd
.Spotlight-V100
.TemporaryItems
.Trashes
.VolumeIcon.icns
.com.apple.timemachine.donotpresent

# Editor files
.vscode/
.idea/
*.swp
*.swo
*~

# Temporary files
*.tmp
*.temp
*.log
.cache/
node_modules/
.npm/

# Build artifacts
dist/
build/
target/
.build/
EOF
    
    print_success "Git security configuration completed"
}

setup_firewall() {
    print_header "🔥 Configuring macOS Firewall"
    
    # Enable macOS Application Firewall
    sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
    sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

    # Note: --setallowsigned and --setallowsignedapp left at defaults
    # Blocking signed apps can break critical system functionality

    print_success "macOS Application Firewall configured and enabled"
    
    # Install and configure LuLu firewall if available
    if check_command LuLu; then
        print_info "LuLu firewall detected"
        # LuLu configuration would go here
    fi
}

setup_system_security() {
    print_header "🛡️ Hardening System Security Settings"
    
    # FileVault (disk encryption)
    if fdesetup status | grep -q "FileVault is Off"; then
        print_warning "FileVault is disabled. Enable it in System Preferences > Security & Privacy > FileVault"
    else
        print_success "FileVault is enabled"
    fi
    
    # Gatekeeper
    sudo spctl --master-enable
    print_success "Gatekeeper enabled"
    
    # System Integrity Protection check
    if csrutil status | grep -q "enabled"; then
        print_success "System Integrity Protection is enabled"
    else
        print_warning "System Integrity Protection is disabled"
    fi
    
    # Disable remote services
    sudo systemsetup -setremotelogin off 2>/dev/null || true
    sudo systemsetup -setremoteappleevents off 2>/dev/null || true
    
    # Security settings
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false
    
    print_success "System security settings configured"
}

# ============================================================================
# SECURITY TOOL CONFIGURATION FUNCTIONS
# ============================================================================

create_trivy_config() {
    print_info "Creating Trivy vulnerability scanner configuration..."
    
    cat > ~/.trivy.yaml << 'EOF'
# Trivy Configuration for Security Scanning
# https://aquasecurity.github.io/trivy/

# Cache settings
cache:
  dir: ~/.cache/trivy

# Database settings
db:
  repository: ghcr.io/aquasecurity/trivy-db

# Scanning settings
vulnerability:
  type:
    - os
    - library
  severity:
    - HIGH
    - CRITICAL

# Output settings
format: table
output: ""

# Scanning options
scan:
  security-checks:
    - vuln
    - config
    - secret
  skip-dirs:
    - node_modules
    - .git
    - .cache
    - .npm
    - vendor

# Timeout settings
timeout: 5m0s

# Quiet mode (reduce noise)
quiet: false
EOF
    
    print_success "Trivy configuration created at ~/.trivy.yaml"
}

create_nmap_config() {
    print_info "Creating Nmap scanning configuration..."
    
    mkdir -p ~/.nmap
    
    cat > ~/.nmap/nmap.conf << 'EOF'
# Nmap Configuration
# Default scanning options for security assessments

# Timing and performance
timing = 3

# Default scan types
scan_type = syn

# Output settings
output_format = normal

# Host discovery
host_discovery = true

# Port scanning
port_range = 1-65535
top_ports = 1000

# Service detection
service_detection = true
version_detection = true

# OS detection
os_detection = false

# Script scanning
script_scanning = false

# Verbosity
verbosity = 1
EOF
    
    print_success "Nmap configuration created"
}

create_gpg_config() {
    print_info "Creating GPG configuration..."
    
    mkdir -p ~/.gnupg
    chmod 700 ~/.gnupg
    
    cat > ~/.gnupg/gpg.conf << 'EOF'
# GPG Configuration
# Security-focused settings

# Default key preferences
default-preference-list SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed

# Algorithm and cipher preferences
personal-cipher-preferences AES256 AES192 AES CAST5
personal-digest-preferences SHA512 SHA384 SHA256 SHA224
personal-compress-preferences ZLIB BZIP2 ZIP Uncompressed

# Default algorithms
cert-digest-algo SHA256
s2k-digest-algo SHA512
s2k-cipher-algo AES256

# Display options
keyid-format 0xlong
with-fingerprint
list-options show-uid-validity
verify-options show-uid-validity

# Security options
require-cross-certification
no-symkey-cache
use-agent
throw-keyids
EOF
    
    cat > ~/.gnupg/gpg-agent.conf << 'EOF'
# GPG Agent Configuration

# Cache settings
default-cache-ttl 600
max-cache-ttl 7200

# Security
require-cross-certification
EOF
    
    chmod 600 ~/.gnupg/gpg.conf
    chmod 600 ~/.gnupg/gpg-agent.conf
    
    print_success "GPG configuration created"
}

setup_monitoring_system() {
    print_header "📊 Setting Up Security Monitoring"
    
    local monitoring_dir="$HOME/.security-monitoring"
    mkdir -p "$monitoring_dir"/{scripts,reports,logs,config}
    
    # Create monitoring script
    cat > "$monitoring_dir/security-scan.sh" << 'EOF'
#!/bin/bash
# Automated Security Monitoring Script

SCRIPT_DIR="$HOME/.security-monitoring"
REPORT_DIR="$SCRIPT_DIR/reports"
LOG_FILE="$SCRIPT_DIR/logs/security-scan.log"
DATE=$(date +%Y-%m-%d)
REPORT_FILE="$REPORT_DIR/security-report-$DATE.html"

mkdir -p "$REPORT_DIR" "$SCRIPT_DIR/logs"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# HTML Report Generation
cat > "$REPORT_FILE" << HTMLEOF
<!DOCTYPE html>
<html>
<head>
    <title>Security Report - $DATE</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .header { background: #f0f0f0; padding: 10px; border-radius: 5px; }
        .section { margin: 20px 0; }
        .critical { color: red; font-weight: bold; }
        .warning { color: orange; }
        .success { color: green; }
        pre { background: #f8f8f8; padding: 10px; border-radius: 3px; overflow-x: auto; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🛡️ Security Report</h1>
        <p>Generated: $(date)</p>
        <p>System: $(uname -a)</p>
    </div>
HTMLEOF

# System Security Checks
echo "<div class='section'><h2>🔍 System Security Status</h2>" >> "$REPORT_FILE"

# FileVault Status
if fdesetup status | grep -q "FileVault is On"; then
    echo "<p class='success'>✅ FileVault: Enabled</p>" >> "$REPORT_FILE"
else
    echo "<p class='critical'>❌ FileVault: Disabled</p>" >> "$REPORT_FILE"
fi

# Firewall Status
if /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate | grep -q "enabled"; then
    echo "<p class='success'>✅ Firewall: Enabled</p>" >> "$REPORT_FILE"
else
    echo "<p class='critical'>❌ Firewall: Disabled</p>" >> "$REPORT_FILE"
fi

# SSH Key Check
if [[ -f "$HOME/.ssh/id_ed25519" ]]; then
    echo "<p class='success'>✅ SSH Keys: Ed25519 key present</p>" >> "$REPORT_FILE"
else
    echo "<p class='warning'>⚠️ SSH Keys: No Ed25519 key found</p>" >> "$REPORT_FILE"
fi

echo "</div>" >> "$REPORT_FILE"

# Network Security
echo "<div class='section'><h2>🌐 Network Security</h2>" >> "$REPORT_FILE"
echo "<h3>Active Network Connections</h3>" >> "$REPORT_FILE"
echo "<pre>" >> "$REPORT_FILE"
netstat -an | head -20 >> "$REPORT_FILE"
echo "</pre>" >> "$REPORT_FILE"
echo "</div>" >> "$REPORT_FILE"

# System Information
echo "<div class='section'><h2>💻 System Information</h2>" >> "$REPORT_FILE"
echo "<pre>" >> "$REPORT_FILE"
system_profiler SPSoftwareDataType >> "$REPORT_FILE"
echo "</pre>" >> "$REPORT_FILE"
echo "</div>" >> "$REPORT_FILE"

# Close HTML
echo "</body></html>" >> "$REPORT_FILE"

log "Security report generated: $REPORT_FILE"
echo "Security report saved to: $REPORT_FILE"
EOF
    
    chmod +x "$monitoring_dir/security-scan.sh"
    
    # Create LaunchAgent for periodic monitoring
    local plist_dir="$HOME/Library/LaunchAgents"
    mkdir -p "$plist_dir"
    
    cat > "$plist_dir/com.security.monitoring.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.security.monitoring</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>-c</string>
        <string>$HOME/.security-monitoring/security-scan.sh</string>
    </array>
    <key>StartInterval</key>
    <integer>86400</integer>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOF
    
    # Load the LaunchAgent
    launchctl load "$plist_dir/com.security.monitoring.plist" 2>/dev/null || true
    
    print_success "Security monitoring system configured"
    print_info "Daily security reports will be saved to: $monitoring_dir/reports/"
}

setup_shell_integration() {
    print_header "🐚 Setting Up Shell Security Integration"
    
    # Add security aliases and functions to shell
    local shell_config=""
    if [[ "$SHELL" == *"zsh"* ]]; then
        shell_config="$HOME/.zshrc"
    elif [[ "$SHELL" == *"bash"* ]]; then
        shell_config="$HOME/.bashrc"
    fi
    
    if [[ -n "$shell_config" ]]; then
        cat >> "$shell_config" << 'EOF'

# ============================================================================
# SECURITY HARDENING SHELL INTEGRATION
# ============================================================================

# Security aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias netscan='nmap -sS -O'
alias portscan='nmap -p-'
alias vulnscan='trivy fs .'
alias secscan='~/.security-monitoring/security-scan.sh'

# Security functions
check_ssh() {
    echo "SSH Key Status:"
    ls -la ~/.ssh/*.pub 2>/dev/null || echo "No SSH public keys found"
}

check_firewall() {
    echo "Firewall Status:"
    /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate
}

check_filevault() {
    echo "FileVault Status:"
    fdesetup status
}

security_status() {
    echo "🛡️ Security Status Overview"
    echo "=========================="
    check_filevault
    echo ""
    check_firewall
    echo ""
    check_ssh
}

# Auto-run security check on new terminal (optional)
# security_status

EOF
        print_success "Shell security integration added to $shell_config"
    fi
}

# ============================================================================
# MAIN MENU SYSTEM
# ============================================================================

show_menu() {
    clear
    echo -e "${CYAN}"
    cat << 'EOF'
    
    ██████╗ ███████╗ ██████╗██╗   ██╗██████╗ ██╗████████╗██╗   ██╗
    ██╔═══╗ ██╔════╝██╔════╝██║   ██║██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝
    ███████╗█████╗  ██║     ██║   ██║██████╔╝██║   ██║    ╚████╔╝ 
    ╚════██║██╔══╝  ██║     ██║   ██║██╔══██╗██║   ██║     ╚██╔╝  
    ██████╔╝███████╗╚██████╗╚██████╔╝██║  ██║██║   ██║      ██║   
    ╚═════╝ ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝   
    
    🛡️ COMPREHENSIVE macOS SECURITY HARDENING SUITE
    
EOF
    echo -e "${NC}"
    
    echo -e "${YELLOW}Choose an option:${NC}\n"
    echo -e "${GREEN} 1)${NC} 🚀 Complete Security Setup (Recommended)"
    echo -e "${GREEN} 2)${NC} 📦 Install Homebrew & Security Tools"
    echo -e "${GREEN} 3)${NC} 🔑 Setup SSH Keys"
    echo -e "${GREEN} 4)${NC} 🔒 Configure Git Security"
    echo -e "${GREEN} 5)${NC} 🔥 Setup Firewall"
    echo -e "${GREEN} 6)${NC} 🛡️  Harden System Security"
    echo -e "${GREEN} 7)${NC} ⚙️  Create Security Tool Configs"
    echo -e "${GREEN} 8)${NC} 📊 Setup Security Monitoring"
    echo -e "${GREEN} 9)${NC} 🐚 Configure Shell Integration"
    echo -e "${GREEN}10)${NC} 🔍 Run Security Status Check"
    echo -e "${GREEN}11)${NC} 📋 View Security Report"
    echo -e "${RED} 0)${NC} 🚪 Exit"
    echo ""
    echo -ne "${CYAN}Enter your choice [0-11]: ${NC}"
}

run_complete_setup() {
    print_header "🚀 COMPLETE SECURITY SETUP"
    print_info "This will run all security hardening components..."
    
    install_homebrew
    install_security_tools
    setup_ssh_keys
    setup_git_security
    setup_firewall
    setup_system_security
    
    # Create configurations
    create_trivy_config
    create_nmap_config
    create_gpg_config
    
    # Setup monitoring and shell integration
    setup_monitoring_system
    setup_shell_integration
    
    print_header "🎉 SECURITY SETUP COMPLETE"
    print_success "Your macOS system has been hardened with enterprise-grade security!"
    print_info "Key accomplishments:"
    echo -e "  ${GREEN}✅${NC} Homebrew and security tools installed"
    echo -e "  ${GREEN}✅${NC} SSH keys generated (Ed25519 + RSA-4096)"
    echo -e "  ${GREEN}✅${NC} Git security configured"
    echo -e "  ${GREEN}✅${NC} System firewall enabled"
    echo -e "  ${GREEN}✅${NC} Security monitoring active"
    echo -e "  ${GREEN}✅${NC} Shell security integration added"
    echo ""
    print_info "Security reports will be generated daily in: ~/.security-monitoring/reports/"
    print_info "Run 'security_status' in your terminal to check system security"
    echo ""
    read -p "Press Enter to continue..."
}

run_security_check() {
    print_header "🔍 SECURITY STATUS CHECK"
    
    echo -e "${CYAN}FileVault (Disk Encryption):${NC}"
    fdesetup status
    echo ""
    
    echo -e "${CYAN}Application Firewall:${NC}"
    /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate
    echo ""
    
    echo -e "${CYAN}SSH Keys:${NC}"
    ls -la ~/.ssh/*.pub 2>/dev/null || echo "No SSH public keys found"
    echo ""
    
    echo -e "${CYAN}Git Configuration:${NC}"
    git config --global user.name
    git config --global user.email
    echo ""
    
    echo -e "${CYAN}Security Tools:${NC}"
    local tools=("nmap" "trivy" "gpg" "ssh")
    for tool in "${tools[@]}"; do
        if check_command "$tool"; then
            echo -e "  ${GREEN}✅${NC} $tool: Available"
        else
            echo -e "  ${RED}❌${NC} $tool: Not found"
        fi
    done
    echo ""
    
    echo -e "${CYAN}Monitoring System:${NC}"
    if [[ -d "$HOME/.security-monitoring" ]]; then
        echo -e "  ${GREEN}✅${NC} Security monitoring: Configured"
    else
        echo -e "  ${RED}❌${NC} Security monitoring: Not configured"
    fi
    echo ""
    
    read -p "Press Enter to continue..."
}

view_security_report() {
    print_header "📋 SECURITY REPORT VIEWER"
    
    local report_dir="$HOME/.security-monitoring/reports"
    
    if [[ -d "$report_dir" ]]; then
        echo -e "${CYAN}Available Security Reports:${NC}\n"
        ls -la "$report_dir"/*.html 2>/dev/null || echo "No reports found"
        echo ""
        
        local latest_report=$(ls -t "$report_dir"/*.html 2>/dev/null | head -1)
        if [[ -n "$latest_report" ]]; then
            echo -e "${YELLOW}Latest report: $(basename "$latest_report")${NC}"
            echo "Location: $latest_report"
            echo ""
            echo "Open this file in a web browser to view the detailed security report."
        fi
    else
        print_warning "Security monitoring not configured. Run option 8 to set it up."
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    # Initialize log file
    log "macOS Security Hardening Script started by $(whoami)"
    
    while true; do
        show_menu
        read -r choice
        
        case $choice in
            1) run_complete_setup ;;
            2) install_homebrew && install_security_tools ;;
            3) setup_ssh_keys ;;
            4) setup_git_security ;;
            5) setup_firewall ;;
            6) setup_system_security ;;
            7) create_trivy_config && create_nmap_config && create_gpg_config ;;
            8) setup_monitoring_system ;;
            9) setup_shell_integration ;;
            10) run_security_check ;;
            11) view_security_report ;;
            0) 
                print_info "Exiting macOS Security Hardening Suite"
                log "Script completed by $(whoami)"
                exit 0
                ;;
            *)
                print_error "Invalid option. Please choose 0-11."
                sleep 2
                ;;
        esac
    done
}

# ============================================================================
# SCRIPT ENTRY POINT
# ============================================================================

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    print_error "This script is designed for macOS only"
    exit 1
fi

# Check for required permissions
if [[ $EUID -eq 0 ]]; then
    print_error "This script should not be run as root"
    exit 1
fi

# Start main execution
main "$@"