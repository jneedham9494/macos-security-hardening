#!/bin/bash
# 1Password Domain Vault Setup
# Configure separate vaults for each security domain with proper compartmentalization

set -euo pipefail

SETUP_LOG="$HOME/.email-safety-net/1password-vault-setup.log"

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

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - SUCCESS: $1" >> "$SETUP_LOG"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - INFO: $1" >> "$SETUP_LOG"
}

print_action() {
    echo -e "${YELLOW}🔧 $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ACTION: $1" >> "$SETUP_LOG"
}

print_warning() {
    echo -e "${RED}⚠️  $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - WARNING: $1" >> "$SETUP_LOG"
}

# ============================================================================
# 1PASSWORD VAULT STRATEGY
# ============================================================================

setup_vault_strategy() {
    print_header "🔐 1PASSWORD VAULT COMPARTMENTALIZATION SETUP"
    
    cat > "$HOME/.email-safety-net/1password-vault-strategy.md" << 'EOF'
# 🔐 1PASSWORD VAULT COMPARTMENTALIZATION STRATEGY

## 🎯 GOAL: Create Isolated Security Domains
Each domain gets its own vault to prevent cross-contamination and maintain perfect separation.

## 📁 VAULT STRUCTURE:

### **🏠 Personal Domain Vault**
- **Name**: `Personal Domain`
- **Browser**: Firefox only
- **Email**: streamcode@protonmail.com
- **Contains**: 
  - Social media accounts
  - Entertainment services (Netflix, Spotify, etc.)
  - Personal shopping accounts
  - Non-sensitive personal accounts
  - Personal cloud storage

### **💰 Financial Domain Vault**  
- **Name**: `Financial Domain`
- **Browser**: Safari only
- **Email**: quietwave@tutanota.de
- **Contains**:
  - Banking accounts
  - Investment platforms
  - Credit card accounts
  - Insurance accounts
  - Tax-related accounts
  - Financial planning tools

### **🛡️ High-Security Domain Vault**
- **Name**: `High Security Domain`
- **Browser**: Brave only  
- **Email**: deepvault@protonmail.com
- **Contains**:
  - Government accounts (IRS, DMV, etc.)
  - Healthcare accounts
  - Legal/professional accounts
  - Cryptocurrency exchanges
  - VPN accounts
  - Security tools

### **✈️ Travel Domain Vault** (Future)
- **Name**: `Travel Domain`
- **Browser**: Tor Browser
- **Email**: TBD (temporary/disposable)
- **Contains**:
  - Hotel bookings
  - Flight bookings
  - Travel services
  - Temporary accounts
  - Location-sensitive accounts

### **🏢 Professional Domain Vault** (Future)
- **Name**: `Professional Domain`
- **Browser**: Chrome (if needed)
- **Email**: TBD (work/professional)
- **Contains**:
  - Work-related accounts
  - Professional networking
  - Business tools
  - Client-related accounts

## 🔐 VAULT ACCESS RULES:

### **Browser-Vault Isolation:**
```
Firefox:     Personal Domain vault ONLY
Safari:      Financial Domain vault ONLY  
Brave:       High Security Domain vault ONLY
Tor:         Travel Domain vault ONLY
Chrome:      Professional Domain vault ONLY
```

### **Critical Security Rules:**
1. **NEVER access wrong vault from wrong browser**
2. **Each browser extension limited to ONE vault**
3. **No shared passwords between vaults**
4. **Different recovery methods per vault**
5. **Separate 2FA where possible**

## 📱 MOBILE STRATEGY:

### **1Password Mobile App Configuration:**
```
Primary Access:    Personal Domain (daily use)
Financial Access:  Financial Domain (when needed)
High-Sec Access:   High Security Domain (rarely)
```

### **Mobile Compartmentalization:**
- **Different biometric profiles** if supported
- **Time-based access restrictions** for high-security
- **Separate mobile browsers** for different domains
- **App-specific vault restrictions**

## 🚨 EMERGENCY ACCESS:

### **Vault Recovery Hierarchy:**
1. **Personal Domain**: Standard recovery
2. **Financial Domain**: Enhanced recovery (backup codes)  
3. **High Security**: Maximum security recovery
4. **Travel Domain**: Disposable/minimal recovery
5. **Professional**: Company-controlled recovery

### **Recovery Method Separation:**
- **Different recovery emails** per vault
- **Different emergency contacts** where possible
- **Separate backup locations** for recovery codes
- **No single point of failure**

## 💾 BACKUP STRATEGY:

### **Vault Export Rules:**
```
Personal:     Monthly encrypted backup
Financial:    Weekly encrypted backup (air-gapped)
High-Sec:     Weekly encrypted backup (offline only)
Travel:       No permanent backup (disposable)
Professional: Company policy dependent
```

### **Storage Locations:**
- **Local encrypted drive** (primary)
- **Separate encrypted USB** (financial)
- **Safety deposit box** (high-security)
- **Secure cloud** (personal only)

## 🔍 AUDIT SCHEDULE:

### **Regular Reviews:**
```
Weekly:   Check for duplicate passwords across vaults
Monthly:  Audit vault access patterns  
Quarterly: Review and update vault assignments
Yearly:   Complete security audit of all vaults
```

### **Red Flags to Watch:**
- Passwords appearing in multiple vaults
- Cross-browser vault access
- Shared accounts between domains
- Vault access from wrong locations
- Unusual login patterns

## 🎯 IMPLEMENTATION CHECKLIST:

### **Phase 1: Vault Creation**
- [ ] Create Personal Domain vault
- [ ] Create Financial Domain vault  
- [ ] Create High Security Domain vault
- [ ] Configure vault icons/colors for easy identification

### **Phase 2: Browser Integration**
- [ ] Install 1Password extension in Firefox (Personal only)
- [ ] Install 1Password extension in Safari (Financial only)
- [ ] Install 1Password extension in Brave (High-Security only)
- [ ] Verify vault isolation per browser

### **Phase 3: Account Migration**
- [ ] Move existing accounts to appropriate vaults
- [ ] Generate new passwords for cross-vault duplicates
- [ ] Update account emails to match domain strategy
- [ ] Verify no account overlap between vaults

### **Phase 4: Security Hardening**
- [ ] Set up different recovery methods per vault
- [ ] Configure vault-specific sharing rules
- [ ] Set up monitoring and alerts
- [ ] Create backup procedures

## 🛠️ TECHNICAL IMPLEMENTATION:

### **1Password Browser Extension Settings:**
```
Firefox Extension:  Personal Domain vault only
Safari Extension:   Financial Domain vault only
Brave Extension:    High Security Domain vault only
```

### **Vault Sharing Rules:**
- **Personal**: Can share with family (limited)
- **Financial**: NO sharing (individual only)
- **High-Security**: NO sharing (individual only)
- **Travel**: Temporary sharing only
- **Professional**: Team sharing as needed

## 🔐 MASTER PASSWORD STRATEGY:

### **Unique Master Passwords:**
- **Different master password** for each vault
- **Progressive complexity** (Personal < Financial < High-Security)
- **No password reuse** between vaults
- **Secure generation** and storage methods

### **Master Password Complexity:**
```
Personal:     16+ characters, mixed complexity
Financial:    20+ characters, high complexity  
High-Security: 24+ characters, maximum complexity
```
EOF

    print_success "1Password vault strategy documentation created"
}

# ============================================================================
# STEP-BY-STEP VAULT CREATION
# ============================================================================

create_vault_guide() {
    print_header "📋 STEP-BY-STEP VAULT CREATION GUIDE"
    
    cat > "$HOME/.email-safety-net/vault-creation-steps.md" << 'EOF'
# 📋 STEP-BY-STEP 1PASSWORD VAULT CREATION

## 🎯 TODAY'S GOAL: Create 3 Primary Vaults
Create and configure Personal, Financial, and High-Security domain vaults.

## 📱 STEP 1: Open 1Password App

### **Launch 1Password:**
1. **Open 1Password app** on your Mac
2. **Sign in** if not already signed in
3. **Go to main vault view**

## 🏠 STEP 2: Create Personal Domain Vault

### **Create the Vault:**
1. **Click the "+" button** or "New Vault"
2. **Name**: `Personal Domain`
3. **Description**: `Firefox browser - Personal accounts and social media`
4. **Icon**: Choose house 🏠 or person icon
5. **Color**: Blue or green
6. **Privacy**: Private vault
7. **Click "Create Vault"**

### **Configure Personal Vault:**
1. **Set vault permissions**: Private/Individual
2. **No sharing** for now
3. **Note the vault ID** for browser extension setup

## 💰 STEP 3: Create Financial Domain Vault

### **Create the Vault:**
1. **Click "New Vault"** again
2. **Name**: `Financial Domain`
3. **Description**: `Safari browser - Banking and financial accounts`
4. **Icon**: Choose bank 🏦 or money 💰 icon
5. **Color**: Gold or orange
6. **Privacy**: Private vault
7. **Click "Create Vault"**

### **Configure Financial Vault:**
1. **Set vault permissions**: Private/Individual
2. **NO sharing allowed**
3. **Note the vault ID** for Safari extension

## 🛡️ STEP 4: Create High-Security Domain Vault

### **Create the Vault:**
1. **Click "New Vault"** again
2. **Name**: `High Security Domain`
3. **Description**: `Brave browser - Government, healthcare, crypto accounts`
4. **Icon**: Choose shield 🛡️ or lock 🔒 icon
5. **Color**: Red or dark blue
6. **Privacy**: Private vault
7. **Click "Create Vault"**

### **Configure High-Security Vault:**
1. **Set vault permissions**: Private/Individual
2. **NO sharing allowed**
3. **Enhanced security** if available
4. **Note the vault ID** for Brave extension

## 🌐 STEP 5: Configure Browser Extensions

### **Firefox - Personal Domain Only:**
1. **Open Firefox**
2. **Go to 1Password extension settings**
3. **Select vaults**: ✅ Personal Domain, ❌ All others
4. **Verify**: Only Personal Domain vault accessible in Firefox

### **Safari - Financial Domain Only:**
1. **Open Safari**
2. **Go to 1Password extension settings**  
3. **Select vaults**: ✅ Financial Domain, ❌ All others
4. **Verify**: Only Financial Domain vault accessible in Safari

### **Brave - High-Security Domain Only:**
1. **Open Brave**
2. **Go to 1Password extension settings**
3. **Select vaults**: ✅ High Security Domain, ❌ All others
4. **Verify**: Only High Security Domain vault accessible in Brave

## ✅ STEP 6: Verification Tests

### **Test Vault Isolation:**
1. **Firefox**: Confirm only Personal Domain visible
2. **Safari**: Confirm only Financial Domain visible
3. **Brave**: Confirm only High Security Domain visible

### **Test Account Access:**
1. **Create test entry** in each vault
2. **Verify browser-specific access**
3. **Confirm no cross-contamination**

## 🎯 STEP 7: Add Email Accounts to Appropriate Vaults

### **Personal Domain Vault (Firefox):**
```
Email: streamcode@protonmail.com
Password: [Your ProtonMail password]
2FA: [If enabled]
Notes: Personal domain email - Firefox access only
```

### **Financial Domain Vault (Safari):**
```
Email: quietwave@tutanota.de  
Password: [Your Tutanota password]
2FA: [If enabled]
Notes: Financial domain email - Safari access only
```

### **High-Security Domain Vault (Brave):**
```
Email: deepvault@protonmail.com
Password: [Same as personal ProtonMail]
2FA: [If enabled]  
Notes: High-security domain email - Brave access only
```

## 🚨 CRITICAL REMINDERS:

### **Vault Access Rules:**
- **NEVER** access Financial vault from Firefox
- **NEVER** access Personal vault from Safari
- **NEVER** access High-Security vault from Firefox/Safari
- **ALWAYS** use correct browser for each domain

### **Password Strategy:**
- **Unique passwords** for each email account where possible
- **No password sharing** between different domains
- **Progressive complexity** based on security level

### **Recovery Planning:**
- **Different recovery emails** for each vault
- **Separate 2FA methods** where possible
- **Document vault assignments** in secure location

## 📱 MOBILE CONFIGURATION:

### **1Password Mobile App:**
1. **Install 1Password mobile app**
2. **Sign in with same account**
3. **Configure vault access priorities**:
   - Primary: Personal Domain (daily use)
   - Secondary: Financial Domain (as needed)
   - Restricted: High Security Domain (rarely)

### **Mobile Browser Strategy:**
```
Safari Mobile:     Financial Domain access
Firefox Mobile:    Personal Domain access  
Brave Mobile:      High-Security Domain access
```

## ✅ SUCCESS CHECKLIST:

- [ ] Personal Domain vault created and configured
- [ ] Financial Domain vault created and configured
- [ ] High Security Domain vault created and configured
- [ ] Firefox extension limited to Personal Domain only
- [ ] Safari extension limited to Financial Domain only
- [ ] Brave extension limited to High Security Domain only
- [ ] All three email accounts stored in appropriate vaults
- [ ] Vault isolation verified through testing
- [ ] Mobile app configured with vault priorities

## 🎯 NEXT STEPS AFTER VAULT SETUP:
1. **Test email compartmentalization** across all browsers
2. **Begin migrating existing accounts** to appropriate vaults
3. **Set up monitoring** for cross-vault security violations
4. **Plan account audit** and migration strategy
EOF

    print_success "Step-by-step vault creation guide created"
}

# ============================================================================
# QUICK SETUP LAUNCHER
# ============================================================================

launch_1password_setup() {
    print_header "🚀 LAUNCHING 1PASSWORD VAULT SETUP"
    
    print_action "Opening 1Password app..."
    
    # Try to open 1Password app
    if command -v open &> /dev/null; then
        if [ -d "/Applications/1Password 7 - Password Manager.app" ]; then
            open -a "1Password 7 - Password Manager" &
            print_success "1Password 7 opened"
        elif [ -d "/Applications/1Password.app" ]; then
            open -a "1Password" &
            print_success "1Password opened"
        else
            print_warning "1Password app not found - please open manually"
        fi
    fi
    
    print_info "Follow the step-by-step guide to create your domain vaults"
    print_info "Remember: Each vault should only be accessible from its designated browser"
    
    cat << 'EOF'

🎯 TODAY'S VAULT CREATION GOALS:

1. 🏠 Create "Personal Domain" vault (Firefox access)
2. 💰 Create "Financial Domain" vault (Safari access)  
3. 🛡️ Create "High Security Domain" vault (Brave access)
4. 🌐 Configure browser extensions for vault isolation
5. ✅ Test that each browser only sees its designated vault

📋 Follow the detailed guide in vault-creation-steps.md

EOF
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    case "${1:-setup}" in
        "strategy")
            setup_vault_strategy
            ;;
        "guide")
            create_vault_guide
            ;;
        "launch")
            launch_1password_setup
            ;;
        "setup"|"all")
            setup_vault_strategy
            create_vault_guide
            launch_1password_setup
            ;;
        *)
            echo "🔐 1Password Domain Vault Setup"
            echo ""
            echo "Usage: $0 [command]"
            echo ""
            echo "Commands:"
            echo "  strategy  - Create vault compartmentalization strategy"
            echo "  guide     - Create step-by-step vault creation guide"
            echo "  launch    - Open 1Password and launch setup process"
            echo "  setup     - All of the above (recommended)"
            ;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi