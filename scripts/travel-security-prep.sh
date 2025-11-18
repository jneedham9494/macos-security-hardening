#!/bin/bash
# Travel Security Preparation Script
# Prepares macOS system for secure international travel with device inspection risks

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.travel-security-backup"
SECURE_STORE="$HOME/.secure-travel-store"
LOG_FILE="$BACKUP_DIR/travel-prep.log"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

print_header() {
    echo -e "\n${CYAN}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║$(printf "%78s" | tr ' ' ' ')║${NC}"
    echo -e "${CYAN}║  $(printf "%-74s" "$1")  ║${NC}"
    echo -e "${CYAN}║$(printf "%78s" | tr ' ' ' ')║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════════════╝${NC}\n"
}

print_critical() {
    echo -e "${RED}🚨 CRITICAL: $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - CRITICAL: $1" >> "$LOG_FILE"
}

print_warning() {
    echo -e "${YELLOW}⚠️  WARNING: $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - WARNING: $1" >> "$LOG_FILE"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - SUCCESS: $1" >> "$LOG_FILE"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - INFO: $1" >> "$LOG_FILE"
}

# ============================================================================
# PHASE 1: PRE-TRAVEL SECURITY ASSESSMENT
# ============================================================================

assess_current_security() {
    print_header "🔍 SECURITY ASSESSMENT FOR TRAVEL"
    
    mkdir -p "$BACKUP_DIR" "$SECURE_STORE"
    
    print_info "Analyzing sensitive data on system..."
    
    # Check for SSH keys
    if [[ -d ~/.ssh ]]; then
        SSH_KEYS=$(ls ~/.ssh/id_* 2>/dev/null | wc -l || echo 0)
        if [[ $SSH_KEYS -gt 0 ]]; then
            print_warning "Found $SSH_KEYS SSH key pairs - HIGH RISK for inspection"
            echo "SSH Keys found:" >> "$LOG_FILE"
            ls -la ~/.ssh/id_* >> "$LOG_FILE" 2>/dev/null || true
        fi
    fi
    
    # Check for Git configuration with sensitive info
    if git config --global --get user.email &>/dev/null; then
        GIT_EMAIL=$(git config --global --get user.email)
        print_warning "Git configured with email: $GIT_EMAIL"
        echo "Git config: $GIT_EMAIL" >> "$LOG_FILE"
    fi
    
    # Check for development projects
    if [[ -d ~/development ]]; then
        REPO_COUNT=$(find ~/development -name ".git" -type d 2>/dev/null | wc -l || echo 0)
        if [[ $REPO_COUNT -gt 0 ]]; then
            print_warning "Found $REPO_COUNT Git repositories - may contain sensitive code"
            echo "Repository count: $REPO_COUNT" >> "$LOG_FILE"
        fi
    fi
    
    # Check for cloud/docker configs
    CLOUD_CONFIGS=""
    [[ -d ~/.aws ]] && CLOUD_CONFIGS="$CLOUD_CONFIGS AWS"
    [[ -d ~/.docker ]] && CLOUD_CONFIGS="$CLOUD_CONFIGS Docker"
    [[ -d ~/.config ]] && CLOUD_CONFIGS="$CLOUD_CONFIGS Config"
    
    if [[ -n "$CLOUD_CONFIGS" ]]; then
        print_warning "Found cloud configs:$CLOUD_CONFIGS"
        echo "Cloud configs:$CLOUD_CONFIGS" >> "$LOG_FILE"
    fi
    
    # Check browser data
    if [[ -d ~/Library/Application\ Support/Google/Chrome ]]; then
        print_warning "Chrome browser data present - contains passwords, cookies, history"
    fi
    
    if [[ -d ~/Library/Application\ Support/Firefox ]]; then
        print_warning "Firefox browser data present - contains passwords, cookies, history"
    fi
    
    print_success "Security assessment completed - check $LOG_FILE for details"
}

# ============================================================================
# PHASE 2: SECURE BACKUP STRATEGY
# ============================================================================

create_secure_backups() {
    print_header "💾 CREATING SECURE BACKUPS"
    
    print_info "Creating encrypted backups of sensitive data..."
    
    # Backup SSH keys
    if [[ -d ~/.ssh ]]; then
        print_info "Backing up SSH keys..."
        tar -czf "$BACKUP_DIR/ssh_backup.tar.gz" -C ~ .ssh/
        
        # Encrypt the backup
        if command -v gpg &> /dev/null; then
            gpg --symmetric --cipher-algo AES256 --output "$BACKUP_DIR/ssh_backup.tar.gz.gpg" "$BACKUP_DIR/ssh_backup.tar.gz"
            rm "$BACKUP_DIR/ssh_backup.tar.gz"
            print_success "SSH keys backed up and encrypted"
        else
            print_warning "GPG not available - SSH backup not encrypted"
        fi
    fi
    
    # Backup Git configuration
    print_info "Backing up Git configuration..."
    git config --global --list > "$BACKUP_DIR/git_config_backup.txt" 2>/dev/null || true
    
    # Backup development projects (metadata only)
    if [[ -d ~/development ]]; then
        print_info "Creating development project inventory..."
        find ~/development -name ".git" -type d > "$BACKUP_DIR/repo_list.txt" 2>/dev/null || true
        
        # Create remote URL backup
        echo "# Git Remote URLs Backup" > "$BACKUP_DIR/git_remotes.txt"
        while IFS= read -r git_dir; do
            if [[ -n "$git_dir" ]]; then
                echo "## $(dirname "$git_dir")" >> "$BACKUP_DIR/git_remotes.txt"
                git -C "$(dirname "$git_dir")" remote -v >> "$BACKUP_DIR/git_remotes.txt" 2>/dev/null || true
                echo "" >> "$BACKUP_DIR/git_remotes.txt"
            fi
        done < "$BACKUP_DIR/repo_list.txt"
    fi
    
    # Backup security tool configurations
    if [[ -d ~/.security-monitoring ]]; then
        print_info "Backing up security configurations..."
        tar -czf "$BACKUP_DIR/security_configs.tar.gz" -C ~ .security-monitoring/ .gitleaks.toml .semgrep.yml .trivy.yaml 2>/dev/null || true
    fi
    
    print_success "Secure backups created in $BACKUP_DIR"
}

# ============================================================================
# PHASE 3: TRAVEL PREPARATION - DATA REMOVAL
# ============================================================================

prepare_for_travel() {
    print_header "🧹 PREPARING SYSTEM FOR TRAVEL"
    
    print_critical "This will remove sensitive data from your system!"
    print_warning "Ensure backups are created and stored securely before proceeding"
    
    read -p "Continue with travel preparation? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Travel preparation cancelled"
        return
    fi
    
    # Remove SSH keys (keep backup)
    if [[ -d ~/.ssh ]]; then
        print_info "Removing SSH private keys..."
        mv ~/.ssh/id_ed25519 "$SECURE_STORE/" 2>/dev/null || true
        mv ~/.ssh/id_rsa "$SECURE_STORE/" 2>/dev/null || true
        print_success "SSH private keys moved to secure storage"
    fi
    
    # Clean Git configuration
    print_info "Cleaning Git configuration..."
    git config --global --unset user.email 2>/dev/null || true
    git config --global --unset user.signingkey 2>/dev/null || true
    git config --global user.name "Travel User" 2>/dev/null || true
    git config --global user.email "user@example.com" 2>/dev/null || true
    
    # Clear browser data
    print_info "Clearing browser data..."
    
    # Chrome
    if [[ -d ~/Library/Application\ Support/Google/Chrome/Default ]]; then
        rm -rf ~/Library/Application\ Support/Google/Chrome/Default/History* 2>/dev/null || true
        rm -rf ~/Library/Application\ Support/Google/Chrome/Default/Cookies* 2>/dev/null || true
        rm -rf ~/Library/Application\ Support/Google/Chrome/Default/Login\ Data* 2>/dev/null || true
        rm -rf ~/Library/Application\ Support/Google/Chrome/Default/Web\ Data* 2>/dev/null || true
        print_success "Chrome sensitive data cleared"
    fi
    
    # Clear shell history
    print_info "Clearing shell history..."
    > ~/.zsh_history
    > ~/.bash_history 2>/dev/null || true
    history -c 2>/dev/null || true
    
    # Clear recent files
    print_info "Clearing recent file lists..."
    rm -rf ~/Library/Application\ Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.RecentDocuments.sfl* 2>/dev/null || true
    
    # Clear logs
    print_info "Clearing system logs..."
    > ~/.security-monitoring/*.log 2>/dev/null || true
    
    print_success "System prepared for travel - sensitive data removed/secured"
}

# ============================================================================
# PHASE 4: SECURE ACCESS SETUP
# ============================================================================

setup_secure_access() {
    print_header "🔐 SETTING UP SECURE REMOTE ACCESS"
    
    print_info "Creating secure access methods for travel..."
    
    # Create travel-safe browser profile
    print_info "Setting up travel-safe browser configuration..."
    
    # Create minimal Chrome profile
    TRAVEL_CHROME="$HOME/Library/Application Support/Google/Chrome/Travel"
    mkdir -p "$TRAVEL_CHROME"
    
    cat > "$TRAVEL_CHROME/Preferences" << 'EOF'
{
   "profile": {
      "default_content_setting_values": {
         "cookies": 2,
         "geolocation": 2,
         "notifications": 2,
         "plugins": 2,
         "popups": 2,
         "ppapi_broker": 2
      },
      "password_manager_enabled": false
   }
}
EOF
    
    # Create VPN connection script (for after arrival)
    cat > "$SECURE_STORE/connect_secure_vpn.sh" << 'EOF'
#!/bin/bash
# Secure VPN Connection Script
# Use this after arrival to establish secure connection

echo "🔐 Establishing secure connection..."

# Check if Mullvad is available
if command -v mullvad &> /dev/null; then
    echo "Connecting to Mullvad VPN..."
    mullvad connect
    sleep 5
    mullvad status
else
    echo "⚠️ Mullvad not found - install VPN client first"
    echo "Alternative: Use Tor Browser for secure access"
    open -a "Tor Browser" 2>/dev/null || echo "Tor Browser not installed"
fi

# Wait for connection
echo "Waiting for secure connection..."
sleep 10

# Test connection
echo "Testing connection security..."
curl -s https://am.i.mullvad.net/json | jq '.mullvad_exit_ip, .ip, .country' 2>/dev/null || curl -s https://ipinfo.io/json | jq '.ip, .country'
EOF
    chmod +x "$SECURE_STORE/connect_secure_vpn.sh"
    
    # Create secure account access guide
    cat > "$SECURE_STORE/secure_access_guide.md" << 'EOF'
# 🛡️ Secure Account Access During Travel

## ⚠️ BEFORE ACCESSING SENSITIVE ACCOUNTS

1. **Connect to VPN FIRST**
   ```bash
   ~/.secure-travel-store/connect_secure_vpn.sh
   ```

2. **Use Incognito/Private Browsing**
   - Never save passwords
   - Clear all data after each session

3. **Use 2FA/MFA Apps on Phone**
   - Authy, Google Authenticator, etc.
   - Keep phone and laptop separate when possible

## 🔐 Account Access Strategy

### High Security Accounts (Banking, Work, Personal)
- **Access Method**: VPN + Tor Browser + 2FA
- **Location**: Only from trusted locations (hotel, not public WiFi)
- **Duration**: Minimize session time
- **After Use**: Clear all browser data

### Medium Security Accounts (Social, Shopping)
- **Access Method**: VPN + Private browsing
- **2FA Required**: Always
- **Clear Data**: After each session

### Development Accounts (GitHub, Cloud)
- **Access Method**: VPN + SSH tunneling if possible
- **Use**: Temporary SSH keys, rotate after travel
- **Avoid**: Committing sensitive code while traveling

## 🚨 Emergency Procedures

### If Device is Compromised
1. Change all critical passwords from a different device
2. Revoke all active sessions
3. Contact banks/services to report potential breach
4. Reset 2FA on all accounts

### If Forced to Unlock Device
1. Comply with authorities (safety first)
2. After release, assume device is compromised
3. Follow full compromise recovery procedure
4. Reset all accounts and keys

## 📱 Phone Security
- Keep separate from laptop when crossing borders
- Use burner apps for communication
- Minimize sensitive data storage
- Regular encrypted backups to cloud

## 🏨 Location Security
- Trusted WiFi only (hotel with WPA3)
- Never use public computers
- Check for listening devices in rooms
- Use phone hotspot when possible
EOF

    # Create recovery script
    cat > "$SECURE_STORE/post_travel_recovery.sh" << 'EOF'
#!/bin/bash
# Post-Travel Recovery Script
# Restores full security configuration after safe return

echo "🔄 Starting post-travel recovery..."

# Restore SSH keys
if [[ -f ~/.secure-travel-store/id_ed25519 ]]; then
    cp ~/.secure-travel-store/id_ed25519 ~/.ssh/
    chmod 600 ~/.ssh/id_ed25519
    echo "✅ SSH keys restored"
fi

# Restore Git configuration
if [[ -f ~/.travel-security-backup/git_config_backup.txt ]]; then
    while IFS= read -r line; do
        if [[ $line == *"="* ]]; then
            key=$(echo "$line" | cut -d'=' -f1)
            value=$(echo "$line" | cut -d'=' -f2-)
            git config --global "$key" "$value"
        fi
    done < ~/.travel-security-backup/git_config_backup.txt
    echo "✅ Git configuration restored"
fi

# Restore security monitoring
if [[ -f ~/.travel-security-backup/security_configs.tar.gz ]]; then
    tar -xzf ~/.travel-security-backup/security_configs.tar.gz -C ~/
    echo "✅ Security configurations restored"
fi

echo "🎉 Recovery complete - full security restored"
echo "🔄 Recommend: Run full security scan after recovery"
EOF
    chmod +x "$SECURE_STORE/post_travel_recovery.sh"
    
    print_success "Secure access methods configured"
    print_info "Access guide created: $SECURE_STORE/secure_access_guide.md"
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    case "${1:-assessment}" in
        "assessment")
            assess_current_security
            ;;
        "backup")
            create_secure_backups
            ;;
        "prepare")
            prepare_for_travel
            ;;
        "access")
            setup_secure_access
            ;;
        "full")
            print_header "🛡️ FULL TRAVEL SECURITY PREPARATION"
            assess_current_security
            create_secure_backups
            setup_secure_access
            print_warning "Run './travel-security-prep.sh prepare' when ready to clean system"
            ;;
        *)
            echo "🛡️ Travel Security Preparation"
            echo ""
            echo "Usage: $0 [command]"
            echo ""
            echo "Commands:"
            echo "  assessment  - Analyze current security risks"
            echo "  backup      - Create secure backups"
            echo "  access      - Set up secure remote access methods"
            echo "  prepare     - Clean system for travel (DESTRUCTIVE)"
            echo "  full        - Run assessment + backup + access setup"
            echo ""
            echo "⚠️ IMPORTANT: Always run 'full' first, then 'prepare' just before travel"
            ;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi