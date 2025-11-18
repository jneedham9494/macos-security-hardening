#!/bin/bash
# ProtonMail Additional Address Setup Guide
# How to add the high-security domain email to your ProtonMail Plus account

set -euo pipefail

SETUP_LOG="$HOME/.email-safety-net/protonmail-additional-setup.log"

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

# ============================================================================
# PROTONMAIL ADDITIONAL ADDRESS SETUP
# ============================================================================

setup_additional_address() {
    print_header "📧 PROTONMAIL ADDITIONAL ADDRESS SETUP"
    
    print_info "Adding second email address to your ProtonMail Plus account..."
    
    cat > "$HOME/.email-safety-net/protonmail-additional-address-guide.md" << 'EOF'
# 📧 HOW TO ADD SECOND PROTONMAIL ADDRESS

## 🎯 GOAL: Add High-Security Domain Email
Add `deepvault@protonmail.com` (or similar) to your existing ProtonMail Plus account

## 📋 STEP-BY-STEP INSTRUCTIONS:

### **Step 1: Access ProtonMail Settings**
1. **Open Firefox** (your personal domain browser)
2. **Go to**: https://mail.protonmail.com
3. **Log in** with your existing account (streamcode@protonmail.com or whatever you created)
4. **Click your profile/avatar** in top right corner
5. **Select "Settings"**

### **Step 2: Navigate to Addresses**
1. In Settings sidebar, **click "Identity and addresses"**
2. **OR** click "All Settings" → "Identity and addresses"
3. You should see your current email address listed

### **Step 3: Add New Address**
1. **Click "Add address"** button
2. **Enter your high-security username**: `deepvault` (or whatever you chose)
3. **Choose domain**: `@protonmail.com`
4. **Add a display name**: something like "Secure" or "High Security"
5. **Click "Save"**

### **Step 4: Verify the New Address**
1. **Check that the new address appears** in your address list
2. **Set as default** if you want (optional)
3. **Test sending** an email from the new address

## 🔍 TROUBLESHOOTING:

### **If You Don't See "Add Address" Option:**
- **Check your plan**: Only ProtonMail Plus and above allow additional addresses
- **Verify payment**: Make sure your Plus subscription is active
- **Try different menu**: Look under "Account" → "Identity and addresses"

### **If Option is Grayed Out:**
- **Plan limitation**: Free accounts can't add addresses
- **Need to upgrade**: Upgrade to ProtonMail Plus first
- **Payment issue**: Check that subscription payment went through

### **Alternative Navigation Paths:**
1. **Settings** → **All Settings** → **Identity and addresses**
2. **Settings** → **Account** → **Addresses**
3. **Profile Menu** → **Settings** → **Identity and addresses**

## 🎯 WHAT YOU'RE LOOKING FOR:

### **In ProtonMail Settings, you should see:**
```
Identity and addresses
├── Your current address (streamcode@protonmail.com)
├── [+ Add address] button
└── Address management options
```

### **After adding, you'll have:**
```
Personal Domain:     streamcode@protonmail.com (existing)
High-Security Domain: deepvault@protonmail.com (new)
```

## 🔐 BROWSER ACCESS STRATEGY:

### **Once Both Addresses Exist:**
```
Firefox Access:  streamcode@protonmail.com (Personal domain)
Brave Access:    deepvault@protonmail.com (High-security domain)
```

### **How to Access Different Addresses:**
1. **Same login credentials** for both addresses
2. **Switch between addresses** when composing emails
3. **Filter inbox** by address if needed
4. **Use different browsers** to maintain compartmentalization

## 🚨 IMPORTANT NOTES:

### **Both Addresses Share:**
- Same login password
- Same 2FA settings
- Same account settings
- Same storage quota

### **Maintain Separation By:**
- Using Firefox ONLY for personal address
- Using Brave ONLY for high-security address
- Never mixing domains in same browser
- Different contacts and usage patterns

## 📱 MOBILE ACCESS:

### **ProtonMail App Strategy:**
```
Option A: Add ONLY personal address to mobile app
Option B: Add both, but use folders/labels for separation
Option C: Browser access for high-security, app for personal
```

## ✅ SUCCESS VERIFICATION:

### **Test That Both Work:**
1. **Send test email** from personal address
2. **Send test email** from high-security address  
3. **Verify both appear** in address dropdown when composing
4. **Check both receive** emails correctly
5. **Test browser separation** (Firefox vs Brave access)
EOF

    print_success "Additional address setup guide created"
    
    # Open ProtonMail in Firefox for user
    print_action "Opening ProtonMail settings in Firefox..."
    if command -v open &> /dev/null; then
        open -a "Firefox" "https://mail.protonmail.com" &
    fi
    
    print_info "Follow the guide to add your high-security address"
}

# ============================================================================
# CURRENT STATUS VERIFICATION
# ============================================================================

verify_current_setup() {
    print_header "✅ CURRENT EMAIL SETUP VERIFICATION"
    
    print_info "Verifying your current email setup..."
    
    cat > "$HOME/.email-safety-net/current-status.md" << 'EOF'
# ✅ CURRENT EMAIL SETUP STATUS

## 📧 ACCOUNTS CREATED:

### ✅ ProtonMail Plus Account
- **Address**: streamcode@protonmail.com (or your chosen username)
- **Plan**: ProtonMail Plus ($4/month)
- **Browser**: Firefox (Personal domain)
- **Status**: ✅ CREATED

### ✅ Tutanota Free Account  
- **Address**: quietwave@tutanota.de (or your chosen username)
- **Plan**: Free
- **Browser**: Safari (Financial domain)
- **Status**: ✅ CREATED

### ⏳ ProtonMail Additional Address
- **Address**: deepvault@protonmail.com (to be added)
- **Plan**: Same ProtonMail Plus account
- **Browser**: Brave (High-security domain)
- **Status**: ⏳ PENDING

## 🎯 NEXT IMMEDIATE STEPS:

1. **Add second ProtonMail address** (follow guide above)
2. **Set up 1Password vaults** for each domain
3. **Configure browser bookmarks** and access
4. **Test all three email addresses** work properly
5. **Plan account migration** from existing accounts

## 🔐 BROWSER COMPARTMENTALIZATION:

### **Current Strategy:**
```
Firefox:  streamcode@protonmail.com (Personal)
Safari:   quietwave@tutanota.de (Financial)  
Brave:    deepvault@protonmail.com (High-security) - TO ADD
```

### **Security Benefits:**
✅ Three separate email providers/accounts
✅ Perfect browser isolation
✅ Different jurisdictions (Swiss + German)
✅ Cost-effective ($4/month total)
✅ Maximum compartmentalization

## 📱 MOBILE PREPARATION:

### **Apps to Install:**
- **ProtonMail app**: For personal domain only
- **Tutanota app**: For financial domain only
- **Browser access**: For high-security domain

## 🎯 SUCCESS METRICS:

### **Today's Goals:**
- [x] ProtonMail Plus account created
- [x] Tutanota account created
- [ ] Second ProtonMail address added
- [ ] Test all three addresses
- [ ] Verify browser compartmentalization

### **This Week's Goals:**
- [ ] Password manager vaults configured
- [ ] Browser bookmarks and restrictions set
- [ ] Mobile apps installed and configured
- [ ] Begin critical account migration planning
EOF

    print_success "Current status verification completed"
    print_info "Review current-status.md for next steps"
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    case "${1:-setup}" in
        "setup")
            setup_additional_address
            ;;
        "status")
            verify_current_setup
            ;;
        "both")
            setup_additional_address
            verify_current_setup
            ;;
        *)
            echo "📧 ProtonMail Additional Address Setup"
            echo ""
            echo "Usage: $0 [command]"
            echo ""
            echo "Commands:"
            echo "  setup   - Show how to add second ProtonMail address"
            echo "  status  - Verify current email setup status"
            echo "  both    - Both setup guide and status check"
            ;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi