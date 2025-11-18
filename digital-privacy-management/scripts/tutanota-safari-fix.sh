#!/bin/bash
# Tutanota Safari Troubleshooting & Alternative Setup
# Fixes common issues with Tutanota signup in Safari

set -euo pipefail

TROUBLESHOOT_LOG="$HOME/.email-safety-net/tutanota-troubleshoot.log"

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
    echo "$(date '+%Y-%m-%d %H:%M:%S') - SUCCESS: $1" >> "$TROUBLESHOOT_LOG"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - INFO: $1" >> "$TROUBLESHOOT_LOG"
}

print_action() {
    echo -e "${YELLOW}🔧 $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ACTION: $1" >> "$TROUBLESHOOT_LOG"
}

# ============================================================================
# SAFARI TUTANOTA TROUBLESHOOTING
# ============================================================================

fix_safari_tutanota() {
    print_header "🔧 SAFARI TUTANOTA TROUBLESHOOTING"
    
    print_info "Common Safari issues with Tutanota signup..."
    
    # Try Safari settings fixes
    print_action "Adjusting Safari settings for Tutanota..."
    
    # Safari privacy settings that might block Tutanota
    defaults write com.apple.Safari "Prevent cross-site tracking" -bool false
    defaults write com.apple.Safari "Block all cookies" -bool false
    defaults write com.apple.Safari "JavaScript Enabled" -bool true
    
    print_success "Safari settings adjusted"
    
    # Open Tutanota in Safari with fresh session
    print_action "Opening Tutanota in Safari with fresh session..."
    
    # Clear Safari cache and try again
    print_info "You may need to clear Safari cache: Safari > Develop > Empty Caches"
    
    # Try alternative Tutanota URLs
    print_action "Trying alternative Tutanota signup URLs..."
    
    if command -v open &> /dev/null; then
        # Try main signup page
        open -a "Safari" "https://tutanota.com/signup" &
        sleep 2
        
        # Try direct signup URL
        open -a "Safari" "https://mail.tutanota.com/signup" &
        sleep 2
    fi
    
    print_success "Alternative Tutanota URLs opened in Safari"
}

# ============================================================================
# ALTERNATIVE BROWSER SOLUTIONS
# ============================================================================

try_alternative_browsers() {
    print_header "🌐 ALTERNATIVE BROWSER SOLUTIONS"
    
    print_info "If Safari continues to have issues, we have alternatives..."
    
    # Option 1: Try Firefox for Tutanota (temporarily)
    print_action "Option 1: Create Tutanota in Firefox, then access via Safari"
    print_info "Create account in Firefox, then only access it via Safari afterward"
    
    # Option 2: Try Chrome (if available)
    if [[ -d "/Applications/Google Chrome.app" ]]; then
        print_action "Option 2: Try Chrome for Tutanota signup"
        print_info "Chrome detected - can use for signup, then access via Safari"
        
        if command -v open &> /dev/null; then
            open -a "Google Chrome" "https://tutanota.com/signup" &
        fi
    fi
    
    # Option 3: Alternative email provider
    print_action "Option 3: Alternative secure email providers"
    print_info "If Tutanota doesn't work, consider: Posteo.de, Mailfence.com"
    
    cat > "$HOME/.email-safety-net/tutanota-alternatives.md" << 'EOF'
# 🔧 TUTANOTA ALTERNATIVES FOR FINANCIAL DOMAIN

## 🚨 IF TUTANOTA WON'T WORK IN SAFARI:

### **OPTION A: Create in Different Browser, Access via Safari**
1. Create Tutanota account in Firefox or Chrome
2. Test that it works
3. Then ONLY access it via Safari going forward
4. Maintains compartmentalization (access via Safari only)

### **OPTION B: Alternative Secure Email Providers**

#### **Posteo (Germany) - €1/month**
- Website: posteo.de
- Similar privacy to Tutanota
- German jurisdiction
- Excellent reputation
- Works well in Safari

#### **Mailfence (Belgium) - Free/Paid**
- Website: mailfence.com  
- Belgian privacy laws
- End-to-end encryption
- Good Safari compatibility

#### **StartMail (Netherlands) - $7/month**
- Website: startmail.com
- Dutch privacy laws
- Excellent security
- Better browser compatibility

### **OPTION C: Use ProtonMail for Financial Too**
```
Personal:     streamcode@protonmail.com
High-Security: deepvault@protonmail.com
Financial:    finance2024@protonmail.com (same paid account)
```

**Pros:** Same provider, easier management
**Cons:** Less isolation than separate provider

## 🎯 **RECOMMENDED TROUBLESHOOTING ORDER:**

### **Step 1: Safari Settings Fix**
1. Safari > Preferences > Privacy
2. Uncheck "Prevent cross-site tracking" temporarily
3. Uncheck "Block all cookies" temporarily  
4. Try Tutanota signup again

### **Step 2: Alternative Signup Method**
1. Create Tutanota in Firefox
2. Verify account works
3. Then access ONLY via Safari forever
4. Delete from Firefox after setup

### **Step 3: Alternative Provider**
1. Try Posteo.de in Safari
2. Create: quietwave@posteo.de
3. Same compartmentalization strategy
4. German privacy laws still apply

### **Step 4: ProtonMail Financial**
1. Add third email to ProtonMail Plus
2. Create: finance2024@protonmail.com
3. Use Safari for access
4. Still maintain browser separation
EOF

    print_success "Tutanota alternatives guide created"
}

# ============================================================================
# QUICK FIX ATTEMPTS
# ============================================================================

quick_fixes() {
    print_header "⚡ QUICK SAFARI FIXES"
    
    print_action "Trying quick Safari fixes..."
    
    # Enable Safari Develop menu
    defaults write com.apple.Safari IncludeDevelopMenu -bool true
    
    print_info "Quick fixes to try in Safari:"
    echo "1. Safari > Preferences > Privacy > Manage Website Data > Remove All"
    echo "2. Safari > Develop > Empty Caches"
    echo "3. Safari > Develop > Disable Extensions (temporarily)"
    echo "4. Try private browsing window: Cmd+Shift+N"
    echo "5. Try different Tutanota URL: mail.tutanota.com/signup"
    
    print_success "Quick fixes listed - try these in Safari"
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    case "${1:-all}" in
        "safari")
            fix_safari_tutanota
            ;;
        "alternatives")
            try_alternative_browsers
            ;;
        "quick")
            quick_fixes
            ;;
        "all")
            print_header "🚀 TUTANOTA SAFARI TROUBLESHOOTING"
            quick_fixes
            fix_safari_tutanota
            try_alternative_browsers
            
            print_info "Troubleshooting completed!"
            print_action "Try the quick fixes first, then alternatives if needed"
            ;;
        *)
            echo "🔧 Tutanota Safari Troubleshooting"
            echo ""
            echo "Usage: $0 [command]"
            echo ""
            echo "Commands:"
            echo "  safari       - Fix Safari settings for Tutanota"
            echo "  alternatives - Show alternative solutions"
            echo "  quick        - Quick fixes to try first"
            echo "  all          - Complete troubleshooting (default)"
            ;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi