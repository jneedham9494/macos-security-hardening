# Project 09: Email Aliasing & Disposable Email Strategy

## 🎯 **Project Overview**

Implement comprehensive email aliasing strategy to protect your primary email addresses from spam, tracking, and breaches. Set up email aliases using ProtonMail/Tutanota features, configure disposable email services for temporary signups, implement email forwarding rules, and create a systematic approach for giving out unique email addresses to untrusted services. This creates traceable email addresses that can be disabled without affecting your primary accounts.

## ⏱️ **Estimated Time**: 3-5 hours initial setup + 15-30 min per new service

## 🚨 **Risk Level**: LOW - Additive security layer, minimal risk if configured properly

---

## ❗ **Why Email Aliasing Is Essential**

Your primary email address is **permanent and valuable** - once it's leaked or sold, you can't take it back:
- Services sell/leak email addresses constantly
- Shared email = linked identity across services (tracking)
- Spam follows you forever once your real email is on spammer lists
- Data breaches expose your email to credential stuffing attacks
- Email domain changes are painful (why you did Project 00!)

Email aliasing solves this by giving each service a **unique, disposable email** that:
- Forwards to your real inbox
- Can be disabled individually if it gets compromised/spammed
- Identifies which service leaked/sold your email (trackability)
- Prevents services from linking your identity across platforms
- Makes it easy to migrate services without changing 100+ accounts

**Example**: Instead of `jack@personal.com` everywhere, use:
- `jack+amazon@personal.com` for Amazon
- `jack.shopping.001@personal.com` for random online stores
- `temp.5f3a@personal.com` for one-time signups

---

## 📋 **Project Checklist**

### Phase 0: Aliasing Strategy Planning (Day 1)

- [ ] **Understand Your Email Provider's Aliasing Features**

  **ProtonMail (Plus/Professional Plans):**
  - Plus addresses: `yourname+anything@protonmail.com` (unlimited, free)
  - Catch-all: `anything@yourdomain.com` forwards to your account (requires custom domain)
  - Aliases: Up to 5-10 true aliases (separate email addresses, not just +tags)
  - Limitations: Plus tags can be stripped by spammers, catch-all requires custom domain

  **Tutanota:**
  - Aliases: 5 aliases on Premium, 20 on Teams, 50 on Pro (true separate addresses)
  - Catch-all: Available with custom domain
  - No plus addressing support (intentional design decision)

  **Gmail (If Still Using):**
  - Plus addressing: `yourname+anything@gmail.com` (unlimited, free)
  - Dot addressing: `your.name@gmail.com` = `yourname@gmail.com` (Gmail ignores dots)
  - Limitations: Google tracks everything, plus tags easily stripped, dot trick widely known

  **Apple iCloud+ (Hide My Email):**
  - Unlimited random aliases: `randomstring@icloud.com`
  - Each alias forwards to your real Apple email
  - Can be created on-demand in Safari when signing up for services
  - Labels: Add notes to remember which service uses which alias
  - Best for: Apple users, excellent privacy feature

  **SimpleLogin / AnonAddy (Third-Party Services):**
  - Unlimited aliases that forward to any email
  - Works with any email provider
  - Advanced features: PGP encryption, custom domains, API
  - Can reply from aliases (preserves anonymity)

- [ ] **Choose Your Aliasing Strategy**

  **Strategy 1: Plus Addressing (Easiest, Least Secure)**
  - Format: `yourname+servicename@domain.com`
  - Pro: Free, unlimited, works everywhere
  - Con: Easily stripped by spammers/services, obvious pattern
  - Best for: Low-risk services, personal tracking only

  **Strategy 2: Catch-All Domain (Moderate, Requires Custom Domain)**
  - Format: `servicename@yourdomain.com` or `anything@yourdomain.com`
  - Pro: Every email works, unique per service, looks professional
  - Con: Requires custom domain ($12/year), exposes domain if leaked
  - Best for: Professional use, moderate privacy needs

  **Strategy 3: True Aliases (Limited Quantity, High Privacy)**
  - Format: Separate email addresses (e.g., `jack.shopping@domain.com`)
  - Pro: True separate identities, can't be pattern-matched
  - Con: Limited quantity (5-50 depending on plan), manual setup per alias
  - Best for: High-value accounts (banking, important subscriptions)

  **Strategy 4: Third-Party Aliasing Service (Best Privacy, Requires Subscription)**
  - Services: SimpleLogin ($30/year), AnonAddy ($12/year), Firefox Relay ($1/month)
  - Format: `randomstring@service.com` or `custom@yourdomain.com`
  - Pro: Unlimited aliases, can reply from alias, works with any email provider, advanced features
  - Con: Adds dependency on third-party service, requires subscription
  - Best for: Maximum privacy, untrusted services, disposable needs

  **Recommended Hybrid Approach:**
  - Plus addressing: Low-risk services, personal tracking
  - True aliases: High-value accounts (5-10 accounts)
  - Third-party service: Medium-risk and untrusted services (unlimited)
  - Disposable email: One-time signups, temporary needs

- [ ] **Document Your Aliasing Scheme**
  - Create `email-aliasing-scheme.md`
  - Define naming conventions:
    - Pattern for plus addressing: `+servicename` or `+category-servicename`
    - Pattern for catch-all: `servicename@domain.com` or `category.service@domain.com`
    - How to generate random aliases for untrusted services
  - Document which strategy for which risk level

### Phase 1: Plus Addressing Setup (Day 1 - 30 min)

**If using ProtonMail, Tutanota, Gmail, or any provider that supports plus addressing:**

- [ ] **Test Plus Addressing**
  - Send test email to: `yourname+test@yourdomain.com`
  - Verify it arrives in your inbox
  - Check if your provider automatically labels/filters plus addresses

- [ ] **Create Filtering Rules**
  - ProtonMail: Settings → Filters → Create filter
  - Rule: If recipient contains `+shopping`, apply label "Shopping" and folder "Shopping"
  - Create filters for common categories:
    - `+shopping` → Shopping folder
    - `+social` → Social Media folder
    - `+finance` → Finance folder (if using personal domain for non-critical finance)
    - `+newsletters` → Newsletters folder (or trash)
    - `+temp` → Temporary folder (auto-delete after 30 days)

- [ ] **Create Plus Address Naming Convention**
  - **Option A: Service Name**
    - Format: `yourname+servicename@domain.com`
    - Example: `jack+amazon@personal.com`, `jack+netflix@personal.com`
    - Pro: Clear which service it's for
    - Con: Long, services can identify pattern

  - **Option B: Category + Number**
    - Format: `yourname+category-###@domain.com`
    - Example: `jack+shopping-001@personal.com`, `jack+shopping-002@personal.com`
    - Pro: Shorter, less obvious pattern
    - Con: Need to track which number goes to which service

  - **Option C: Random Short Code**
    - Format: `yourname+xyz123@domain.com`
    - Example: `jack+f3a2@personal.com`, `jack+m9k1@personal.com`
    - Pro: Looks random, harder to pattern match
    - Con: Impossible to remember, must track in spreadsheet

- [ ] **Start Using Plus Addressing for New Signups**
  - Going forward: NEVER use your bare email for new services
  - Always use plus addressing
  - Document in 1Password: Add email address used in "Username" field
  - Track in spreadsheet: `email-aliases-master.csv`

### Phase 2: Custom Domain Catch-All (Day 1-2) (Optional)

**Skip this if you don't own a custom domain. Requires: Custom domain + email hosting that supports catch-all.**

- [ ] **Purchase Privacy Domain** (If You Don't Have One)
  - Registrars with good privacy:
    - Njalla ($15/year) - Anonymous registration, accepts Bitcoin
    - Namecheap ($11/year) - Good privacy, WHOIS protection included
    - Cloudflare ($9/year) - Cheap, privacy-focused
  - Domain suggestions:
    - Use common surname + random number (e.g., `smith2847.com`)
    - Use random dictionary words (e.g., `bluecoffee289.com`)
    - AVOID using your real name or identifiable information

- [ ] **Configure Email Hosting with Catch-All**

  **Option 1: ProtonMail Custom Domain (Requires Plus/Professional)**
  - ProtonMail Settings → Domains → Add Domain
  - Follow DNS setup instructions (MX records, verification)
  - Enable catch-all: Settings → Domains → [Your Domain] → Catch-all
  - Choose: Forward all to your main account or create rules
  - Cost: $5/month for Plus (includes custom domain + catch-all)

  **Option 2: Tutanota Custom Domain (Requires Premium+)**
  - Settings → Custom email domains → Add domain
  - Configure DNS records as instructed
  - Enable catch-all forwarding
  - Cost: $3-8/month depending on plan

  **Option 3: Cloudflare Email Routing (Free)**
  - Cloudflare Dashboard → Email → Email Routing
  - Enable Email Routing for your domain
  - Configure catch-all rule → Forward to your primary email
  - Pro: Completely free, privacy-respecting
  - Con: Receive only (can't send FROM catch-all addresses)
  - Perfect for: Aliasing without needing to reply from aliases

  **Option 4: ForwardEmail.net (Free/Paid)**
  - Free: Unlimited catch-all forwarding
  - Paid ($3/month): Reply from aliases, custom rules, API
  - Configure DNS records as instructed
  - Set up catch-all forwarding

- [ ] **Test Catch-All Functionality**
  - Send test email to: `randomtest123@yourdomain.com`
  - Verify it arrives in your inbox
  - Try multiple random addresses to ensure all forward correctly

- [ ] **Create Catch-All Naming Convention**
  - **Format 1: Service Name**
    - `servicename@yourdomain.com`
    - Example: `amazon@yourdomain.com`, `netflix@yourdomain.com`

  - **Format 2: Category.Service**
    - `category.servicename@yourdomain.com`
    - Example: `shopping.amazon@yourdomain.com`, `streaming.netflix@yourdomain.com`

  - **Format 3: Random Generated**
    - `randomstring@yourdomain.com`
    - Example: `f3k29@yourdomain.com`, `a8m3k@yourdomain.com`
    - Generate using password manager or random string generator

- [ ] **Set Up Filtering Rules for Catch-All**
  - If your email provider allows:
    - Filter by recipient address
    - Auto-label and organize by service or category
  - Example: If recipient is `shopping.*@yourdomain.com`, label as "Shopping"

### Phase 3: Third-Party Aliasing Service Setup (Day 2) (Recommended)

**Choose one service for maximum flexibility and privacy:**

- [ ] **Option 1: SimpleLogin (Recommended)**

  **Setup:**
  - Visit: https://simplelogin.io/
  - Sign up with your primary email (financial or personal domain)
  - Choose plan:
    - Free: 15 aliases, 1 mailbox
    - Premium: $30/year - Unlimited aliases, custom domain support, PGP encryption, API
  - Connect your mailbox: Verify your primary email for forwarding
  - Download browser extension: Chrome, Firefox, Safari (creates aliases on-demand)
  - Download mobile app: iOS, Android

  **Create Your First Alias:**
  - Dashboard → Create Alias
  - Options:
    - Random alias: `randomstring@simplelogin.co`
    - Custom alias: `customname@simplelogin.co`
    - Custom domain: `anything@yourdomain.com` (if you have custom domain)
  - Forwards to: Your primary email
  - Enable/disable: Toggle aliases on/off individually
  - Label: Add note for which service this is for

  **Browser Extension Usage:**
  - When signing up for new service, click SimpleLogin icon
  - It auto-fills a new random alias
  - Alias is created and forwarded to your email automatically
  - Save alias to 1Password along with password

- [ ] **Option 2: AnonAddy (Alternative)**

  **Setup:**
  - Visit: https://anonaddy.com/
  - Sign up with primary email
  - Choose plan:
    - Free: 20 aliases, 1 recipient, limited bandwidth
    - Lite: $12/year - 50 aliases
    - Pro: $36/year - Unlimited everything
  - Verify your recipient email
  - Download browser extension (Chrome, Firefox)

  **Features:**
  - Format options: `username.abc123@anonaddy.me`
  - Shared domains: anonaddy.com, anonaddy.me (multiple options)
  - Custom domain: Add your own domain
  - Encryption: PGP encrypt forwarded emails
  - Reply from alias: Maintains anonymity even in replies

- [ ] **Option 3: Firefox Relay (Easy, Apple-Like)**

  **Setup:**
  - Visit: https://relay.firefox.com/
  - Sign in with Firefox account
  - Choose plan:
    - Free: 5 aliases
    - Premium: $1/month - Unlimited aliases, custom subdomain, phone masking
  - Browser integration: Built into Firefox (auto-suggest aliases)

  **Usage:**
  - Generate random alias: `randomstring@mozmail.com`
  - Or premium: `customname@yoursubdomain.mozmail.com`
  - Forward to: Your Firefox account email
  - Block/allow: Toggle forwarding per alias
  - Integrated with Firefox password manager

- [ ] **Option 4: Apple Hide My Email (If Apple User)**

  **Setup:**
  - Requires: iCloud+ subscription ($1/month, includes 50GB storage)
  - Settings → [Your Name] → iCloud → Hide My Email
  - Or: Built into Safari password manager when signing up for services

  **Usage:**
  - Safari auto-suggests: "Hide My Email"
  - Generates: `randomstring@icloud.com`
  - Forwards to: Your primary Apple ID email
  - Manage: Settings app or iCloud.com
  - Label: Add notes to remember which service
  - Integrated with Apple Keychain (auto-saves with password)

- [ ] **Configure Your Chosen Service**
  - Add all mailboxes (personal, financial, professional domains)
  - Set up default forwarding preferences
  - Install browser extension for easy alias generation
  - Test: Create alias, send test email, verify forwarding works
  - Test reply: Ensure you can reply from alias if service supports it

### Phase 4: Disposable Email for Temporary Needs (Day 2 - 30 min)

**For truly temporary signups (one-time access, suspect sites, testing):**

- [ ] **Identify Disposable Email Use Cases**
  - Accessing a PDF that requires email
  - One-time discount codes
  - Testing a service you don't trust
  - Signing up for something just to see content
  - Temporary project collaboration
  - Avoiding long-term commitment

- [ ] **Choose Disposable Email Service**

  **Option 1: Guerrilla Mail (No Account Required)**
  - Visit: https://www.guerrillamail.com/
  - Instant temporary email: `randomstring@guerrillamail.com`
  - Lasts: 1 hour (auto-deletes)
  - No signup, completely anonymous
  - Use for: Very temporary needs, one-time access

  **Option 2: Temp Mail (No Account Required)**
  - Visit: https://temp-mail.org/
  - Random email: `randomstring@tempmail.com`
  - Lasts: Until you close the tab (or can generate new one)
  - Simple interface, widely used
  - Use for: Temporary signups, testing

  **Option 3: 10 Minute Mail**
  - Visit: https://10minutemail.com/
  - Email lasts exactly 10 minutes (can extend)
  - Perfect for: Verification emails, quick signups
  - Use for: Services that require immediate email verification

  **Option 4: Your Aliasing Service's "Temp" Category**
  - SimpleLogin: Create aliases labeled "TEMP", delete after use
  - Advantage: Traceable, can reactivate if needed
  - Use for: Slightly longer-term temporary needs (days/weeks)

- [ ] **Create "Disposable Email" Workflow**
  - When you encounter a site requiring email but you don't trust it:
    1. Decide: Is this truly one-time? → Disposable service
    2. Or might I need it again? → Aliasing service with "TEMP" label
  - For disposable: Open in private/incognito window (don't save credentials)
  - For temp aliasing: Save in 1Password with "TEMPORARY" tag, review/delete quarterly

### Phase 5: Email Alias Tracking System (Day 3)

- [ ] **Create Alias-to-Service Mapping Spreadsheet**
  - Use: `email-aliases-master.csv` template
  - Columns:
    - Alias Email Address
    - Real Email (forwards to)
    - Service/Website
    - Date Created
    - Risk Level (Low/Medium/High)
    - Status (Active/Disabled/Spam/Compromised)
    - Notes
    - Aliasing Method (Plus/Catch-all/SimpleLogin/Disposable)

- [ ] **Document Existing Aliases**
  - If you already use plus addressing or aliases:
    - Review your sent mail and inbox
    - Identify all email addresses you've given out
    - Add to tracking spreadsheet
  - If starting fresh:
    - Begin tracking from now forward
    - Update spreadsheet every time you create new alias

- [ ] **Integrate Alias Tracking with 1Password**
  - When saving login to 1Password:
    - Username field: Include the alias email you used
    - Notes: Add "Alias: [email]@[domain]" for easy search
    - Tags: Add "email-alias" tag
  - This allows searching 1Password to find which service uses which alias

- [ ] **Set Up Alias Review Process**
  - Calendar reminder: Quarterly alias audit
  - Review:
    - Which aliases are receiving spam? (Disable them)
    - Which services leaked your alias? (Identify culprit, notify if major breach)
    - Which aliases are no longer needed? (Service canceled, account deleted)
    - Which aliases should be upgraded to more permanent email? (Service became important)
  - Update tracking spreadsheet

### Phase 6: Email Forwarding Rules & Filters (Day 3)

- [ ] **Set Up Inbox Organization Rules**

  **ProtonMail Filtering:**
  - Settings → Filters → Add Filter
  - Examples:
    - If recipient contains `+shopping`, move to "Shopping" folder, label "Shopping"
    - If recipient contains `+newsletters`, move to "Newsletters", mark as read
    - If recipient contains `+temp`, move to "Temporary", auto-delete after 30 days
    - If recipient contains certain alias, forward to specific folder

  **Tutanota Filtering:**
  - Settings → Email → Inbox rules
  - Similar logic: Recipient → Action (move, label, delete)

  **Third-Party Service Filtering:**
  - SimpleLogin: Can add notes to aliases (helps remember which is which)
  - Set up filters in your primary email based on sender or subject patterns

- [ ] **Create Spam Detection Rules**
  - If alias starts receiving spam:
    - Identifies which service leaked/sold your email
    - Action: Disable alias in aliasing service
    - Document: Which service was responsible (in tracking spreadsheet)
    - Contact service: Let them know their email list was compromised
    - Create new alias: For that service if you still need it

- [ ] **Set Up Priority Filtering**
  - Important aliases (banking, work): Priority inbox, notifications
  - Medium importance (subscriptions): Normal inbox, no notifications
  - Low importance (newsletters, promotions): Separate folder, batch review weekly
  - Temporary aliases: Auto-delete after 30 days

### Phase 7: Migration Strategy for Existing Accounts (Day 3-4)

**Gradually migrate existing accounts to aliasing system:**

- [ ] **Categorize Existing Accounts by Migration Priority**

  **DO NOT MIGRATE (Keep Original Email):**
  - Financial accounts (banks, credit cards, investments, crypto)
  - Government services (IRS, SSA, DMV, healthcare)
  - Work/professional accounts
  - Primary social media (Facebook, LinkedIn, Twitter)
  - Reason: These need your "real" domain email for legitimacy and recovery

  **MIGRATE TO ALIAS (High Priority):**
  - Shopping sites (Amazon, eBay, small retailers)
  - Subscription services (non-critical streaming, apps, SaaS)
  - Forums and communities
  - Mailing lists and newsletters
  - Reason: High spam risk, tracking risk, low consequence if disabled

  **MIGRATE OVER TIME (Low Priority):**
  - Gaming accounts
  - Entertainment services (Netflix, Spotify - if you want tracking protection)
  - Rarely-used accounts
  - Reason: Time investment, evaluate if you even want to keep account

- [ ] **Create Phased Migration Plan**
  - Week 1: All new signups use aliases (start immediately)
  - Week 2-4: Migrate high-priority accounts (shopping, subscriptions)
  - Month 2-3: Migrate medium-priority (entertainment, gaming)
  - Ongoing: Migrate accounts as you use them (lazy migration)

- [ ] **Migration Process Per Account**
  1. Choose appropriate alias type (plus addressing, catch-all, SimpleLogin)
  2. Generate alias following your naming convention
  3. Log into account → Settings → Change email address
  4. Update to new alias
  5. Verify confirmation email arrives (forwarding works)
  6. Update 1Password entry with new email
  7. Document in alias tracking spreadsheet
  8. Test login with new email

- [ ] **Handle Accounts That Don't Allow Email Changes**
  - Option 1: Keep original email (accept the tradeoff)
  - Option 2: Create new account with alias (lose history)
  - Option 3: Contact support to change email manually
  - Document: Services that make email changes difficult

---

## 🔍 **Advanced Aliasing Techniques**

### PGP Encryption with Aliases

- [ ] **SimpleLogin PGP Encryption**
  - Generate PGP key pair (use GPG or ProtonMail)
  - SimpleLogin Settings → Encryption → Add public key
  - All forwarded emails are encrypted before sending to you
  - Only you can decrypt (even SimpleLogin can't read)
  - Best for: Maximum privacy on untrusted services

### Reply From Alias (Preserving Anonymity)

- [ ] **Configure Reply Functionality**
  - SimpleLogin: Automatically enabled, reply to forwarded email and it replies from alias
  - AnonAddy: Same, reply-to address is set to alias
  - Benefit: Service never sees your real email, even in correspondence
  - Use case: Customer support, returns, ongoing communication where you want anonymity

### Domain Rotation Strategy

- [ ] **Multiple Domains for Compartmentalization**
  - Purchase 2-3 cheap domains for different purposes:
    - `shopping-domain.com` for all shopping sites
    - `social-domain.com` for social media and forums
    - `temp-domain.com` for temporary/untrusted signups
  - Benefit: If one domain gets burned (spam, blacklisted), others unaffected
  - Cost: $10-15/year per domain

### API-Based Alias Generation

- [ ] **SimpleLogin API for Power Users**
  - Generate aliases programmatically
  - Use cases:
    - Shell script to create alias and copy to clipboard
    - Integration with other tools
    - Automated alias creation for testing/development
  - Documentation: https://github.com/simple-login/app/blob/master/docs/api.md

---

## 🚧 **Common Issues & Solutions**

### Issue: Service rejects plus addressing (strips + and everything after)
**Solution**: Use catch-all domain or third-party aliasing service. Plus addressing is convenient but not universally respected. Some services intentionally block it.

### Issue: Can't remember which alias goes to which service
**Solution**: This is why tracking spreadsheet is critical. Also document in 1Password notes field. Consider using service name in alias (e.g., `amazon@domain.com`) for easy recall.

### Issue: Alias starts receiving spam
**Solution**: This is WORKING AS INTENDED. Disable that alias in your aliasing service. You now know which service leaked/sold your email. Create new alias for that service if you still need it. Document in tracking spreadsheet.

### Issue: Forgot to use alias for signup, used real email instead
**Solution**: If possible, change email address in account settings to alias. If not, accept it and make sure to use aliases going forward. Set up filtering rule to catch that sender.

### Issue: Email forwarding is slow (delay in receiving emails)
**Solution**: Normal for aliasing services (usually 1-5 minute delay). For time-sensitive emails (2FA codes), use your real email or faster aliasing service. SimpleLogin is generally faster than others.

### Issue: Service blocks emails from aliasing service (spam filter)
**Solution**: Rare but happens. Some services blacklist known aliasing domains. Workaround: Use custom domain catch-all or plus addressing. Or contact service support to whitelist.

### Issue: Too many aliases, losing track
**Solution**: Simplify naming convention. Use your third-party aliasing service's labeling/notes feature. Keep tracking spreadsheet updated. Regularly audit and delete unused aliases.

---

## ✅ **Success Criteria**

- [ ] Aliasing strategy chosen and documented (plus addressing, catch-all, third-party, or hybrid)
- [ ] Aliasing service configured (SimpleLogin, AnonAddy, Firefox Relay, or built-in provider features)
- [ ] Browser extension installed (if applicable) for easy alias generation
- [ ] Email forwarding rules set up for organization and filtering
- [ ] Alias tracking system established (`email-aliases-master.csv`)
- [ ] Naming convention defined and documented
- [ ] Test aliases created and verified (forwarding works, can reply if needed)
- [ ] ALL new signups use aliases (no more giving out real email)
- [ ] High-risk existing accounts migrated to aliases (shopping, subscriptions, newsletters)
- [ ] Quarterly alias review process scheduled in calendar
- [ ] Integration with 1Password (aliases documented in login entries)

---

## 📁 **Project Files**

- `email-aliasing-scheme.md` - Complete documentation of your aliasing strategy and naming conventions
- `email-aliases-master.csv` - Master tracking spreadsheet (alias → service mapping)
- `aliasing-service-comparison.md` - Comparison of SimpleLogin vs AnonAddy vs Firefox Relay vs Apple Hide My Email
- `migration-priority-list.txt` - Which accounts to migrate to aliases (prioritized)
- `spam-culprits.txt` - Services that leaked/sold email addresses (identified via alias spam)
- `email-filtering-rules.md` - Documentation of forwarding and filtering rules set up
- `quarterly-alias-audit-checklist.md` - Recurring checklist for alias review

---

## 🔄 **Dependencies**

- **Prerequisite**: Primary email domains must be active (Personal, Financial, Professional)
- **Prerequisite**: Custom domain (optional, only if using catch-all strategy)
- **Prerequisite**: Email provider that supports aliasing features (plus addressing, catch-all, or third-party)
- **Recommended Before**: Project 00 (Login Migration) - establishes your primary email domains
- **Recommended Before**: Project 06 (Subscription Audit) - identifies accounts to migrate
- **Blocks**: None - this is an additive privacy layer
- **Timeline**: Set up early and use for all new signups going forward

---

## ⚠️ **Critical Warnings**

1. **Plus addressing can be stripped by spammers** - not foolproof, but better than nothing
2. **Don't use aliases for financial accounts** - use your real domain email for legitimacy
3. **Track your aliases religiously** - you'll forget which alias goes where
4. **Third-party aliasing services are a dependency** - if they shut down, you lose access to those aliases
5. **Custom domain catch-all requires domain renewal** - set auto-renew or lose all aliases
6. **Some services block known aliasing domains** - always have backup method (plus addressing)
7. **Disposable emails expire** - don't use for anything you need long-term access to
8. **Replying from alias can break with some email clients** - test reply functionality
9. **Spam identifies leak source** - this is a feature, not a bug (use it to identify bad actors)
10. **Don't over-complicate** - start simple (plus addressing), add complexity as needed

---

## 📊 **Aliasing Service Comparison**

| Service | Cost | Aliases | Custom Domain | Reply | Encryption | Best For |
|---------|------|---------|---------------|-------|------------|----------|
| **Plus Addressing** | Free | Unlimited | N/A | Yes | No | Low-risk, easy start |
| **Catch-All Domain** | $12/year (domain) | Unlimited | Yes (yours) | Yes | Depends on host | Professional use |
| **SimpleLogin** | $30/year | Unlimited | Yes | Yes | PGP | Best all-around |
| **AnonAddy** | $12-36/year | 50-Unlimited | Yes | Yes | PGP | Budget-friendly |
| **Firefox Relay** | $1/month | Unlimited | Subdomain only | No | No | Easy, integrated |
| **Apple Hide My Email** | $1/month | Unlimited | N/A | No | No | Apple users |

---

## 🎯 **Quick Start**

Ready to implement email aliasing? Follow this order:

**Day 1: Setup & Testing** (2 hours)
1. Choose aliasing strategy (recommendation: SimpleLogin for most users)
2. Sign up for SimpleLogin (or your chosen service)
3. Install browser extension
4. Create and test first 3 aliases
5. Verify forwarding works and you can receive emails

**Day 2: System & Tracking** (1-2 hours)
6. Document naming convention
7. Set up email filtering rules in your primary email
8. Create alias tracking spreadsheet
9. Integrate with 1Password (document aliases in login entries)

**Day 3: Migration Start** (1-2 hours)
10. Identify 5-10 high-priority accounts to migrate (shopping, subscriptions)
11. Change email addresses to new aliases
12. Test login with new aliases
13. Update tracking spreadsheet

**Ongoing: New Signups** (15-30 min per service)
- NEVER use real email for new signups
- Generate alias via browser extension or service
- Document in 1Password and tracking spreadsheet
- Quarterly: Review and clean up unused aliases

**Total Initial Setup: 3-5 hours**
**Per New Service: 15-30 minutes**

Remember: Email aliases are your **traceable identity layer** - once set up, they make privacy and spam management effortless! 📧🔒
