# Project 00: Migrate All Logins Away From Gmail

## 🎯 **Project Overview**
Systematically identify and migrate ALL accounts currently using jackneedham9494@gmail.com as their primary login email to the appropriate domain-specific email addresses.

## ⏱️ **Estimated Time**: 6-10 hours spread over 2-3 weeks
## 🚨 **Risk Level**: HIGH - Critical prerequisite for safe Gmail account deletion

---

## ❗ **Why This Comes First**

This project is **Project 00** because it MUST be completed before you can safely delete your Gmail account (Project 01). If any accounts still use Gmail as their primary login, you'll lose access when the account is deleted.

**This project focuses on LOGIN EMAIL MIGRATION, not just recovery emails.**

---

## 📋 **Project Checklist**

### Phase 0: Discovery & Audit (Week 1)

- [ ] **Export account list from 1Password**
  - Export all items to CSV
  - Filter for items containing "gmail.com" in username/email field
  - Generate master list of accounts to migrate

- [ ] **Run account audit script**
  - Execute: `scripts/analyze-accounts-csv.sh`
  - Review the accounts.csv file (24,000+ lines)
  - Identify accounts by category

- [ ] **Check for "Sign in with Google" OAuth**
  - Go to: https://myaccount.google.com/permissions
  - Document ALL apps using Google OAuth
  - These need full account migration, not just email updates

- [ ] **Browser stored passwords audit**
  - Check Safari/Chrome/Firefox saved passwords
  - Export any passwords not in 1Password yet
  - Add to migration list

### Phase 1: Categorize by Domain (Week 1)

For each account, determine target domain:

- [ ] **Personal/Social Domain** → personal@protonmail.com
  - Social media (Twitter, Instagram, Facebook, Reddit, Discord)
  - Entertainment (Netflix, Spotify, YouTube, Steam)
  - Personal shopping (Amazon personal, hobby sites)
  - Dating/social apps

- [ ] **Financial/Banking Domain** → finance@tutanota.de
  - Banks and credit unions
  - Credit card accounts
  - Investment platforms (stocks, retirement, Fidelity)
  - Cryptocurrency exchanges (Coinbase, Kraken)
  - Insurance (health, auto, home)
  - Payment processors (PayPal, Venmo)

- [ ] **Professional/Work Domain** → work@company.com
  - LinkedIn (work profile)
  - Professional development platforms
  - Industry-specific tools
  - Work-adjacent services

- [ ] **Travel Domain** → travel@[disposable].com
  - Airlines (EasyJet, British Airways, United)
  - Hotels (Marriott, Hilton, Airbnb)
  - Car rentals
  - Travel booking sites

- [ ] **High-Security Domain** → secure@tutanota.de
  - Cryptocurrency wallets (hardware wallet services)
  - Secure communications (Signal, encrypted email)
  - Privacy tools and VPN services
  - Government services

### Phase 2: Account Migration Strategy (Week 1-2)

- [ ] **Create migration tracking spreadsheet**
  - Columns: Account Name, Current Email, Target Domain, Status, Notes, Date Migrated
  - Import from scripts/accounts.csv analysis
  - Track progress for all ~100-200 accounts

- [ ] **Prioritize by risk level**
  - **CRITICAL (Migrate First)**: Financial, crypto, work accounts
  - **HIGH (Migrate Next)**: Social media, primary shopping accounts
  - **MEDIUM**: Entertainment services, secondary accounts
  - **LOW**: Rarely-used accounts, can delete instead

- [ ] **Document "hard migration" accounts**
  - Some services don't allow email changes
  - Options: Create new account, contact support, or accept loss
  - List of known problematic services

### Phase 3: Execute Migrations (Week 2-3)

**Critical Accounts (Day 1-3)**
- [ ] Migrate banking accounts (typically requires phone/ID verification)
- [ ] Migrate investment accounts (may need broker support call)
- [ ] Migrate cryptocurrency exchanges (verify 2FA codes work after)
- [ ] Migrate primary credit cards
- [ ] Migrate insurance providers

**High-Priority Accounts (Day 4-7)**
- [ ] Migrate social media (Twitter, Instagram, Facebook, Reddit)
- [ ] Migrate email services (ProtonMail, Tutanota admin emails)
- [ ] Migrate Amazon and primary shopping accounts
- [ ] Migrate entertainment (Netflix, Spotify, YouTube)
- [ ] Migrate password managers (if email is used for recovery)

**Medium-Priority Accounts (Week 2)**
- [ ] Migrate gaming accounts (Steam, console accounts)
- [ ] Migrate travel loyalty programs
- [ ] Migrate subscription services
- [ ] Migrate utility accounts
- [ ] Migrate smaller shopping sites

**Low-Priority Accounts (Week 3)**
- [ ] Migrate or delete rarely-used accounts
- [ ] Migrate forums and community sites
- [ ] Migrate newsletter subscriptions
- [ ] Clean up any remaining accounts

### Phase 4: OAuth & Social Login Migration (Week 3)

- [ ] **Audit all social login providers**
  - Check: https://myaccount.google.com/permissions (Sign in with Google)
  - Check: facebook.com/settings → Apps and Websites (Sign in with Facebook)
  - Check: appleid.apple.com → Sign in with Apple
  - Check: github.com/settings/applications (OAuth apps)
  - Check: twitter.com/settings/connected_apps (Sign in with Twitter)
  - Check: linkedin.com/settings/data-privacy → Other applications

- [ ] **Categorize OAuth-connected apps by strategy**
  - **Type A - Can migrate to email/password**: Create new login, disconnect OAuth
  - **Type B - Can switch providers**: Change from Google to Apple/GitHub/etc.
  - **Type C - OAuth only, no alternatives**: Keep Google temporarily or find alternative app
  - **Type D - Can create new account**: Start fresh with new domain email

- [ ] **Execute OAuth migrations by type**

  **Type A: Convert to email/password (Preferred)**
  - Check if service allows adding email/password authentication
  - Add email/password login to existing account
  - Test new login method works
  - Disconnect OAuth provider
  - Revoke OAuth permission

  **Type B: Switch OAuth providers (Good alternative)**
  - Check if service supports multiple OAuth providers
  - Add new provider (Apple ID, GitHub, LinkedIn)
  - Test new provider login works
  - Remove Google OAuth
  - Revoke Google permission

  **Type C: Keep OAuth temporarily (Last resort)**
  - Document why you need to keep it
  - Set reminder to re-evaluate in 90 days
  - Keep Google account active with forwarding
  - Consider alternative services in the meantime

  **Type D: Create new account (Clean slate)**
  - Sign up with new domain-appropriate email
  - Migrate critical data manually (if possible)
  - Delete old OAuth-connected account
  - Revoke OAuth permission

- [ ] **Handle specific OAuth scenarios**
  - **Apple "Sign in with Apple"**: Generally privacy-friendly, can keep or migrate
  - **GitHub OAuth**: Fine for developer tools, consider keeping
  - **Facebook Login**: High priority to remove for privacy reasons
  - **LinkedIn Login**: Depends on professional needs
  - **Twitter/X Login**: Consider migrating due to platform instability

- [ ] **Remove OAuth permissions after migration**
  - Google: https://myaccount.google.com/permissions
  - Facebook: facebook.com/settings → Apps and Websites → Remove
  - Apple: appleid.apple.com → Sign-In & Security → Apps using Apple ID
  - GitHub: github.com/settings/applications → Revoke
  - LinkedIn: linkedin.com/settings/data-privacy → Revoke access

### Phase 5: Verification (Week 3-4)

- [ ] **Test all migrated accounts**
  - Log in with new email address
  - Verify password works from 1Password
  - Confirm 2FA codes work (if applicable)
  - Check that account functions normally

- [ ] **Update 1Password entries**
  - Update username/email field to new address
  - Move to appropriate vault (Personal, Financial, High-Security)
  - Add tags for domain categorization
  - Update notes with migration date

- [ ] **Final Gmail inbox scan**
  - Search for "verify email" or "confirm email" messages
  - Look for password reset emails (indicates missed accounts)
  - Check for recurring billing notifications
  - Screenshot/document any services still emailing old address

- [ ] **Create account recovery backup**
  - Export updated 1Password vault
  - Store encrypted backup in safe location
  - Document emergency access procedures
  - Verify backup codes for critical accounts

---

## 🔍 **Account Discovery Methods**

### Method 1: 1Password Export
```bash
# Export from 1Password to CSV
# Filter for gmail.com entries
grep -i "gmail.com" 1password-export.csv > gmail-accounts.txt
```

### Method 2: Email Search
Search Gmail inbox for:
- "welcome" OR "account created"
- "verify your email"
- "password reset"
- "billing" OR "invoice"
- "subscription" OR "renewal"

### Method 3: Browser History Analysis
Review frequently visited sites and check if you're logged in with Gmail

### Method 4: Use Existing Scripts
```bash
cd /Users/jackdev/development/digital-privacy-management/scripts
./analyze-accounts-csv.sh
./account-categorization.sh
```

---

## 🚧 **Common Issues & Solutions**

### Issue: Service doesn't allow email changes
**Solution**:
1. Contact customer support (many will change it manually)
2. Create new account with new email, cancel old one
3. If critical data: Export data, migrate to new account
4. If not important: Accept loss and move on

### Issue: Need Gmail for account recovery
**Solution**: Update recovery email BEFORE changing primary email. Most services let you have multiple recovery options.

### Issue: "Sign in with Google" can't be disconnected
**Solution**:
1. Keep Google account active temporarily (set up forwarding)
2. Evaluate alternative services that don't require Google
3. After 90 days, revisit if service added email/password option
4. Consider switching to "Sign in with Apple" if available (better privacy)

### Issue: Multiple OAuth providers connected to same account
**Solution**: This is actually good! Test each login method, keep the most privacy-friendly (Apple > GitHub > LinkedIn > Google > Facebook), remove the rest.

### Issue: Service only supports OAuth, no email/password option
**Solution**:
1. Check if you can add a secondary OAuth provider (Apple, GitHub)
2. If not, evaluate if you really need this service
3. Consider competitor services that offer email/password login
4. If critical: Keep Google account active but disable all other uses

### Issue: Lost track of which accounts are migrated
**Solution**: Use the tracking spreadsheet religiously. Mark each account immediately after migration.

---

## ✅ **Success Criteria**

- [ ] 100% of financial accounts migrated to finance domain
- [ ] 100% of social/personal accounts migrated to personal domain
- [ ] 90%+ of all accounts migrated (some services may be impossible)
- [ ] Zero critical services still using Gmail as primary login
- [ ] All "Sign in with Google" OAuth connections documented and planned
- [ ] 1Password vaults updated and organized by domain
- [ ] Migration tracking spreadsheet complete and verified

---

## 📁 **Project Files**

- `migration-tracking.csv` - Master account migration tracker
- `domain-categorization.txt` - Account-to-domain mapping
- `oauth-apps-list.txt` - All OAuth/social login providers by service
- `oauth-migration-strategy.txt` - Type A/B/C/D categorization for each OAuth app
- `hard-migration-accounts.txt` - Services that don't allow email changes
- `keep-google-temporarily.txt` - Apps that require temporary Google access
- `verification-log.md` - Testing log for migrated accounts

---

## 🔄 **Dependencies**

- **Prerequisite**: New email accounts must be active and receiving mail
- **Prerequisite**: 1Password must be set up with domain-specific vaults
- **Blocks**: Project 01 (Gmail cleanup) - CANNOT delete Gmail until this is done
- **Timeline**: Start immediately, complete before attempting Project 01

---

## ⚠️ **Critical Warnings**

1. **DO NOT delete Gmail account until this project is 100% complete**
2. **Test login with NEW email before removing OLD email from account**
3. **Update recovery emails in addition to primary login email**
4. **Keep detailed notes** - you'll need them when troubleshooting later
5. **Financial accounts are HIGH RISK** - double and triple check these

---

## 📊 **Estimated Account Counts**

Based on typical user with 10+ years of Gmail usage:
- Financial: 10-20 accounts
- Social/Personal: 30-50 accounts
- Professional: 10-15 accounts
- Shopping/Subscriptions: 40-60 accounts
- Travel: 10-20 accounts
- Forums/Communities: 20-30 accounts
- **Total**: ~150-200 accounts to migrate

---

## 🎯 **Quick Start**

Ready to begin? Start with these three steps:

1. **Export 1Password to CSV** - Get your master account list
2. **Run account analysis script** - `./scripts/analyze-accounts-csv.sh`
3. **Create migration tracking spreadsheet** - Template provided above

**Remember**: This is tedious but CRITICAL work. Take breaks, stay organized, and verify everything! 🔒
