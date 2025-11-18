#!/bin/bash
# 1Password Account Email Strategy
# Choose the right email for your 1Password master account

set -euo pipefail

SETUP_LOG="$HOME/.email-safety-net/1password-account-setup.log"

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

print_recommendation() {
    echo -e "${PURPLE}🎯 $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - RECOMMENDATION: $1" >> "$SETUP_LOG"
}

# ============================================================================
# 1PASSWORD ACCOUNT EMAIL STRATEGY
# ============================================================================

choose_account_email() {
    print_header "📧 1PASSWORD ACCOUNT EMAIL STRATEGY"
    
    cat > "$HOME/.email-safety-net/1password-account-email-choice.md" << 'EOF'
# 📧 1PASSWORD ACCOUNT EMAIL STRATEGY

## 🎯 CRITICAL DECISION: Which Email for 1Password Account?

Your 1Password account email is the **master key** to your entire digital privacy system. Choose carefully!

## 🏆 RECOMMENDED STRATEGY: Use Personal Domain Email

### **✅ BEST CHOICE: streamcode@protonmail.com**

#### **Why This Is Perfect:**
- **Already created and verified** ✅
- **High-security provider** (ProtonMail) ✅
- **Swiss jurisdiction** (strong privacy laws) ✅
- **Your personal domain** - appropriate for personal password manager ✅
- **Clean slate** - no existing compromises ✅
- **End-to-end encrypted** recovery emails ✅

#### **Perfect Alignment:**
```
1Password Account:     streamcode@protonmail.com
Personal Domain:       streamcode@protonmail.com (same email)
Financial Domain:      quietwave@tutanota.de (separate)
High-Security Domain:  deepvault@protonmail.com (separate)
```

## 🔐 SECURITY BENEFITS:

### **Why NOT Use Old Email:**
- **Potentially compromised** from years of use
- **Data broker exposure** likely
- **Breach history** unknown
- **Privacy violations** accumulated over time
- **Wrong jurisdiction** (probably Gmail/Yahoo/etc.)

### **Why NOT Use Financial or High-Security:**
- **Keep domains separate** - 1Password shouldn't be tied to specific use case
- **Recovery complexity** - mixing password manager with domain strategy
- **Access patterns** - personal use fits personal email

## 🎯 IMPLEMENTATION STRATEGY:

### **Step 1: Create 1Password Account**
1. **Go to**: https://1password.com/sign-up
2. **Use email**: `streamcode@protonmail.com`
3. **Create strong master password** (unique, never used before)
4. **Enable 2FA** immediately
5. **Download recovery kit** and store securely

### **Step 2: Verify Email Access**
1. **Open Firefox** (your personal domain browser)
2. **Check ProtonMail** for verification email
3. **Click verification link**
4. **Complete account setup**

### **Step 3: Security Hardening**
1. **Enable all security features**
2. **Set up recovery methods**
3. **Configure family/emergency access** if desired
4. **Document recovery procedures**

## 🚨 ALTERNATIVE CONSIDERATIONS:

### **Option B: Create Dedicated 1Password Email**
If you want complete separation, create a 4th ProtonMail address:

#### **Pros:**
- **Complete isolation** from all domains
- **Dedicated recovery** path
- **No domain mixing**

#### **Cons:**
- **More complexity** to manage
- **Additional cost** (another ProtonMail address)
- **Not necessary** for personal use case

### **Option C: Use High-Security Email**
Use `deepvault@protonmail.com` for maximum security:

#### **Pros:**
- **Highest security** domain
- **Maximum protection**

#### **Cons:**
- **Mixing domains** - password manager not high-security specific
- **Access complexity** - would need Brave for account management
- **Over-engineering** for password manager use case

## 🎯 FINAL RECOMMENDATION:

### **Use streamcode@protonmail.com Because:**

1. **✅ Perfect Security Level**
   - ProtonMail encryption
   - Swiss privacy laws
   - Clean account history

2. **✅ Logical Domain Alignment**
   - Personal password manager = personal email
   - Natural access pattern
   - Firefox browser management

3. **✅ Practical Simplicity**
   - Already set up and verified
   - No additional complexity
   - Easy to remember and access

4. **✅ Recovery Strategy**
   - Can use other ProtonMail address as backup
   - Multiple recovery paths available
   - Secure provider for all recovery

## 📱 MOBILE ACCESS STRATEGY:

### **1Password Mobile App:**
- **Account email**: streamcode@protonmail.com
- **Primary access**: Personal Domain vault (most used)
- **Secondary access**: Financial Domain (when needed)
- **Restricted access**: High-Security Domain (rarely)

### **Recovery Planning:**
- **Primary recovery**: streamcode@protonmail.com
- **Backup recovery**: deepvault@protonmail.com
- **Emergency access**: Family member with quietwave@tutanota.de

## ✅ DECISION CHECKLIST:

### **Why streamcode@protonmail.com Is Perfect:**
- [x] High-security email provider (ProtonMail)
- [x] Clean account with no compromise history
- [x] Appropriate domain level (personal use)
- [x] Easy browser access (Firefox - personal domain)
- [x] Strong jurisdiction (Switzerland)
- [x] End-to-end encrypted recovery emails
- [x] Logical domain alignment
- [x] Already verified and working

### **Implementation Plan:**
1. **Use streamcode@protonmail.com** for 1Password account
2. **Access via Firefox** for account management
3. **Set up vault compartmentalization** as planned
4. **Use other emails** as backup recovery methods
5. **Maintain domain separation** in daily use

## 🚀 NEXT STEPS:

1. **Sign up for 1Password** using streamcode@protonmail.com
2. **Verify email** in Firefox/ProtonMail
3. **Complete security setup** (2FA, recovery kit)
4. **Create domain vaults** as planned
5. **Configure browser extensions** for vault isolation

This choice gives you maximum security while maintaining the logical separation of your domain strategy!
EOF

    print_success "1Password account email strategy documented"
}

# ============================================================================
# LAUNCH 1PASSWORD SIGNUP
# ============================================================================

launch_1password_signup() {
    print_header "🚀 LAUNCHING 1PASSWORD ACCOUNT CREATION"
    
    print_recommendation "Use streamcode@protonmail.com for your 1Password account"
    print_info "This maintains perfect domain alignment while maximizing security"
    
    print_action "Opening 1Password signup page..."
    if command -v open &> /dev/null; then
        open "https://1password.com/sign-up" &
        print_success "1Password signup page opened"
    fi
    
    print_action "Opening ProtonMail for email verification..."
    if command -v open &> /dev/null; then
        open -a "Firefox" "https://mail.protonmail.com" &
        print_success "ProtonMail opened in Firefox"
    fi
    
    cat << 'EOF'

🎯 1PASSWORD ACCOUNT CREATION CHECKLIST:

✅ **Email to Use**: streamcode@protonmail.com
✅ **Browser**: Any browser for signup (then manage via Firefox)
✅ **Master Password**: Create unique, strong password (never used before)
✅ **2FA**: Enable immediately after account creation
✅ **Recovery Kit**: Download and store securely offline

📋 **Signup Steps:**
1. Enter streamcode@protonmail.com as your email
2. Create strong master password (24+ characters recommended)
3. Complete signup process
4. Check ProtonMail in Firefox for verification email
5. Verify email address
6. Enable 2FA security
7. Download recovery kit
8. Return here to continue with vault setup

🔐 **Why This Email Choice:**
- ✅ High-security ProtonMail provider
- ✅ Clean account with no compromise history  
- ✅ Personal domain alignment
- ✅ Firefox browser management
- ✅ Swiss privacy jurisdiction
- ✅ Perfect for personal password manager use

EOF
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    case "${1:-recommend}" in
        "recommend"|"choice")
            choose_account_email
            ;;
        "signup")
            launch_1password_signup
            ;;
        "all")
            choose_account_email
            launch_1password_signup
            ;;
        *)
            echo "📧 1Password Account Email Strategy"
            echo ""
            echo "Usage: $0 [command]"
            echo ""
            echo "Commands:"
            echo "  recommend  - Show email choice strategy and recommendation"
            echo "  signup     - Launch 1Password signup with recommended email"
            echo "  all        - Both recommendation and signup launch"
            ;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi