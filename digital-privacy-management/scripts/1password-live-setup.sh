#!/bin/bash
# 1Password Live Vault Setup Guide
# Step-by-step vault creation with email password storage

set -euo pipefail

SETUP_LOG="$HOME/.email-safety-net/1password-live-setup.log"

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

print_step() {
    echo -e "${YELLOW}🔧 STEP $1${NC}"
}

print_action() {
    echo -e "${BLUE}📋 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - SUCCESS: $1" >> "$SETUP_LOG"
}

print_important() {
    echo -e "${RED}🚨 $1${NC}"
}

# ============================================================================
# LIVE VAULT CREATION GUIDE
# ============================================================================

vault_creation_walkthrough() {
    print_header "🔐 LIVE 1PASSWORD VAULT CREATION WALKTHROUGH"
    
    print_step "1: CREATE PERSONAL DOMAIN VAULT"
    print_action "In your 1Password app:"
    echo "   1. Click the '+' button or 'New Vault'"
    echo "   2. Name: Personal Domain"
    echo "   3. Description: Firefox browser - Personal accounts and social media"
    echo "   4. Icon: 🏠 House or 👤 Person"
    echo "   5. Color: Blue or Green"
    echo "   6. Privacy: Private vault"
    echo "   7. Click 'Create Vault'"
    echo ""
    
    read -p "✅ Press ENTER when Personal Domain vault is created..."
    print_success "Personal Domain vault created"
    
    print_step "2: CREATE FINANCIAL DOMAIN VAULT"
    print_action "In your 1Password app:"
    echo "   1. Click 'New Vault' again"
    echo "   2. Name: Financial Domain"
    echo "   3. Description: Safari browser - Banking and financial accounts"
    echo "   4. Icon: 🏦 Bank or 💰 Money"
    echo "   5. Color: Gold or Orange"
    echo "   6. Privacy: Private vault"
    echo "   7. Click 'Create Vault'"
    echo ""
    
    read -p "✅ Press ENTER when Financial Domain vault is created..."
    print_success "Financial Domain vault created"
    
    print_step "3: CREATE HIGH-SECURITY DOMAIN VAULT"
    print_action "In your 1Password app:"
    echo "   1. Click 'New Vault' again"
    echo "   2. Name: High Security Domain"
    echo "   3. Description: Brave browser - Government, healthcare, crypto accounts"
    echo "   4. Icon: 🛡️ Shield or 🔒 Lock"
    echo "   5. Color: Red or Dark Blue"
    echo "   6. Privacy: Private vault"
    echo "   7. Click 'Create Vault'"
    echo ""
    
    read -p "✅ Press ENTER when High Security Domain vault is created..."
    print_success "High Security Domain vault created"
    
    print_step "4: VERIFY ALL VAULTS EXIST"
    print_action "Check that you now see these vaults in 1Password:"
    echo "   ✅ Personal Domain (🏠)"
    echo "   ✅ Financial Domain (🏦)"
    echo "   ✅ High Security Domain (🛡️)"
    echo "   ✅ Private (default vault - can ignore for now)"
    echo ""
    
    read -p "✅ Press ENTER when you can see all three vaults..."
    print_success "All domain vaults verified"
}

# ============================================================================
# EMAIL PASSWORD STORAGE
# ============================================================================

store_email_passwords() {
    print_header "📧 STORING EMAIL PASSWORDS IN CORRECT VAULTS"
    
    print_step "5: ADD PERSONAL EMAIL TO PERSONAL DOMAIN VAULT"
    print_action "Let's add your ProtonMail personal account:"
    echo ""
    echo "   1. Select 'Personal Domain' vault"
    echo "   2. Click '+' to add new item"
    echo "   3. Choose 'Login' type"
    echo "   4. Title: ProtonMail Personal"
    echo "   5. Website: https://mail.protonmail.com"
    echo "   6. Username: streamcode@protonmail.com"
    echo "   7. Password: [Enter your ProtonMail password]"
    echo "   8. Notes: Personal domain email - Firefox access only"
    echo "   9. Save the item"
    echo ""
    
    read -p "✅ Press ENTER when ProtonMail Personal is saved in Personal Domain vault..."
    print_success "ProtonMail Personal account stored in Personal Domain vault"
    
    print_step "6: ADD FINANCIAL EMAIL TO FINANCIAL DOMAIN VAULT"
    print_action "Let's add your Tutanota account:"
    echo ""
    echo "   1. Select 'Financial Domain' vault"
    echo "   2. Click '+' to add new item"
    echo "   3. Choose 'Login' type"
    echo "   4. Title: Tutanota Financial"
    echo "   5. Website: https://mail.tutanota.com"
    echo "   6. Username: quietwave@tutanota.de"
    echo "   7. Password: [Enter your Tutanota password]"
    echo "   8. Notes: Financial domain email - Safari access only"
    echo "   9. Save the item"
    echo ""
    
    read -p "✅ Press ENTER when Tutanota Financial is saved in Financial Domain vault..."
    print_success "Tutanota Financial account stored in Financial Domain vault"
    
    print_step "7: ADD HIGH-SECURITY EMAIL TO HIGH-SECURITY VAULT"
    print_action "Let's add your ProtonMail high-security account:"
    echo ""
    echo "   1. Select 'High Security Domain' vault"
    echo "   2. Click '+' to add new item"
    echo "   3. Choose 'Login' type"
    echo "   4. Title: ProtonMail High Security"
    echo "   5. Website: https://mail.protonmail.com"
    echo "   6. Username: deepvault@protonmail.com"
    echo "   7. Password: [Same as your ProtonMail password - it's the same account]"
    echo "   8. Notes: High-security domain email - Brave access only"
    echo "   9. Save the item"
    echo ""
    
    read -p "✅ Press ENTER when ProtonMail High Security is saved in High Security Domain vault..."
    print_success "ProtonMail High Security account stored in High Security Domain vault"
}

# ============================================================================
# BROWSER EXTENSION CONFIGURATION
# ============================================================================

configure_browser_extensions() {
    print_header "🌐 CONFIGURING BROWSER EXTENSIONS FOR VAULT ISOLATION"
    
    print_step "8: CONFIGURE FIREFOX EXTENSION (PERSONAL DOMAIN ONLY)"
    print_action "Set up Firefox for Personal Domain access:"
    echo ""
    echo "   1. Open Firefox"
    echo "   2. Click 1Password extension icon"
    echo "   3. Go to Settings/Preferences"
    echo "   4. Find 'Vaults' or 'Account' settings"
    echo "   5. UNCHECK all vaults EXCEPT 'Personal Domain'"
    echo "   6. Verify only Personal Domain is accessible"
    echo "   7. Test by trying to access passwords"
    echo ""
    
    read -p "✅ Press ENTER when Firefox is configured for Personal Domain only..."
    print_success "Firefox configured for Personal Domain vault access only"
    
    print_step "9: CONFIGURE SAFARI EXTENSION (FINANCIAL DOMAIN ONLY)"
    print_action "Set up Safari for Financial Domain access:"
    echo ""
    echo "   1. Open Safari"
    echo "   2. Click 1Password extension icon"
    echo "   3. Go to Settings/Preferences"
    echo "   4. Find 'Vaults' or 'Account' settings"
    echo "   5. UNCHECK all vaults EXCEPT 'Financial Domain'"
    echo "   6. Verify only Financial Domain is accessible"
    echo "   7. Test by trying to access passwords"
    echo ""
    
    read -p "✅ Press ENTER when Safari is configured for Financial Domain only..."
    print_success "Safari configured for Financial Domain vault access only"
    
    print_step "10: CONFIGURE BRAVE EXTENSION (HIGH-SECURITY DOMAIN ONLY)"
    print_action "Set up Brave for High Security Domain access:"
    echo ""
    echo "   1. Open Brave"
    echo "   2. Install 1Password extension if not already installed"
    echo "   3. Click 1Password extension icon"
    echo "   4. Go to Settings/Preferences"
    echo "   5. Find 'Vaults' or 'Account' settings"
    echo "   6. UNCHECK all vaults EXCEPT 'High Security Domain'"
    echo "   7. Verify only High Security Domain is accessible"
    echo "   8. Test by trying to access passwords"
    echo ""
    
    read -p "✅ Press ENTER when Brave is configured for High Security Domain only..."
    print_success "Brave configured for High Security Domain vault access only"
}

# ============================================================================
# VERIFICATION AND TESTING
# ============================================================================

verify_setup() {
    print_header "✅ VERIFICATION AND TESTING"
    
    print_step "11: VERIFY VAULT ISOLATION"
    print_action "Let's test that everything is properly isolated:"
    echo ""
    echo "   🔍 FIREFOX TEST:"
    echo "   1. Open Firefox"
    echo "   2. Click 1Password extension"
    echo "   3. Verify you ONLY see Personal Domain vault"
    echo "   4. Verify you can access ProtonMail Personal login"
    echo ""
    echo "   🔍 SAFARI TEST:"
    echo "   1. Open Safari"
    echo "   2. Click 1Password extension"
    echo "   3. Verify you ONLY see Financial Domain vault"
    echo "   4. Verify you can access Tutanota Financial login"
    echo ""
    echo "   🔍 BRAVE TEST:"
    echo "   1. Open Brave"
    echo "   2. Click 1Password extension"
    echo "   3. Verify you ONLY see High Security Domain vault"
    echo "   4. Verify you can access ProtonMail High Security login"
    echo ""
    
    read -p "✅ Press ENTER when all browser isolation tests pass..."
    print_success "All browser vault isolation verified"
    
    print_step "12: CREATE SUMMARY DOCUMENT"
    
    cat > "$HOME/.email-safety-net/1password-setup-complete.md" << 'EOF'
# ✅ 1PASSWORD SETUP COMPLETE

## 🎯 SUCCESSFULLY CONFIGURED:

### **📧 Email Accounts Stored:**
```
Personal Domain Vault:     streamcode@protonmail.com
Financial Domain Vault:    quietwave@tutanota.de
High Security Domain Vault: deepvault@protonmail.com
```

### **🌐 Browser Vault Access:**
```
Firefox:  Personal Domain vault ONLY
Safari:   Financial Domain vault ONLY  
Brave:    High Security Domain vault ONLY
```

### **🔐 Vault Structure:**
- **Personal Domain** (🏠) - Firefox access
- **Financial Domain** (🏦) - Safari access
- **High Security Domain** (🛡️) - Brave access

## 🎯 USAGE RULES:

### **Strict Browser-Vault Isolation:**
- **NEVER** access Financial vault from Firefox
- **NEVER** access Personal vault from Safari
- **NEVER** access High Security vault from Firefox/Safari
- **ALWAYS** use correct browser for each domain

### **Adding New Accounts:**
```
Personal accounts     → Personal Domain vault (Firefox)
Banking/investments   → Financial Domain vault (Safari)
Government/healthcare → High Security Domain vault (Brave)
```

## ✅ NEXT STEPS:
1. Test email compartmentalization across all browsers
2. Begin migrating existing accounts to appropriate vaults
3. Set up monitoring for cross-vault security violations
4. Plan account audit and migration strategy

## 🚨 SECURITY REMINDERS:
- Each browser only sees its designated vault
- Email passwords stored in domain-appropriate vaults
- Perfect compartmentalization maintained
- No cross-contamination between domains
EOF

    print_success "Setup summary document created"
    
    print_important "🎉 1PASSWORD VAULT SETUP COMPLETE!"
    echo ""
    echo "✅ Three domain vaults created"
    echo "✅ Email passwords stored in correct vaults"
    echo "✅ Browser extensions configured for isolation"
    echo "✅ Vault access properly restricted"
    echo "✅ Perfect compartmentalization achieved"
    echo ""
    echo "🎯 Your digital privacy foundation is now rock-solid!"
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    vault_creation_walkthrough
    store_email_passwords
    configure_browser_extensions
    verify_setup
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi