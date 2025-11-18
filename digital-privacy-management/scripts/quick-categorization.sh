#!/bin/bash
# Quick Account Categorization Reference
# Streamlined categorization with clear decision rules

set -euo pipefail

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

print_quick_guide() {
    print_header "⚡ QUICK CATEGORIZATION REFERENCE"
    
    cat > "$HOME/.email-safety-net/quick-categorization-guide.md" << 'EOF'
# ⚡ QUICK ACCOUNT CATEGORIZATION GUIDE

## 🎯 YOUR MISSION: Sort 292 Accounts into 4 Categories

### 🔥 **PRIORITY 1: FINANCIAL DOMAIN** → Safari Browser
**🏦 MOVE TO FINANCIAL DOMAIN IF IT INVOLVES MONEY:**
```
✅ Banks: Chase, Wells Fargo, Bank of America, local banks
✅ Credit Cards: Visa, Mastercard, Amex, store credit cards  
✅ Investments: Fidelity, Schwab, Robinhood, E*Trade, 401k
✅ Insurance: Auto, health, life, home, renters insurance
✅ Payments: PayPal, Venmo, Zelle, Stripe, Apple Pay
✅ Loans: Mortgage, auto loans, student loans
✅ Tax: TurboTax, H&R Block, IRS online
```
**Target: ~20-40 accounts**

---

### 🔥 **PRIORITY 2: HIGH-SECURITY DOMAIN** → Brave Browser  
**🛡️ MOVE TO HIGH-SECURITY IF IT'S GOVERNMENT/HEALTHCARE/LEGAL:**
```
✅ Government: IRS, DMV, Social Security, state/federal agencies
✅ Healthcare: Health insurance portals, doctor accounts, pharmacy
✅ Legal: Court systems, legal services, professional licenses
✅ Crypto: Coinbase, Binance, hardware wallet interfaces
✅ Identity: Credit monitoring, identity protection services
```
**Target: ~10-20 accounts**

---

### 🔥 **PRIORITY 3: DELETE CANDIDATES** → Remove Completely
**🗑️ DELETE IF IT'S OLD, UNUSED, OR UNNECESSARY:**
```
✅ Not used in 2+ years
✅ Duplicate accounts (multiple Facebook, Google, etc.)
✅ Dead services (MySpace, Google+, discontinued sites)
✅ Old work accounts (if this is personal device)
✅ Spam/marketing accounts
✅ Trial accounts never converted
✅ Test/temporary accounts
```
**Target: ~50-100 accounts (reduce attack surface!)**

---

### 🔥 **REMAINING: PERSONAL DOMAIN** → Firefox Browser
**🏠 EVERYTHING ELSE STAYS IN PERSONAL DOMAIN:**
```
✅ Social Media: Facebook, Instagram, Twitter, LinkedIn, TikTok
✅ Entertainment: Netflix, Spotify, YouTube, Hulu, Disney+
✅ Shopping: Amazon, eBay, Etsy, clothing stores, food delivery
✅ Gaming: Steam, PlayStation, Xbox, mobile games  
✅ Productivity: Google Drive, Dropbox, productivity apps
✅ General: Forums, blogs, news sites, hobby sites
```
**Target: ~150-200 accounts**

---

## ⚡ **SPEED CATEGORIZATION RULES:**

### **INSTANT DECISIONS:**
- **Contains "bank", "credit", "finance"** → Financial Domain
- **Contains "gov", ".gov", "health", "medical"** → High-Security Domain  
- **Haven't used since 2022** → Delete List
- **Social media, entertainment** → Personal Domain (stays put)

### **QUICK KEYWORD MATCHING:**
```
Financial: bank, credit, visa, chase, fidelity, paypal, insurance, loan, tax
High-Sec: gov, irs, dmv, health, medical, legal, crypto, bitcoin, security
Delete: old, backup, test, trial, temp, unused, duplicate, work, spam
Personal: facebook, netflix, amazon, google, apple, spotify, gaming
```

---

## 📋 **SIMPLE WORKFLOW:**

### **Step 1: Open 1Password Personal Domain Vault**
- You have 292 accounts to review
- Go through them systematically (alphabetically works well)

### **Step 2: Use the 4-Category Sort**
For each account ask:
1. **Money-related?** → Financial Domain
2. **Government/Healthcare/Legal?** → High-Security Domain  
3. **Old/Unused/Unnecessary?** → Delete
4. **Everything else?** → Personal Domain (stays)

### **Step 3: Create Your Lists**
Keep track of:
- **Financial accounts to migrate** (highest priority)
- **High-security accounts to migrate** (second priority)
- **Accounts to delete** (immediate security benefit)
- **Personal accounts** (already in right place)

---

## 🎯 **EXPECTED RESULTS:**
```
Personal Domain:     150-200 accounts (50-70%) → Stay in Firefox
Financial Domain:    20-40 accounts (7-15%) → Move to Safari  
High-Security:       10-20 accounts (3-7%) → Move to Brave
Delete:              50-100 accounts (15-35%) → Remove completely
```

---

## 🚨 **CRITICAL REMINDERS:**

### **Financial Security (URGENT):**
- **Banks and credit cards** MUST move to Financial Domain (Safari)
- **Investment accounts** need Financial Domain protection
- **These are your highest-value targets for attackers**

### **Privacy Protection:**
- **Government accounts** MUST move to High-Security Domain (Brave)
- **Healthcare data** needs maximum protection
- **These contain your most sensitive personal information**

### **Attack Surface Reduction:**
- **Delete old accounts** to reduce breach exposure
- **Fewer accounts = less vulnerability**
- **Clean up now saves security headaches later**

---

## ✅ **WHEN YOU'RE DONE CATEGORIZING:**

### **Next Immediate Steps:**
1. **Migrate financial accounts** to Financial Domain (Safari vault)
2. **Migrate high-security accounts** to High-Security Domain (Brave vault)
3. **Begin deleting unnecessary accounts**
4. **Update email addresses** during migration process

### **You'll Know You're Ready When:**
- [ ] All financial accounts identified and ready to migrate
- [ ] All government/healthcare accounts identified and ready to migrate
- [ ] Clear list of accounts to delete
- [ ] Remaining personal accounts staying in Personal Domain

**Take your time - accuracy is more important than speed!**
**Better to be thorough now than have security issues later.**

---

*This guide helps you efficiently sort your 292 accounts into the perfect security domains for your digital privacy system.*
EOF

    echo -e "${GREEN}✅ Quick categorization guide created!${NC}"
    echo ""
    echo -e "${BLUE}📋 Here's your streamlined approach:${NC}"
    echo ""
    echo "1. 🔍 **Review guide**: Check ~/.email-safety-net/quick-categorization-guide.md"
    echo "2. 📱 **Open 1Password**: Go to Personal Domain vault (292 accounts)"
    echo "3. ⚡ **Quick sort**: Use the 4-category decision rules"
    echo "4. 📊 **Track results**: Keep count of each category"
    echo ""
    echo -e "${PURPLE}🎯 When you're done categorizing, let me know your counts:${NC}"
    echo "   - Financial accounts (banks, credit cards, investments)"
    echo "   - High-security accounts (government, healthcare, legal)"  
    echo "   - Accounts to delete (old, unused, unnecessary)"
    echo "   - Personal accounts (social, entertainment - staying put)"
    echo ""
    echo -e "${YELLOW}💡 This approach lets you work at your own pace with clear guidelines.${NC}"
}

# ============================================================================
# CATEGORIZATION RESULTS COLLECTOR
# ============================================================================

collect_results() {
    print_header "📊 CATEGORIZATION RESULTS"
    
    echo "When you've finished categorizing your accounts, enter your results:"
    echo ""
    
    read -p "🏦 Financial Domain accounts (banks, credit, investments): " financial_count
    read -p "🛡️ High-Security Domain accounts (gov, healthcare, legal): " security_count  
    read -p "🗑️ Accounts to delete (old, unused, unnecessary): " delete_count
    
    local personal_count=$((292 - financial_count - security_count - delete_count))
    
    echo ""
    echo -e "${CYAN}📊 YOUR CATEGORIZATION RESULTS:${NC}"
    echo ""
    echo "   🏦 Financial Domain:     $financial_count accounts → Safari vault"
    echo "   🛡️ High-Security Domain: $security_count accounts → Brave vault"
    echo "   🏠 Personal Domain:      $personal_count accounts → Firefox vault (staying)"
    echo "   🗑️ To Delete:            $delete_count accounts → Remove completely"
    echo ""
    echo "   📊 Total Processed:      $((financial_count + security_count + personal_count + delete_count)) / 292 accounts"
    echo ""
    
    # Create summary file
    cat > "$HOME/.email-safety-net/final-categorization-results.md" << EOF
# 📊 FINAL CATEGORIZATION RESULTS

## 🎯 ACCOUNT DISTRIBUTION:
- **Financial Domain**: $financial_count accounts → Safari browser
- **High-Security Domain**: $security_count accounts → Brave browser  
- **Personal Domain**: $personal_count accounts → Firefox browser (staying)
- **To Delete**: $delete_count accounts → Remove completely

## 📋 NEXT IMMEDIATE ACTIONS:

### 🚨 **URGENT (Do Today):**
1. **Migrate $financial_count financial accounts** to Financial Domain vault
   - Move to Safari-only access
   - Update emails to quietwave@tutanota.de

### 🔒 **HIGH PRIORITY (This Week):**
2. **Migrate $security_count high-security accounts** to High-Security Domain vault
   - Move to Brave-only access  
   - Update emails to deepvault@protonmail.com

### 🧹 **SECURITY CLEANUP (Ongoing):**
3. **Delete $delete_count unnecessary accounts**
   - Reduces attack surface significantly
   - Eliminates old security vulnerabilities

### 📧 **EMAIL MIGRATION (Parallel):**
4. **Plan Gmail sunset strategy**
   - Set up forwarding during transition
   - Update critical accounts first
   - Gradually reduce Gmail dependency

## 🎯 SUCCESS METRICS:
- ✅ Perfect domain separation achieved
- ✅ Financial accounts properly secured
- ✅ Government/healthcare accounts maximally protected  
- ✅ Attack surface reduced by $delete_count accounts
- ✅ Ready for secure digital life operation

Date: $(date '+%Y-%m-%d %H:%M:%S')
EOF

    echo -e "${GREEN}✅ Results saved! Ready to begin account migration.${NC}"
    echo ""
    echo -e "${PURPLE}🎯 Your next step: Start with financial account migration (highest priority)${NC}"
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    case "${1:-guide}" in
        "guide")
            print_quick_guide
            ;;
        "results")
            collect_results
            ;;
        "both")
            print_quick_guide
            echo ""
            read -p "Press ENTER when you've finished categorizing and want to record results..."
            collect_results
            ;;
        *)
            echo "⚡ Quick Account Categorization"
            echo ""
            echo "Usage: $0 [command]"
            echo ""
            echo "Commands:"
            echo "  guide     - Show quick categorization guide"
            echo "  results   - Collect categorization results"
            echo "  both      - Guide then results collection"
            ;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi