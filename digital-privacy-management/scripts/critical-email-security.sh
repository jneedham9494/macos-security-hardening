#!/bin/bash
# Critical Email & Account Security Migration Strategy
# Addresses the dual risk of missing critical emails vs leaving vulnerable accounts open

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SECURITY_LOG="$HOME/.email-security-migration.log"
CRITICAL_ACCOUNTS_DIR="$HOME/.critical-accounts"

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
    echo "$(date '+%Y-%m-%d %H:%M:%S') - CRITICAL: $1" >> "$SECURITY_LOG"
}

print_warning() {
    echo -e "${YELLOW}⚠️  WARNING: $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - WARNING: $1" >> "$SECURITY_LOG"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - SUCCESS: $1" >> "$SECURITY_LOG"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - INFO: $1" >> "$SECURITY_LOG"
}

# ============================================================================
# DUAL RISK ASSESSMENT
# ============================================================================

assess_dual_risks() {
    print_header "⚖️ DUAL RISK ASSESSMENT"
    
    mkdir -p "$CRITICAL_ACCOUNTS_DIR"
    
    print_critical "RISK 1: Missing critical emails from old account"
    print_critical "RISK 2: Leaving vulnerable accounts open on old email"
    print_warning "These risks require careful balancing and staged approach"
    
    cat > "$CRITICAL_ACCOUNTS_DIR/risk-assessment.md" << 'EOF'
# ⚖️ DUAL RISK ANALYSIS

## 🚨 RISK 1: Missing Critical Emails
### Consequences:
- Locked out of important accounts
- Missing security alerts/breach notifications
- Missing financial statements/alerts
- Missing work/professional communications
- Missing account recovery emails
- Missing subscription renewals/cancellations

### Likelihood: HIGH if not properly managed

## 🚨 RISK 2: Vulnerable Accounts on Old Email
### Consequences:
- Corporate monitoring of personal accounts
- Account takeover if email compromised
- Data mining by employer
- Privacy violations
- Professional reputation damage
- Legal/employment complications

### Likelihood: VERY HIGH with corporate email

## ⚖️ RISK BALANCING STRATEGY
The key is **STAGED MIGRATION** with **SAFETY NETS**
EOF
    
    print_success "Risk assessment documented"
}

# ============================================================================
# STAGED MIGRATION STRATEGY
# ============================================================================

create_staged_migration() {
    print_header "📋 STAGED MIGRATION STRATEGY"
    
    cat > "$CRITICAL_ACCOUNTS_DIR/staged-migration-plan.md" << 'EOF'
# 📋 STAGED MIGRATION STRATEGY
## Balances missing emails vs vulnerable accounts

## PHASE 1: IMMEDIATE SAFETY (Week 1)
### 🛡️ Create Safety Net BEFORE any migration

#### 1.1 Email Forwarding Setup
- Set up forwarding rules on old email
- Forward ALL emails to a secure temporary email
- Use ProtonMail or Tutanota for temporary forwarding
- Document all forwarding rules

#### 1.2 Critical Account Identification
- Banking and financial institutions
- Work/professional accounts
- Primary phone/mobile accounts  
- Password manager account
- Primary cloud storage
- Government services (taxes, benefits, etc.)
- Medical/insurance accounts
- Domain registrations and hosting

#### 1.3 Backup Communication Channels
- Set up Signal with trusted contacts
- Create emergency contact methods
- Document all account recovery phone numbers
- Create physical backup of critical account info

## PHASE 2: CRITICAL ACCOUNT MIGRATION (Week 2)
### 🏦 Migrate ONLY the most critical accounts first

#### 2.1 Banking & Financial (Highest Priority)
```
For each critical financial account:
1. Log in with old email
2. Add new financial domain email as secondary
3. Verify new email works
4. Change primary email to new domain email
5. Test login with new email
6. Update password and enable 2FA
7. Download/backup all statements
8. Set up new security alerts to new email
```

#### 2.2 Essential Infrastructure
- Password manager account
- Primary phone/mobile account
- Essential cloud storage
- Domain registrations

#### 2.3 Critical Verification
- Test all migrated accounts work with new email
- Verify recovery methods work
- Confirm security alerts come to new email
- Document successful migrations

## PHASE 3: PROFESSIONAL SEPARATION (Week 3)
### 💼 Handle work/professional accounts

#### 3.1 Work Account Strategy
```
Options:
A) Keep work email ONLY for work systems
B) Create separate professional domain email
C) Migrate professional services to new professional email
```

#### 3.2 Professional Service Migration
- LinkedIn (if personal profile)
- Professional certifications
- Industry newsletters and services
- Conference and event registrations

## PHASE 4: PERSONAL ACCOUNT MIGRATION (Week 4-6)
### 🎭 Migrate personal accounts systematically

#### 4.1 High-Value Personal
- Primary social media accounts
- Important shopping accounts (Amazon, etc.)
- Entertainment services with purchase history
- Photo storage and personal cloud services

#### 4.2 Medium-Value Personal  
- Secondary social media
- Subscription services
- Gaming platforms
- Newsletter subscriptions

#### 4.3 Low-Value Personal
- Marketing emails
- Old/unused accounts
- Promotional subscriptions
- Test accounts

## PHASE 5: LEGACY EMAIL SECURITY (Month 2-3)
### 🔒 Secure the transition period

#### 5.1 Gradual Email Monitoring Reduction
```
Month 1: Check old email daily
Month 2: Check old email every 2-3 days  
Month 3: Check old email weekly
Month 4: Check old email monthly
Month 6+: Consider closing or archiving
```

#### 5.2 Account Cleanup Verification
- Run final scan for any missed accounts
- Verify all important accounts migrated
- Check for any ongoing email traffic
- Document any remaining legitimate senders

#### 5.3 Legacy Email Closure Decision
```
Safe to close when:
- No important emails for 30+ days
- All critical accounts confirmed migrated
- All forwarding rules verified working
- Backup recovery methods tested
- Emergency procedures documented
```

## 🚨 EMERGENCY PROCEDURES

### If Old Email Gets Compromised:
1. Immediately change passwords on ALL migrated accounts
2. Check activity logs on all financial accounts
3. Enable additional 2FA where possible
4. Contact banks/financial institutions
5. Monitor credit reports for suspicious activity
6. Document the incident and response

### If Missing Critical Email Access:
1. Use account recovery phone numbers
2. Contact customer service directly
3. Use backup recovery emails
4. Use trusted contact recovery methods
5. Present ID at physical locations (banks)

### If Migration Goes Wrong:
1. Revert to old email immediately
2. Remove new email from accounts if problematic
3. Re-establish forwarding rules
4. Contact support for affected accounts
5. Document lessons learned for future attempts

## 📊 MIGRATION TRACKING

### Critical Success Metrics:
- [ ] All critical accounts migrated successfully
- [ ] No missed important emails for 30 days
- [ ] All new accounts work with domain emails
- [ ] Emergency procedures tested and documented
- [ ] Old email monitoring plan established

### Red Flag Indicators:
- Missing account access after migration
- Critical emails not received for >24 hours
- Account recovery failures
- Security alerts to old email only
- Inability to access financial accounts
EOF

    print_success "Staged migration strategy created"
}

# ============================================================================
# CRITICAL ACCOUNT IDENTIFICATION
# ============================================================================

create_critical_account_checklist() {
    print_header "🎯 CRITICAL ACCOUNT IDENTIFICATION"
    
    cat > "$CRITICAL_ACCOUNTS_DIR/critical-accounts-checklist.md" << 'EOF'
# 🎯 CRITICAL ACCOUNTS CHECKLIST
## Accounts that CANNOT be lost access to

## 🏦 FINANCIAL (MIGRATE FIRST - Week 1)
### Primary Banking
- [ ] Primary checking account
- [ ] Primary savings account  
- [ ] Primary credit card
- [ ] Mortgage/loan accounts

### Investments & Retirement
- [ ] 401(k)/retirement accounts
- [ ] Brokerage accounts (Schwab, Fidelity, etc.)
- [ ] Robo-advisors (Betterment, Wealthfront)
- [ ] Cryptocurrency exchanges (Coinbase, etc.)

### Financial Services
- [ ] PayPal/Venmo/Cash App
- [ ] Tax services (TurboTax, H&R Block)
- [ ] Insurance (health, auto, home, life)
- [ ] Credit monitoring services

## 📱 ESSENTIAL INFRASTRUCTURE (MIGRATE FIRST - Week 1)
### Communication & Access
- [ ] Primary phone/mobile account
- [ ] Password manager account (Bitwarden/1Password)
- [ ] Primary cloud storage (Google Drive, iCloud, Dropbox)
- [ ] Two-factor authentication apps (Authy, Google Authenticator)

### Technical Infrastructure
- [ ] Domain registrations and hosting
- [ ] VPN services
- [ ] Email provider accounts themselves
- [ ] Backup services

## 🏛️ GOVERNMENT & LEGAL (MIGRATE SECOND - Week 2)  
### Official Services
- [ ] IRS/tax portal
- [ ] Social Security Administration
- [ ] State DMV/vehicle registration
- [ ] Healthcare.gov or state health exchanges
- [ ] Unemployment/benefits services
- [ ] Voter registration

### Legal & Professional
- [ ] Attorney communications
- [ ] Accountant services
- [ ] Legal document services

## 🏥 HEALTH & MEDICAL (MIGRATE SECOND - Week 2)
### Healthcare Providers
- [ ] Primary care physician portal
- [ ] Specialist doctors
- [ ] Hospital systems
- [ ] Pharmacy accounts
- [ ] Health insurance portals
- [ ] Medical device accounts (if applicable)

## 💼 PROFESSIONAL (EVALUATE CAREFULLY - Week 3)
### Work-Related (Consider keeping on work email)
- [ ] Corporate email and systems
- [ ] Work-provided services
- [ ] Company benefits portals

### Professional Development (Migrate to professional domain)
- [ ] LinkedIn profile
- [ ] Professional certifications
- [ ] Industry associations
- [ ] Conference and event platforms
- [ ] Professional development courses

## 🎭 HIGH-VALUE PERSONAL (MIGRATE THIRD - Week 4)
### Important Personal Services
- [ ] Primary social media (Facebook, Twitter, Instagram)
- [ ] Photo storage with irreplaceable content
- [ ] Music services with large libraries (Spotify, Apple Music)
- [ ] Streaming services with watch history (Netflix, etc.)
- [ ] Shopping accounts with significant history (Amazon, etc.)

### Family & Communication
- [ ] Family sharing accounts
- [ ] School/education accounts for children
- [ ] Utilities (gas, electric, water, internet)
- [ ] Home security systems

## 🎮 MEDIUM-VALUE PERSONAL (MIGRATE FOURTH - Week 5-6)
### Entertainment & Hobbies
- [ ] Gaming platforms (Steam, PlayStation, Xbox)
- [ ] Hobby-related services
- [ ] Subscription boxes
- [ ] News and magazine subscriptions

### Secondary Services
- [ ] Backup social media accounts
- [ ] Secondary shopping accounts
- [ ] App store accounts
- [ ] Ride-sharing (Uber, Lyft)

## 📧 LOW-VALUE/DISPOSABLE (CLEAN UP - Week 6+)
### Consider Deleting Rather Than Migrating
- [ ] Old accounts you never use
- [ ] Marketing email subscriptions
- [ ] Free trial accounts
- [ ] Abandoned social media profiles
- [ ] Old forum accounts
- [ ] Promotional/coupon services

## 🚨 SPECIAL CONSIDERATIONS

### Accounts with Limited Email Changes:
Some services make email changes difficult:
- Government services (may require in-person verification)
- Some banks (may require branch visit)
- Some employers (may not allow email changes)
- Legal services (may require documentation)

### Accounts with Purchased Content:
- iTunes/App Store purchases
- Kindle books and digital content
- Steam games and digital libraries
- Course platforms with purchased content

### Family/Shared Accounts:
- Family sharing services
- Joint bank accounts
- Shared subscription services
- Children's accounts

## 📋 TRACKING TEMPLATE

Service: ________________
Current Email: ________________
Account Type: ________________
Migration Priority: ________________
Migration Date: ________________
New Email: ________________
Status: ________________
Notes: ________________
EOF

    print_success "Critical account checklist created"
}

# ============================================================================
# EMAIL FORWARDING SETUP
# ============================================================================

create_forwarding_strategy() {
    print_header "📬 EMAIL FORWARDING STRATEGY"
    
    cat > "$CRITICAL_ACCOUNTS_DIR/forwarding-setup.md" << 'EOF'
# 📬 EMAIL FORWARDING STRATEGY
## Safety net during migration period

## 🎯 FORWARDING GOALS
1. **Catch all critical emails** during migration
2. **Monitor for missed accounts** that need migration
3. **Provide safety buffer** in case of problems
4. **Enable gradual transition** rather than sudden cutoff

## 📧 FORWARDING SETUP OPTIONS

### Option A: Corporate Email Forwarding (If Allowed)
```
Risk Level: HIGH (corporate monitoring)
Pros: Automatic forwarding of all emails
Cons: Corporate IT may monitor forwarding rules
Setup: Check corporate email settings for forwarding rules
```

### Option B: External Email Monitoring
```
Risk Level: MEDIUM
Pros: Regular monitoring without automatic forwarding
Cons: Manual process, risk of missing emails
Setup: Regular manual checking of old email
```

### Option C: Trusted Contact Monitoring
```
Risk Level: LOW  
Pros: Someone else monitors for critical emails
Cons: Requires trusted person with good judgment
Setup: Give trusted contact access to check for emergencies
```

## 📋 FORWARDING RULE CONFIGURATION

### Critical Email Keywords to Forward:
- "urgent"
- "security alert"
- "account locked"
- "verification required"
- "password reset"
- "suspicious activity"
- "payment due"
- "bill"
- "statement"
- "breach"
- "compromise"

### Bank/Financial Institution Names:
- [Your bank names]
- "Chase", "Bank of America", "Wells Fargo", etc.
- "Visa", "Mastercard", "American Express"
- "PayPal", "Venmo"
- Investment company names

### Critical Services:
- Password manager company names
- Phone company names
- Cloud storage provider names
- Important subscription services

## 🔄 MONITORING SCHEDULE

### Week 1-2 (Critical Migration Period):
- Check forwarded emails: Every 4 hours
- Direct check old email: Daily
- Document all emails received
- Immediately handle any security alerts

### Week 3-4 (High-Value Migration):
- Check forwarded emails: Every 8 hours  
- Direct check old email: Every 2 days
- Continue documenting patterns
- Address any missed accounts discovered

### Month 2 (Medium-Value Migration):
- Check forwarded emails: Daily
- Direct check old email: Every 3-4 days
- Reduce monitoring as confidence grows
- Plan for eventual monitoring reduction

### Month 3+ (Transition to Independence):
- Check forwarded emails: Every few days
- Direct check old email: Weekly
- Prepare for eventual forwarding removal
- Document final state for future reference

## 🚨 EMERGENCY EMAIL RESPONSE

### If Critical Email Missed:
1. **Immediate Action**: Log into old email directly
2. **Account Recovery**: Use alternative recovery methods
3. **Direct Contact**: Call customer service immediately
4. **Documentation**: Record what was missed and why
5. **Process Improvement**: Update forwarding rules

### If Security Alert Received:
1. **Verify Legitimacy**: Check directly with service
2. **Immediate Response**: Follow security alert instructions
3. **Account Review**: Check all account activity
4. **Password Change**: Update passwords if needed
5. **Monitoring Increase**: Increase email monitoring temporarily

## 📊 FORWARDING SUCCESS METRICS

### Positive Indicators:
- All critical emails successfully forwarded
- No missed account access issues
- Security alerts properly received and handled
- Smooth migration of high-priority accounts
- Confidence in new email system growing

### Warning Signs:
- Missing emails from known critical services
- Account access problems
- Delayed security notifications
- Confusion about which email to use
- Technical problems with forwarding

## 🔧 TECHNICAL FORWARDING SETUP

### Gmail Forwarding:
1. Settings → Forwarding and POP/IMAP
2. Add forwarding address
3. Verify forwarding email
4. Set forwarding rules
5. Choose "keep Gmail copy" or "delete"

### Outlook Forwarding:
1. Settings → Mail → Forwarding
2. Enable forwarding
3. Enter forwarding address
4. Save settings

### Corporate Email:
1. Check with IT department first
2. Follow corporate forwarding policies
3. Document approval if required
4. Test forwarding functionality

## ⚠️ FORWARDING SECURITY CONSIDERATIONS

### Security Risks:
- Forwarding rules can be monitored
- Forwarded emails lose some security
- Potential for email loops
- Risk of forwarding to wrong address

### Security Measures:
- Use encrypted email for forwarding destination
- Regularly verify forwarding is working correctly
- Monitor for any unauthorized forwarding rule changes
- Have backup plan if forwarding fails

### Exit Strategy:
- Plan for eventual removal of forwarding
- Test that all critical accounts work without forwarding
- Document final verification that forwarding can be safely removed
- Keep emergency procedures for any final cleanup needed
EOF

    print_success "Email forwarding strategy created"
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    case "${1:-assess}" in
        "assess")
            assess_dual_risks
            ;;
        "strategy")
            create_staged_migration
            ;;
        "critical")
            create_critical_account_checklist
            ;;
        "forwarding")
            create_forwarding_strategy
            ;;
        "full")
            print_header "🚀 COMPLETE CRITICAL EMAIL SECURITY STRATEGY"
            assess_dual_risks
            create_staged_migration
            create_critical_account_checklist
            create_forwarding_strategy
            
            print_success "Critical email security strategy completed!"
            print_warning "Review all files in $CRITICAL_ACCOUNTS_DIR"
            print_info "Start with: critical-accounts-checklist.md"
            ;;
        *)
            echo "🔒 Critical Email & Account Security Migration"
            echo ""
            echo "Usage: $0 [command]"
            echo ""
            echo "Commands:"
            echo "  assess     - Assess dual risks (missing emails vs vulnerable accounts)"
            echo "  strategy   - Create staged migration strategy"
            echo "  critical   - Create critical account identification checklist"
            echo "  forwarding - Create email forwarding safety net strategy"
            echo "  full       - Complete critical email security planning"
            ;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi