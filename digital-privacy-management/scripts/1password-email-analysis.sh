#!/bin/bash
# 1Password Account Email: Personal vs High-Security Domain Analysis
# Deep dive into why personal domain is the better choice

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

print_comparison() {
    echo -e "${PURPLE}🔍 $1${NC}"
}

print_pro() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_con() {
    echo -e "${RED}❌ $1${NC}"
}

print_insight() {
    echo -e "${BLUE}💡 $1${NC}"
}

# ============================================================================
# DETAILED COMPARISON: PERSONAL vs HIGH-SECURITY EMAIL
# ============================================================================

analyze_email_choice() {
    print_header "🤔 PERSONAL vs HIGH-SECURITY EMAIL FOR 1PASSWORD"
    
    cat > "$HOME/.email-safety-net/1password-email-comparison.md" << 'EOF'
# 🤔 PERSONAL vs HIGH-SECURITY EMAIL FOR 1PASSWORD

## 🎯 THE QUESTION: Which Email Is Actually Better?

You raise an excellent point! Let's analyze both options thoroughly:

## 📊 OPTION A: streamcode@protonmail.com (Personal Domain)

### ✅ **PROS:**
- **Natural alignment**: Password manager is a personal tool
- **Daily access pattern**: You'll manage 1Password regularly  
- **Firefox integration**: Matches your personal browser
- **Logical hierarchy**: Personal tools in personal domain
- **Frequent use**: Password manager is everyday utility
- **Recovery simplicity**: Easy access for account management
- **Cost efficiency**: No additional setup needed

### ❌ **CONS:**
- **Lower security tier**: Not your highest-security domain
- **Broader attack surface**: Personal domain has more accounts
- **Mixed usage**: Personal accounts stored alongside critical ones

## 🛡️ OPTION B: deepvault@protonmail.com (High-Security Domain)

### ✅ **PROS:**
- **Maximum security**: Highest protection level
- **Minimal attack surface**: Fewest accounts in this domain
- **Critical system protection**: Password manager is critical infrastructure
- **Brave browser**: Enhanced security features
- **Restricted access**: Less frequent use = less exposure
- **Premium protection**: For your most important tool

### ❌ **CONS:**
- **Access complexity**: Need Brave browser for management
- **Daily friction**: Managing password manager from high-security domain
- **Domain mixing**: Password manager manages ALL domains, not just high-security
- **Overkill factor**: May be excessive for daily password management
- **Recovery complexity**: Harder access during emergencies

## 🎯 CRITICAL ANALYSIS: What Really Matters?

### **🔍 Key Insight #1: Password Manager Usage Pattern**
```
Daily Use:     Accessing passwords across ALL domains
Management:    Occasional account settings, vault management  
Emergency:     Need fast access during password recovery
```

**Winner**: Personal domain - matches daily usage pattern

### **🔍 Key Insight #2: Security Threat Model**
```
Personal Domain Threats:   Social engineering, phishing, general attacks
High-Security Threats:     Nation-state, advanced persistent threats, targeted attacks
Password Manager Threats:  Mass breaches, credential stuffing, social engineering
```

**Analysis**: Password manager faces general threats, not nation-state level

### **🔍 Key Insight #3: Domain Separation Purpose**
```
Personal:       Social media, entertainment, general accounts
Financial:      Banking, investments, money-related
High-Security:  Government, healthcare, crypto, legal
```

**Question**: Where does "password manager" naturally fit?

### **🔍 Key Insight #4: Recovery Scenarios**
```
Scenario 1: Forgot 1Password master password
Scenario 2: Need to access 1Password from new device
Scenario 3: Emergency access during travel
Scenario 4: Family member needs access
```

**Winner**: Personal domain - easier emergency access

## 🎯 EXPERT RECOMMENDATION: Personal Domain

### **🏆 Why streamcode@protonmail.com Wins:**

#### **1. Usage Pattern Alignment**
- Password manager is a **daily utility tool**
- You'll access it **frequently** across all domains
- **Firefox integration** for easy management
- **Natural workflow** for password management

#### **2. Security Is Already Excellent**
- **ProtonMail encryption** provides top-tier security
- **Swiss jurisdiction** offers strong legal protection  
- **Clean account** with no compromise history
- **2FA + recovery kit** provide additional layers

#### **3. Practical Simplicity**
- **Easy daily access** for password management
- **Natural browser alignment** (Firefox = personal)
- **Emergency recovery** is straightforward
- **Family sharing** options if needed

#### **4. Domain Logic**
- Password manager **serves all domains**, not just high-security
- **Personal tool** for personal digital life management
- **Infrastructure utility** rather than sensitive data storage

## 🔐 ALTERNATIVE: Hybrid Security Approach

### **If You Want Maximum Security:**

#### **Primary Account: Personal Domain**
```
1Password Account:     streamcode@protonmail.com
Daily Management:      Firefox browser
Regular Access:        All vaults via personal domain
```

#### **Enhanced Security Measures:**
```
Master Password:       Maximum complexity (30+ characters)
2FA:                  Hardware key (YubiKey) + backup codes
Recovery Email:        deepvault@protonmail.com (high-security backup)
Emergency Access:      Separate recovery methods
Vault Isolation:       Strict browser-vault separation
```

### **Best of Both Worlds:**
- **Daily usability** via personal domain
- **Maximum security** through enhanced measures
- **High-security backup** for recovery
- **Perfect vault separation** maintained

## 🚨 HIGH-SECURITY DOMAIN CONCERNS:

### **Why High-Security Domain Might Be Overkill:**

#### **1. Access Friction**
- **Brave browser required** for all 1Password management
- **Less convenient** for daily password needs
- **Complicates workflow** unnecessarily

#### **2. Domain Mixing**
- Password manager stores **all domain passwords**
- Creates **conceptual overlap** between domains
- **High-security domain** shouldn't manage personal/financial passwords

#### **3. Recovery Complexity**
- **Emergency access** more difficult
- **Family sharing** complications
- **Device setup** requires high-security browser

#### **4. Threat Model Mismatch**
- Password managers face **consumer-level threats**
- High-security domain designed for **nation-state threats**
- **Over-engineering** the security model

## ✅ FINAL VERDICT: Personal Domain

### **The Smart Choice: streamcode@protonmail.com**

#### **Reasoning:**
1. **Perfect security level** for password manager threats
2. **Optimal usability** for daily password management  
3. **Natural domain alignment** (personal tool = personal domain)
4. **Enhanced security measures** can be added without domain switching
5. **Emergency access** remains practical
6. **Future flexibility** for account management

#### **Security Enhancement Strategy:**
- Use **maximum complexity master password**
- Enable **hardware 2FA** (YubiKey)
- Set **high-security email as backup recovery**
- Implement **strict vault isolation**
- Regular **security audits** and monitoring

### **Result: Enterprise-Grade Security with Personal-Domain Practicality**

This gives you the perfect balance of maximum security and optimal usability for your digital privacy management system.
EOF

    print_comparison "Detailed analysis complete - personal domain wins for practical reasons"
}

# ============================================================================
# QUICK DECISION GUIDE
# ============================================================================

quick_decision() {
    print_header "⚡ QUICK DECISION: PERSONAL vs HIGH-SECURITY"
    
    cat << 'EOF'

🤔 **Your Question**: Shouldn't I use the high-security email?

💡 **Quick Answer**: Personal domain is actually better!

🎯 **Key Reasons:**

✅ **Daily Usage**: You'll access 1Password constantly from ALL domains
✅ **Natural Fit**: Password manager is a personal utility tool  
✅ **Browser Logic**: Firefox (personal) is perfect for 1Password management
✅ **Emergency Access**: Easier recovery if you get locked out
✅ **Security**: ProtonMail already provides enterprise-grade protection

❌ **High-Security Problems**:
❌ **Over-engineering**: Password managers don't need nation-state security
❌ **Access Friction**: Would require Brave browser for all management
❌ **Domain Mixing**: Password manager stores ALL domain passwords, not just high-security
❌ **Recovery Complexity**: Harder emergency access

🔐 **Security Enhancement Instead:**
- Use 30+ character master password
- Enable hardware 2FA (YubiKey)
- Set high-security email as backup recovery
- Maintain strict vault separation

🏆 **Result**: Personal domain gives you perfect security WITH perfect usability

📧 **Stick with**: streamcode@protonmail.com

EOF
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    case "${1:-quick}" in
        "analyze"|"detailed")
            analyze_email_choice
            ;;
        "quick"|"decision")
            quick_decision
            ;;
        "both")
            analyze_email_choice
            quick_decision
            ;;
        *)
            echo "🤔 1Password Email Choice Analysis"
            echo ""
            echo "Usage: $0 [command]"
            echo ""
            echo "Commands:"
            echo "  quick      - Quick decision guide"
            echo "  analyze    - Detailed comparison analysis"
            echo "  both       - Both quick and detailed analysis"
            ;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi