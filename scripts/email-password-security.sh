#!/bin/bash
# Email & Password Manager Travel Security Script
# Mitigates risks from single email dependency and password manager exposure

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EMAIL_BACKUP_DIR="$HOME/.travel-security-backup/email"
PASSWORD_BACKUP_DIR="$HOME/.travel-security-backup/passwords"
LOG_FILE="$HOME/.travel-security-backup/email-password-prep.log"

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
# EMAIL RISK ASSESSMENT
# ============================================================================

assess_email_risks() {
    print_header "📧 EMAIL SECURITY RISK ASSESSMENT"
    
    mkdir -p "$EMAIL_BACKUP_DIR" "$PASSWORD_BACKUP_DIR"
    
    print_critical "Single email address creates MASSIVE attack surface!"
    
    # Check for common email patterns
    PRIMARY_EMAIL=""
    if git config --global --get user.email &>/dev/null; then
        PRIMARY_EMAIL=$(git config --global --get user.email)
        print_warning "Primary email detected: $PRIMARY_EMAIL"
        echo "Primary email: $PRIMARY_EMAIL" >> "$LOG_FILE"
        
        # Analyze email domain for risk level
        DOMAIN=$(echo "$PRIMARY_EMAIL" | cut -d'@' -f2)
        case "$DOMAIN" in
            "example.com"|"*.corp"|"*.company.com")
                print_critical "CORPORATE EMAIL DETECTED - Extremely high risk for inspection"
                echo "Corporate email risk: CRITICAL" >> "$LOG_FILE"
                ;;
            "gmail.com"|"outlook.com"|"yahoo.com")
                print_warning "Consumer email service - High visibility, well-known to authorities"
                echo "Consumer email risk: HIGH" >> "$LOG_FILE"
                ;;
            "protonmail.com"|"tutanota.com"|"fastmail.com")
                print_warning "Privacy-focused email - May raise suspicion during inspection"
                echo "Privacy email risk: MEDIUM-HIGH" >> "$LOG_FILE"
                ;;
            *)
                print_info "Custom domain email - Lower profile but still risky"
                echo "Custom domain risk: MEDIUM" >> "$LOG_FILE"
                ;;
        esac
    fi
    
    # Check mail applications
    print_info "Checking email applications..."
    
    if [[ -d ~/Library/Mail ]]; then
        MAIL_ACCOUNTS=$(find ~/Library/Mail -name "*.mbox" 2>/dev/null | wc -l || echo 0)
        if [[ $MAIL_ACCOUNTS -gt 0 ]]; then
            print_warning "Apple Mail configured with $MAIL_ACCOUNTS account(s) - Contains full email history"
            echo "Apple Mail accounts: $MAIL_ACCOUNTS" >> "$LOG_FILE"
        fi
    fi
    
    if [[ -d ~/Library/Application\ Support/Microsoft\ Outlook ]]; then
        print_warning "Microsoft Outlook detected - Likely contains corporate email"
        echo "Outlook detected: YES" >> "$LOG_FILE"
    fi
    
    print_success "Email risk assessment completed"
}

# ============================================================================
# PASSWORD MANAGER RISK ASSESSMENT  
# ============================================================================

assess_password_manager_risks() {
    print_header "🔐 PASSWORD MANAGER RISK ASSESSMENT"
    
    print_critical "Password manager = Single point of failure for ALL accounts!"
    
    # Check for common password managers
    PASSWORD_MANAGERS_FOUND=""
    
    # 1Password
    if [[ -d ~/Library/Application\ Support/1Password* ]] || [[ -d ~/Library/Group\ Containers/2BUA8C4S2C.com.1password* ]]; then
        print_warning "1Password detected - Contains ALL account credentials"
        PASSWORD_MANAGERS_FOUND="$PASSWORD_MANAGERS_FOUND 1Password"
        echo "1Password: DETECTED" >> "$LOG_FILE"
    fi
    
    # Bitwarden
    if [[ -d ~/Library/Application\ Support/Bitwarden* ]]; then
        print_warning "Bitwarden detected - Contains ALL account credentials"
        PASSWORD_MANAGERS_FOUND="$PASSWORD_MANAGERS_FOUND Bitwarden"
        echo "Bitwarden: DETECTED" >> "$LOG_FILE"
    fi
    
    # LastPass
    if [[ -d ~/Library/Application\ Support/LastPass* ]]; then
        print_warning "LastPass detected - Contains ALL account credentials"
        PASSWORD_MANAGERS_FOUND="$PASSWORD_MANAGERS_FOUND LastPass"
        echo "LastPass: DETECTED" >> "$LOG_FILE"
    fi
    
    # Dashlane
    if [[ -d ~/Library/Application\ Support/Dashlane* ]]; then
        print_warning "Dashlane detected - Contains ALL account credentials"  
        PASSWORD_MANAGERS_FOUND="$PASSWORD_MANAGERS_FOUND Dashlane"
        echo "Dashlane: DETECTED" >> "$LOG_FILE"
    fi
    
    # Keychain Access (built-in)
    KEYCHAIN_ITEMS=$(security dump-keychain -d 2>/dev/null | grep -c "keychain:" || echo "Unable to count")
    if [[ "$KEYCHAIN_ITEMS" != "Unable to count" ]]; then
        print_warning "macOS Keychain contains saved passwords - Accessible if unlocked"
        echo "Keychain items: $KEYCHAIN_ITEMS" >> "$LOG_FILE"
    fi
    
    if [[ -n "$PASSWORD_MANAGERS_FOUND" ]]; then
        print_critical "Password managers found:$PASSWORD_MANAGERS_FOUND"
        print_critical "If unlocked during inspection = TOTAL COMPROMISE"
    else
        print_info "No major password manager applications detected"
    fi
    
    print_success "Password manager risk assessment completed"
}

# ============================================================================
# EMERGENCY TRAVEL MITIGATION
# ============================================================================

create_emergency_mitigation() {
    print_header "🛡️ EMERGENCY TRAVEL MITIGATION STRATEGY"
    
    print_info "Creating emergency protocols for email and password security..."
    
    # Create travel email strategy
    cat > "$EMAIL_BACKUP_DIR/travel_email_strategy.md" << 'EOF'
# 🚨 EMERGENCY EMAIL & PASSWORD TRAVEL STRATEGY

## CRITICAL RISKS IDENTIFIED:
- Single email address = Master key to ALL accounts
- Password manager = Instant access to EVERYTHING
- Corporate email mixing with personal accounts
- No account recovery independence

## IMMEDIATE PRE-TRAVEL ACTIONS:

### EMAIL STRATEGY:

#### 1. CREATE BURNER EMAIL (DO TODAY):
```
Service: ProtonMail or Tutanota
Purpose: Travel-only communications
Usage: Hotel bookings, local services, temporary accounts
Never: Banking, work, or sensitive accounts
```

#### 2. BACKUP CRITICAL RECOVERY CODES:
```
Export from password manager:
- 2FA backup codes for ALL critical accounts
- Account recovery questions/answers
- Emergency contact information
- Backup authentication methods

Store separately from devices (encrypted cloud, trusted contact)
```

#### 3. SET UP RECOVERY INDEPENDENCE:
```
Critical accounts should have:
- Multiple recovery email addresses
- Phone number recovery (different from primary)
- Trusted contact recovery where available
- Hardware security keys where possible
```

### PASSWORD MANAGER STRATEGY:

#### 1. TRAVEL VAULT CREATION:
```
Create separate "Travel" vault containing ONLY:
- Essential travel accounts (airline, hotel, ride-share)
- Burner email credentials
- Emergency contact information
- Medical/insurance information

EXCLUDE from travel vault:
- Banking, investment, crypto accounts
- Work/corporate credentials  
- Social media accounts
- Shopping/e-commerce accounts
```

#### 2. SECURE BACKUP METHODS:
```
Export critical passwords to encrypted file:
- Banking institutions (top 3-5 most critical)
- Work accounts (absolute minimum needed)
- Recovery accounts (password reset emails)

Store backup separately from password manager
```

#### 3. EMERGENCY ACCESS PROTOCOLS:
```
If forced to unlock password manager:
- Reveal ONLY travel vault
- "I keep minimal passwords on travel devices"
- "Banking and work accounts are not synced for security"
- Have explanation ready for limited access
```

## BORDER INSPECTION PROTOCOLS:

### EMAIL ACCESS:
- Only access burner email during inspection if required
- Never voluntarily show primary email application
- "I use web email when traveling for security"

### PASSWORD MANAGER:
- If forced to unlock, show only travel vault
- "I don't sync sensitive accounts to travel devices"
- "Banking passwords are kept separately for security"

## POST-INSPECTION RECOVERY:

### If Primary Email Accessed:
1. Change passwords for ALL accounts immediately
2. Check login history for unauthorized access
3. Revoke active sessions on all services
4. Enable additional security features
5. Consider changing primary email if heavily compromised

### If Password Manager Accessed:
1. Change ALL revealed passwords immediately
2. Assume full account compromise
3. Check account activity across all services
4. Revoke active sessions everywhere
5. Re-enable 2FA on all accounts
6. Consider new password manager instance

## LONG-TERM SECURITY IMPROVEMENTS:

### Email Security:
- Create separate emails for different purposes:
  - Personal: friends, family, personal services
  - Financial: banking, investments, insurance
  - Shopping: e-commerce, subscriptions
  - Work: corporate accounts only
  - Recovery: backup email for password resets

### Password Manager Security:
- Use multiple vaults/collections for different purposes
- Separate work and personal completely
- Use hardware security keys where possible
- Regular security audits and password rotation

## EMERGENCY CONTACTS:
- Legal: [Your attorney contact info]
- Work: [IT security team if corporate device]
- Family: [Emergency contact who can help with accounts]
- Technical: [Trusted friend who understands your setup]
EOF

    # Create password backup script
    cat > "$PASSWORD_BACKUP_DIR/emergency_password_export.sh" << 'EOF'
#!/bin/bash
# Emergency Password Export for Travel
# Creates secure backup of critical passwords

echo "🚨 EMERGENCY PASSWORD BACKUP"
echo "This will create encrypted backup of critical passwords"
echo ""

# Create encrypted backup directory
BACKUP_DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="critical_passwords_$BACKUP_DATE.txt"
ENCRYPTED_FILE="$BACKUP_FILE.gpg"

echo "📝 Manual Password Backup Required:"
echo "1. Open your password manager"
echo "2. Export ONLY these critical accounts to $BACKUP_FILE:"
echo "   - Primary email account"
echo "   - Top 3 bank accounts"
echo "   - Work/corporate login"
echo "   - Password manager master password"
echo "   - 2FA app backup codes"
echo ""
echo "3. Encrypt the file:"
echo "   gpg --symmetric --cipher-algo AES256 $BACKUP_FILE"
echo ""
echo "4. Store encrypted file separately from devices"
echo "5. Delete plaintext file: rm $BACKUP_FILE"
echo ""
echo "⚠️ NEVER store this backup on the same device as your password manager!"
EOF

    chmod +x "$PASSWORD_BACKUP_DIR/emergency_password_export.sh"
    
    # Create account audit script
    cat > "$EMAIL_BACKUP_DIR/account_audit.sh" << 'EOF'
#!/bin/bash
# Critical Account Audit for Travel Security

echo "🔍 CRITICAL ACCOUNT AUDIT"
echo "Review each category and take action:"
echo ""

echo "🏦 FINANCIAL ACCOUNTS (Change recovery emails, add backup 2FA):"
echo "- Primary bank account"
echo "- Credit card accounts"  
echo "- Investment/retirement accounts"
echo "- PayPal/digital payment services"
echo "- Cryptocurrency exchanges"
echo ""

echo "💼 WORK ACCOUNTS (Separate from personal email):"
echo "- Corporate email/Office 365"
echo "- VPN access"
echo "- Cloud services (AWS, Azure, etc.)"
echo "- Code repositories (GitHub, GitLab)"
echo "- Internal company systems"
echo ""

echo "🔐 SECURITY ACCOUNTS (Critical for recovery):"
echo "- Primary email provider"
echo "- Password manager account"
echo "- 2FA app accounts (Authy, Google)"
echo "- Cloud backup services"
echo "- Domain registrar accounts"
echo ""

echo "📱 PERSONAL ACCOUNTS (Consider separate recovery):"
echo "- Social media accounts"
echo "- Shopping/e-commerce"
echo "- Streaming services"
echo "- Cloud storage (Google Drive, Dropbox)"
echo "- Subscription services"
echo ""

echo "✅ ACTION ITEMS:"
echo "1. Add secondary recovery email to critical accounts"
echo "2. Enable SMS backup for 2FA where possible"
echo "3. Download and store backup codes"
echo "4. Test recovery process for top 5 most critical accounts"
echo "5. Document emergency contact procedures"
EOF

    chmod +x "$EMAIL_BACKUP_DIR/account_audit.sh"
    
    print_success "Emergency mitigation strategy created"
    print_warning "Review all files in $EMAIL_BACKUP_DIR and $PASSWORD_BACKUP_DIR"
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    case "${1:-assessment}" in
        "assessment"|"assess")
            assess_email_risks
            assess_password_manager_risks
            ;;
        "mitigation"|"emergency")
            create_emergency_mitigation
            ;;
        "full")
            print_header "🚨 FULL EMAIL & PASSWORD SECURITY ASSESSMENT"
            assess_email_risks
            assess_password_manager_risks  
            create_emergency_mitigation
            print_critical "IMMEDIATE ACTION REQUIRED - Review all generated files!"
            ;;
        *)
            echo "🚨 Email & Password Manager Travel Security"
            echo ""
            echo "Usage: $0 [command]"
            echo ""
            echo "Commands:"
            echo "  assessment  - Analyze email and password manager risks"
            echo "  mitigation  - Create emergency travel protocols"
            echo "  full        - Run complete assessment and create mitigation"
            echo ""
            echo "⚠️ CRITICAL: Single email + password manager = TOTAL COMPROMISE RISK"
            ;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi