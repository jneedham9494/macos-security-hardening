#!/bin/bash
# Account Categorization System
# Smart categorization of 292 imported accounts into security domains

set -euo pipefail

SETUP_LOG="$HOME/.email-safety-net/account-categorization.log"

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
    echo -e "${PURPLE}🎯 PHASE $1${NC}"
}

print_action() {
    echo -e "${YELLOW}📋 $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_categories() {
    echo -e "${CYAN}📊 $1${NC}"
}

# ============================================================================
# CATEGORIZATION FRAMEWORK
# ============================================================================

setup_categorization_framework() {
    print_header "📊 ACCOUNT CATEGORIZATION FRAMEWORK"
    
    cat > "$HOME/.email-safety-net/categorization-guide.md" << 'EOF'
# 📊 ACCOUNT CATEGORIZATION FRAMEWORK

## 🎯 GOAL: Sort 292 Accounts into Security Domains

### 🏠 **PERSONAL DOMAIN** (Keep in Firefox)
**Criteria**: Daily use, social, entertainment, low security risk
**Examples**:
- Social Media: Facebook, Instagram, Twitter, LinkedIn, TikTok
- Entertainment: Netflix, Spotify, YouTube, Amazon Prime, Disney+
- Shopping: Amazon, eBay, Etsy, clothing stores, food delivery
- Gaming: Steam, PlayStation, Xbox, mobile games
- General Services: Email subscriptions, forums, blogs
- Personal Tools: Fitness apps, photo storage, productivity apps

**Security Level**: Standard
**Browser**: Firefox only
**Email**: streamcode@protonmail.com

---

### 🏦 **FINANCIAL DOMAIN** (Move to Safari)
**Criteria**: Money-related, high value, financial institutions
**Examples**:
- Banking: Chase, Bank of America, Wells Fargo, local banks
- Credit Cards: Visa, Mastercard, Amex, store cards
- Investments: Fidelity, Schwab, E*Trade, Robinhood, 401k
- Insurance: Auto, health, life, home insurance
- Financial Services: PayPal, Venmo, Zelle, crypto exchanges
- Tax Services: TurboTax, H&R Block, IRS accounts
- Loans: Mortgage, car loans, student loans

**Security Level**: High
**Browser**: Safari only
**Email**: quietwave@tutanota.de

---

### 🛡️ **HIGH-SECURITY DOMAIN** (Move to Brave)
**Criteria**: Government, healthcare, legal, maximum sensitivity
**Examples**:
- Government: IRS, DMV, Social Security, state agencies
- Healthcare: Health insurance, doctor portals, pharmacy
- Legal: Legal services, court systems, professional licenses
- Cryptocurrency: Hardware wallet interfaces, major exchanges
- Identity: Credit monitoring, identity theft protection
- Professional: Professional licenses, certifications
- Security Tools: VPN services, security software

**Security Level**: Maximum
**Browser**: Brave only
**Email**: deepvault@protonmail.com

---

### 🗑️ **DELETE CATEGORY**
**Criteria**: Unnecessary, duplicate, old, or compromised
**Examples**:
- Old/Unused: Accounts not used in 2+ years
- Duplicates: Multiple accounts for same service
- Spam Services: Marketing lists, promotional accounts
- Dead Services: Discontinued websites/apps
- Work Accounts: Old job-related accounts (if personal device)
- Test Accounts: Trial accounts, temporary signups

**Action**: Delete immediately after verification

---

## 🔍 CATEGORIZATION DECISION TREE:

### **Step 1: Security Risk Assessment**
```
Is this account related to money or finances? 
├── YES → Financial Domain
└── NO → Continue to Step 2

Is this account government, healthcare, or legal?
├── YES → High-Security Domain  
└── NO → Continue to Step 3

Is this account used regularly for personal life?
├── YES → Personal Domain
└── NO → Consider for deletion
```

### **Step 2: Usage Frequency Check**
```
When did you last use this account?
├── Within 6 months → Keep in appropriate domain
├── 6-24 months → Evaluate necessity
└── 2+ years → Strong candidate for deletion
```

### **Step 3: Value Assessment**
```
Does this account provide ongoing value?
├── YES → Keep in appropriate domain
├── MAYBE → Keep but monitor
└── NO → Delete
```

## 📋 CATEGORIZATION PROCESS:

### **Phase 1: Quick Sort (Pattern Recognition)**
- Review account names/URLs for obvious patterns
- Sort clear-cut cases first (banks → Financial, social → Personal)
- Mark obvious deletions (old services, duplicates)

### **Phase 2: Detailed Review (Manual Assessment)**
- Evaluate unclear cases individually
- Consider account value and usage frequency
- Make final domain assignments

### **Phase 3: Migration Planning**
- Create lists for each domain
- Plan migration order (high-priority first)
- Set up email update schedule

## 🎯 EFFICIENCY TIPS:

### **Batch Processing**:
- Sort by website domain (all Google accounts together)
- Group similar services (all streaming services)
- Handle duplicates in batches

### **Quick Decision Rules**:
- **Banking/Credit**: Always Financial Domain
- **Government**: Always High-Security Domain
- **Social Media**: Usually Personal Domain
- **Old Email**: Usually delete after forwarding setup

### **Priority Order**:
1. **Critical Financial**: Banks, credit cards (immediate migration)
2. **Government/Healthcare**: High-security accounts (immediate migration)
3. **Daily Personal**: Social, entertainment (can wait)
4. **Cleanup**: Deletions and consolidation (ongoing)

## 📊 TARGET DISTRIBUTION:

### **Expected Account Distribution**:
```
Personal Domain:     ~150-200 accounts (50-70%)
Financial Domain:    ~20-40 accounts (7-15%)  
High-Security Domain: ~10-20 accounts (3-7%)
Delete:              ~50-100 accounts (15-35%)
```

### **Quality over Quantity**:
- **Fewer accounts = better security**
- **Clear categorization = perfect separation**
- **Regular cleanup = ongoing privacy**

This framework ensures every account gets properly categorized for maximum security and usability!
EOF

    print_success "Categorization framework created"
}

# ============================================================================
# INTERACTIVE CATEGORIZATION PROCESS
# ============================================================================

start_categorization_process() {
    print_header "🔍 INTERACTIVE ACCOUNT CATEGORIZATION"
    
    print_phase "1: PREPARATION"
    print_action "Setting up categorization workspace..."
    
    # Create categorization workspace
    mkdir -p "$HOME/.email-safety-net/categorization"
    
    cat > "$HOME/.email-safety-net/categorization/personal-domain.txt" << 'EOF'
# 🏠 PERSONAL DOMAIN ACCOUNTS
# Firefox browser - streamcode@protonmail.com
# Social media, entertainment, shopping, general accounts

EOF

    cat > "$HOME/.email-safety-net/categorization/financial-domain.txt" << 'EOF'
# 🏦 FINANCIAL DOMAIN ACCOUNTS  
# Safari browser - quietwave@tutanota.de
# Banking, credit cards, investments, insurance

EOF

    cat > "$HOME/.email-safety-net/categorization/high-security-domain.txt" << 'EOF'
# 🛡️ HIGH-SECURITY DOMAIN ACCOUNTS
# Brave browser - deepvault@protonmail.com
# Government, healthcare, legal, cryptocurrency

EOF

    cat > "$HOME/.email-safety-net/categorization/delete-list.txt" << 'EOF'
# 🗑️ ACCOUNTS TO DELETE
# Old, unused, duplicate, or unnecessary accounts

EOF

    print_success "Categorization workspace created"
    
    print_phase "2: CATEGORIZATION APPROACH"
    print_action "Choose your categorization method:"
    echo ""
    echo "   🎯 OPTION A: GUIDED CATEGORIZATION"
    echo "      - Interactive prompts for each account type"
    echo "      - AI-assisted decision making"
    echo "      - Recommended for thorough review"
    echo ""
    echo "   🎯 OPTION B: BATCH CATEGORIZATION"
    echo "      - Sort by patterns and keywords"
    echo "      - Faster for obvious categories"
    echo "      - Manual review of unclear cases"
    echo ""
    echo "   🎯 OPTION C: MANUAL REVIEW"
    echo "      - Review accounts directly in 1Password"
    echo "      - Use categorization guide as reference"
    echo "      - Self-directed approach"
    echo ""
    
    read -p "   Which approach would you prefer? (a/b/c): " categorization_method
    
    case "$categorization_method" in
        "a"|"A")
            guided_categorization
            ;;
        "b"|"B")
            batch_categorization
            ;;
        "c"|"C")
            manual_review_guide
            ;;
        *)
            print_info "Invalid choice, defaulting to guided categorization"
            guided_categorization
            ;;
    esac
}

# ============================================================================
# GUIDED CATEGORIZATION
# ============================================================================

guided_categorization() {
    print_header "🎯 GUIDED ACCOUNT CATEGORIZATION"
    
    print_action "Let's categorize your accounts systematically..."
    echo ""
    
    print_phase "STEP 1: FINANCIAL ACCOUNTS (Highest Priority)"
    echo ""
    echo "   🏦 Let's identify your financial accounts first"
    echo "   These need immediate migration to Financial Domain (Safari)"
    echo ""
    echo "   Look through your Personal Domain vault and identify:"
    echo "   ✅ Banks (Chase, Bank of America, Wells Fargo, etc.)"
    echo "   ✅ Credit Cards (Visa, Mastercard, Amex, store cards)"
    echo "   ✅ Investment Accounts (Fidelity, Schwab, Robinhood, etc.)"
    echo "   ✅ Insurance (Auto, health, life, home)"
    echo "   ✅ Payment Services (PayPal, Venmo, Zelle)"
    echo ""
    
    read -p "   How many financial accounts did you identify? " financial_count
    echo "Financial accounts identified: $financial_count" >> "$HOME/.email-safety-net/categorization/financial-domain.txt"
    
    print_phase "STEP 2: HIGH-SECURITY ACCOUNTS"
    echo ""
    echo "   🛡️ Now let's identify high-security accounts"
    echo "   These need migration to High-Security Domain (Brave)"
    echo ""
    echo "   Look for:"
    echo "   ✅ Government (IRS, DMV, Social Security, state agencies)"
    echo "   ✅ Healthcare (Insurance portals, doctor accounts, pharmacy)"
    echo "   ✅ Legal (Court systems, professional licenses)"
    echo "   ✅ Cryptocurrency (Exchanges, wallet services)"
    echo ""
    
    read -p "   How many high-security accounts did you identify? " security_count
    echo "High-security accounts identified: $security_count" >> "$HOME/.email-safety-net/categorization/high-security-domain.txt"
    
    print_phase "STEP 3: DELETION CANDIDATES"
    echo ""
    echo "   🗑️ Let's identify accounts to delete"
    echo "   This will significantly reduce your attack surface"
    echo ""
    echo "   Look for:"
    echo "   ✅ Accounts not used in 2+ years"
    echo "   ✅ Duplicate accounts for same service"
    echo "   ✅ Old work accounts (if this is personal device)"
    echo "   ✅ Dead/discontinued services"
    echo "   ✅ Spam/marketing accounts"
    echo ""
    
    read -p "   How many accounts are candidates for deletion? " delete_count
    echo "Deletion candidates identified: $delete_count" >> "$HOME/.email-safety-net/categorization/delete-list.txt"
    
    print_phase "STEP 4: REMAINING PERSONAL ACCOUNTS"
    echo ""
    local remaining_count=$((292 - financial_count - security_count - delete_count))
    echo "   🏠 Remaining accounts: $remaining_count"
    echo "   These will stay in Personal Domain (Firefox)"
    echo ""
    echo "   This should include:"
    echo "   ✅ Social media (Facebook, Instagram, Twitter, etc.)"
    echo "   ✅ Entertainment (Netflix, Spotify, YouTube, etc.)"
    echo "   ✅ Shopping (Amazon, eBay, clothing stores, etc.)"
    echo "   ✅ General services and apps"
    echo ""
    echo "Remaining personal accounts: $remaining_count" >> "$HOME/.email-safety-net/categorization/personal-domain.txt"
    
    # Generate summary
    cat > "$HOME/.email-safety-net/categorization/categorization-summary.md" << EOF
# 📊 ACCOUNT CATEGORIZATION SUMMARY

## 🎯 CATEGORIZATION RESULTS:
- **Total Accounts**: 292
- **Financial Domain**: $financial_count accounts
- **High-Security Domain**: $security_count accounts  
- **Personal Domain**: $remaining_count accounts
- **To Delete**: $delete_count accounts

## 📋 NEXT STEPS:
1. **Immediate**: Migrate financial accounts to Financial Domain (Safari)
2. **Immediate**: Migrate high-security accounts to High-Security Domain (Brave)  
3. **This Week**: Begin deleting unnecessary accounts
4. **Ongoing**: Update email addresses during migration

## 🎯 MIGRATION PRIORITY:
1. **Financial accounts** (highest priority - money security)
2. **High-security accounts** (government, healthcare, legal)
3. **Account deletions** (reduce attack surface)
4. **Email updates** (align with domain strategy)

Date: $(date '+%Y-%m-%d %H:%M:%S')
EOF

    print_success "Guided categorization complete!"
    show_categorization_summary "$financial_count" "$security_count" "$remaining_count" "$delete_count"
}

# ============================================================================
# BATCH CATEGORIZATION
# ============================================================================

batch_categorization() {
    print_header "⚡ BATCH ACCOUNT CATEGORIZATION"
    
    print_action "Smart pattern-based categorization..."
    echo ""
    
    cat > "$HOME/.email-safety-net/categorization/batch-patterns.md" << 'EOF'
# ⚡ BATCH CATEGORIZATION PATTERNS

## 🏦 FINANCIAL DOMAIN PATTERNS:
**Bank Keywords**: bank, chase, wellsfargo, bankofamerica, citi, capital, credit, visa, mastercard, amex
**Investment Keywords**: fidelity, schwab, robinhood, etrade, vanguard, 401k, ira
**Insurance Keywords**: geico, progressive, statefarm, allstate, insurance, health
**Payment Keywords**: paypal, venmo, zelle, stripe, square

## 🛡️ HIGH-SECURITY DOMAIN PATTERNS:
**Government Keywords**: irs, gov, dmv, social, security, state, federal, tax
**Healthcare Keywords**: health, medical, doctor, pharmacy, kaiser, medicare, medicaid
**Legal Keywords**: court, legal, law, attorney, license, professional
**Crypto Keywords**: coinbase, binance, crypto, bitcoin, ethereum, wallet

## 🏠 PERSONAL DOMAIN PATTERNS:
**Social Keywords**: facebook, instagram, twitter, linkedin, tiktok, snapchat, social
**Entertainment Keywords**: netflix, spotify, youtube, hulu, disney, prime, streaming
**Shopping Keywords**: amazon, ebay, etsy, shop, store, retail, clothing
**Gaming Keywords**: steam, playstation, xbox, nintendo, gaming, game

## 🗑️ DELETE PATTERNS:
**Old Keywords**: old, backup, test, trial, temp, sample, demo
**Dead Services**: myspace, vine, google+, discontinued
**Work Keywords**: work, office, corporate, company (if personal device)
EOF

    print_info "Use these patterns to quickly sort your accounts"
    print_action "Review accounts in 1Password and sort using pattern matching"
    
    echo ""
    read -p "Press ENTER when you've completed batch categorization..."
    
    # Collect results
    echo ""
    echo "📊 Enter your batch categorization results:"
    read -p "Financial Domain accounts: " financial_count
    read -p "High-Security Domain accounts: " security_count  
    read -p "Accounts to delete: " delete_count
    
    local remaining_count=$((292 - financial_count - security_count - delete_count))
    
    show_categorization_summary "$financial_count" "$security_count" "$remaining_count" "$delete_count"
}

# ============================================================================
# MANUAL REVIEW GUIDE
# ============================================================================

manual_review_guide() {
    print_header "📋 MANUAL REVIEW GUIDE"
    
    print_action "Self-directed categorization approach..."
    echo ""
    
    cat > "$HOME/.email-safety-net/categorization/manual-review-checklist.md" << 'EOF'
# 📋 MANUAL REVIEW CHECKLIST

## 🎯 CATEGORIZATION PROCESS:

### **Step 1: Open 1Password Personal Domain Vault**
1. Open 1Password app
2. Select Personal Domain vault
3. Review all 292 imported accounts

### **Step 2: Create Migration Lists**
Create separate notes or documents for:
- **Financial Domain**: Banks, credit cards, investments, insurance
- **High-Security Domain**: Government, healthcare, legal, crypto
- **Personal Domain**: Social, entertainment, shopping (stays put)
- **Delete List**: Old, unused, duplicate accounts

### **Step 3: Sort Accounts Systematically**
Go through accounts alphabetically and assign each to a category:

**Quick Decision Rules**:
- Contains "bank", "credit", "finance" → Financial Domain
- Contains "gov", "health", "legal" → High-Security Domain  
- Social media, entertainment → Personal Domain
- Not used in 2+ years → Delete List

### **Step 4: Validate Categories**
Double-check assignments:
- **Financial**: Anything money-related?
- **High-Security**: Government, healthcare, legal?
- **Personal**: Daily use, low security risk?
- **Delete**: Really unnecessary?

### **Step 5: Plan Migration Order**
1. **Financial** (highest priority)
2. **High-Security** (immediate security needs)
3. **Deletions** (reduce attack surface)
4. **Email updates** (align with domains)

## ✅ QUALITY CHECKPOINTS:

- [ ] All financial accounts identified
- [ ] All government/healthcare accounts identified
- [ ] Obvious deletions marked
- [ ] Account counts seem reasonable
- [ ] Ready to begin migration

Take your time - accuracy is more important than speed!
EOF

    print_info "Manual review guide created"
    print_action "Work through your accounts at your own pace"
    
    echo ""
    read -p "Press ENTER when you've completed manual categorization..."
    
    # Collect results
    echo ""
    echo "📊 Enter your categorization results:"
    read -p "Financial Domain accounts: " financial_count
    read -p "High-Security Domain accounts: " security_count
    read -p "Accounts to delete: " delete_count
    
    local remaining_count=$((292 - financial_count - security_count - delete_count))
    
    show_categorization_summary "$financial_count" "$security_count" "$remaining_count" "$delete_count"
}

# ============================================================================
# CATEGORIZATION SUMMARY
# ============================================================================

show_categorization_summary() {
    local financial=$1
    local security=$2  
    local personal=$3
    local delete=$4
    
    print_header "📊 CATEGORIZATION COMPLETE"
    
    print_categories "FINAL ACCOUNT DISTRIBUTION:"
    echo ""
    echo "   🏦 Financial Domain:     $financial accounts → Safari"
    echo "   🛡️ High-Security Domain: $security accounts → Brave" 
    echo "   🏠 Personal Domain:      $personal accounts → Firefox"
    echo "   🗑️ To Delete:            $delete accounts"
    echo ""
    echo "   📊 Total Processed:      $((financial + security + personal + delete)) / 292 accounts"
    echo ""
    
    print_success "Categorization phase complete!"
    
    echo ""
    print_info "🎯 NEXT IMMEDIATE STEPS:"
    echo ""
    echo "1. 🏦 **URGENT**: Migrate financial accounts to Financial Domain"
    echo "   - Move $financial banking/credit/investment accounts to Safari vault"
    echo "   - Update to quietwave@tutanota.de email"
    echo ""
    echo "2. 🛡️ **HIGH PRIORITY**: Migrate high-security accounts"  
    echo "   - Move $security government/healthcare accounts to Brave vault"
    echo "   - Update to deepvault@protonmail.com email"
    echo ""
    echo "3. 🗑️ **SECURITY**: Begin account deletion process"
    echo "   - Delete $delete unnecessary accounts"
    echo "   - Reduce attack surface significantly"
    echo ""
    echo "4. 📧 **ONGOING**: Email migration planning"
    echo "   - Set up Gmail forwarding"
    echo "   - Plan Gmail sunset timeline"
    echo ""
    
    # Log results
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Categorization complete: F:$financial S:$security P:$personal D:$delete" >> "$SETUP_LOG"
    
    read -p "Ready to start the account migration process? (y/n): " start_migration
    
    if [[ "$start_migration" == "y" ]]; then
        print_success "Excellent! Let's begin with financial account migration..."
        print_info "This is the highest priority for your security"
    else
        print_info "Take your time to review. When ready, we'll start with financial migration."
    fi
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    setup_categorization_framework
    echo ""
    start_categorization_process
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi