# Project 06: Subscription & Recurring Payment Audit

## 🎯 **Project Overview**

Comprehensive audit of ALL recurring subscriptions and memberships across streaming services, software, gyms, memberships, cloud storage, and any other recurring charges. Cancel unnecessary subscriptions, update payment methods to domain-appropriate cards, migrate accounts to correct email domains, and establish a tracking system to prevent future subscription creep.

## ⏱️ **Estimated Time**: 4-6 hours over 1 week

## 🚨 **Risk Level**: LOW - Mostly administrative work, but requires attention to avoid accidentally canceling needed services

---

## ❗ **Why Subscription Audits Matter**

Most people are **hemorrhaging money** on forgotten subscriptions:
- Average person has 12-15 recurring subscriptions
- 42% of people have forgotten subscriptions they're still paying for
- Average waste: $133-$200/month on unused subscriptions
- Subscription services make it easy to sign up, hard to cancel (dark patterns)
- Email compartmentalization helps: Different emails for different categories makes tracking easier

Beyond saving money, this project:
- Reduces your digital footprint (fewer services with your data)
- Aligns payment methods with your domain strategy
- Identifies privacy risks (services that have old email/payment info)
- Establishes tracking system to prevent future waste

---

## 📋 **Project Checklist**

### Phase 0: Discovery & Inventory (Day 1)

- [ ] **Review Credit Card/Bank Statements**
  - Pull last 3-6 months of statements for ALL cards and bank accounts
  - Highlight every recurring charge
  - Note: Subscription name, amount, frequency, payment method
  - Look for: Monthly, quarterly, annual subscriptions

- [ ] **Check Digital Receipt Archives**
  - Search Gmail/old email for: "subscription", "recurring", "membership", "auto-renew", "invoice"
  - Search for: "trial ending", "payment processed", "subscription renewed"
  - Document services you might have forgotten

- [ ] **Review App Store Subscriptions**
  - **iOS**: Settings → [Your Name] → Subscriptions
  - **Google Play**: Play Store → Menu → Subscriptions
  - **Amazon**: Account → Memberships & Subscriptions
  - Document all active subscriptions

- [ ] **Check PayPal Recurring Payments**
  - PayPal → Settings → Payments → Manage automatic payments
  - Document all active agreements
  - Note: Many people forget PayPal subscriptions

- [ ] **Check Other Payment Processors**
  - Venmo: Settings → Subscriptions (if available)
  - Cash App: Activity → Recurring payments
  - Any buy-now-pay-later services (Affirm, Klarna)

- [ ] **Create Master Subscription Inventory**
  - Use `subscription-audit-master.csv` template
  - Columns: Service Name, Category, Cost, Frequency, Payment Method, Email Used, Last Use Date, Keep/Cancel Decision, Action Date
  - List EVERY subscription found

### Phase 1: Categorize Subscriptions (Day 1-2)

**Sort subscriptions into categories for analysis:**

- [ ] **Streaming & Entertainment**
  - Video: Netflix, Hulu, Disney+, HBO Max, Prime Video, Peacock, Paramount+, Apple TV+
  - Music: Spotify, Apple Music, YouTube Music, Tidal, Pandora, SiriusXM
  - Gaming: Xbox Game Pass, PlayStation Plus, Nintendo Switch Online, Discord Nitro, Steam
  - Podcasts: Patreon subscriptions, podcast premium feeds
  - Reading: Kindle Unlimited, Audible, Scribd, magazine subscriptions

- [ ] **Software & Productivity**
  - Cloud storage: iCloud, Google Drive, Dropbox, OneDrive, pCloud, Sync.com
  - Productivity: Microsoft 365, Adobe Creative Cloud, Grammarly, Notion, Evernote
  - Password managers: 1Password (keep!), LastPass, Dashlane
  - VPN: NordVPN, ExpressVPN, Mullvad, ProtonVPN, Private Internet Access
  - Antivirus: Norton, McAfee, Malwarebytes
  - Development: GitHub Pro, Heroku, AWS, various APIs

- [ ] **News & Information**
  - News: New York Times, Wall Street Journal, Washington Post, Bloomberg, The Athletic
  - Magazines: Wired, The Economist, New Yorker, etc.
  - Research: JSTOR, academic journals, professional databases

- [ ] **Health & Fitness**
  - Gym memberships: Planet Fitness, 24 Hour Fitness, local gyms
  - Fitness apps: Peloton, Apple Fitness+, Beachbody, Strava Premium
  - Meditation: Headspace, Calm, Ten Percent Happier
  - Health tracking: MyFitnessPal Premium, Lose It!, Cronometer

- [ ] **Food & Delivery**
  - Meal kits: HelloFresh, Blue Apron, EveryPlate
  - Delivery services: DoorDash DashPass, Uber Eats Pass, Grubhub+
  - Coffee: Blue Bottle, Trade Coffee
  - Snacks: SnackCrate, various subscription boxes

- [ ] **Professional & Education**
  - Professional memberships: LinkedIn Premium, industry associations
  - Learning platforms: Coursera, Udemy, MasterClass, Skillshare, Pluralsight
  - Certifications: Annual renewals for professional certifications

- [ ] **Lifestyle & Shopping**
  - Amazon Prime (Video + Shipping)
  - Costco/Sam's Club membership
  - Beauty boxes: Birchbox, Ipsy, FabFitFun
  - Clothing: Stitch Fix, Rent the Runway
  - Subscription boxes: Various monthly boxes

- [ ] **Financial Services**
  - Credit monitoring: Credit Karma, IdentityGuard, LifeLock
  - Investment apps: Robinhood Gold, M1 Plus, premium trading platforms
  - Banking services: Premium checking account fees, safe deposit box

- [ ] **Rarely-Used or Forgotten**
  - Free trials that converted to paid (common culprit!)
  - Services from old interests/hobbies
  - Duplicate services (e.g., two cloud storage subscriptions)
  - Work-related subscriptions from old jobs

### Phase 2: Keep/Cancel Decision Matrix (Day 2-3)

**For EACH subscription, evaluate:**

- [ ] **Usage Analysis**
  - When did I last use this service? (Check login history if available)
  - How often do I use it? (Daily, weekly, monthly, rarely)
  - What's my cost per use? (Annual cost ÷ times used per year)
  - Could I accomplish the same thing for free or cheaper?

- [ ] **Value Assessment**
  - Does this service provide real value to my life?
  - Am I using it out of habit or genuine need?
  - Would I miss it if I canceled? (Be honest!)
  - Is there a cheaper alternative?

- [ ] **Duplication Check**
  - Do I have multiple subscriptions that serve the same purpose?
    - Example: Netflix + Hulu + Disney+ + HBO Max (do you need ALL?)
    - Example: Spotify + Apple Music (pick one)
    - Example: Two cloud storage services (consolidate)
  - Can I share with family (legitimate family plans)?

- [ ] **Apply Decision Criteria**

  **KEEP IF:**
  - Use it at least weekly
  - No free alternative exists
  - Cost per use is reasonable
  - Provides significant value

  **CONSIDER DOWNGRADING IF:**
  - Current tier has features you don't use
  - Lower tier meets your needs
  - Can switch to annual plan for discount

  **CANCEL IF:**
  - Haven't used in 3+ months
  - Forgot it existed until now
  - Free alternative is good enough
  - Duplicate of another service
  - Cost per use is unreasonably high
  - Can resubscribe later if needed

  **PAUSE IF:**
  - Seasonal use (e.g., ski resort pass, summer streaming)
  - Project-based need (e.g., Adobe for one project)
  - Many services allow pausing without losing account

### Phase 3: Execute Cancellations (Day 3-4)

**Cancellation Strategy: Work from least painful to most impactful**

- [ ] **Wave 1: Definitely Unused (Start Here - Easy Wins)**
  - Services you forgot existed
  - Free trials that auto-converted
  - Services from old hobbies
  - Duplicate subscriptions
  - Goal: Build momentum with easy cancellations

- [ ] **Wave 2: Rarely Used**
  - Used once or twice in past year
  - "Maybe I'll need it someday" subscriptions
  - Services that have adequate free alternatives

- [ ] **Wave 3: Downgrade Instead of Cancel**
  - Services you use but are on too high a tier
  - Switch from monthly to annual (often 20-40% cheaper)
  - Switch from individual to family plan (share with partner)

- [ ] **Cancellation Execution Checklist (Per Service)**
  - Log into service account
  - Navigate to subscription settings (often buried in dark patterns)
  - Screenshot current subscription details (for records)
  - Note cancellation date and whether you retain access until end of billing cycle
  - Download any data you want to keep (playlists, documents, etc.)
  - Cancel subscription
  - Confirm cancellation email received
  - Mark in spreadsheet: "Canceled - Ends [date]"
  - Set calendar reminder 1 week before end date to verify cancellation

- [ ] **Common Cancellation Paths (Cheat Sheet)**
  - **Netflix**: Account → Membership & Billing → Cancel Membership
  - **Spotify**: Account → Subscription → Cancel Premium
  - **Amazon Prime**: Account → Prime Membership → End Membership
  - **Adobe**: Account → Plans → Manage Plan → Cancel (watch for early termination fee!)
  - **Gym memberships**: Often require in-person cancellation or certified letter (check contract)
  - **The Athletic**: Settings → Manage Subscription → Cancel
  - **NYT**: Account → Subscription → Cancel (expect retention offers)

- [ ] **Handle Cancellation Dark Patterns**
  - "Are you sure?" screens: Yes, I'm sure
  - Retention offers (discounts): Only accept if you were genuinely considering keeping
  - "Downgrade instead?" offers: Evaluate honestly (sometimes good deal)
  - Phone-only cancellation: Block out time, expect hold times
  - Certified letter required: Send immediately, certified mail with tracking

- [ ] **Document Difficult Cancellations**
  - Services that make cancellation intentionally difficult
  - Take screenshots of process
  - Keep confirmation emails
  - Report to `difficult-cancellations.txt` (useful for others)

### Phase 4: Update Payment Methods & Email Addresses (Day 4-5)

**For subscriptions you're KEEPING:**

- [ ] **Align Payment Methods with Domain Strategy**
  - **Personal Domain** subscriptions (Netflix, Spotify, gaming) → Personal credit card
  - **Professional Domain** subscriptions (LinkedIn Premium, industry tools) → Work credit card
  - **Household/Family** subscriptions (shared services) → Household card
  - Update payment method in each service's billing settings

- [ ] **Update Email Addresses to Domain Strategy**
  - **Entertainment subscriptions** → Personal domain email
  - **Professional subscriptions** → Professional domain email
  - **Financial subscriptions** → Financial domain email
  - Note: Some services require you to create a new account with new email (evaluate if worth it)

- [ ] **Consolidate Where Possible**
  - Family plans: Switch from multiple individual accounts to one family plan
    - Spotify Family, Apple Music Family, YouTube Premium Family, Disney+ Bundle
  - Bundle opportunities:
    - Disney+ / Hulu / ESPN+ bundle
    - Microsoft 365 Family (6 accounts)
  - Shared accounts (legitimate sharing with household members)

- [ ] **Set Up Payment Failure Alerts**
  - Ensure credit card has alerts enabled for declined payments
  - Update expiration dates proactively (set calendar reminders)
  - Have backup payment method on file for critical services

### Phase 5: Establish Subscription Tracking System (Day 5)

- [ ] **Set Up Subscription Management Tool**
  - **Option 1: Spreadsheet** (free, flexible)
    - Use `subscription-tracker-ongoing.csv` template
    - Columns: Service, Category, Cost, Frequency, Next Billing Date, Payment Method, Email, Cancel By Date, Notes
    - Update monthly

  - **Option 2: Subscription Management App** (paid, automated)
    - Truebill / Rocket Money (tracks and helps cancel)
    - Bobby (iOS subscription tracker)
    - Budget apps with subscription tracking (YNAB, Mint)
    - Caution: These apps need read access to your bank accounts (privacy tradeoff)

  - **Option 3: Calendar-Based Tracking** (free, proactive)
    - Create calendar events for each renewal date
    - Set reminders 1 week before renewal to reevaluate
    - Especially important for annual subscriptions (easy to forget)

- [ ] **Create Subscription Decision Process**
  - Before subscribing to new service:
    - Do I already have something that does this?
    - Can I trial it for free first?
    - Is this an impulse subscription or genuine need?
    - What's the cancellation process? (Check BEFORE subscribing)
    - Add to tracking system IMMEDIATELY upon subscribing
  - Set rule: "No new subscriptions without canceling one first" (subscription budget)

- [ ] **Set Up Quarterly Review Process**
  - Calendar reminder: Review all subscriptions every 3 months
  - Questions to ask:
    - Which subscriptions did I NOT use this quarter?
    - Are there new cheaper alternatives?
    - Can I pause seasonally-used subscriptions?
    - Am I approaching any annual renewal dates?
  - Document in: `quarterly-subscription-review-YYYY-QX.md`

- [ ] **Create Virtual Card System for Trials** (Advanced)
  - Use Privacy.com or bank's virtual card numbers for free trials
  - Set spending limit ($1 for trial, prevents auto-charge after trial ends)
  - Prevents forgetting to cancel trials
  - Each trial gets unique virtual card number

---

## 🔍 **Subscription Audit Insights**

### Hidden Subscription Locations to Check

