#!/bin/bash
# Simultaneous Email Creation & Safety Net Setup
# Creates new domain emails while establishing comprehensive safety measures

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SETUP_LOG="$HOME/.email-domain-setup.log"
SAFETY_NET_DIR="$HOME/.email-safety-net"

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
# STEP 1: EMAIL PROVIDER RESEARCH & BROWSER PREP
# ============================================================================

prepare_email_setup() {
    print_header "🔍 EMAIL PROVIDER RESEARCH & BROWSER PREPARATION"
    
    mkdir -p "$SAFETY_NET_DIR"
    
    print_action "Opening email provider websites in correct browsers..."
    
    # Open ProtonMail in Firefox (Personal/Professional domain)
    print_info "Opening ProtonMail in Firefox for Personal domain setup..."
    if command -v open &> /dev/null; then
        open -a "Firefox" "https://protonmail.com/signup" &
        sleep 2
    fi
    
    # Open Tutanota in Safari (Financial domain)
    print_info "Opening Tutanota in Safari for Financial domain setup..."
    if command -v open &> /dev/null; then
        open -a "Safari" "https://tutanota.com/signup" &
        sleep 2
    fi
    
    # Open ProtonMail in Brave (High-security domain)
    print_info "Opening ProtonMail in Brave for High-security domain setup..."
    if command -v open &> /dev/null; then
        open -a "Brave Browser" "https://protonmail.com/signup" &
        sleep 2
    fi
    
    cat > "$SAFETY_NET_DIR/email-creation-guide.md" << 'EOF'
# 📧 EMAIL CREATION GUIDE
## Simultaneous domain email setup with safety nets

## 🌐 BROWSER & EMAIL ASSIGNMENTS

### 1. Personal Domain Email - Firefox
**Website**: https://protonmail.com/signup (ALREADY OPENED)
**Browser**: Firefox ONLY
**Recommended Username**: yourname.personal@protonmail.com
**Purpose**: Social media, entertainment, personal shopping
**Security**: Standard 2FA + recovery phone

### 2. Financial Domain Email - Safari  
**Website**: https://tutanota.com/signup (ALREADY OPENED)
**Browser**: Safari ONLY
**Recommended Username**: yourname.finance@tutanota.de
**Purpose**: Banking, investments, insurance
**Security**: Hardware 2FA + secure recovery

### 3. High-Security Domain Email - Brave
**Website**: https://protonmail.com/signup (ALREADY OPENED)  
**Browser**: Brave ONLY
**Recommended Username**: yourname.secure@protonmail.com
**Purpose**: Crypto, privacy tools, sensitive communications
**Security**: Maximum security + hardware keys

## 📋 EMAIL CREATION CHECKLIST

### For Each Email Account:
- [ ] Choose strong, unique username
- [ ] Use different password for each (generate with password manager)
- [ ] Enable 2FA immediately after creation
- [ ] Set up recovery methods (different for each domain)
- [ ] Test login works in designated browser
- [ ] NEVER log into this email from other browsers

### Security Settings to Enable:
- [ ] 2FA/Two-factor authentication
- [ ] Login notifications
- [ ] Encrypted storage (if available)
- [ ] Privacy mode/tracking protection
- [ ] Strong password requirements
- [ ] Recovery email (use different providers)

## 🔐 DOMAIN-SPECIFIC SECURITY LEVELS

### Personal Domain (Firefox + ProtonMail):
- Standard ProtonMail security
- Phone number recovery
- Backup email recovery (use Tutanota)
- Standard 2FA app

### Financial Domain (Safari + Tutanota):
- Maximum Tutanota security settings
- Secure phone number (Google Voice + physical backup)
- NO backup email (isolated for security)
- Hardware 2FA when possible

### High-Security Domain (Brave + ProtonMail):
- ProtonMail with custom domain (if possible)
- Multiple recovery methods
- Air-gapped 2FA backup
- Hardware security key required
EOF

    print_success "Email creation guide prepared and browsers opened"
    print_warning "Complete email creation while we set up safety nets..."
}

# ============================================================================
# STEP 2: CRITICAL ACCOUNT IDENTIFICATION
# ============================================================================

identify_critical_accounts() {
    print_header "🎯 CRITICAL ACCOUNT IDENTIFICATION"
    
    cat > "$SAFETY_NET_DIR/account-identification-worksheet.md" << 'EOF'
# 🎯 CRITICAL ACCOUNT IDENTIFICATION WORKSHEET
## Complete while creating emails

## 📱 IMMEDIATE RESEARCH TASKS

### 1. Check Your Phone
Open each app and note:
- Which email it's registered with
- Whether it's critical or can be recreated
- Which domain it should belong to

### 2. Check Your Computer
Review:
- Browser saved passwords
- Keychain/credential manager
- Bookmark folders for frequent sites
- Recently visited websites

### 3. Think Through Daily Activities
What do you use every day that requires an account?
- Banking and money management
- Work and professional tools
- Communication and social
- Entertainment and shopping

## 🏦 FINANCIAL ACCOUNTS (MIGRATE FIRST)
*Write down each account you discover:*

**Banks & Credit Cards:**
- [ ] Primary bank: ________________
- [ ] Secondary bank: ________________  
- [ ] Credit card 1: ________________
- [ ] Credit card 2: ________________
- [ ] Other financial: ________________

**Investments & Savings:**
- [ ] 401k/Retirement: ________________
- [ ] Brokerage: ________________
- [ ] Robo-advisor: ________________
- [ ] Crypto exchange: ________________
- [ ] Other investments: ________________

**Payment Services:**
- [ ] PayPal: ________________
- [ ] Venmo: ________________
- [ ] Cash App: ________________
- [ ] Apple Pay: ________________
- [ ] Other payments: ________________

## 📱 ESSENTIAL INFRASTRUCTURE (MIGRATE SECOND)
- [ ] Phone/Mobile account: ________________
- [ ] Current password manager: ________________
- [ ] Primary cloud storage: ________________
- [ ] Backup services: ________________
- [ ] Domain registrations: ________________

## 💼 PROFESSIONAL ACCOUNTS (EVALUATE DOMAIN)
- [ ] Work email: ________________ (Keep on work email?)
- [ ] LinkedIn: ________________ (Professional domain?)
- [ ] GitHub/Development: ________________
- [ ] Professional services: ________________
- [ ] Industry tools: ________________

## 🎭 PERSONAL ACCOUNTS (MIGRATE LATER)
- [ ] Facebook: ________________
- [ ] Twitter/X: ________________
- [ ] Instagram: ________________
- [ ] Amazon: ________________
- [ ] Netflix: ________________
- [ ] Spotify: ________________
- [ ] Gaming accounts: ________________

## 🏥 HEALTH & GOVERNMENT (MIGRATE CAREFULLY)
- [ ] Health insurance: ________________
- [ ] Doctor portals: ________________
- [ ] Pharmacy: ________________
- [ ] IRS/Tax services: ________________
- [ ] DMV/Vehicle: ________________
- [ ] Benefits/Government: ________________

## 📧 CURRENT EMAIL ANALYSIS

### Your Current Email Usage:
Current Primary Email: ________________
Email Provider: ________________
Estimated # of Accounts: ________________
Most Critical Accounts: ________________
Biggest Migration Concerns: ________________

### Safety Net Planning:
Can you set up forwarding? ________________
Do you have backup recovery methods? ________________
Who can help in emergency? ________________
What's your biggest fear about migration? ________________
EOF

    print_success "Account identification worksheet created"
    print_info "Complete this while emails are being created"
}

# ============================================================================
# STEP 3: SAFETY NET ESTABLISHMENT
# ============================================================================

establish_safety_nets() {
    print_header "🛡️ SAFETY NET ESTABLISHMENT"
    
    cat > "$SAFETY_NET_DIR/safety-net-setup.md" << 'EOF'
# 🛡️ SAFETY NET SETUP GUIDE
## Complete BEFORE any account migration

## 📬 EMAIL FORWARDING SETUP

### Option A: Corporate Email Forwarding (High Risk)
**IF your corporate IT allows forwarding:**
1. Log into corporate email
2. Go to Settings → Forwarding
3. Add your new personal domain email
4. Test forwarding with a test email
5. Document that forwarding is active

**RISK**: Corporate monitoring of forwarding rules

### Option B: Manual Email Monitoring (Safer)
**Recommended approach for corporate email:**
1. Check corporate email daily for first 2 weeks
2. Check every 2-3 days for next month
3. Look for emails from services you're migrating
4. Forward important emails manually to new addresses
5. Document any patterns you notice

### Option C: Email App Setup
**Set up old email in a dedicated email app:**
1. Use Apple Mail or Outlook
2. Add old email account
3. Set to check every few hours
4. Use for monitoring only (no sending)
5. Gradually reduce checking frequency

## 📞 BACKUP COMMUNICATION CHANNELS

### Primary Backup: Signal
1. Install Signal on phone
2. Set up with trusted contacts
3. Share Signal number with family
4. Use for emergency communications during migration
5. Test that trusted contacts can reach you

### Secondary Backup: Phone Number
1. Verify your phone number is current
2. Document which accounts use it for recovery
3. Test that you can receive SMS codes
4. Consider Google Voice as backup number
5. Update emergency contacts with new numbers

### Tertiary Backup: Trusted Contact
1. Choose someone who can help in emergency
2. Give them backup contact information
3. Explain the migration project
4. Provide them with emergency procedures
5. Test communication methods

## 📋 EMERGENCY RECOVERY DOCUMENTATION

### Create Physical Backup:
1. Write down all account recovery phone numbers
2. Document customer service numbers for critical accounts
3. Note physical addresses for important services (banks)
4. Store in secure location (not on computer)
5. Give copy to trusted contact

### Digital Backup:
1. Export password manager to encrypted file
2. Store on USB drive separate from computer
3. Encrypt with strong password
4. Store USB drive in different location
5. Test that backup can be restored

## 🔄 TESTING SAFETY NETS

### Test Email Forwarding:
1. Send test email to old address
2. Verify it forwards to new address
3. Check timing (should be immediate)
4. Test with different email types
5. Document any issues

### Test Backup Communications:
1. Have trusted contact try to reach you
2. Test Signal messaging works
3. Verify phone calls work
4. Test SMS recovery codes
5. Confirm emergency procedures

### Test Recovery Documentation:
1. Try logging into one account using backup info
2. Verify phone numbers work for account recovery
3. Test customer service contact information
4. Confirm physical backup is accessible
5. Update any outdated information

## 📊 SAFETY NET VERIFICATION CHECKLIST

Before starting any migration:
- [ ] Email forwarding or monitoring plan active
- [ ] Signal set up with trusted contacts
- [ ] Phone number verified and backed up
- [ ] Emergency contact person briefed
- [ ] Physical backup documentation created
- [ ] Digital backup secured and tested
- [ ] All safety nets tested and working
- [ ] Emergency procedures documented and understood

## 🚨 EMERGENCY PROCEDURES

### If You Get Locked Out:
1. Use backup phone number for recovery
2. Contact customer service directly
3. Visit physical location if possible (banks)
4. Use trusted contact for assistance
5. Access physical backup documentation

### If Old Email Gets Compromised:
1. Immediately change passwords on all migrated accounts
2. Check activity logs on financial accounts
3. Enable additional 2FA where possible
4. Contact banks and critical services
5. Monitor credit reports for unusual activity

### If New Email Has Problems:
1. Revert to old email immediately
2. Remove new email from partially migrated accounts
3. Re-establish old email monitoring
4. Contact support for affected accounts
5. Wait 24-48 hours before trying again

## 📈 CONFIDENCE BUILDING

### Start Small:
1. Test migration with one low-risk account first
2. Verify the process works end-to-end
3. Confirm safety nets catch any issues
4. Build confidence before moving to critical accounts
5. Document lessons learned for next accounts

This safety net gives you confidence to migrate knowing you won't lose access to anything critical!
EOF

    print_success "Safety net establishment guide created"
}

# ============================================================================
# STEP 4: MIGRATION TIMELINE & CHECKLIST
# ============================================================================

create_migration_timeline() {
    print_header "📅 MIGRATION TIMELINE & CHECKLIST"
    
    cat > "$SAFETY_NET_DIR/migration-timeline.md" << 'EOF'
# 📅 MIGRATION TIMELINE & CHECKLIST
## Your structured 4-week migration plan

## 🎯 THIS WEEK (Week 1): Foundation Setup
### Day 1-2: Email Creation
- [ ] Create Personal domain email in Firefox
- [ ] Create Financial domain email in Safari  
- [ ] Create High-security domain email in Brave
- [ ] Test each email works in its designated browser
- [ ] Set up 2FA on all new emails

### Day 3-4: Safety Net Setup
- [ ] Set up email forwarding or monitoring plan
- [ ] Install Signal and add trusted contacts
- [ ] Create emergency contact documentation
- [ ] Test all backup communication methods
- [ ] Create physical and digital backups

### Day 5-7: Account Discovery
- [ ] Complete account identification worksheet
- [ ] Research phone apps and their email associations
- [ ] Check browser saved passwords
- [ ] Identify most critical accounts for first migration
- [ ] Prioritize accounts by risk and importance

## 📋 WEEK 2: Critical Account Migration
### Focus: Banking, Financial, Essential Infrastructure

**Migration Process for Each Account:**
1. [ ] Log in with current email
2. [ ] Add new domain email as secondary/backup
3. [ ] Verify new email works (check verification email)
4. [ ] Test login with new email
5. [ ] Change primary email to new domain email
6. [ ] Update password and enable stronger 2FA
7. [ ] Download/backup important data
8. [ ] Set up security alerts to new email
9. [ ] Test everything works with new email
10. [ ] Mark as completed and document

**Target Accounts Week 2:**
- [ ] Primary bank account
- [ ] Most-used credit card
- [ ] Password manager account
- [ ] Primary phone/mobile account
- [ ] Most critical cloud storage

## 📋 WEEK 3: High-Value Personal & Professional
### Focus: Important personal accounts and professional services

**Target Accounts Week 3:**
- [ ] Secondary financial accounts
- [ ] Professional accounts (LinkedIn, etc.)
- [ ] Important subscription services
- [ ] Main social media accounts
- [ ] Primary shopping accounts (Amazon, etc.)

## 📋 WEEK 4: Medium-Value Accounts
### Focus: Less critical but regularly used accounts

**Target Accounts Week 4:**
- [ ] Entertainment services (Netflix, Spotify)
- [ ] Secondary social media
- [ ] Gaming platforms
- [ ] Newsletter subscriptions
- [ ] Less critical shopping accounts

## 📋 MONTH 2+: Cleanup & Independence
### Focus: Final cleanup and legacy email reduction

**Target Activities:**
- [ ] Delete or abandon low-value accounts
- [ ] Test all migrated accounts work independently
- [ ] Reduce old email monitoring frequency
- [ ] Update all emergency contacts with new emails
- [ ] Plan eventual old email closure

## 🎯 DAILY MIGRATION ROUTINE

### Each Day During Migration:
1. **Morning**: Check old email for any urgent messages
2. **Work Time**: Migrate 1-2 accounts using the process above
3. **Evening**: Test migrated accounts and update documentation
4. **Before Bed**: Check new emails for any issues

### Weekly Review:
1. **Count**: How many accounts migrated this week?
2. **Issues**: Any problems encountered?
3. **Safety**: All safety nets still working?
4. **Confidence**: Feeling comfortable with the process?
5. **Adjustments**: Any changes needed for next week?

## 📊 SUCCESS METRICS

### Week 1 Success:
- [ ] All new emails created and tested
- [ ] Safety nets established and tested
- [ ] Account discovery completed
- [ ] Migration plan finalized
- [ ] Confidence in proceeding

### Week 2 Success:
- [ ] All critical financial accounts migrated
- [ ] No loss of access to any accounts
- [ ] Safety nets caught any issues
- [ ] New emails receiving important messages
- [ ] Old email monitoring working

### Month 1 Success:
- [ ] 80%+ of active accounts migrated
- [ ] Comfortable using new domain structure
- [ ] No critical emails missed
- [ ] All safety procedures working
- [ ] Ready to reduce old email dependence

## 🚨 STOP CONDITIONS

### Stop migration immediately if:
- You lose access to any critical account
- Safety nets fail to catch important emails
- You feel overwhelmed or confused
- Technical problems persist
- Any security incidents occur

### Resume when:
- All issues resolved and understood
- Safety nets re-established and tested
- Confidence restored
- Emergency procedures updated
- Backup plans confirmed working

Remember: This is a marathon, not a sprint. Better to go slow and maintain access than rush and get locked out!
EOF

    print_success "Migration timeline and checklist created"
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    case "${1:-full}" in
        "prepare")
            prepare_email_setup
            ;;
        "identify")
            identify_critical_accounts
            ;;
        "safety")
            establish_safety_nets
            ;;
        "timeline")
            create_migration_timeline
            ;;
        "full")
            print_header "🚀 SIMULTANEOUS EMAIL CREATION & SAFETY NET SETUP"
            prepare_email_setup
            identify_critical_accounts
            establish_safety_nets
            create_migration_timeline
            
            print_success "Email creation and safety net setup completed!"
            print_warning "Review all files in $SAFETY_NET_DIR"
            print_info "Create emails in opened browsers while completing worksheets"
            print_critical "Test each email in its designated browser ONLY"
            ;;
        *)
            echo "📧 Simultaneous Email Creation & Safety Net Setup"
            echo ""
            echo "Usage: $0 [command]"
            echo ""
            echo "Commands:"
            echo "  prepare   - Open email providers in correct browsers"
            echo "  identify  - Create account identification worksheet"
            echo "  safety    - Establish safety net procedures"
            echo "  timeline  - Create migration timeline and checklist"
            echo "  full      - Complete simultaneous setup (default)"
            ;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi