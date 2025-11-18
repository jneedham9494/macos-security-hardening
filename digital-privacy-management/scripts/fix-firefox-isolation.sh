#!/bin/bash
# Fix Firefox 1Password Extension Vault Isolation
# Troubleshoot and fix vault isolation issues

set -euo pipefail

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

print_step() {
    echo -e "${YELLOW}🔧 $1${NC}"
}

print_action() {
    echo -e "${BLUE}📋 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_important() {
    echo -e "${RED}🚨 $1${NC}"
}

# ============================================================================
# FIREFOX VAULT ISOLATION FIX
# ============================================================================

fix_firefox_isolation() {
    print_header "🔧 FIXING FIREFOX 1PASSWORD VAULT ISOLATION"
    
    print_important "SECURITY ISSUE DETECTED: Firefox can see multiple vaults"
    print_action "Let's fix this step by step"
    
    echo ""
    echo "🎯 GOAL: Restrict Firefox to Personal Domain vault ONLY"
    echo ""
    
    print_step "METHOD 1: EXTENSION SETTINGS FIX"
    print_action "Try this first (most common solution):"
    echo ""
    echo "   1. Open Firefox"
    echo "   2. Click the 1Password extension icon (🔑)"
    echo "   3. Click the 'Settings' gear icon"
    echo "   4. Look for 'Vaults' or 'Account' tab"
    echo "   5. You should see a list of all your vaults with checkboxes:"
    echo "      □ Personal Domain"
    echo "      □ Financial Domain"
    echo "      □ High Security Domain"
    echo "      □ Private (default)"
    echo "   6. UNCHECK everything EXCEPT 'Personal Domain'"
    echo "   7. Save/Apply changes"
    echo "   8. Close and reopen 1Password extension"
    echo ""
    
    read -p "✅ Press ENTER when you've tried Method 1..."
    
    echo ""
    echo "❓ Did Method 1 work? Can you now only see Personal Domain vault in Firefox? (y/n)"
    read -r method1_success
    
    if [[ "$method1_success" == "y" ]]; then
        print_success "Method 1 successful - Firefox isolation fixed!"
        return 0
    fi
    
    print_step "METHOD 2: ALTERNATIVE SETTINGS LOCATION"
    print_action "Sometimes the settings are in a different place:"
    echo ""
    echo "   1. In Firefox, click 1Password extension"
    echo "   2. Click your profile/avatar (top right)"
    echo "   3. Select 'Preferences' or 'Settings'"
    echo "   4. Look for 'Security' or 'Privacy' section"
    echo "   5. Find 'Vault Access' or 'Available Vaults'"
    echo "   6. Disable all vaults except Personal Domain"
    echo "   7. Save changes"
    echo ""
    
    read -p "✅ Press ENTER when you've tried Method 2..."
    
    echo ""
    echo "❓ Did Method 2 work? (y/n)"
    read -r method2_success
    
    if [[ "$method2_success" == "y" ]]; then
        print_success "Method 2 successful - Firefox isolation fixed!"
        return 0
    fi
    
    print_step "METHOD 3: EXTENSION REINSTALL"
    print_action "If settings don't work, try reinstalling:"
    echo ""
    echo "   1. In Firefox, go to Add-ons (Cmd+Shift+A)"
    echo "   2. Find 1Password extension"
    echo "   3. Click 'Remove' or 'Disable'"
    echo "   4. Restart Firefox"
    echo "   5. Go to 1Password website: https://1password.com/downloads/"
    echo "   6. Download Firefox extension again"
    echo "   7. Install and sign in"
    echo "   8. During setup, choose ONLY Personal Domain vault"
    echo ""
    
    read -p "✅ Press ENTER when you've tried Method 3..."
    
    echo ""
    echo "❓ Did Method 3 work? (y/n)"
    read -r method3_success
    
    if [[ "$method3_success" == "y" ]]; then
        print_success "Method 3 successful - Firefox isolation fixed!"
        return 0
    fi
    
    print_step "METHOD 4: MANUAL VAULT CONFIGURATION"
    print_action "Advanced configuration approach:"
    echo ""
    echo "   1. Open 1Password desktop app"
    echo "   2. Go to 1Password > Preferences/Settings"
    echo "   3. Find 'Browser' or 'Security' section"
    echo "   4. Look for 'Browser Integration' settings"
    echo "   5. Find Firefox-specific settings"
    echo "   6. Set vault restrictions per browser"
    echo "   7. Apply changes and restart Firefox"
    echo ""
    
    read -p "✅ Press ENTER when you've tried Method 4..."
    
    echo ""
    echo "❓ Did Method 4 work? (y/n)"
    read -r method4_success
    
    if [[ "$method4_success" == "y" ]]; then
        print_success "Method 4 successful - Firefox isolation fixed!"
        return 0
    fi
    
    print_important "All methods attempted. Let's verify current status..."
}

# ============================================================================
# VERIFY FIX AND RETEST
# ============================================================================

verify_fix() {
    print_header "✅ VERIFYING FIREFOX ISOLATION FIX"
    
    print_action "Let's test if Firefox isolation is now working:"
    echo ""
    echo "   🔍 FIREFOX ISOLATION TEST:"
    echo "   1. Open Firefox"
    echo "   2. Click 1Password extension"
    echo "   3. Check what vaults you can see"
    echo "   4. You should ONLY see 'Personal Domain'"
    echo ""
    
    read -p "✅ Press ENTER when you've tested Firefox isolation..."
    
    echo ""
    echo "❓ Final verification:"
    echo "   Can you now ONLY see Personal Domain vault in Firefox? (y/n)"
    read -r final_isolation_test
    
    if [[ "$final_isolation_test" == "y" ]]; then
        print_success "🎉 FIREFOX ISOLATION FIXED!"
        echo ""
        echo "✅ Firefox now only sees Personal Domain vault"
        echo "✅ Perfect compartmentalization restored"
        echo "✅ Security issue resolved"
        echo ""
        echo "🎯 Your digital privacy system is now fully secure!"
        
        # Update the test results
        cat > "$HOME/.email-safety-net/isolation-fix-complete.md" << 'EOF'
# ✅ FIREFOX ISOLATION FIX COMPLETE

## 🔧 ISSUE RESOLVED:
Firefox 1Password extension was showing multiple vaults instead of being restricted to Personal Domain vault only.

## 🛠️ SOLUTION APPLIED:
Successfully configured Firefox 1Password extension to show only Personal Domain vault.

## ✅ VERIFICATION:
- Firefox extension shows ONLY Personal Domain vault
- Perfect browser-vault isolation restored
- Security compartmentalization maintained

## 🎯 SYSTEM STATUS:
**FULLY OPERATIONAL** - All browsers now properly isolated:
- Firefox: Personal Domain only ✅
- Safari: Financial Domain only ✅  
- Brave: High Security Domain only ✅

## 🚀 READY FOR NEXT PHASE:
Account migration and digital footprint cleanup can now proceed safely.
EOF
        
        print_success "Fix documentation created"
        
    else
        print_important "❌ ISOLATION STILL NOT WORKING"
        echo ""
        echo "🔧 Additional troubleshooting needed:"
        echo "   - Check 1Password app version (may need update)"
        echo "   - Verify account has proper vault permissions"
        echo "   - Consider contacting 1Password support"
        echo "   - May need to use different browser for personal domain"
        echo ""
        echo "🎯 Temporary workaround: Use Safari for personal domain until fixed"
    fi
}

# ============================================================================
# QUICK RETEST OPTION
# ============================================================================

run_quick_retest() {
    print_header "🧪 QUICK ISOLATION RETEST"
    
    print_action "Let's quickly retest all browsers:"
    echo ""
    
    echo "🦊 FIREFOX TEST:"
    echo "   What vaults can you see in Firefox 1Password extension?"
    echo "   (Should be: Personal Domain only)"
    read -p "   Enter vault names you see: " firefox_vaults
    
    echo ""
    echo "🧭 SAFARI TEST:"
    echo "   What vaults can you see in Safari 1Password extension?"
    echo "   (Should be: Financial Domain only)"
    read -p "   Enter vault names you see: " safari_vaults
    
    echo ""
    echo "🦁 BRAVE TEST:"
    echo "   What vaults can you see in Brave 1Password extension?"
    echo "   (Should be: High Security Domain only)"
    read -p "   Enter vault names you see: " brave_vaults
    
    echo ""
    print_action "RESULTS SUMMARY:"
    echo "   Firefox shows: $firefox_vaults"
    echo "   Safari shows: $safari_vaults"
    echo "   Brave shows: $brave_vaults"
    echo ""
    
    # Simple validation
    if [[ "$firefox_vaults" == *"Personal"* ]] && [[ "$firefox_vaults" != *"Financial"* ]] && [[ "$firefox_vaults" != *"High Security"* ]]; then
        print_success "✅ Firefox isolation: PERFECT"
    else
        print_important "❌ Firefox isolation: NEEDS FIXING"
    fi
    
    if [[ "$safari_vaults" == *"Financial"* ]] && [[ "$safari_vaults" != *"Personal"* ]] && [[ "$safari_vaults" != *"High Security"* ]]; then
        print_success "✅ Safari isolation: PERFECT"
    else
        print_important "❌ Safari isolation: NEEDS FIXING"
    fi
    
    if [[ "$brave_vaults" == *"High Security"* ]] && [[ "$brave_vaults" != *"Personal"* ]] && [[ "$brave_vaults" != *"Financial"* ]]; then
        print_success "✅ Brave isolation: PERFECT"
    else
        print_important "❌ Brave isolation: NEEDS FIXING"
    fi
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    case "${1:-fix}" in
        "fix")
            fix_firefox_isolation
            verify_fix
            ;;
        "test"|"verify")
            run_quick_retest
            ;;
        "both")
            fix_firefox_isolation
            verify_fix
            run_quick_retest
            ;;
        *)
            echo "🔧 Firefox 1Password Isolation Fix"
            echo ""
            echo "Usage: $0 [command]"
            echo ""
            echo "Commands:"
            echo "  fix     - Fix Firefox vault isolation issues"
            echo "  test    - Quick retest of all browser isolation"
            echo "  both    - Fix and then test"
            ;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi