#!/bin/bash
# Automated Account Categorization Analysis
# Analyze accounts.csv and categorize into security domains

set -euo pipefail

CSV_FILE="/Users/jackdev/development/digital-privacy-management/scripts/accounts.csv"
OUTPUT_DIR="$HOME/.email-safety-net/categorized-accounts"

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

print_category() {
    echo -e "${PURPLE}📊 $1${NC}"
}

print_count() {
    echo -e "${YELLOW}📈 $1${NC}"
}

# ============================================================================
# ANALYZE CSV FILE
# ============================================================================

analyze_accounts() {
    print_header "📊 AUTOMATED ACCOUNT CATEGORIZATION ANALYSIS"
    
    if [[ ! -f "$CSV_FILE" ]]; then
        echo "❌ CSV file not found: $CSV_FILE"
        exit 1
    fi
    
    # Create output directory
    mkdir -p "$OUTPUT_DIR"
    
    echo "🔍 Analyzing accounts from: $CSV_FILE"
    echo ""
    
    # Count total accounts (excluding header)
    local total_accounts=$(tail -n +2 "$CSV_FILE" | wc -l | tr -d ' ')
    echo "📊 Total accounts found: $total_accounts"
    echo ""
    
    # Initialize category files
    echo "# 🏦 FINANCIAL DOMAIN ACCOUNTS" > "$OUTPUT_DIR/financial-domain.txt"
    echo "# Safari browser - quietwave@tutanota.de" >> "$OUTPUT_DIR/financial-domain.txt"
    echo "# Banking, credit cards, investments, insurance, payments" >> "$OUTPUT_DIR/financial-domain.txt"
    echo "" >> "$OUTPUT_DIR/financial-domain.txt"
    
    echo "# 🛡️ HIGH-SECURITY DOMAIN ACCOUNTS" > "$OUTPUT_DIR/high-security-domain.txt"
    echo "# Brave browser - deepvault@protonmail.com" >> "$OUTPUT_DIR/high-security-domain.txt"
    echo "# Government, healthcare, legal, cryptocurrency" >> "$OUTPUT_DIR/high-security-domain.txt"
    echo "" >> "$OUTPUT_DIR/high-security-domain.txt"
    
    echo "# 🏠 PERSONAL DOMAIN ACCOUNTS" > "$OUTPUT_DIR/personal-domain.txt"
    echo "# Firefox browser - streamcode@protonmail.com" >> "$OUTPUT_DIR/personal-domain.txt"
    echo "# Social media, entertainment, shopping, general accounts" >> "$OUTPUT_DIR/personal-domain.txt"
    echo "" >> "$OUTPUT_DIR/personal-domain.txt"
    
    echo "# 🗑️ ACCOUNTS TO DELETE" > "$OUTPUT_DIR/delete-candidates.txt"
    echo "# Old, unused, duplicate, or unnecessary accounts" >> "$OUTPUT_DIR/delete-candidates.txt"
    echo "" >> "$OUTPUT_DIR/delete-candidates.txt"
    
    echo "# ❓ UNCLEAR CATEGORIZATION" > "$OUTPUT_DIR/manual-review.txt"
    echo "# Accounts needing manual review for proper categorization" >> "$OUTPUT_DIR/manual-review.txt"
    echo "" >> "$OUTPUT_DIR/manual-review.txt"
    
    # Categorize accounts
    categorize_accounts
}

# ============================================================================
# CATEGORIZATION LOGIC
# ============================================================================

categorize_accounts() {
    print_category "🔍 CATEGORIZING ACCOUNTS BY DOMAIN..."
    
    local financial_count=0
    local security_count=0
    local personal_count=0
    local delete_count=0
    local manual_count=0
    
    # Read CSV file and categorize
    while IFS=',' read -r email username1 username2 title note url category otpurl; do
        # Skip header row
        [[ "$email" == "username" ]] && continue
        
        # Skip empty rows
        [[ -z "$url" && -z "$title" && -z "$email" ]] && continue
        
        local account_name=""
        if [[ -n "$title" ]]; then
            account_name="$title"
        elif [[ -n "$url" ]]; then
            account_name="$url"
        else
            account_name="Unknown Account"
        fi
        
        # Clean up account name (remove protocols, www, etc.)
        account_name=$(echo "$account_name" | sed 's|https\?://||g' | sed 's|www\.||g' | sed 's|/$||g')
        
        # Categorization logic
        if categorize_financial "$account_name" "$url" "$title"; then
            echo "✅ $account_name | $email" >> "$OUTPUT_DIR/financial-domain.txt"
            ((financial_count++))
        elif categorize_high_security "$account_name" "$url" "$title"; then
            echo "✅ $account_name | $email" >> "$OUTPUT_DIR/high-security-domain.txt"
            ((security_count++))
        elif categorize_delete "$account_name" "$url" "$title" "$email"; then
            echo "🗑️ $account_name | $email" >> "$OUTPUT_DIR/delete-candidates.txt"
            ((delete_count++))
        elif categorize_personal "$account_name" "$url" "$title"; then
            echo "✅ $account_name | $email" >> "$OUTPUT_DIR/personal-domain.txt"
            ((personal_count++))
        else
            echo "❓ $account_name | $email | $url" >> "$OUTPUT_DIR/manual-review.txt"
            ((manual_count++))
        fi
        
    done < "$CSV_FILE"
    
    show_categorization_results "$financial_count" "$security_count" "$personal_count" "$delete_count" "$manual_count"
}

# ============================================================================
# CATEGORIZATION FUNCTIONS
# ============================================================================

categorize_financial() {
    local name="$1" url="$2" title="$3"
    local text=$(echo "${name} ${url} ${title}" | tr '[:upper:]' '[:lower:]')  # Convert to lowercase
    
    # Financial keywords
    if [[ "$text" =~ (bank|chase|wells|fargo|america|citi|capital|hsbc|santander) ]] ||
       [[ "$text" =~ (credit|visa|mastercard|amex|americanexpress|discover) ]] ||
       [[ "$text" =~ (fidelity|schwab|robinhood|etrade|vanguard|401k|ira) ]] ||
       [[ "$text" =~ (paypal|venmo|zelle|stripe|square|wise) ]] ||
       [[ "$text" =~ (insurance|admiral|geico|progressive|allstate) ]] ||
       [[ "$text" =~ (mortgage|loan|student.*loan|auto.*loan) ]] ||
       [[ "$text" =~ (tax|turbo|turbotax|h&r|irs\.gov|hmrc) ]] ||
       [[ "$text" =~ (coinbase|binance|kraken|bitstamp|crypto|bitcoin) ]] ||
       [[ "$text" =~ (scottishwidows|pension|retirement) ]]; then
        return 0
    fi
    return 1
}

categorize_high_security() {
    local name="$1" url="$2" title="$3"
    local text=$(echo "${name} ${url} ${title}" | tr '[:upper:]' '[:lower:]')  # Convert to lowercase
    
    # High-security keywords
    if [[ "$text" =~ (\.gov|government|irs|dmv|social.*security|federal|state) ]] ||
       [[ "$text" =~ (nhs|health|medical|doctor|pharmacy|kaiser|patient) ]] ||
       [[ "$text" =~ (legal|court|law|attorney|lawyer|justice) ]] ||
       [[ "$text" =~ (passport|visa|immigration|border) ]] ||
       [[ "$text" =~ (service\.gov\.uk|gov\.uk|ca\.gov|login\.gov) ]] ||
       [[ "$text" =~ (recova.*19|boots.*covid|expresstest) ]]; then
        return 0
    fi
    return 1
}

categorize_personal() {
    local name="$1" url="$2" title="$3"
    local text=$(echo "${name} ${url} ${title}" | tr '[:upper:]' '[:lower:]')  # Convert to lowercase
    
    # Personal/Entertainment keywords
    if [[ "$text" =~ (facebook|instagram|twitter|linkedin|tiktok|snapchat|reddit) ]] ||
       [[ "$text" =~ (netflix|spotify|youtube|hulu|disney|prime|hbo|twitch) ]] ||
       [[ "$text" =~ (amazon|ebay|etsy|shop|store|retail|clothing|fashion) ]] ||
       [[ "$text" =~ (gaming|steam|playstation|xbox|nintendo|epic|blizzard) ]] ||
       [[ "$text" =~ (deliveroo|uber|lyft|food|restaurant|mcdonalds|pizza) ]] ||
       [[ "$text" =~ (fitness|gym|sports|music|art|hobby|travel|hotel) ]] ||
       [[ "$text" =~ (news|guardian|bbc|verge|medium|blog) ]] ||
       [[ "$text" =~ (google|apple|microsoft|github|dropbox) ]] ||
       [[ "$text" =~ (udemy|codecademy|learning|education|course) ]]; then
        return 0
    fi
    return 1
}

categorize_delete() {
    local name="$1" url="$2" title="$3" email="$4"
    local text=$(echo "${name} ${url} ${title}" | tr '[:upper:]' '[:lower:]')  # Convert to lowercase
    
    # Delete candidates
    if [[ "$text" =~ (test|trial|temp|sample|demo|backup|old) ]] ||
       [[ "$text" =~ (myspace|vine|google\+|discontinued) ]] ||
       [[ "$email" =~ (jneedham@ripple\.com|work|corporate|company) ]] ||
       [[ "$text" =~ (spam|marketing|promo|newsletter) ]] ||
       [[ "$text" =~ (duplicate|multiple|extra) ]]; then
        return 0
    fi
    return 1
}

# ============================================================================
# RESULTS DISPLAY
# ============================================================================

show_categorization_results() {
    local financial=$1 security=$2 personal=$3 delete=$4 manual=$5
    local total=$((financial + security + personal + delete + manual))
    
    print_header "📊 CATEGORIZATION RESULTS"
    
    print_count "DOMAIN DISTRIBUTION:"
    echo ""
    echo "   🏦 Financial Domain:     $financial accounts → Safari vault"
    echo "   🛡️ High-Security Domain: $security accounts → Brave vault"
    echo "   🏠 Personal Domain:      $personal accounts → Firefox vault (staying)"
    echo "   🗑️ Delete Candidates:    $delete accounts → Remove completely"
    echo "   ❓ Manual Review:        $manual accounts → Need categorization"
    echo ""
    echo "   📊 Total Categorized:    $total accounts"
    echo ""
    
    # Create summary file
    cat > "$OUTPUT_DIR/categorization-summary.md" << EOF
# 📊 AUTOMATED CATEGORIZATION RESULTS

## 🎯 ACCOUNT DISTRIBUTION:
- **Financial Domain**: $financial accounts → Safari browser (quietwave@tutanota.de)
- **High-Security Domain**: $security accounts → Brave browser (deepvault@protonmail.com)
- **Personal Domain**: $personal accounts → Firefox browser (streamcode@protonmail.com)
- **Delete Candidates**: $delete accounts → Remove completely
- **Manual Review**: $manual accounts → Need manual categorization

## 📋 FILES CREATED:
- \`financial-domain.txt\` - Banking, credit cards, investments, payments
- \`high-security-domain.txt\` - Government, healthcare, legal accounts  
- \`personal-domain.txt\` - Social media, entertainment, shopping
- \`delete-candidates.txt\` - Old, unused, or unnecessary accounts
- \`manual-review.txt\` - Accounts needing manual review

## 🎯 NEXT IMMEDIATE ACTIONS:

### 🚨 **URGENT (Do Today):**
1. **Review Financial Domain accounts** ($financial accounts)
   - Verify all banking/credit card accounts are captured
   - Plan migration to Financial Domain vault (Safari)

### 🔒 **HIGH PRIORITY (This Week):**
2. **Review High-Security Domain accounts** ($security accounts)
   - Verify all government/healthcare accounts are captured
   - Plan migration to High-Security Domain vault (Brave)

### 🧹 **SECURITY CLEANUP:**
3. **Review Delete Candidates** ($delete accounts)
   - Verify accounts are truly unnecessary
   - Begin deletion process to reduce attack surface

### ❓ **MANUAL REVIEW:**
4. **Categorize Manual Review accounts** ($manual accounts)
   - Review accounts that couldn't be auto-categorized
   - Assign to appropriate domains

## 📧 **EMAIL MIGRATION STRATEGY:**
- **Financial accounts**: Update to quietwave@tutanota.de
- **High-security accounts**: Update to deepvault@protonmail.com
- **Personal accounts**: Update to streamcode@protonmail.com
- **Set up Gmail forwarding** during transition period

## ✅ **SUCCESS METRICS:**
- ✅ All accounts categorized and sorted
- ✅ Financial accounts secured in appropriate domain
- ✅ Government/healthcare accounts maximally protected
- ✅ Attack surface reduced through account deletion
- ✅ Perfect domain separation maintained

Date: $(date '+%Y-%m-%d %H:%M:%S')
EOF

    echo "✅ Categorization complete! Files saved to: $OUTPUT_DIR"
    echo ""
    echo "🎯 **KEY FINDINGS:**"
    
    if [[ $financial -gt 0 ]]; then
        echo "   🚨 **$financial FINANCIAL ACCOUNTS** need immediate migration to Safari"
    fi
    
    if [[ $security -gt 0 ]]; then
        echo "   🔒 **$security HIGH-SECURITY ACCOUNTS** need migration to Brave"
    fi
    
    if [[ $delete -gt 0 ]]; then
        echo "   🧹 **$delete ACCOUNTS** are candidates for deletion"
    fi
    
    if [[ $manual -gt 0 ]]; then
        echo "   ❓ **$manual ACCOUNTS** need manual review"
    fi
    
    echo ""
    echo "📋 **NEXT STEPS:**"
    echo "1. Review the categorized files in: $OUTPUT_DIR"
    echo "2. Verify financial and high-security categorizations"
    echo "3. Begin with financial account migration (highest priority)"
    echo "4. Plan high-security account migration"
    echo "5. Start account deletion process"
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    analyze_accounts
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi