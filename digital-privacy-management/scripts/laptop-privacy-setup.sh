#!/bin/bash
# Laptop Privacy & Browser Compartmentalization Setup
# Sets up a clean laptop for compartmentalized private browsing

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SETUP_LOG="$HOME/.privacy-setup.log"

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
    echo "$(date '+%Y-%m-%d %H:%M:%S') - CRITICAL: $1" >> "$SETUP_LOG"
}

print_warning() {
    echo -e "${YELLOW}⚠️  WARNING: $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - WARNING: $1" >> "$SETUP_LOG"
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
    echo -e "${PURPLE}🔧 $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ACTION: $1" >> "$SETUP_LOG"
}

# ============================================================================
# SYSTEM PRIVACY HARDENING
# ============================================================================

harden_system_privacy() {
    print_header "🛡️ SYSTEM PRIVACY HARDENING"
    
    print_action "Configuring system privacy settings..."
    
    # Disable Siri data collection
    defaults write com.apple.assistant.support "Siri Data Sharing Opt-In Status" -int 2
    print_success "Disabled Siri data sharing"
    
    # Disable location-based Apple ads
    defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false
    print_success "Disabled location-based Apple ads"
    
    # Disable crash reporting
    defaults write com.apple.CrashReporter DialogType none
    print_success "Disabled automatic crash reporting"
    
    # Disable analytics sharing
    defaults write "/Library/Application Support/CrashReporter/DiagnosticMessagesHistory.plist" AutoSubmit -bool false
    defaults write "/Library/Application Support/CrashReporter/DiagnosticMessagesHistory.plist" SeedAutoSubmit -bool false
    print_success "Disabled analytics sharing"
    
    # Configure Safari privacy settings
    defaults write com.apple.Safari UniversalSearchEnabled -bool false
    defaults write com.apple.Safari SuppressSearchSuggestions -bool true
    defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true
    defaults write com.apple.Safari AutoFillFromAddressBook -bool false
    defaults write com.apple.Safari AutoFillPasswords -bool false
    defaults write com.apple.Safari AutoFillCreditCardData -bool false
    defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false
    print_success "Configured Safari privacy settings"
    
    # Set secure DNS (Quad9)
    print_action "Setting secure DNS servers..."
    networksetup -setdnsservers "Wi-Fi" 9.9.9.9 149.112.112.112
    if [[ $? -eq 0 ]]; then
        print_success "Set secure DNS servers (Quad9)"
    else
        print_warning "Could not set DNS - may need manual configuration"
    fi
}

# ============================================================================
# BROWSER INSTALLATION & SETUP
# ============================================================================

install_browsers() {
    print_header "🌐 BROWSER INSTALLATION & COMPARTMENTALIZATION"
    
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        print_action "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        print_success "Homebrew installed"
    else
        print_info "Homebrew already installed"
    fi
    
    # Install browsers for compartmentalization
    print_action "Installing compartmentalized browsers..."
    
    # Firefox (Personal domain)
    if ! brew list --cask firefox &> /dev/null; then
        brew install --cask firefox
        print_success "Firefox installed (Personal domain)"
    else
        print_info "Firefox already installed"
    fi
    
    # Safari already installed (Financial domain)
    print_info "Safari (built-in) assigned to Financial domain"
    
    # Brave (High-security domain)
    if ! brew list --cask brave-browser &> /dev/null; then
        brew install --cask brave-browser
        print_success "Brave installed (High-security domain)"
    else
        print_info "Brave already installed"
    fi
    
    # Tor Browser (Travel/Anonymous domain)
    if ! brew list --cask tor-browser &> /dev/null; then
        brew install --cask tor-browser
        print_success "Tor Browser installed (Travel/Anonymous domain)"
    else
        print_info "Tor Browser already installed"
    fi
}

# ============================================================================
# BROWSER PROFILE CONFIGURATION
# ============================================================================

configure_browser_profiles() {
    print_header "👤 BROWSER PROFILE CONFIGURATION"
    
    # Create browser profile directories
    mkdir -p "$HOME/.browser-profiles"
    
    # Create profile setup scripts
    cat > "$HOME/.browser-profiles/setup-profiles.sh" << 'EOF'
#!/bin/bash
# Browser Profile Setup for Domain Compartmentalization

echo "🌐 BROWSER DOMAIN ASSIGNMENT:"
echo ""
echo "🎭 PERSONAL DOMAIN - Arc or Firefox"
echo "  • Social media (Twitter, Instagram, Reddit)"
echo "  • Entertainment (Netflix, YouTube, Spotify)"
echo "  • Personal shopping (Amazon personal)"
echo "  • Dating and social connections"
echo ""
echo "🏦 FINANCIAL DOMAIN - Safari"
echo "  • Banking websites"
echo "  • Investment platforms"
echo "  • Credit card accounts" 
echo "  • Cryptocurrency exchanges"
echo "  • Insurance portals"
echo ""
echo "💼 PROFESSIONAL DOMAIN - Firefox"
echo "  • Work email and corporate systems"
echo "  • LinkedIn professional profile"
echo "  • Work-related SaaS tools"
echo "  • Professional development"
echo ""
echo "🔐 HIGH-SECURITY DOMAIN - Brave"
echo "  • Crypto wallets and DeFi"
echo "  • Privacy tools setup"
echo "  • Secure communications"
echo "  • VPN/security services"
echo ""
echo "✈️ TRAVEL/TEMPORARY DOMAIN - Tor Browser"
echo "  • Hotel and travel bookings"
echo "  • Temporary services"
echo "  • Anonymous browsing"
echo "  • Disposable accounts"
echo ""
echo "⚠️ NEVER mix domains in the same browser!"
echo "⚠️ Always check which browser you're using before logging in!"
EOF

    chmod +x "$HOME/.browser-profiles/setup-profiles.sh"
    print_success "Created browser profile configuration guide"
    
    # Create domain verification checklist
    cat > "$HOME/.browser-profiles/domain-checklist.md" << 'EOF'
# 🔐 DOMAIN VERIFICATION CHECKLIST

## Before accessing ANY website, verify:

### 1. Browser Check:
- [ ] Firefox = Professional domain only
- [ ] Safari = Financial domain only  
- [ ] Arc/Personal Browser = Personal domain only
- [ ] Brave = High-security domain only
- [ ] Tor = Travel/temporary only

### 2. Account Type Check:
- [ ] Personal/Social → Arc/Personal browser only
- [ ] Banking/Finance → Safari only
- [ ] Work/Corporate → Firefox only
- [ ] Crypto/Security → Brave only
- [ ] Travel/Temporary → Tor only

### 3. Security Level Check:
- [ ] High-value financial → Safari with hardware 2FA
- [ ] Crypto/DeFi → Brave with hardware wallet
- [ ] Work systems → Firefox with corporate SSO
- [ ] Personal accounts → Arc/Personal browser with standard 2FA
- [ ] Temporary accounts → Tor with disposable credentials

## 🚨 EMERGENCY PROTOCOLS:

### If you accidentally cross domains:
1. IMMEDIATELY log out of the account
2. Clear all cookies and data for that browser
3. Change the account password
4. Review account activity for unauthorized access
5. Re-login in the correct browser only

### If browser is compromised:
1. Clear all browsing data
2. Reset browser to defaults
3. Change passwords for all accounts used in that browser
4. Enable additional 2FA if available
5. Monitor accounts for unusual activity
EOF

    print_success "Created domain verification checklist"
}

# ============================================================================
# PRIVACY TOOLS INSTALLATION
# ============================================================================

install_privacy_tools() {
    print_header "🔧 PRIVACY TOOLS INSTALLATION"
    
    print_action "Installing essential privacy and security tools..."
    
    # VPN clients
    if ! brew list --cask protonvpn &> /dev/null; then
        brew install --cask protonvpn
        print_success "ProtonVPN installed"
    fi
    
    # Password managers (but not logging in yet)
    if ! brew list --cask bitwarden &> /dev/null; then
        brew install --cask bitwarden
        print_success "Bitwarden installed (setup later)"
    fi
    
    if ! brew list --cask 1password &> /dev/null; then
        brew install --cask 1password
        print_success "1Password installed (setup later)"
    fi
    
    # Secure communication
    if ! brew list --cask signal &> /dev/null; then
        brew install --cask signal
        print_success "Signal installed"
    fi
    
    # File encryption
    if ! command -v gpg &> /dev/null; then
        brew install gnupg
        print_success "GnuPG installed"
    fi
    
    # Network monitoring
    if ! brew list --cask little-snitch &> /dev/null; then
        brew install --cask little-snitch
        print_success "Little Snitch installed (firewall)"
    fi
    
    # Ad blocking
    if ! brew list --cask adguard &> /dev/null; then
        brew install --cask adguard
        print_success "AdGuard installed"
    fi
}

# ============================================================================
# BROWSER EXTENSION SETUP
# ============================================================================

setup_browser_extensions() {
    print_header "🧩 BROWSER EXTENSION RECOMMENDATIONS"
    
    cat > "$HOME/.browser-profiles/extension-setup.md" << 'EOF'
# 🧩 BROWSER EXTENSION SETUP BY DOMAIN

## Firefox (Personal Domain):
### Essential Extensions:
- uBlock Origin (ad/tracker blocking)
- Privacy Badger (tracker protection)
- ClearURLs (remove tracking parameters)
- Facebook Container (isolate Facebook tracking)
- DuckDuckGo Privacy Essentials

### Setup Instructions:
1. Open Firefox
2. Go to Add-ons menu (Cmd+Shift+A)
3. Search and install each extension
4. Configure uBlock Origin in medium mode
5. Enable all Privacy Badger protections

## Chrome (Financial Domain):
### Minimal Extensions (Security Focus):
- uBlock Origin (essential blocking only)
- HTTPS Everywhere (force secure connections)
- Password manager extension (when ready)

### Security Notes:
- Keep extensions minimal for financial browsing
- Never install crypto-related extensions in this browser
- Always verify bank website certificates

## Safari (Professional Domain):
### Built-in Features:
- Enable "Prevent cross-site tracking"
- Enable "Hide IP address from trackers"
- Use Safari's built-in password manager for work accounts

### Minimal Extensions:
- AdGuard for Safari (if needed)
- Corporate SSO extensions only

## Brave (High-Security Domain):
### Built-in Features (Use These):
- Brave Shields (maximum protection)
- Built-in Tor browsing for sensitive activities
- Built-in ad/tracker blocking

### Additional Extensions:
- Hardware wallet extensions (MetaMask, etc.)
- Privacy-focused extensions only
- NO social media or tracking extensions

## Tor Browser (Travel Domain):
### DO NOT INSTALL EXTENSIONS:
- Tor Browser should remain stock
- Extensions can compromise anonymity
- Use built-in security settings only

# 🔧 EXTENSION SECURITY SETTINGS:

## uBlock Origin Configuration:
1. Open uBlock Origin settings
2. Enable "I am an advanced user"
3. Set to medium mode
4. Block all 3rd party scripts and frames
5. Enable all filter lists except language-specific

## Privacy Badger Configuration:
1. Enable "Send Global Privacy Control signal"
2. Enable "Prevent WebRTC from leaking local IP"
3. Enable "Replace social media buttons"
4. Review and approve all blocked trackers

## General Extension Security:
- Only install extensions from official stores
- Review permissions carefully
- Regularly audit installed extensions
- Remove unused extensions immediately
- Never install browser extensions for password management in financial browsers
EOF

    print_success "Created browser extension setup guide"
}

# ============================================================================
# FINAL SETUP AND VERIFICATION
# ============================================================================

create_verification_scripts() {
    print_header "✅ VERIFICATION & MAINTENANCE SCRIPTS"
    
    # Create browser verification script
    cat > "$HOME/.browser-profiles/verify-setup.sh" << 'EOF'
#!/bin/bash
# Browser Setup Verification Script

echo "🔍 BROWSER COMPARTMENTALIZATION VERIFICATION"
echo ""

# Check installed browsers
echo "📋 INSTALLED BROWSERS:"
if [[ -d "/Applications/Firefox.app" ]]; then
    echo "✅ Firefox (Personal Domain)"
else
    echo "❌ Firefox missing"
fi

if [[ -d "/Applications/Google Chrome.app" ]]; then
    echo "✅ Chrome (Financial Domain)"
else
    echo "❌ Chrome missing"
fi

if [[ -d "/Applications/Safari.app" ]]; then
    echo "✅ Safari (Professional Domain)"
else
    echo "❌ Safari missing"
fi

if [[ -d "/Applications/Brave Browser.app" ]]; then
    echo "✅ Brave (High-Security Domain)"
else
    echo "❌ Brave missing"
fi

if [[ -d "/Applications/Tor Browser.app" ]]; then
    echo "✅ Tor Browser (Travel Domain)"
else
    echo "❌ Tor Browser missing"
fi

echo ""
echo "🔐 SECURITY TOOLS:"
if [[ -d "/Applications/ProtonVPN.app" ]]; then
    echo "✅ ProtonVPN"
else
    echo "❌ ProtonVPN missing"
fi

if [[ -d "/Applications/Bitwarden.app" ]]; then
    echo "✅ Bitwarden (not configured yet)"
else
    echo "❌ Bitwarden missing"
fi

if [[ -d "/Applications/1Password 7 - Password Manager.app" ]] || [[ -d "/Applications/1Password.app" ]]; then
    echo "✅ 1Password (not configured yet)"
else
    echo "❌ 1Password missing"
fi

echo ""
echo "🌐 DNS VERIFICATION:"
DNS_SERVERS=$(networksetup -getdnsservers "Wi-Fi" 2>/dev/null)
if [[ $DNS_SERVERS == *"9.9.9.9"* ]]; then
    echo "✅ Secure DNS configured (Quad9)"
else
    echo "⚠️  DNS may need manual configuration"
    echo "Current DNS: $DNS_SERVERS"
fi

echo ""
echo "🎯 NEXT STEPS:"
echo "1. Set up email addresses for each domain"
echo "2. Configure password managers with separate vaults"
echo "3. Install browser extensions per domain"
echo "4. Test each browser with appropriate accounts"
echo "5. Set up monitoring and backup procedures"
EOF

    chmod +x "$HOME/.browser-profiles/verify-setup.sh"
    print_success "Created verification script"
    
    # Create daily maintenance script
    cat > "$HOME/.browser-profiles/daily-maintenance.sh" << 'EOF'
#!/bin/bash
# Daily Privacy Maintenance Script

echo "🔧 DAILY PRIVACY MAINTENANCE"
echo ""

echo "🧹 BROWSER CLEANUP:"
echo "1. Clear cookies and data in Tor Browser"
echo "2. Review recently visited sites for domain violations"
echo "3. Update browser extensions if available"
echo "4. Check for browser security updates"
echo ""

echo "🔐 SECURITY CHECKS:"
echo "1. Verify VPN is connected when needed"
echo "2. Check for password manager security alerts"
echo "3. Review any security notifications"
echo "4. Verify 2FA devices are accessible"
echo ""

echo "📊 MONITORING:"
echo "1. Check breach monitoring alerts"
echo "2. Review account activity logs"
echo "3. Verify backup system integrity"
echo "4. Update threat model if needed"
echo ""

echo "✅ Run this checklist daily for optimal security!"
EOF

    chmod +x "$HOME/.browser-profiles/daily-maintenance.sh"
    print_success "Created daily maintenance script"
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    case "${1:-full}" in
        "system")
            harden_system_privacy
            ;;
        "browsers")
            install_browsers
            configure_browser_profiles
            ;;
        "tools")
            install_privacy_tools
            ;;
        "extensions")
            setup_browser_extensions
            ;;
        "verify")
            "$HOME/.browser-profiles/verify-setup.sh"
            ;;
        "full")
            print_header "🚀 COMPLETE LAPTOP PRIVACY SETUP"
            harden_system_privacy
            install_browsers
            configure_browser_profiles
            install_privacy_tools
            setup_browser_extensions
            create_verification_scripts
            
            print_success "Laptop privacy setup completed!"
            print_warning "Please review all files in ~/.browser-profiles/"
            print_info "Run ~/.browser-profiles/verify-setup.sh to verify installation"
            ;;
        *)
            echo "🔐 Laptop Privacy & Browser Setup"
            echo ""
            echo "Usage: $0 [command]"
            echo ""
            echo "Commands:"
            echo "  system     - Harden system privacy settings"
            echo "  browsers   - Install and configure browsers"
            echo "  tools      - Install privacy tools"
            echo "  extensions - Set up browser extensions"
            echo "  verify     - Verify setup completion"
            echo "  full       - Complete setup (default)"
            ;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi