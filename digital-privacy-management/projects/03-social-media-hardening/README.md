# Project 03: Social Media Privacy Hardening

## 🎯 **Project Overview**

Systematically audit and lock down privacy settings across ALL social media platforms (Twitter, Instagram, Facebook, Reddit, LinkedIn, Discord, YouTube). Remove unnecessary permissions, connected apps, and old posts that leak personal information. Configure appropriate visibility settings for each platform based on its purpose.

## ⏱️ **Estimated Time**: 6-8 hours over 1-2 weeks

## 🚨 **Risk Level**: MEDIUM - Requires careful review to avoid accidentally making profiles too private or deleting important content

---

## ❗ **Why This Project Matters**

Social media platforms are **major privacy risks** that collect extensive data about your behavior, connections, location, and interests. Most accounts have:
- Overly permissive default privacy settings
- Years of old posts with personal information
- Dozens of connected third-party apps with broad permissions
- Location data embedded in photos and check-ins
- Email addresses and phone numbers exposed to advertisers

This project systematically hardens each platform to minimize data exposure while maintaining the social functionality you actually need.

---

## 📋 **Project Checklist**

### Phase 0: Preparation & Inventory (Day 1)

- [ ] **Inventory all social media accounts**
  - Document all platforms you use (active and dormant)
  - Note which email addresses are currently used for each
  - Determine which domain each should migrate to
  - Identify accounts to delete entirely

- [ ] **Create audit tracking spreadsheet**
  - Columns: Platform, Username, Current Email, Target Domain, Privacy Settings Status, Connected Apps Removed, Old Posts Cleaned, Date Completed
  - Use `social-media-audit.csv` template
  - Track progress for each account

- [ ] **Backup important content before changes**
  - Download photo archives from Instagram, Facebook
  - Export important tweets or Reddit posts
  - Save Discord server lists and important DMs
  - Document important connections/followers you want to keep

### Phase 1: Twitter/X Hardening (2-3 hours)

- [ ] **Account & Email Migration**
  - Settings → Your Account → Account Information → Email
  - Update to personal domain email
  - Verify new email address
  - Remove old Gmail from account

- [ ] **Privacy Settings Audit**
  - Settings → Privacy and Safety → Audience and tagging
    - Photo tagging: OFF or "Only people you follow"
    - Location information: Remove from all tweets, disable for future
  - Settings → Privacy and Safety → Direct Messages
    - Allow message requests from: Only people you follow
    - Read receipts: OFF
    - Filter low-quality messages: ON
  - Settings → Privacy and Safety → Discoverability
    - Let others find you by email: OFF
    - Let others find you by phone number: OFF

- [ ] **Connected Apps & Permissions**
  - Settings → Security and Account Access → Apps and Sessions
  - Review ALL connected apps: https://twitter.com/settings/connected_apps
  - Revoke access to any apps you don't actively use
  - Common culprits: old social media schedulers, analytics tools, games
  - Document which apps you're keeping and why

- [ ] **Content Audit & Cleanup**
  - Search your tweets for personal info: "@your_username phone", "@your_username email", "@your_username address"
  - Delete tweets with location data
  - Review and delete tweets from more than 2-3 years ago (consider using TweetDelete tool)
  - Remove any tweets with embarrassing or compromising information

- [ ] **Advanced Privacy Settings**
  - Settings → Privacy and Safety → Data sharing and off-Twitter activity
    - Disable "Allow additional information sharing with business partners"
    - Disable "Personalize based on your inferred identity"
  - Settings → Privacy and Safety → Ads preferences
    - Disable all personalized ads
    - Disable all interest categories
  - Settings → Security → Two-factor authentication
    - Enable 2FA using 1Password (authenticator app, NOT SMS)
    - Store backup codes in 1Password

### Phase 2: Instagram Hardening (1-2 hours)

**Primary Account: jack_meme_only**

- [ ] **Account Settings**
  - Settings → Account Center → Personal Details → Email
  - Update to personal domain email
  - Verify email address
  - Remove old Gmail

- [ ] **Privacy Settings**
  - Settings → Privacy → Account Privacy: PRIVATE (recommended)
  - Settings → Privacy → Activity Status: OFF
  - Settings → Privacy → Story Sharing: OFF
  - Settings → Privacy → Comments: Choose "From People You Follow" or manual approval
  - Settings → Privacy → Tags: Manual approval required
  - Settings → Privacy → Mentions: "Only People You Follow"

- [ ] **Connected Apps & Services**
  - Settings → Security → Apps and Websites
  - Remove ALL third-party apps you don't actively use
  - Check for old apps: social media schedulers, analytics, shopping integrations

- [ ] **Location & Photo Metadata**
  - Settings → Privacy → Location Services: OFF
  - Review old posts and remove location tags
  - Download Instagram data to check EXIF data: Settings → Privacy → Download Your Information
  - Consider using EXIF removal tool before future uploads

- [ ] **Content Audit**
  - Review follower list, remove unknown or suspicious accounts
  - Review posts from years ago, delete any with:
    - Full name or personal details
    - Home address or identifiable locations
    - Phone numbers or email addresses
    - Embarrassing or compromising content

- [ ] **Ads & Data Settings**
  - Settings → Ads → Ad Topics: Hide all sensitive categories
  - Settings → Ads → Data About Your Activity From Partners: OFF

**Secondary Account: jack_needs_ham**

- [ ] **Evaluate account necessity**
  - Determine if this account serves any current purpose
  - If not needed: Download data, then delete account permanently
  - If keeping: Apply all same privacy settings as primary account

### Phase 3: Facebook Hardening (2-3 hours)

- [ ] **Account & Contact Information**
  - Settings → Personal Information → Contact Info
  - Update email to personal domain
  - Remove or hide phone number (set to "Only Me")
  - Review all personal information fields, set to "Only Me" or "Friends"

- [ ] **Privacy Settings Overhaul**
  - Settings → Privacy → Who can see your future posts: Friends (NOT Public)
  - Settings → Privacy → Limit Past Posts: Apply to all old public posts
  - Settings → Privacy → Who can look you up using email: Friends or Only Me
  - Settings → Privacy → Who can look you up using phone: Friends or Only Me
  - Settings → Privacy → Do you want search engines outside of Facebook to link to your profile: NO
  - Settings → Privacy → Who can send you friend requests: Friends of Friends (not Everyone)

- [ ] **Timeline & Tagging Settings**
  - Settings → Profile and Tagging → Who can post on your timeline: Only Me or Friends
  - Settings → Profile and Tagging → Review posts you're tagged in: ON (manual approval)
  - Settings → Profile and Tagging → Review tags people add: ON (manual approval)
  - Review old tagged photos and remove tags from sensitive content

- [ ] **Apps & Websites Audit**
  - Settings → Apps and Websites: https://www.facebook.com/settings?tab=applications
  - Remove ALL apps and games you don't actively use
  - For apps you keep: Click "View and Edit" and minimize permissions
  - Common culpratives: old games, quiz apps, dating apps, shopping integrations
  - Check "Expired" and "Removed" sections to see past data sharing

- [ ] **Location Services**
  - Settings → Location → Location History: OFF
  - Review and delete location history if it exists
  - Settings → Ads → Location Services: OFF

- [ ] **Ads & Data Settings**
  - Settings → Ads → Ad Settings
    - Ad topics: Hide all sensitive categories
    - Advertisers with your contact info: Review and remove
    - Your activity off Facebook: Clear history and turn OFF
  - Settings → Ads → Ad preferences based on data from partners: OFF

- [ ] **Content Audit**
  - Use Facebook's "View As" tool to see what others see
  - Review posts from multiple years ago
  - Delete or restrict visibility on posts with personal information
  - Consider using Facebook's "Manage Activity" bulk deletion tools

- [ ] **Security Settings**
  - Settings → Security → Two-factor authentication
  - Enable 2FA using 1Password (authenticator app, NOT SMS)
  - Store backup codes in 1Password
  - Settings → Security → Get alerts about unrecognized logins: ON

### Phase 4: Reddit Hardening (1-2 hours)

**Main Account: TheBearWithWings**

- [ ] **Account Settings**
  - User Settings → Account → Email
  - Update to personal domain email
  - Verify new email
  - User Settings → Account → Phone number: REMOVE

- [ ] **Privacy Settings**
  - User Settings → Privacy → Personalization Options
    - Personalize recommendations based on your activity: OFF
    - Personalize ads based on your activity: OFF
    - Personalize ads based on information from partners: OFF
  - User Settings → Privacy → Advanced Privacy Settings
    - Show profile in search results: OFF
    - Allow search engines to index profile: OFF
    - Allow chat requests: Only from trusted users or OFF

- [ ] **Profile Visibility**
  - User Settings → Profile → Show active communities: OFF
  - User Settings → Profile → Content visibility: Hide NSFW content from profile
  - User Settings → Safety → Block new users from messaging you: ON (optional)

- [ ] **Comment History Audit**
  - Review comment history for personal information leaks
  - Delete comments containing:
    - Real name, age, location details
    - Workplace information
    - Family member names
    - Financial details
    - Anything that could identify you
  - Consider using PowerDeleteSuite or Redact to bulk-delete old comments
  - Remember: Reddit comments are often archived, so deletion isn't perfect

- [ ] **Security Settings**
  - User Settings → Safety & Privacy → Two-Factor Authentication
  - Enable 2FA using 1Password authenticator
  - Store backup codes in 1Password

**NSFW Account: not_my_account_nsfw**

- [ ] **Account Deletion Recommended**
  - Maintaining separate identity is HIGH RISK for privacy
  - Download any saved posts you want to keep
  - User Settings → Account → Deactivate Account
  - Confirm deletion and remove from 1Password
  - Consider using main account with throwaway alts for sensitive topics instead

### Phase 5: LinkedIn Hardening (1-2 hours)

- [ ] **Account Settings**
  - Settings → Account Preferences → Email Addresses
  - Update to professional domain email
  - Verify new email
  - Remove old Gmail

- [ ] **Privacy Settings**
  - Settings → Visibility → Profile visibility to search engines: OFF (unless you need it for job searching)
  - Settings → Visibility → Edit your public profile
    - Minimize information shown publicly (only name and headline)
    - Remove public access to connections, experience details
  - Settings → Visibility → Who can see your email: Only You
  - Settings → Visibility → Who can see your connections: Only You or Connections
  - Settings → Visibility → Profile viewing options: Private mode (they won't see you viewed them)

- [ ] **Communications Settings**
  - Settings → Communications → Who can reach you
    - Invitations: Only people who know your email or appear in your imported contacts
    - Messages: Connections only or Connections + InMail
  - Settings → Communications → Messaging experience
    - Read receipts: OFF

- [ ] **Data Privacy**
  - Settings → Data Privacy → How LinkedIn uses your data
    - Connections and search data for profile recommendations: OFF
    - Job seeking preferences: Review and minimize sharing
  - Settings → Data Privacy → Other applications
    - Review and remove connected apps
  - Settings → Data Privacy → Advertising data
    - Disable ad personalization based on profile data
    - Opt out of ads based on activity on LinkedIn network sites

- [ ] **Activity Broadcasts**
  - Settings → Visibility → Share profile updates with your network: OFF
  - This prevents followers from seeing every profile edit, job change, etc.

- [ ] **Content Review**
  - Review old posts for overly personal information
  - Download your LinkedIn data archive (takes 24 hours): Settings → Data Privacy → Get a copy of your data
  - Clean up recommendations you've given if they contain sensitive info

- [ ] **Security Settings**
  - Settings → Account Access → Two-step verification
  - Enable 2FA using 1Password authenticator
  - Store backup codes in 1Password

### Phase 6: Discord Hardening (1 hour)

**Account: BearWithWings**

- [ ] **Account Settings**
  - User Settings → My Account → Email
  - Update to personal domain email
  - Verify new email

- [ ] **Privacy Settings**
  - User Settings → Privacy & Safety
    - Safe Direct Messaging: Scan DMs from non-friends
    - Allow direct messages from server members: OFF (or limit to friends)
    - Use data to improve Discord: OFF
    - Use data to customize my Discord experience: OFF
  - User Settings → Privacy & Safety → Friend Requests
    - Enable from: Server members only OR None
    - Remove "Everyone" option

- [ ] **Contact Sync & Discoverability**
  - User Settings → Privacy & Safety → How We Use Your Data
    - Phone number and email discoverability: OFF
    - Sync contacts: OFF (never enable this)

- [ ] **Server Audit**
  - Review all Discord servers you're a member of
  - Leave servers you no longer actively participate in
  - For remaining servers:
    - Review privacy settings per-server
    - Limit DM permissions from server members
    - Be aware of which servers can see your online status

- [ ] **Direct Message Cleanup**
  - Review DM history for sensitive information
  - Delete messages containing personal details
  - Be aware: recipients still have copies even after you delete

- [ ] **Security Settings**
  - User Settings → My Account → Two-Factor Authentication
  - Enable 2FA using 1Password authenticator (NOT SMS)
  - Store backup codes in 1Password
  - User Settings → Authorized Apps: Review and remove old OAuth apps

### Phase 7: YouTube Hardening (1 hour)

- [ ] **Account & Email**
  - Google Account settings → Personal Info → Email
  - Update to personal domain email (if not tied to work account)
  - Note: YouTube is tied to Google Account, so changes affect all Google services

- [ ] **Privacy Settings**
  - YouTube Settings → Privacy
    - Keep all my subscriptions private: ON
    - Keep all my saved playlists private: ON
    - Pause watch history: Consider enabling for max privacy
    - Pause search history: Consider enabling for max privacy
  - YouTube Settings → Subscriptions → Manage
    - Review subscriptions, unsubscribe from channels you don't actively watch

- [ ] **Activity Controls**
  - Google Account → Data & Privacy → History Settings
    - YouTube History: Pause or Auto-delete every 3 months
    - YouTube Search History: Pause or Auto-delete
  - Google Account → Data & Privacy → Activity Controls
    - Web & App Activity: Pause or Auto-delete
    - Location History: Pause (unless you need it)

- [ ] **Ad Settings**
  - Google Account → Data & Privacy → Personalized Ads
    - Turn OFF ad personalization
    - Manage ad settings and remove all interests

- [ ] **Connected Apps**
  - Google Account → Security → Third-party apps with account access
  - https://myaccount.google.com/permissions
  - Remove all third-party apps connected to YouTube/Google
  - Only keep essential apps you actively use

- [ ] **Content Review**
  - Review uploaded videos for personal information
  - Review comments for personal details
  - Set old videos to Private or Unlisted as needed

### Phase 8: Additional Platforms (As Applicable)

**TikTok** (if applicable)
- [ ] Settings → Privacy → Account Privacy: Private
- [ ] Settings → Privacy → Suggest your account to others: OFF
- [ ] Remove email/phone from profile
- [ ] Disable all data sharing options
- [ ] Review and delete old videos with personal info

**Snapchat** (if applicable)
- [ ] Settings → Mobile Number: Remove
- [ ] Settings → Email: Update to personal domain
- [ ] Settings → See Me in Quick Add: OFF
- [ ] Settings → Location: Ghost Mode (always)
- [ ] Review Snap Map history and delete

**Pinterest** (if applicable)
- [ ] Settings → Account Management → Email: Update
- [ ] Settings → Privacy and Data → Search Privacy: Hide profile
- [ ] Settings → Privacy and Data → Private Profile: ON
- [ ] Remove connected apps and integrations

---

## 🔍 **Universal Privacy Best Practices**

Apply these to ALL platforms:

### Email & Contact Information
- [ ] Update to appropriate domain email (Personal/Professional)
- [ ] Remove or hide phone numbers
- [ ] Remove recovery emails that use old Gmail
- [ ] Verify all email changes with confirmation links

### Two-Factor Authentication
- [ ] Enable 2FA on ALL accounts using 1Password authenticator
- [ ] AVOID SMS-based 2FA when possible (SIM swap attacks)
- [ ] Store all backup codes in 1Password
- [ ] Test 2FA codes work before closing settings

### Third-Party App Permissions
- [ ] Review ALL connected apps and OAuth integrations
- [ ] Remove apps you haven't used in 6+ months
- [ ] For apps you keep: minimize permissions (don't give "full account access")
- [ ] Set calendar reminders to review permissions quarterly

### Location Data
- [ ] Disable location services for all social media apps
- [ ] Remove historical location data and check-ins
- [ ] Strip EXIF metadata from photos before uploading
- [ ] Never use "check-in" features

### Old Content Cleanup
- [ ] Review posts from 2+ years ago
- [ ] Delete posts with personal information (name, address, phone, email, workplace)
- [ ] Delete posts with identifiable locations (home, school, work)
- [ ] Delete embarrassing or compromising content
- [ ] Consider using bulk deletion tools (carefully!)

### Visibility & Discoverability
- [ ] Prevent search engines from indexing your profile
- [ ] Disable "find by email" and "find by phone"
- [ ] Set default post visibility to Friends/Followers only (not Public)
- [ ] Review what's visible to non-friends using platform's "View As" tools

### Advertising & Data Sharing
- [ ] Disable all ad personalization
- [ ] Opt out of data sharing with third-party partners
- [ ] Remove all advertiser targeting categories
- [ ] Clear off-platform activity tracking

---

## 🚧 **Common Issues & Solutions**

### Issue: Platform won't let me change email address
**Solution**:
1. Check if email is still unverified - verify it first
2. Try from desktop browser instead of mobile app
3. Some platforms require you to add new email first, then remove old one
4. Contact support if absolutely stuck

### Issue: Can't remember which apps I've connected to each platform
**Solution**: Every major platform has a "Connected Apps" or "Apps and Websites" section in settings. Go through each platform methodically.

### Issue: Worried about deleting old posts I might want later
**Solution**:
1. Download your data archive from each platform FIRST
2. Store archives in encrypted backup (not cloud)
3. Then proceed with deletion
4. Most platforms keep data for 30-90 days, so you can recover if needed

### Issue: Platform keeps re-enabling privacy-invasive settings after updates
**Solution**:
1. Document your privacy settings with screenshots
2. Set quarterly calendar reminder to re-check settings
3. Use browser extensions like Privacy Badger to block trackers
4. Consider moving to more privacy-respecting platforms

### Issue: Bulk deletion tools are deleting TOO much
**Solution**:
1. Test with small batches first (10-20 posts)
2. Download full data archive before any bulk deletion
3. Use platform's native tools when available (safer)
4. For Reddit: use tools that overwrite then delete (helps with archives)

### Issue: 2FA codes not working after email change
**Solution**:
1. Make sure you're using TIME-BASED codes (TOTP), not email codes
2. Check that your device time is accurate (TOTP requires correct time)
3. Use backup codes stored in 1Password if codes fail
4. Contact support if completely locked out

---

## ✅ **Success Criteria**

- [ ] ALL social media accounts updated to appropriate domain emails
- [ ] 2FA enabled using 1Password authenticator (not SMS) on all accounts
- [ ] Privacy settings set to maximum on all platforms
- [ ] All unused third-party apps disconnected (aim for 80%+ reduction)
- [ ] Old posts with personal information deleted or restricted
- [ ] Location services disabled and historical location data removed
- [ ] Ad personalization and data sharing disabled everywhere
- [ ] Search engine indexing disabled on personal profiles
- [ ] Quarterly privacy audit calendar reminder set
- [ ] All changes documented in social-media-audit.csv tracking spreadsheet

---

## 📁 **Project Files**

- `social-media-audit.csv` - Master tracking spreadsheet for all platforms
- `connected-apps-removed.txt` - List of third-party apps removed from each platform
- `account-data-backups/` - Folder containing downloaded data archives from each platform
- `privacy-settings-screenshots/` - Screenshots of privacy settings before/after
- `old-posts-archive.txt` - Notes on what content was deleted and why
- `quarterly-audit-checklist.md` - Checklist for recurring privacy audits

---

## 🔄 **Dependencies**

- **Prerequisite**: New email domains must be active and receiving mail (Personal, Professional)
- **Prerequisite**: 1Password must be configured with authenticator support
- **Recommended Before**: Project 00 (Login Migration) - easier to do email updates after main migration
- **Blocks**: None - this is an independent hardening project
- **Timeline**: Can start anytime, but ideally after email migration is complete

---

## ⚠️ **Critical Warnings**

1. **Download data archives BEFORE bulk deletions** - you can't undo permanent deletion
2. **Test 2FA codes BEFORE logging out** - don't lock yourself out
3. **Verify email changes work** - check confirmation emails arrive at new address
4. **Be careful with "Delete All" tools** - they can't distinguish important from unimportant content
5. **Some platforms archive your data** - deletion doesn't mean it's truly gone forever (Reddit, Twitter/X)
6. **Deactivation ≠ Deletion** - many platforms have separate "deactivate" (reversible) vs "delete" (permanent) options

---

## 📊 **Platform Priority Guide**

**High Priority (Do First):**
- Facebook (highest data collection, most privacy invasive)
- LinkedIn (contains professional identity, needs careful handling)
- Instagram (extensive third-party app ecosystem)

**Medium Priority (Do Next):**
- Twitter/X (public nature makes it high risk)
- Reddit (comment history can leak identity)
- YouTube/Google (tied to Google ecosystem)

**Lower Priority (Do Last):**
- Discord (smaller attack surface if you're not in public servers)
- TikTok, Snapchat, Pinterest (if applicable)

---

## 🎯 **Quick Start**

Ready to begin? Follow these steps:

1. **Create tracking spreadsheet** - Use `social-media-audit.csv` template
2. **Start with Facebook** - It's the most privacy-invasive, start there
3. **Download data archives** - Before making any changes, download backups
4. **Work platform by platform** - Don't rush, be thorough
5. **Test as you go** - Log out and log back in to verify changes work

**Estimated Time Breakdown:**
- Facebook: 2-3 hours (most complex)
- Instagram: 1-2 hours
- Twitter/X: 2-3 hours (if you have years of tweets)
- LinkedIn: 1-2 hours
- Reddit: 1-2 hours (depends on comment history)
- Discord: 1 hour
- YouTube: 1 hour

**Total: 6-8 hours over 1-2 weeks** (with breaks)

Remember: This is tedious but CRITICAL work for your privacy. Take your time, stay organized, and verify everything! 🔒