- [ ] **Domain Registrars** (GoDaddy, Namecheap, etc.)
  - Auto-renewing domain registrations
  - Privacy protection add-ons
  - Email hosting

- [ ] **Web Hosting & Cloud Services**
  - Old websites you no longer maintain
  - Cloud server instances (AWS EC2, DigitalOcean droplets)
  - Static site hosting

- [ ] **App Store Hidden Subscriptions**
  - Canceled apps may still have active subscriptions
  - Check: Settings → Subscriptions (iOS) even for deleted apps
  - Uninstalling an app does NOT cancel subscription

- [ ] **Browser Extension Subscriptions**
  - Premium versions of extensions
  - VPN browser extensions
  - Productivity extensions

- [ ] **Patreon & Creator Subscriptions**
  - Easy to accumulate many small $5-10 pledges
  - Review: patreon.com/settings/memberships
  - Cancel creators you're no longer following

### Annual Subscription Strategy

- [ ] **Create Annual Renewal Calendar**
  - Many subscriptions bill annually and are easy to forget
  - Set reminders 30 days AND 7 days before renewal
  - Examples to track:
    - Amazon Prime (April)
    - Domain registrations (various)
    - Professional memberships
    - VPN services
    - Antivirus software
    - Cloud storage annual plans

- [ ] **Evaluate Annual vs Monthly**
  - Annual is usually 20-40% cheaper BUT requires upfront payment
  - Use annual for: Services you're confident you'll use all year
  - Use monthly for: Services you're unsure about or use seasonally
  - Can switch to annual after 3-6 months of consistent monthly use

---

## 🚧 **Common Issues & Solutions**

### Issue: Service makes cancellation extremely difficult (phone-only, wait times, retention pressure)
**Solution**:
1. Check if your state has laws requiring easy cancellation (California, New York have strong protections)
2. Try chat support instead of phone (often faster, get transcript)
3. Be firm: "I need to cancel. I'm not interested in retention offers."
4. If all else fails: Report to credit card as unwanted recurring charge, dispute
5. Document everything in case you need to escalate

### Issue: Canceled subscription but still getting charged
**Solution**:
1. Check confirmation email - did cancellation go through?
2. Check if you canceled before or after billing cycle start
3. Contact support with confirmation email as proof
4. Dispute charge with credit card if company is unresponsive
5. Block future charges via credit card's "merchant block" feature

### Issue: Want to cancel but will lose access to content/data
**Solution**:
1. Download data BEFORE canceling (most services have export feature)
2. Check if you retain access until end of paid period (most do)
3. Consider downgrading to free tier instead of full cancellation
4. Take screenshots of important content
5. Some services let you "reactivate" later without losing data

### Issue: Family member is using subscription I want to cancel
**Solution**:
1. Communicate before canceling (avoid family drama!)
2. Consider switching to family plan and sharing cost
3. Transfer ownership of subscription to family member
4. Find free alternative and help them transition

### Issue: Service only allows cancellation at specific times (gym contract, annual commitment)
**Solution**:
1. Read contract carefully for cancellation windows
2. Set calendar reminder for allowed cancellation period
3. Send cancellation request in writing (certified mail for gyms)
4. Some states allow cancellation for relocation or medical reasons
5. Check if contract has early termination fee (might be worth paying)

### Issue: Scared to cancel because "might need it later"
**Solution**:
1. Most services let you resubscribe anytime
2. Your data usually persists even after cancellation (goes to free tier)
3. Calculate: Cost of keeping subscription "just in case" vs resubscribing if needed
4. If genuinely worried: Pause instead of cancel (many services offer this)

---

## ✅ **Success Criteria**

- [ ] Comprehensive list of ALL subscriptions created (found via multiple discovery methods)
- [ ] Every subscription evaluated with keep/cancel/downgrade decision
- [ ] Unused subscriptions canceled (target: 30-50% reduction)
- [ ] Payment methods updated to align with domain strategy for kept subscriptions
- [ ] Email addresses updated to correct domains for kept subscriptions
- [ ] Confirmation emails received for all cancellations
- [ ] Tracking system established (spreadsheet, app, or calendar-based)
- [ ] Quarterly review process set up with calendar reminders
- [ ] Estimated monthly savings calculated (sum of canceled subscription costs)
- [ ] Virtual card system set up for future free trials (optional but recommended)

---

## 📁 **Project Files**

- `subscription-audit-master.csv` - Complete inventory of all subscriptions found
- `subscription-tracker-ongoing.csv` - Ongoing tracking system for kept subscriptions
- `cancellation-confirmations/` - Folder with screenshots/emails confirming cancellations
- `keep-cancel-decision-matrix.md` - Documentation of decision criteria and rationale
- `difficult-cancellations.txt` - List of services that made cancellation difficult (warn others)
- `annual-renewal-calendar.ics` - Calendar file with all annual renewal dates
- `subscription-savings-calculation.txt` - Total monthly/annual savings from cancellations
- `quarterly-review-checklist.md` - Template for recurring quarterly subscription audits

---

## 🔄 **Dependencies**

- **Prerequisite**: Access to all credit card and bank statements (6 months recommended)
- **Prerequisite**: Access to all email accounts (to search for subscription receipts)
- **Prerequisite**: Domain-specific payment methods identified (or use during this project)
- **Recommended Before**: Project 00 (Login Migration) - makes email updates easier
- **Recommended Before**: Project 04 (Financial Privacy) - payment method security
- **Blocks**: None - this is an independent audit project
- **Timeline**: Can start anytime, but ideally after email migration is complete

---

## ⚠️ **Critical Warnings**

1. **Uninstalling an app does NOT cancel the subscription** - must cancel explicitly in App Store/Google Play
2. **"Free trial" often requires credit card and auto-converts to paid** - set calendar reminder to cancel before trial ends
3. **Some services have early termination fees** (Adobe, gym contracts) - read terms before subscribing
4. **Canceling may result in immediate loss of access** - download data first, check if you retain access until end of billing cycle
5. **Family members may be using subscriptions you don't realize** - communicate before canceling
6. **Annual subscriptions often don't offer prorated refunds** - cancel but won't get money back for unused months
7. **Retention teams are trained to save subscriptions** - be firm, don't accept discount unless genuinely wanted
8. **Some services make it deliberately difficult to cancel** (dark patterns) - be persistent, document process
9. **Paused subscriptions still need monitoring** - they auto-resume after pause period
10. **Always keep confirmation email/screenshot of cancellation** - proof if you get charged later

---

## 📊 **Subscription Cost Analysis**

**Average Monthly Subscription Costs by Category:**
- Streaming (Video): $40-80 (Netflix + Hulu + Disney+ + HBO Max)
- Music: $10-15 (Spotify or Apple Music)
- Cloud Storage: $10-20 (iCloud/Google Drive/Dropbox)
- News: $10-30 (NYT, WSJ, etc.)
- Fitness: $30-50 (gym + fitness app)
- Gaming: $15-30 (Game Pass, PlayStation Plus)
- Software: $50-100 (Adobe, Microsoft 365, etc.)
- Food Delivery: $10-20 (DoorDash Pass, etc.)
- Professional: $30-60 (LinkedIn Premium, industry associations)

**Total Average: $200-400/month or $2,400-4,800/year**

**Goal: Reduce by 30-50% = $720-$2,400/year in savings**

---

## 🎯 **Quick Start**

Ready to audit your subscriptions? Follow this order:

1. **Discovery Day 1** (2 hours)
   - Pull 6 months of credit card statements
   - Check App Store / Google Play subscriptions
   - Search emails for "subscription" and "recurring"
   - Create master list of everything found

2. **Categorize Day 2** (1 hour)
   - Sort subscriptions into categories
   - Note: Cost, frequency, last use date, payment method

3. **Decision Day 3** (1-2 hours)
   - Evaluate each subscription with keep/cancel criteria
   - Mark decisions in spreadsheet
   - Identify easy wins (forgot about) vs. hard decisions

4. **Cancel Wave 1 Day 4** (1-2 hours)
   - Cancel all "definitely unused" subscriptions
   - Document confirmations
   - Calculate savings

5. **Update & Track Day 5** (1-2 hours)
   - Update payment methods for kept subscriptions
   - Update email addresses to correct domains
   - Set up tracking system and calendar reminders

**Estimated Time Breakdown:**
- Discovery and inventory: 2 hours
- Categorization and analysis: 1 hour
- Decision making: 1-2 hours
- Cancellation execution: 1-3 hours (depending on number and difficulty)
- Payment method updates: 1 hour
- Email address updates: 1 hour
- Tracking system setup: 30 minutes

**Total: 4-6 hours over 1 week**

**Expected Results:**
- 30-50% reduction in subscriptions
- $50-150/month in savings ($600-1,800/year)
- Cleaner digital footprint (fewer services with your data)
- Aligned payment methods with domain strategy

Remember: Subscriptions are designed to be "set and forget" - fight back with regular audits! 💰📊
