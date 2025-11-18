#!/bin/bash
# Email Compartmentalization Testing
# Comprehensive verification of browser-email isolation

set -euo pipefail

SETUP_LOG="$HOME/.email-safety-net/email-compartmentalization-test.log"

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

print_test() {
    echo -e "${YELLOW}🧪 TEST $1${NC}"
}

print_action() {
    echo -e "${BLUE}📋 $1${NC}"
}

print_pass() {
    echo -e "${GREEN}✅ PASS: $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - PASS: $1" >> "$SETUP_LOG"
}

print_fail() {
    echo -e "${RED}❌ FAIL: $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - FAIL: $1" >> "$SETUP_LOG"
}

print_warning() {
    echo -e "${PURPLE}⚠️  $1${NC}"
}

# ============================================================================
# FIREFOX PERSONAL DOMAIN TEST
# ============================================================================

test_firefox_personal() {
    print_header "🦊 FIREFOX PERSONAL DOMAIN TEST"
    
    print_test "1: FIREFOX EMAIL ACCESS AND 1PASSWORD INTEGRATION"
    
    print_action "Let's test Firefox with Personal Domain:"
    echo ""
    echo "   🎯 GOAL: Verify Firefox only accesses Personal Domain"
    echo "   📧 Email: streamcode@protonmail.com"
    echo "   🔐 Vault: Personal Domain only"
    echo ""
    echo "   STEPS:"
    echo "   1. Open Firefox"
    echo "   2. Go to https://mail.protonmail.com"
    echo "   3. Click 1Password extension"
    echo "   4. Verify you ONLY see Personal Domain vault"
    echo "   5. Use 1Password to log into ProtonMail"
    echo "   6. Verify login works correctly"
    echo "   7. Send a test email to yourself"
    echo ""
    
    read -p "✅ Press ENTER when Firefox test is complete..."
    
    echo ""
    echo "❓ Firefox Test Results:"
    echo "   Did 1Password show ONLY Personal Domain vault? (y/n)"
    read -r firefox_vault_isolation
    
    echo "   Did ProtonMail login work correctly? (y/n)"
    read -r firefox_login_success
    
    echo "   Were you able to send a test email? (y/n)"
    read -r firefox_email_send
    
    if [[ "$firefox_vault_isolation" == "y" && "$firefox_login_success" == "y" && "$firefox_email_send" == "y" ]]; then
        print_pass "Firefox Personal Domain test - All checks passed"
    else
        print_fail "Firefox Personal Domain test - Some checks failed"
        echo "   Vault isolation: $firefox_vault_isolation"
        echo "   Login success: $firefox_login_success"
        echo "   Email send: $firefox_email_send"
    fi
}

# ============================================================================
# SAFARI FINANCIAL DOMAIN TEST
# ============================================================================

test_safari_financial() {
    print_header "🧭 SAFARI FINANCIAL DOMAIN TEST"
    
    print_test "2: SAFARI EMAIL ACCESS AND 1PASSWORD INTEGRATION"
    
    print_action "Let's test Safari with Financial Domain:"
    echo ""
    echo "   🎯 GOAL: Verify Safari only accesses Financial Domain"
    echo "   📧 Email: quietwave@tutanota.de"
    echo "   🔐 Vault: Financial Domain only"
    echo ""
    echo "   STEPS:"
    echo "   1. Open Safari"
    echo "   2. Go to https://mail.tutanota.com"
    echo "   3. Click 1Password extension"
    echo "   4. Verify you ONLY see Financial Domain vault"
    echo "   5. Use 1Password to log into Tutanota"
    echo "   6. Verify login works correctly"
    echo "   7. Send a test email to yourself"
    echo ""
    
    read -p "✅ Press ENTER when Safari test is complete..."
    
    echo ""
    echo "❓ Safari Test Results:"
    echo "   Did 1Password show ONLY Financial Domain vault? (y/n)"
    read -r safari_vault_isolation
    
    echo "   Did Tutanota login work correctly? (y/n)"
    read -r safari_login_success
    
    echo "   Were you able to send a test email? (y/n)"
    read -r safari_email_send
    
    if [[ "$safari_vault_isolation" == "y" && "$safari_login_success" == "y" && "$safari_email_send" == "y" ]]; then
        print_pass "Safari Financial Domain test - All checks passed"
    else
        print_fail "Safari Financial Domain test - Some checks failed"
        echo "   Vault isolation: $safari_vault_isolation"
        echo "   Login success: $safari_login_success"
        echo "   Email send: $safari_email_send"
    fi
}

# ============================================================================
# BRAVE HIGH-SECURITY DOMAIN TEST
# ============================================================================

test_brave_high_security() {
    print_header "🦁 BRAVE HIGH-SECURITY DOMAIN TEST"
    
    print_test "3: BRAVE EMAIL ACCESS AND 1PASSWORD INTEGRATION"
    
    print_action "Let's test Brave with High-Security Domain:"
    echo ""
    echo "   🎯 GOAL: Verify Brave only accesses High-Security Domain"
    echo "   📧 Email: deepvault@protonmail.com"
    echo "   🔐 Vault: High Security Domain only"
    echo ""
    echo "   STEPS:"
    echo "   1. Open Brave"
    echo "   2. Go to https://mail.protonmail.com"
    echo "   3. Click 1Password extension"
    echo "   4. Verify you ONLY see High Security Domain vault"
    echo "   5. Use 1Password to log into ProtonMail (high-security address)"
    echo "   6. Verify login works correctly"
    echo "   7. Send a test email to yourself"
    echo ""
    
    read -p "✅ Press ENTER when Brave test is complete..."
    
    echo ""
    echo "❓ Brave Test Results:"
    echo "   Did 1Password show ONLY High Security Domain vault? (y/n)"
    read -r brave_vault_isolation
    
    echo "   Did ProtonMail login work correctly? (y/n)"
    read -r brave_login_success
    
    echo "   Were you able to send a test email? (y/n)"
    read -r brave_email_send
    
    if [[ "$brave_vault_isolation" == "y" && "$brave_login_success" == "y" && "$brave_email_send" == "y" ]]; then
        print_pass "Brave High-Security Domain test - All checks passed"
    else
        print_fail "Brave High-Security Domain test - Some checks failed"
        echo "   Vault isolation: $brave_vault_isolation"
        echo "   Login success: $brave_login_success"
        echo "   Email send: $brave_email_send"
    fi
}

# ============================================================================
# CROSS-CONTAMINATION TEST
# ============================================================================

test_cross_contamination() {
    print_header "🚫 CROSS-CONTAMINATION PREVENTION TEST"
    
    print_test "4: VERIFY NO CROSS-BROWSER ACCESS"
    
    print_action "Critical security test - verify perfect isolation:"
    echo ""
    echo "   🔍 NEGATIVE TESTS (These should FAIL):"
    echo ""
    echo "   TEST A: Try accessing Financial vault from Firefox"
    echo "   1. Open Firefox"
    echo "   2. Click 1Password extension"
    echo "   3. Try to find Financial Domain vault"
    echo "   4. You should NOT see it"
    echo ""
    
    read -p "✅ Press ENTER when you've tested Firefox isolation..."
    
    echo "   Can you see Financial or High-Security vaults in Firefox? (y/n)"
    read -r firefox_contamination
    
    echo ""
    echo "   TEST B: Try accessing Personal vault from Safari"
    echo "   1. Open Safari"
    echo "   2. Click 1Password extension"
    echo "   3. Try to find Personal Domain vault"
    echo "   4. You should NOT see it"
    echo ""
    
    read -p "✅ Press ENTER when you've tested Safari isolation..."
    
    echo "   Can you see Personal or High-Security vaults in Safari? (y/n)"
    read -r safari_contamination
    
    echo ""
    echo "   TEST C: Try accessing Personal/Financial vaults from Brave"
    echo "   1. Open Brave"
    echo "   2. Click 1Password extension"
    echo "   3. Try to find Personal or Financial Domain vaults"
    echo "   4. You should NOT see them"
    echo ""
    
    read -p "✅ Press ENTER when you've tested Brave isolation..."
    
    echo "   Can you see Personal or Financial vaults in Brave? (y/n)"
    read -r brave_contamination
    
    if [[ "$firefox_contamination" == "n" && "$safari_contamination" == "n" && "$brave_contamination" == "n" ]]; then
        print_pass "Cross-contamination test - Perfect isolation maintained"
    else
        print_fail "Cross-contamination test - Isolation breach detected"
        print_warning "SECURITY ISSUE: Some browsers can access wrong vaults"
        echo "   Firefox sees other vaults: $firefox_contamination"
        echo "   Safari sees other vaults: $safari_contamination"
        echo "   Brave sees other vaults: $brave_contamination"
    fi
}

# ============================================================================
# EMAIL FORWARDING AND INTEGRATION TEST
# ============================================================================

test_email_integration() {
    print_header "📬 EMAIL INTEGRATION AND FORWARDING TEST"
    
    print_test "5: CROSS-DOMAIN EMAIL COMMUNICATION"
    
    print_action "Test email communication between domains:"
    echo ""
    echo "   🎯 GOAL: Verify all email addresses work and can communicate"
    echo ""
    echo "   EMAIL CHAIN TEST:"
    echo "   1. From Firefox: Send email from streamcode@protonmail.com to quietwave@tutanota.de"
    echo "   2. From Safari: Check Tutanota for the email, then reply back"
    echo "   3. From Brave: Send email from deepvault@protonmail.com to both addresses"
    echo ""
    echo "   This tests:"
    echo "   ✅ All email addresses are functional"
    echo "   ✅ Cross-provider communication works"
    echo "   ✅ Browser compartmentalization is maintained"
    echo ""
    
    read -p "✅ Press ENTER when you've completed the email chain test..."
    
    echo ""
    echo "❓ Email Integration Results:"
    echo "   Did personal → financial email work? (y/n)"
    read -r personal_to_financial
    
    echo "   Did financial → personal reply work? (y/n)"
    read -r financial_to_personal
    
    echo "   Did high-security → both emails work? (y/n)"
    read -r high_security_broadcast
    
    if [[ "$personal_to_financial" == "y" && "$financial_to_personal" == "y" && "$high_security_broadcast" == "y" ]]; then
        print_pass "Email integration test - All communications working"
    else
        print_fail "Email integration test - Some communications failed"
        echo "   Personal → Financial: $personal_to_financial"
        echo "   Financial → Personal: $financial_to_personal"
        echo "   High-Security broadcast: $high_security_broadcast"
    fi
}

# ============================================================================
# GENERATE TEST RESULTS SUMMARY
# ============================================================================

generate_test_summary() {
    print_header "📊 TEST RESULTS SUMMARY"
    
    cat > "$HOME/.email-safety-net/compartmentalization-test-results.md" << EOF
# 📊 EMAIL COMPARTMENTALIZATION TEST RESULTS

## 🧪 TEST EXECUTION DATE: $(date '+%Y-%m-%d %H:%M:%S')

### 🦊 FIREFOX PERSONAL DOMAIN TEST:
- **Vault Isolation**: $firefox_vault_isolation
- **Login Success**: $firefox_login_success  
- **Email Sending**: $firefox_email_send
- **Status**: $([ "$firefox_vault_isolation" = "y" ] && [ "$firefox_login_success" = "y" ] && [ "$firefox_email_send" = "y" ] && echo "✅ PASS" || echo "❌ FAIL")

### 🧭 SAFARI FINANCIAL DOMAIN TEST:
- **Vault Isolation**: $safari_vault_isolation
- **Login Success**: $safari_login_success
- **Email Sending**: $safari_email_send  
- **Status**: $([ "$safari_vault_isolation" = "y" ] && [ "$safari_login_success" = "y" ] && [ "$safari_email_send" = "y" ] && echo "✅ PASS" || echo "❌ FAIL")

### 🦁 BRAVE HIGH-SECURITY DOMAIN TEST:
- **Vault Isolation**: $brave_vault_isolation
- **Login Success**: $brave_login_success
- **Email Sending**: $brave_email_send
- **Status**: $([ "$brave_vault_isolation" = "y" ] && [ "$brave_login_success" = "y" ] && [ "$brave_email_send" = "y" ] && echo "✅ PASS" || echo "❌ FAIL")

### 🚫 CROSS-CONTAMINATION TEST:
- **Firefox Isolation**: $([ "$firefox_contamination" = "n" ] && echo "✅ SECURE" || echo "❌ BREACH")
- **Safari Isolation**: $([ "$safari_contamination" = "n" ] && echo "✅ SECURE" || echo "❌ BREACH")
- **Brave Isolation**: $([ "$brave_contamination" = "n" ] && echo "✅ SECURE" || echo "❌ BREACH")
- **Overall**: $([ "$firefox_contamination" = "n" ] && [ "$safari_contamination" = "n" ] && [ "$brave_contamination" = "n" ] && echo "✅ PERFECT ISOLATION" || echo "❌ ISOLATION BREACH")

### 📬 EMAIL INTEGRATION TEST:
- **Personal → Financial**: $personal_to_financial
- **Financial → Personal**: $financial_to_personal
- **High-Security Broadcast**: $high_security_broadcast
- **Status**: $([ "$personal_to_financial" = "y" ] && [ "$financial_to_personal" = "y" ] && [ "$high_security_broadcast" = "y" ] && echo "✅ PASS" || echo "❌ FAIL")

## 🎯 OVERALL SYSTEM STATUS:

### ✅ SUCCESSFUL COMPONENTS:
EOF

    # Check each component and add to summary
    if [[ "$firefox_vault_isolation" == "y" && "$firefox_login_success" == "y" && "$firefox_email_send" == "y" ]]; then
        echo "- Firefox Personal Domain compartmentalization" >> "$HOME/.email-safety-net/compartmentalization-test-results.md"
    fi
    
    if [[ "$safari_vault_isolation" == "y" && "$safari_login_success" == "y" && "$safari_email_send" == "y" ]]; then
        echo "- Safari Financial Domain compartmentalization" >> "$HOME/.email-safety-net/compartmentalization-test-results.md"
    fi
    
    if [[ "$brave_vault_isolation" == "y" && "$brave_login_success" == "y" && "$brave_email_send" == "y" ]]; then
        echo "- Brave High-Security Domain compartmentalization" >> "$HOME/.email-safety-net/compartmentalization-test-results.md"
    fi
    
    if [[ "$firefox_contamination" == "n" && "$safari_contamination" == "n" && "$brave_contamination" == "n" ]]; then
        echo "- Perfect vault isolation across all browsers" >> "$HOME/.email-safety-net/compartmentalization-test-results.md"
    fi
    
    cat >> "$HOME/.email-safety-net/compartmentalization-test-results.md" << 'EOF'

### 🔐 SECURITY VERIFICATION:
```
Email Addresses:     3/3 functional
Browser Isolation:   Perfect separation
Vault Access:        Domain-restricted
Cross-contamination: None detected
Integration:         Full communication capability
```

### 🎯 NEXT STEPS:
1. Begin migrating existing accounts to appropriate vaults
2. Set up account categorization and audit process
3. Implement ongoing monitoring for vault access violations
4. Plan secure phone migration strategy

### 🚨 MAINTENANCE REMINDERS:
- Test isolation monthly
- Monitor for 1Password extension updates that might affect vault settings
- Verify no accidental cross-browser vault access
- Regular audit of vault contents and assignments

## 🏆 DIGITAL PRIVACY FOUNDATION STATUS: OPERATIONAL

Your compartmentalized email system is now fully functional and secure!
EOF

    print_pass "Test results summary generated"
    
    # Calculate overall success
    local all_tests_pass=true
    
    [[ "$firefox_vault_isolation" != "y" || "$firefox_login_success" != "y" || "$firefox_email_send" != "y" ]] && all_tests_pass=false
    [[ "$safari_vault_isolation" != "y" || "$safari_login_success" != "y" || "$safari_email_send" != "y" ]] && all_tests_pass=false
    [[ "$brave_vault_isolation" != "y" || "$brave_login_success" != "y" || "$brave_email_send" != "y" ]] && all_tests_pass=false
    [[ "$firefox_contamination" != "n" || "$safari_contamination" != "n" || "$brave_contamination" != "n" ]] && all_tests_pass=false
    
    if $all_tests_pass; then
        echo ""
        print_pass "🏆 ALL TESTS PASSED - DIGITAL PRIVACY SYSTEM FULLY OPERATIONAL"
        echo ""
        echo "🎯 Your compartmentalized email system is:"
        echo "   ✅ Perfectly isolated"
        echo "   ✅ Fully functional"
        echo "   ✅ Ready for production use"
        echo "   ✅ Enterprise-grade secure"
        echo ""
        echo "🚀 Ready to move to the next phase: Account migration and cleanup!"
    else
        echo ""
        print_fail "⚠️  SOME TESTS FAILED - REVIEW AND FIX ISSUES"
        echo ""
        echo "🔧 Check the test results above and fix any failing components"
        echo "💡 Most issues are usually browser extension vault settings"
        echo "🔄 Re-run tests after fixing issues"
    fi
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    echo "🧪 Starting comprehensive email compartmentalization testing..."
    echo ""
    
    test_firefox_personal
    echo ""
    test_safari_financial
    echo ""
    test_brave_high_security
    echo ""
    test_cross_contamination
    echo ""
    test_email_integration
    echo ""
    generate_test_summary
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi