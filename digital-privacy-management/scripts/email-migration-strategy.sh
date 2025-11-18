#!/bin/bash
# Email Migration & Identity Compartmentalization Strategy
# Safely transition from single email to domain-separated emails

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MIGRATION_LOG="$HOME/.email-migration.log"
ACCOUNT_AUDIT_DIR="$HOME/.account-audit"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
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
    echo "$(date '+%Y-%m-%d %H:%M:%S') - CRITICAL: $1" >> "$MIGRATION_LOG"
}

print_warning() {
    echo -e "${YELLOW}⚠️  WARNING: $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - WARNING: $1" >> "$MIGRATION_LOG"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - SUCCESS: $1" >> "$MIGRATION_LOG"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - INFO: $1" >> "$MIGRATION_LOG"
}

print_action() {
    echo -e "${PURPLE}🔧 $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ACTION: $1" >> "$MIGRATION_LOG"
}

# ============================================================================
# CURRENT EMAIL ANALYSIS
# ============================================================================

analyze_current_setup() {
    print_header "📧 CURRENT EMAIL ANALYSIS"
    
    mkdir -p "$ACCOUNT_AUDIT_DIR"
    
    # Get current email from git config
    CURRENT_EMAIL=""
    if git config --global --get user.email &>/dev/null; then
        CURRENT_EMAIL=$(git config --global --get user.email)
        print_warning "Git email detected: $CURRENT_EMAIL"
        print_info "NOTE: User confirmed not actively using normal email on this laptop"
        echo "Git email: $CURRENT_EMAIL (not actively used)" >> "$MIGRATION_LOG"
    else
        print_success "No git email configured - clean laptop setup!"
    fi
    
    # Analyze current email domain
    if [[ -n "$CURRENT_EMAIL" ]]; then
        DOMAIN=$(echo "$CURRENT_EMAIL" | cut -d'@' -f2)
        USERNAME=$(echo "$CURRENT_EMAIL" | cut -d'@' -f1)
        
        print_info "Domain: $DOMAIN"
        print_info "Username: $USERNAME"
        
        # Risk assessment based on domain
        case "$DOMAIN" in
            "example.com"|*.corp|*.company.com)
                print_critical "CORPORATE EMAIL - High risk for personal use!"
                RISK_LEVEL="CRITICAL"
                ;;
            "gmail.com"|"outlook.com"|"yahoo.com"|"hotmail.com")
                print_warning "Consumer email - High tracking/surveillance risk"
                RISK_LEVEL="HIGH"
                ;;
            "protonmail.com"|"tutanota.com"|"fastmail.com")
                print_info "Privacy-focused email - Good foundation"
                RISK_LEVEL="MEDIUM"
                ;;
            *)
                print_info "Custom domain - Moderate risk"
                RISK_LEVEL="MEDIUM"
                ;;
        esac
        
        echo "Current email risk level: $RISK_LEVEL" >> "$MIGRATION_LOG"
    fi
    
    print_success "Email analysis completed"
}

# ============================================================================
# EMAIL DOMAIN SETUP STRATEGY
# ============================================================================

create_email_strategy() {
    print_header "🎯 EMAIL DOMAIN SETUP STRATEGY"
    
    cat > "$ACCOUNT_AUDIT_DIR/email-domain-plan.md" << 'EOF'
# 📧 EMAIL DOMAIN SETUP STRATEGY

## PHASE 1: NEW EMAIL CREATION (Week 1)

### 1. Personal Domain Email
**Recommended**: ProtonMail or Tutanota
- Purpose: Social media, entertainment, personal shopping
- Security: Medium (standard 2FA)
- Recovery: Personal phone + trusted contact

### 2. Financial Domain Email  
**Recommended**: Different provider than personal (Tutanota if using ProtonMail)
- Purpose: Banking, investments, insurance
- Security: High (hardware 2FA)
- Recovery: Secure phone + bank verification

### 3. Professional Domain Email
**Options**: 
- Keep current work email for work only
- Create separate professional email for LinkedIn, certifications
- Security: Corporate standards
- Recovery: IT department + personal backup

### 4. High-Security Domain Email
**Recommended**: ProtonMail with custom domain (most secure)
- Purpose: Crypto, privacy tools, sensitive communications
- Security: Maximum (hardware keys + air-gapped backup)
- Recovery: Multiple secure methods + trusted contacts

### 5. Travel/Disposable Domain
**Recommended**: Guerrilla Mail, 10-minute mail, or similar
- Purpose: Temporary accounts, travel bookings
- Security: Minimal (disposable)
- Recovery: None (by design)

## PHASE 2: ACCOUNT DISCOVERY & CATEGORIZATION (Week 2)

### Audit Strategy:
1. **Email Search**: Search current email for account signup confirmations
2. **Password Manager**: Export all saved accounts
3. **Browser History**: Check frequently visited sites
4. **Phone Apps**: List all apps requiring accounts
5. **Manual Memory**: Think through all services you use

### Categorization Criteria:
- **CRITICAL**: Banking, work, primary communications
- **HIGH**: Investment, insurance, important personal
- **MEDIUM**: Shopping, entertainment, social media
- **LOW**: Newsletters, temporary services, old accounts

## PHASE 3: MIGRATION PRIORITY (Week 3-4)

### Migration Order:
1. **STOP using current email for NEW accounts immediately**
2. **Create all new domain emails**
3. **Migrate CRITICAL accounts first** (banking, work recovery)
4. **Migrate HIGH priority** (investments, important personal)
5. **Migrate MEDIUM priority** (shopping, social media)
6. **DELETE or abandon LOW priority** accounts

### Migration Process Per Account:
1. Log into account with current email
2. Update email address to appropriate domain email
3. Verify new email address
4. Test login with new email
5. Update password manager entry
6. Update 2FA if needed
7. Mark as completed in tracking sheet

## PHASE 4: LEGACY EMAIL TRANSITION (Month 2)

### Current Email Future:
- **Keep active** for 6-12 months minimum
- **Set up forwarding** to appropriate domain emails
- **Monitor** for any missed accounts
- **Gradually phase out** as confidence grows
- **Eventually close** or convert to backup/archive only

### Security During Transition:
- Never access multiple domains from same browser
- Use appropriate browser for each domain
- Keep separate password manager vaults
- Monitor all emails for security alerts
- Document everything for audit trail
EOF

    print_success "Email domain strategy created"
}

# ============================================================================
# ACCOUNT DISCOVERY TOOLS
# ============================================================================

create_account_discovery_tools() {
    print_header "🔍 ACCOUNT DISCOVERY TOOLS"
    
    # Create account audit spreadsheet template
    cat > "$ACCOUNT_AUDIT_DIR/account-audit-template.csv" << 'EOF'
Service Name,Current Email,Account Type,Priority,Domain Assignment,Migration Status,Notes
Gmail,current@email.com,Email,CRITICAL,Keep as backup,PENDING,Primary email service
Facebook,current@email.com,Social,MEDIUM,Personal Domain,PENDING,Social media
Bank of America,current@email.com,Financial,CRITICAL,Financial Domain,PENDING,Primary bank
Amazon,current@email.com,Shopping,MEDIUM,Personal Domain,PENDING,Personal shopping
Work Email,work@company.com,Professional,CRITICAL,Professional Domain,KEEP,Work-provided
Netflix,current@email.com,Entertainment,MEDIUM,Personal Domain,PENDING,Streaming service
Coinbase,current@email.com,Crypto,HIGH,High-Security Domain,PENDING,Cryptocurrency
LinkedIn,current@email.com,Professional,HIGH,Professional Domain,PENDING,Professional network
iPhone/iCloud,current@email.com,System,CRITICAL,Personal Domain,PENDING,Apple ecosystem
Password Manager,current@email.com,Security,CRITICAL,High-Security Domain,PENDING,Security tool
EOF

    # Create email search script
    cat > "$ACCOUNT_AUDIT_DIR/discover-accounts.sh" << 'EOF'
#!/bin/bash
# Account Discovery Helper Script

echo "🔍 ACCOUNT DISCOVERY CHECKLIST"
echo ""

echo "📧 EMAIL SEARCH METHODS:"
echo "1. Search current email for 'welcome', 'account created', 'verify'"
echo "2. Search for 'password reset', 'security alert', 'login'"
echo "3. Search for 'subscription', 'billing', 'payment'"
echo "4. Search for company names: 'amazon', 'google', 'microsoft', etc."
echo ""

echo "🔐 PASSWORD MANAGER EXPORT:"
echo "1. Open your current password manager"
echo "2. Export all passwords to CSV/JSON"
echo "3. Review each entry for domain categorization"
echo "4. DO NOT delete original entries yet"
echo ""

echo "🌐 BROWSER ANALYSIS:"
echo "1. Check browser saved passwords"
echo "2. Review bookmark folders"
echo "3. Check browser history for frequent sites"
echo "4. Look at browser extensions and their logins"
echo ""

echo "📱 MOBILE APP AUDIT:"
echo "1. List all apps on phone requiring accounts"
echo "2. Check which apps sync with email"
echo "3. Review app store purchase history"
echo "4. Check for apps with saved login credentials"
echo ""

echo "🏦 FINANCIAL SERVICES:"
echo "1. Banks and credit unions"
echo "2. Credit card accounts"
echo "3. Investment platforms (Robinhood, Schwab, etc.)"
echo "4. Insurance companies"
echo "5. Tax services (TurboTax, H&R Block)"
echo "6. Cryptocurrency exchanges"
echo ""

echo "💼 PROFESSIONAL SERVICES:"
echo "1. Work email and corporate systems"
echo "2. LinkedIn and professional networks"
echo "3. Cloud services (AWS, Azure, Google Cloud)"
echo "4. Development tools (GitHub, GitLab)"
echo "5. Design tools (Adobe, Figma)"
echo "6. Communication tools (Slack, Teams)"
echo ""

echo "🎭 PERSONAL SERVICES:"
echo "1. Social media (Facebook, Twitter, Instagram)"
echo "2. Entertainment (Netflix, Spotify, YouTube)"
echo "3. Shopping (Amazon, eBay, online stores)"
echo "4. Dating apps and social platforms"
echo "5. Gaming platforms and accounts"
echo "6. Cloud storage (Google Drive, Dropbox)"
echo ""

echo "📋 DOCUMENTATION:"
echo "1. Add each discovered account to account-audit-template.csv"
echo "2. Categorize by domain (Personal/Financial/Professional/High-Security/Travel)"
echo "3. Set priority (CRITICAL/HIGH/MEDIUM/LOW)"
echo "4. Plan migration order"
echo ""

echo "✅ Start with the CSV template and work through each category systematically!"
EOF

    chmod +x "$ACCOUNT_AUDIT_DIR/discover-accounts.sh"
    print_success "Account discovery tools created"
}

# ============================================================================
# MIGRATION TRACKING SYSTEM
# ============================================================================

create_migration_tracking() {
    print_header "📊 MIGRATION TRACKING SYSTEM"
    
    # Create migration checklist
    cat > "$ACCOUNT_AUDIT_DIR/migration-checklist.md" << 'EOF'
# 📋 EMAIL MIGRATION CHECKLIST

## PRE-MIGRATION SETUP

### New Email Accounts Created:
- [ ] Personal Domain Email (ProtonMail/Tutanota)
- [ ] Financial Domain Email (Different provider)
- [ ] Professional Domain Email (If needed)
- [ ] High-Security Domain Email (Most secure provider)
- [ ] Travel Domain Setup (Disposable services)

### Security Setup:
- [ ] 2FA enabled on all new email accounts
- [ ] Recovery methods configured (phone, backup codes)
- [ ] Email forwarding rules set up (if needed)
- [ ] Browser compartmentalization verified

## MIGRATION EXECUTION

### Phase 1: Critical Accounts (Week 1)
- [ ] Primary bank account
- [ ] Credit card accounts
- [ ] Investment accounts
- [ ] Work-related accounts
- [ ] Primary phone/mobile account
- [ ] Password manager account
- [ ] Primary cloud storage

### Phase 2: High Priority (Week 2)
- [ ] Insurance accounts
- [ ] Cryptocurrency exchanges
- [ ] Secondary financial services
- [ ] Professional networking (LinkedIn)
- [ ] Important subscription services
- [ ] Tax and legal services

### Phase 3: Medium Priority (Week 3)
- [ ] Social media accounts
- [ ] Entertainment services (Netflix, Spotify)
- [ ] Shopping accounts (Amazon, etc.)
- [ ] Gaming platforms
- [ ] Non-critical cloud services
- [ ] Newsletter subscriptions

### Phase 4: Low Priority (Week 4)
- [ ] Old/unused accounts (consider deleting)
- [ ] Temporary service accounts
- [ ] Marketing/promotional accounts
- [ ] Test accounts and demos

## POST-MIGRATION VERIFICATION

### Security Checks:
- [ ] All critical accounts accessible with new emails
- [ ] 2FA working on migrated accounts
- [ ] Password manager updated with new credentials
- [ ] Recovery methods tested
- [ ] No orphaned accounts with old email

### Monitoring Setup:
- [ ] Breach monitoring for all new emails
- [ ] Security alerts configured
- [ ] Account activity monitoring enabled
- [ ] Regular security audit scheduled

## LEGACY EMAIL MANAGEMENT

### Current Email Transition:
- [ ] Forwarding rules configured
- [ ] Regular monitoring for missed accounts
- [ ] Gradual reduction of usage
- [ ] Archive important historical emails
- [ ] Plan for eventual closure/conversion

### Emergency Procedures:
- [ ] Emergency contact list updated
- [ ] Backup communication methods established
- [ ] Recovery procedures documented
- [ ] Security incident response plan ready
EOF

    # Create migration progress tracker
    cat > "$ACCOUNT_AUDIT_DIR/track-progress.sh" << 'EOF'
#!/bin/bash
# Migration Progress Tracker

echo "📊 EMAIL MIGRATION PROGRESS TRACKER"
echo ""

if [[ -f "$HOME/.account-audit/account-audit-template.csv" ]]; then
    TOTAL_ACCOUNTS=$(tail -n +2 "$HOME/.account-audit/account-audit-template.csv" | wc -l)
    COMPLETED=$(tail -n +2 "$HOME/.account-audit/account-audit-template.csv" | grep -c "COMPLETED" || echo 0)
    PENDING=$(tail -n +2 "$HOME/.account-audit/account-audit-template.csv" | grep -c "PENDING" || echo 0)
    
    echo "📈 PROGRESS SUMMARY:"
    echo "Total Accounts: $TOTAL_ACCOUNTS"
    echo "Completed: $COMPLETED"
    echo "Pending: $PENDING"
    echo "Progress: $((COMPLETED * 100 / TOTAL_ACCOUNTS))%"
    echo ""
    
    echo "📋 BY PRIORITY:"
    echo "Critical: $(grep "CRITICAL" "$HOME/.account-audit/account-audit-template.csv" | wc -l) accounts"
    echo "High: $(grep "HIGH" "$HOME/.account-audit/account-audit-template.csv" | wc -l) accounts"
    echo "Medium: $(grep "MEDIUM" "$HOME/.account-audit/account-audit-template.csv" | wc -l) accounts"
    echo "Low: $(grep "LOW" "$HOME/.account-audit/account-audit-template.csv" | wc -l) accounts"
    echo ""
    
    echo "🎯 NEXT ACTIONS:"
    echo "Review account-audit-template.csv and update migration status"
    echo "Focus on CRITICAL accounts first"
    echo "Use appropriate browser for each domain"
else
    echo "❌ Account audit file not found"
    echo "Run discover-accounts.sh first to create the tracking file"
fi
EOF

    chmod +x "$ACCOUNT_AUDIT_DIR/track-progress.sh"
    print_success "Migration tracking system created"
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    case "${1:-analyze}" in
        "analyze")
            analyze_current_setup
            ;;
        "strategy")
            create_email_strategy
            ;;
        "discover")
            create_account_discovery_tools
            "$ACCOUNT_AUDIT_DIR/discover-accounts.sh"
            ;;
        "tracking")
            create_migration_tracking
            ;;
        "progress")
            "$ACCOUNT_AUDIT_DIR/track-progress.sh"
            ;;
        "full")
            print_header "🚀 COMPLETE EMAIL MIGRATION PLANNING"
            analyze_current_setup
            create_email_strategy
            create_account_discovery_tools
            create_migration_tracking
            
            print_success "Email migration strategy completed!"
            print_warning "Review all files in $ACCOUNT_AUDIT_DIR"
            print_info "Start with: $ACCOUNT_AUDIT_DIR/discover-accounts.sh"
            ;;
        *)
            echo "📧 Email Migration & Identity Strategy"
            echo ""
            echo "Usage: $0 [command]"
            echo ""
            echo "Commands:"
            echo "  analyze    - Analyze current email setup"
            echo "  strategy   - Create email domain strategy"
            echo "  discover   - Run account discovery tools"
            echo "  tracking   - Set up migration tracking"
            echo "  progress   - Check migration progress"
            echo "  full       - Complete migration planning (default)"
            ;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi