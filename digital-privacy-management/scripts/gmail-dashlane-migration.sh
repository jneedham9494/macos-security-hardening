#!/bin/bash
# Gmail and Dashlane Migration Strategy
# Safe transition from old digital identity to new compartmentalized system

set -euo pipefail

AUDIT_LOG="$HOME/.email-safety-net/gmail-dashlane-migration.log"

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

print_phase() {
    echo -e "${YELLOW}📋 PHASE $1${NC}"
}

print_action() {
    echo -e "${BLUE}🔧 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - SUCCESS: $1" >> "$AUDIT_LOG"
}

print_critical() {
    echo -e "${RED}🚨 CRITICAL: $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - CRITICAL: $1" >> "$AUDIT_LOG"
}

print_insight() {
    echo -e "${PURPLE}💡 $1${NC}"
}

# ============================================================================
# CURRENT STATE ANALYSIS
# ============================================================================

analyze_current_state() {
    print_header "🔍 GMAIL + DASHLANE CURRENT STATE ANALYSIS"
    
    cat > "$HOME/.email-safety-net/migration-analysis.md" << 'EOF'
# 🔍 GMAIL + DASHLANE MIGRATION ANALYSIS

## 🎯 CURRENT SITUATION:

### **📧 Gmail Account:**
- **Status**: Active daily use
- **Risk Level**: HIGH - Google ecosystem lock-in
- **Data Exposure**: Years of personal data, contacts, account registrations
- **Privacy Issues**: Google tracking, data mining, advertising profiling
- **Migration Challenge**: Critical accounts tied to Gmail address

### **🔐 Dashlane Account:**
- **Status**: Active password manager
- **Risk Level**: MEDIUM - Centralized password storage
- **Data**: All current passwords, potentially sensitive data
- **Migration Challenge**: Need to extract passwords without losing access

## 🚨 CRITICAL MIGRATION RISKS:

### **⚠️ The Email Lock-in Problem:**
```
Gmail Address → Hundreds of Accounts → Potential Lockout Risk
```

### **⚠️ The Password Manager Transition:**
```
Dashlane Passwords → Must Transfer → Without Losing Access
```

### **⚠️ The Timing Problem:**
```
Can't delete Gmail immediately → Need gradual migration → Safety nets required
```

## 🎯 STRATEGIC APPROACH:

### **🛡️ SAFETY-FIRST MIGRATION:**
1. **Extract** Dashlane data safely
2. **Audit** all accounts tied to Gmail
3. **Categorize** accounts by domain appropriateness
4. **Migrate** accounts to new email addresses
5. **Set up** Gmail forwarding as safety net
6. **Gradually** phase out old systems

### **📋 THREE-PHASE PLAN:**

#### **Phase 1: Data Extraction & Safety (This Session)**
- Export Dashlane passwords securely
- Import critical passwords to 1Password vaults
- Set up Gmail forwarding to new addresses
- Identify critical accounts requiring immediate attention

#### **Phase 2: Account Categorization & Migration (Next Session)**
- Audit all accounts by domain category
- Begin systematic email address migration
- Update critical accounts to new email addresses
- Test that old accounts still work during transition

#### **Phase 3: Cleanup & Security (Future Session)**
- Complete account migrations
- Delete unnecessary accounts
- Secure old Gmail account (but keep active)
- Implement ongoing monitoring

## 🔐 MIGRATION SECURITY PRINCIPLES:

### **✅ NEVER LOSE ACCESS:**
- Keep Gmail active during entire migration
- Maintain Dashlane until all passwords transferred
- Test each migration step before proceeding
- Multiple backup methods for critical accounts

### **✅ DOMAIN-APPROPRIATE PLACEMENT:**
```
Banking/Financial    → quietwave@tutanota.de (Safari)
Government/Healthcare → deepvault@protonmail.com (Brave)
Social/Entertainment  → streamcode@protonmail.com (Firefox)
```

### **✅ GRADUAL TRANSITION:**
- No "big bang" migrations
- Account-by-account careful transition
- Verification at each step
- Rollback plan if issues arise

## 🎯 TODAY'S OBJECTIVES:

1. **Export Dashlane data** safely
2. **Import critical passwords** to 1Password
3. **Set up Gmail forwarding** to new addresses
4. **Identify high-priority accounts** for migration
5. **Create migration timeline** and priority list

This ensures you never lose access while building your new secure foundation.
EOF

    print_success "Migration analysis documentation created"
}

# ============================================================================
# DASHLANE DATA EXTRACTION
# ============================================================================

extract_dashlane_data() {
    print_header "📤 DASHLANE DATA EXTRACTION"
    
    print_phase "1: SAFELY EXPORT DASHLANE PASSWORDS"
    
    print_action "Let's extract your Dashlane data safely:"
    echo ""
    echo "   🎯 GOAL: Export all passwords without losing Dashlane access"
    echo ""
    echo "   📋 DASHLANE EXPORT STEPS:"
    echo "   1. Open Dashlane app/browser extension"
    echo "   2. Go to Settings/Preferences"
    echo "   3. Look for 'Export' or 'Data Export' option"
    echo "   4. Choose 'CSV' format (most compatible)"
    echo "   5. Export to secure location (Downloads folder)"
    echo "   6. Password protect the export file"
    echo ""
    echo "   🔐 SECURITY NOTES:"
    echo "   - CSV file contains ALL passwords in plain text"
    echo "   - Store in secure location only"
    echo "   - Delete after importing to 1Password"
    echo "   - Never email or upload to cloud services"
    echo ""
    
    read -p "✅ Press ENTER when you've exported Dashlane data..."
    
    echo ""
    echo "❓ Export verification:"
    echo "   Did Dashlane export complete successfully? (y/n)"
    read -r dashlane_export_success
    
    echo "   Where did you save the export file?"
    read -p "   Enter file path: " export_file_path
    
    if [[ "$dashlane_export_success" == "y" ]]; then
        print_success "Dashlane data exported successfully"
        echo "Export file location: $export_file_path" >> "$AUDIT_LOG"
    else
        print_critical "Dashlane export failed - troubleshooting needed"
        return 1
    fi
}

# ============================================================================
# 1PASSWORD IMPORT PROCESS
# ============================================================================

import_to_1password() {
    print_header "📥 IMPORTING TO 1PASSWORD VAULTS"
    
    print_phase "2: IMPORT PASSWORDS TO APPROPRIATE VAULTS"
    
    print_action "Strategic import to maintain domain separation:"
    echo ""
    echo "   🎯 GOAL: Import passwords to correct domain vaults"
    echo ""
    echo "   📋 IMPORT STRATEGY:"
    echo "   1. Import ALL passwords to 1Password first"
    echo "   2. Then move them to appropriate domain vaults"
    echo "   3. This ensures no passwords are lost"
    echo ""
    echo "   🔧 1PASSWORD IMPORT STEPS:"
    echo "   1. Open 1Password desktop app"
    echo "   2. Go to File > Import"
    echo "   3. Select 'Dashlane' as source"
    echo "   4. Choose your exported CSV file"
    echo "   5. Import to 'Private' vault first (temporary)"
    echo "   6. Review imported items"
    echo "   7. Move items to appropriate domain vaults"
    echo ""
    
    read -p "✅ Press ENTER when you've started the 1Password import..."
    
    echo ""
    echo "❓ Import verification:"
    echo "   Did 1Password import complete successfully? (y/n)"
    read -r import_success
    
    echo "   How many passwords were imported?"
    read -p "   Enter approximate number: " imported_count
    
    if [[ "$import_success" == "y" ]]; then
        print_success "Passwords imported to 1Password successfully"
        echo "Imported approximately $imported_count passwords" >> "$AUDIT_LOG"
    else
        print_critical "1Password import failed - may need manual CSV import"
        return 1
    fi
    
    print_action "Next: Categorize and move passwords to domain vaults"
    echo ""
    echo "   🏠 PERSONAL DOMAIN (Firefox): Social media, entertainment, shopping"
    echo "   🏦 FINANCIAL DOMAIN (Safari): Banking, investments, credit cards"
    echo "   🛡️ HIGH-SECURITY DOMAIN (Brave): Government, healthcare, crypto"
    echo ""
    echo "   We'll do this systematically to maintain perfect separation."
}

# ============================================================================
# GMAIL FORWARDING SETUP
# ============================================================================

setup_gmail_forwarding() {
    print_header "📧 GMAIL FORWARDING SAFETY NET"
    
    print_phase "3: SET UP GMAIL FORWARDING TO NEW ADDRESSES"
    
    print_action "Create safety net for missed emails:"
    echo ""
    echo "   🎯 GOAL: Forward Gmail to new addresses without losing anything"
    echo ""
    echo "   📋 GMAIL FORWARDING SETUP:"
    echo "   1. Open Gmail in browser"
    echo "   2. Go to Settings (gear icon) > See all settings"
    echo "   3. Click 'Forwarding and POP/IMAP' tab"
    echo "   4. Click 'Add a forwarding address'"
    echo "   5. Add: streamcode@protonmail.com (personal domain)"
    echo "   6. Verify the forwarding address (check ProtonMail)"
    echo "   7. Set up forwarding rules by category"
    echo ""
    echo "   🔧 SMART FORWARDING STRATEGY:"
    echo "   - Personal emails → streamcode@protonmail.com"
    echo "   - Financial emails → quietwave@tutanota.de" 
    echo "   - High-security emails → deepvault@protonmail.com"
    echo ""
    echo "   ⚠️ IMPORTANT: Keep Gmail active during transition!"
    echo ""
    
    read -p "✅ Press ENTER when you've set up Gmail forwarding..."
    
    echo ""
    echo "❓ Forwarding verification:"
    echo "   Did Gmail forwarding setup complete? (y/n)"
    read -r forwarding_success
    
    echo "   Which new addresses did you add for forwarding?"
    read -p "   Enter addresses: " forwarding_addresses
    
    if [[ "$forwarding_success" == "y" ]]; then
        print_success "Gmail forwarding safety net established"
        echo "Forwarding to: $forwarding_addresses" >> "$AUDIT_LOG"
    else
        print_critical "Gmail forwarding setup incomplete - manual setup needed"
    fi
}

# ============================================================================
# CRITICAL ACCOUNTS IDENTIFICATION
# ============================================================================

identify_critical_accounts() {
    print_header "🎯 CRITICAL ACCOUNTS IDENTIFICATION"
    
    print_phase "4: IDENTIFY HIGH-PRIORITY MIGRATION ACCOUNTS"
    
    print_action "Let's identify which accounts need immediate attention:"
    echo ""
    echo "   🎯 GOAL: Find accounts that could lock you out if Gmail disappears"
    echo ""
    echo "   🚨 CRITICAL ACCOUNT CATEGORIES:"
    echo ""
    echo "   💰 FINANCIAL (Immediate Priority):"
    echo "   - Banking accounts"
    echo "   - Credit card accounts"
    echo "   - Investment platforms"
    echo "   - PayPal, Venmo, financial apps"
    echo ""
    echo "   🏛️ GOVERNMENT/LEGAL (High Priority):"
    echo "   - IRS, tax accounts"
    echo "   - DMV, government services"
    echo "   - Healthcare portals"
    echo "   - Insurance accounts"
    echo ""
    echo "   🔐 SECURITY/INFRASTRUCTURE (High Priority):"
    echo "   - Backup email accounts"
    echo "   - Cloud storage (Google Drive, iCloud)"
    echo "   - VPN services"
    echo "   - Domain registrars"
    echo ""
    echo "   📱 ESSENTIAL SERVICES (Medium Priority):"
    echo "   - Phone/internet providers"
    echo "   - Utilities"
    echo "   - Subscription services"
    echo ""
    
    cat > "$HOME/.email-safety-net/critical-accounts-template.md" << 'EOF'
# 🎯 CRITICAL ACCOUNTS MIGRATION CHECKLIST

## 💰 FINANCIAL ACCOUNTS (IMMEDIATE PRIORITY):
- [ ] Primary bank: ________________
- [ ] Secondary bank: ______________
- [ ] Credit cards: ________________
- [ ] Investment/401k: _____________
- [ ] PayPal/Venmo: _______________
- [ ] Crypto exchanges: ___________

## 🏛️ GOVERNMENT/HEALTHCARE (HIGH PRIORITY):
- [ ] IRS/Tax accounts: ___________
- [ ] State government: __________
- [ ] Healthcare portal: _________
- [ ] Insurance: ________________
- [ ] DMV: _____________________

## 🔐 SECURITY/INFRASTRUCTURE (HIGH PRIORITY):
- [ ] Recovery emails: ___________
- [ ] Cloud storage: ____________
- [ ] VPN services: _____________
- [ ] Domain registrars: ________
- [ ] Password managers: ________

## 📱 ESSENTIAL SERVICES (MEDIUM PRIORITY):
- [ ] Phone provider: ___________
- [ ] Internet provider: ________
- [ ] Utilities: _______________
- [ ] Streaming services: ______
- [ ] Work accounts: ___________

## 🎮 PERSONAL/SOCIAL (LOW PRIORITY):
- [ ] Social media: ____________
- [ ] Gaming accounts: _________
- [ ] Shopping sites: __________
- [ ] News/media: _____________

## 📋 MIGRATION NOTES:
Target domains for each category:
- Financial → quietwave@tutanota.de (Safari)
- Government/Healthcare → deepvault@protonmail.com (Brave)  
- Personal/Social → streamcode@protonmail.com (Firefox)

## 🚨 IMMEDIATE ACTION REQUIRED:
List the top 5 accounts that would cause major problems if you lost access:
1. ________________________________
2. ________________________________
3. ________________________________
4. ________________________________
5. ________________________________
EOF

    print_success "Critical accounts template created"
    
    print_action "Please review and fill out the critical accounts checklist"
    echo "   📝 File location: ~/.email-safety-net/critical-accounts-template.md"
    echo ""
    echo "   Focus on accounts where losing access would cause:"
    echo "   💰 Financial loss"
    echo "   🚨 Legal problems"
    echo "   🔒 Security vulnerabilities"
    echo "   💼 Work/business disruption"
}

# ============================================================================
# MIGRATION TIMELINE CREATION
# ============================================================================

create_migration_timeline() {
    print_header "📅 MIGRATION TIMELINE & NEXT STEPS"
    
    cat > "$HOME/.email-safety-net/migration-timeline.md" << 'EOF'
# 📅 GMAIL + DASHLANE MIGRATION TIMELINE

## ✅ COMPLETED TODAY:
- [x] Exported Dashlane passwords safely
- [x] Imported passwords to 1Password
- [x] Set up Gmail forwarding safety net
- [x] Identified critical accounts requiring migration

## 🎯 WEEK 1 (IMMEDIATE PRIORITIES):
### Days 1-2: Financial Account Migration
- [ ] Update all banking accounts to quietwave@tutanota.de
- [ ] Test login access with new email
- [ ] Update credit card account emails
- [ ] Migrate investment/retirement accounts

### Days 3-4: Government/Healthcare Migration  
- [ ] Update IRS/tax accounts to deepvault@protonmail.com
- [ ] Migrate healthcare portal accounts
- [ ] Update insurance account emails
- [ ] Verify government service access

### Days 5-7: Security Infrastructure
- [ ] Update recovery emails for critical accounts
- [ ] Migrate cloud storage accounts
- [ ] Update VPN and security service emails
- [ ] Test all critical account access

## 🎯 WEEK 2 (SECONDARY PRIORITIES):
### Days 8-10: Essential Services
- [ ] Update phone/internet provider emails
- [ ] Migrate utility account emails
- [ ] Update subscription service emails
- [ ] Verify service access and billing

### Days 11-14: Personal/Social Accounts
- [ ] Migrate social media to streamcode@protonmail.com
- [ ] Update shopping site emails
- [ ] Migrate entertainment/streaming accounts
- [ ] Clean up unnecessary accounts

## 🎯 MONTH 2 (CLEANUP & SECURITY):
### Weeks 3-4: Account Audit
- [ ] Review all migrated accounts
- [ ] Delete unnecessary/duplicate accounts
- [ ] Update privacy settings on retained accounts
- [ ] Implement ongoing monitoring

### Weeks 5-8: Final Cleanup
- [ ] Reduce Gmail forwarding (test independence)
- [ ] Secure old Gmail account (don't delete)
- [ ] Complete Dashlane account closure
- [ ] Document final account inventory

## 🚨 CRITICAL SUCCESS FACTORS:

### ✅ NEVER DELETE GMAIL ACCOUNT:
- Keep as backup/recovery method
- Many accounts may still reference it
- Useful for forgotten account recovery
- Can be secured and minimized, not deleted

### ✅ TEST EVERY MIGRATION:
- Verify login with new email BEFORE removing old email
- Keep old email active until verified working
- Document any accounts that resist migration

### ✅ DOMAIN SEPARATION:
```
Financial accounts    → Safari + quietwave@tutanota.de
Government/Healthcare → Brave + deepvault@protonmail.com  
Personal/Social      → Firefox + streamcode@protonmail.com
```

### ✅ SAFETY NETS:
- Gmail forwarding remains active during migration
- 1Password has all passwords from Dashlane
- Multiple backup methods for critical accounts
- Gradual transition prevents lockouts

## 📱 MOBILE STRATEGY:
- Install email apps for new addresses
- Test mobile access for critical accounts
- Ensure 1Password mobile app works properly
- Plan phone migration in parallel

## 🎯 SUCCESS METRICS:
- [ ] All critical accounts accessible via new emails
- [ ] No lost access to important services
- [ ] Perfect domain separation maintained
- [ ] Gmail dependency eliminated (but not deleted)
- [ ] 1Password fully replaces Dashlane

This timeline ensures safe, systematic migration without losing access to anything important.
EOF

    print_success "Migration timeline created"
    
    print_insight "Strategic approach ensures you never lose access while building new system"
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    analyze_current_state
    echo ""
    extract_dashlane_data
    echo ""
    import_to_1password
    echo ""
    setup_gmail_forwarding
    echo ""
    identify_critical_accounts
    echo ""
    create_migration_timeline
    
    echo ""
    print_critical "🎯 MIGRATION SESSION COMPLETE"
    echo ""
    echo "✅ Foundation established for safe Gmail/Dashlane migration"
    echo "✅ Data extracted and safety nets in place"
    echo "✅ Timeline created for systematic account migration"
    echo ""
    echo "🚀 Next session: Begin critical account migrations"
    echo "📋 Focus: Financial accounts first (highest risk)"
    echo "🛡️ Principle: Never lose access during transition"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi