#!/bin/bash
# Dashlane to 1Password Migration Strategy
# Determine optimal domain placement and secure migration approach

set -euo pipefail

SETUP_LOG="$HOME/.email-safety-net/dashlane-migration.log"

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

print_recommendation() {
    echo -e "${PURPLE}🎯 RECOMMENDATION: $1${NC}"
}

print_warning() {
    echo -e "${RED}⚠️  WARNING: $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_step() {
    echo -e "${YELLOW}📋 STEP $1${NC}"
}

# ============================================================================
# DASHLANE MIGRATION DOMAIN STRATEGY
# ============================================================================

analyze_migration_strategy() {
    print_header "🔄 DASHLANE TO 1PASSWORD MIGRATION STRATEGY"
    
    cat > "$HOME/.email-safety-net/dashlane-migration-strategy.md" << 'EOF'
# 🔄 DASHLANE TO 1PASSWORD MIGRATION STRATEGY

## 🎯 CRITICAL DECISION: Which Domain for Dashlane Import?

### 🚨 THE CHALLENGE:
You have existing Dashlane data that needs to be migrated to your new compartmentalized 1Password system. Where should it go?

## 📊 DOMAIN ANALYSIS:

### 🏠 **Option A: Import to Personal Domain**
#### ✅ **PROS:**
- **Natural fit**: Most accounts are likely personal/social
- **Daily access**: Personal domain is your most-used vault
- **Firefox integration**: Easy access for everyday use
- **Logical starting point**: Personal life = personal domain

#### ❌ **CONS:**
- **Mixed security levels**: Banking accounts in personal domain
- **Contamination risk**: High-security accounts in wrong domain
- **Migration complexity**: Will need to sort and move accounts later

### 🏦 **Option B: Import to Financial Domain**
#### ✅ **PROS:**
- **High-value protection**: Banking accounts get proper domain
- **Safari isolation**: Financial accounts stay in financial browser

#### ❌ **CONS:**
- **Wrong fit**: Social media accounts don't belong in financial domain
- **Access complexity**: Need Safari for non-financial accounts
- **Logical mismatch**: Entertainment accounts in banking domain

### 🛡️ **Option C: Import to High-Security Domain**
#### ✅ **PROS:**
- **Maximum protection**: All accounts get highest security
- **Future-proof**: Can move accounts down in security later

#### ❌ **CONS:**
- **Massive overkill**: Social media doesn't need nation-state security
- **Access friction**: Daily accounts require high-security browser
- **Domain pollution**: Mixing low-value accounts with high-security

### 🎯 **Option D: SMART STAGING APPROACH (RECOMMENDED)**
#### ✅ **THE BEST STRATEGY:**
- **Import to Personal Domain FIRST** (staging area)
- **Categorize and sort** all imported accounts
- **Move accounts to appropriate domains** during cleanup
- **Delete/consolidate** unnecessary accounts during process

## 🏆 RECOMMENDED APPROACH: PERSONAL DOMAIN STAGING

### 🎯 **Why Personal Domain First:**

#### **1. Natural Staging Area**
- Most accounts are likely personal/social anyway
- Firefox access makes sorting easier
- Personal domain can handle mixed account types temporarily

#### **2. Easy Categorization Process**
```
Import All → Personal Domain
    ↓
Categorize During Review
    ↓
Move to Appropriate Domains:
├── Keep in Personal (social, entertainment, shopping)
├── Move to Financial (banks, investments, credit cards)
├── Move to High-Security (government, healthcare, crypto)
└── Delete (unnecessary, duplicate, old accounts)
```

#### **3. Safe Migration Path**
- **No account loss** during migration
- **Gradual categorization** without time pressure
- **Easy access** for account review and cleanup
- **Flexible sorting** as you learn your account patterns

#### **4. Risk Mitigation**
- **Immediate backup** of all Dashlane data in secure system
- **No rush decisions** about domain placement
- **Time to properly categorize** based on actual account usage
- **Safety net** during transition period

## 📋 IMPLEMENTATION PLAN:

### **Phase 1: Export and Import (Today)**
```
1. Export Dashlane data to CSV/JSON
2. Import to Personal Domain vault in 1Password
3. Verify all accounts transferred successfully
4. Keep Dashlane active as backup during transition
```

### **Phase 2: Categorization (This Week)**
```
1. Review all imported accounts
2. Categorize by domain type:
   - Personal: Social, entertainment, shopping, general
   - Financial: Banking, credit cards, investments, insurance
   - High-Security: Government, healthcare, crypto, legal
   - Delete: Old, duplicate, unnecessary accounts
```

### **Phase 3: Domain Migration (Next Week)**
```
1. Move financial accounts to Financial Domain vault
2. Move high-security accounts to High-Security Domain vault
3. Keep personal accounts in Personal Domain vault
4. Update browser bookmarks and access patterns
```

### **Phase 4: Cleanup and Verification (Ongoing)**
```
1. Test all migrated accounts work correctly
2. Update passwords for high-priority accounts
3. Delete old Dashlane account
4. Verify perfect domain separation maintained
```

## 🚨 CRITICAL SAFETY MEASURES:

### **During Migration:**
- **Keep Dashlane active** until 100% verified
- **Export Dashlane data** as backup before starting
- **Test critical accounts** immediately after import
- **Don't delete anything** until fully verified

### **Domain Contamination Prevention:**
- **Temporary mixing is OK** in Personal Domain during sorting
- **Final separation** must be perfect before going live
- **No permanent cross-domain accounts**
- **Browser isolation** maintained throughout process

## 🎯 GMAIL MIGRATION STRATEGY:

### **Parallel Email Migration:**
```
Current Gmail → Appropriate Domain Emails:
├── Social accounts → streamcode@protonmail.com (Personal)
├── Banking accounts → quietwave@tutanota.de (Financial)
├── Government accounts → deepvault@protonmail.com (High-Security)
└── Spam/marketing → Delete or unsubscribe
```

### **Email Update Process:**
1. **Import accounts to Personal Domain first**
2. **Update email addresses** during domain migration
3. **Set up forwarding** from Gmail during transition
4. **Gradually phase out** Gmail dependency

## ✅ SUCCESS METRICS:

### **Migration Complete When:**
- [ ] All Dashlane accounts imported to 1Password
- [ ] All accounts categorized and moved to correct domains
- [ ] All critical accounts tested and working
- [ ] Browser-domain isolation verified
- [ ] Gmail dependency eliminated
- [ ] Old accounts cleaned up and deleted
- [ ] Monitoring and maintenance procedures established

## 🎯 IMMEDIATE NEXT STEPS:

1. **Export Dashlane data** (CSV format recommended)
2. **Import to Personal Domain** vault in 1Password
3. **Verify import success** (account count, critical accounts)
4. **Begin account categorization** process
5. **Plan domain migration** timeline

This approach gives you maximum safety, flexibility, and control during your digital privacy migration!
EOF

    print_recommendation "IMPORT TO PERSONAL DOMAIN FIRST (Staging Approach)"
    echo ""
    print_info "This gives you maximum safety and flexibility during migration"
}

# ============================================================================
# DASHLANE EXPORT PROCESS
# ============================================================================

guide_dashlane_export() {
    print_header "📤 DASHLANE EXPORT PROCESS"
    
    print_step "1: EXPORT YOUR DASHLANE DATA"
    echo ""
    echo "   🎯 GOAL: Safely export all your Dashlane passwords and data"
    echo ""
    echo "   EXPORT STEPS:"
    echo "   1. Open Dashlane app or go to app.dashlane.com"
    echo "   2. Log into your Dashlane account"
    echo "   3. Go to Settings or My Account"
    echo "   4. Look for 'Export' or 'Data Export' option"
    echo "   5. Choose export format:"
    echo "      - CSV (recommended for 1Password import)"
    echo "      - JSON (alternative option)"
    echo "   6. Download the export file"
    echo "   7. Save to secure location (Desktop or Documents)"
    echo ""
    
    print_warning "SECURITY: Export file contains all passwords in readable format!"
    print_info "Keep export file secure and delete after successful import"
    
    echo ""
    read -p "✅ Press ENTER when you have exported your Dashlane data..."
    
    echo ""
    echo "❓ Export verification:"
    echo "   Did you successfully export your Dashlane data? (y/n)"
    read -r export_success
    
    echo "   What file format did you export? (csv/json)"
    read -r export_format
    
    echo "   Approximately how many accounts were exported?"
    read -r account_count
    
    if [[ "$export_success" == "y" ]]; then
        print_info "✅ Export successful: $account_count accounts in $export_format format"
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Dashlane export: $account_count accounts ($export_format)" >> "$SETUP_LOG"
    else
        print_warning "Export failed - troubleshooting needed"
    fi
}

# ============================================================================
# 1PASSWORD IMPORT PROCESS
# ============================================================================

guide_1password_import() {
    print_header "📥 1PASSWORD IMPORT TO PERSONAL DOMAIN"
    
    print_step "2: IMPORT TO PERSONAL DOMAIN VAULT"
    echo ""
    echo "   🎯 GOAL: Import Dashlane data to Personal Domain vault as staging area"
    echo ""
    echo "   IMPORT STEPS:"
    echo "   1. Open 1Password app"
    echo "   2. Select 'Personal Domain' vault"
    echo "   3. Go to File menu → Import"
    echo "   4. Choose 'Dashlane' as source"
    echo "   5. Select your exported file"
    echo "   6. Review import preview"
    echo "   7. Confirm import to Personal Domain vault"
    echo "   8. Wait for import to complete"
    echo ""
    
    print_info "All accounts will be imported to Personal Domain for sorting"
    print_warning "This may take a few minutes for large exports"
    
    echo ""
    read -p "✅ Press ENTER when you have imported your Dashlane data to Personal Domain..."
    
    echo ""
    echo "❓ Import verification:"
    echo "   Did the import complete successfully? (y/n)"
    read -r import_success
    
    echo "   How many accounts were imported to Personal Domain?"
    read -r imported_count
    
    echo "   Can you see all your accounts in Personal Domain vault? (y/n)"
    read -r accounts_visible
    
    if [[ "$import_success" == "y" && "$accounts_visible" == "y" ]]; then
        print_info "✅ Import successful: $imported_count accounts in Personal Domain vault"
        echo "$(date '+%Y-%m-%d %H:%M:%S') - 1Password import: $imported_count accounts to Personal Domain" >> "$SETUP_LOG"
        
        cat >> "$HOME/.email-safety-net/dashlane-migration-strategy.md" << EOF

## ✅ MIGRATION STATUS UPDATE:
- **Export Date**: $(date '+%Y-%m-%d %H:%M:%S')
- **Accounts Exported**: $account_count (Dashlane)
- **Accounts Imported**: $imported_count (1Password Personal Domain)
- **Status**: Ready for categorization phase

### **Next Steps:**
1. Review all imported accounts in Personal Domain vault
2. Begin categorization process (Personal, Financial, High-Security, Delete)
3. Plan domain migration for non-personal accounts
4. Keep Dashlane active as backup during transition
EOF
        
    else
        print_warning "Import issues detected - troubleshooting needed"
    fi
}

# ============================================================================
# NEXT STEPS PLANNING
# ============================================================================

plan_next_steps() {
    print_header "🎯 NEXT STEPS AFTER IMPORT"
    
    if [[ "${import_success:-}" == "y" ]]; then
        echo ""
        echo "🎉 MIGRATION PHASE 1 COMPLETE!"
        echo ""
        echo "✅ Dashlane data exported successfully"
        echo "✅ All accounts imported to Personal Domain vault"
        echo "✅ Data safely backed up in 1Password"
        echo ""
        echo "🎯 IMMEDIATE NEXT STEPS:"
        echo ""
        echo "1. 📋 **Account Categorization** (This Week)"
        echo "   - Review all accounts in Personal Domain"
        echo "   - Categorize by domain type"
        echo "   - Identify accounts for deletion"
        echo ""
        echo "2. 🔄 **Domain Migration** (Next Week)"
        echo "   - Move financial accounts to Financial Domain"
        echo "   - Move high-security accounts to High-Security Domain"
        echo "   - Update browser bookmarks"
        echo ""
        echo "3. 📧 **Email Migration** (Parallel Process)"
        echo "   - Update account emails to match domains"
        echo "   - Set up Gmail forwarding"
        echo "   - Plan Gmail sunset timeline"
        echo ""
        echo "4. 🧹 **Cleanup and Verification** (Ongoing)"
        echo "   - Test all migrated accounts"
        echo "   - Delete unnecessary accounts"
        echo "   - Verify domain separation"
        echo ""
        
        print_recommendation "Keep Dashlane active until 100% verified!"
        print_info "Ready to start account categorization process?"
        
    else
        echo ""
        echo "🔧 TROUBLESHOOTING NEEDED"
        echo ""
        echo "Migration issues detected. Common solutions:"
        echo "- Check Dashlane export file format"
        echo "- Verify Personal Domain vault is selected"
        echo "- Try smaller batch imports if large file"
        echo "- Check 1Password import documentation"
    fi
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    case "${1:-all}" in
        "strategy")
            analyze_migration_strategy
            ;;
        "export")
            guide_dashlane_export
            ;;
        "import")
            guide_1password_import
            ;;
        "plan")
            plan_next_steps
            ;;
        "all")
            analyze_migration_strategy
            echo ""
            guide_dashlane_export
            echo ""
            guide_1password_import
            echo ""
            plan_next_steps
            ;;
        *)
            echo "🔄 Dashlane to 1Password Migration"
            echo ""
            echo "Usage: $0 [command]"
            echo ""
            echo "Commands:"
            echo "  strategy  - Show migration strategy and domain analysis"
            echo "  export    - Guide Dashlane data export process"
            echo "  import    - Guide 1Password import process"
            echo "  plan      - Show next steps after import"
            echo "  all       - Complete migration process"
            ;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi