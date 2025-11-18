# Project 01: Legacy Gmail Cleanup & Deactivation

## 🎯 **Project Overview**
Safely migrate away from the entire Google ecosystem (Gmail, Drive, Photos, Calendar, etc.) and deactivate your old Google account (jackneedham9494@gmail.com) after securing all data and services.

## ⏱️ **Estimated Time**: 8-12 hours spread over 3-4 weeks
## 🚨 **Risk Level**: HIGH - Complete ecosystem migration, point of no return once account is deleted

## 🌐 **Scope Expansion**
This project is much larger than just Gmail - your Google account likely includes:
- Google Drive documents and shared files
- Google Photos with years of personal photos  
- YouTube subscriptions, playlists, and content
- Google Calendar events and shared calendars
- Google Contacts and sync services
- Chrome browser sync and bookmarks
- Google Pay payment methods and transaction history
- Third-party apps using "Sign in with Google"
- Potential business services (Analytics, Ads, Cloud Platform)

---

## 📋 **Project Checklist**

### Phase 0: Google Ecosystem Discovery (Week 1)
- [ ] **Run Google ecosystem assessment**
  - Execute: `google-ecosystem-assessment.sh`
  - Audit all Google services you're actually using
  - Identify critical data vs convenience features
  - Plan alternative services for each Google service

### Phase 1: Data Backup & Migration Setup (Week 1-2)
- [ ] **Download Google Takeout backup**
  - Go to: https://takeout.google.com
  - Select: Mail, Drive, Photos, Contacts, Calendar, Chrome, YouTube
  - WARNING: Can be 10-50GB+ and take 24-48 hours to prepare
  - Download and verify backup integrity
  - Store backup in encrypted location

- [ ] **Set up alternative services**
  - ProtonDrive account (Google Drive replacement)
  - ProtonCalendar setup (Google Calendar replacement) 
  - Choose photo storage solution (ProtonDrive or local backup)
  - Plan YouTube account migration (new account with personal domain)
  - Set up bookmark export strategy (Chrome → Firefox/Brave)

- [ ] **Document shared content**
  - List all Google Docs/Sheets shared with others
  - Note any collaborative projects or teams
  - Plan ownership transfer or alternative sharing methods
  - Screenshot important shared calendars

### Phase 2: Critical Data Migration (Week 2-3)
- [ ] **Migrate Google Drive content**
  - Download critical documents and upload to ProtonDrive
  - Transfer ownership of shared documents to others (if needed)
  - Export Google Docs/Sheets to standard formats (PDF, DOCX, XLSX)
  - Update any links or references to Google Drive files

- [ ] **Migrate Google Photos**
  - Download photo archives from Google Takeout
  - Organize and upload to new photo storage solution
  - Update any shared photo albums with family/friends
  - Cancel Google Photos backup on all devices

- [ ] **Migrate Google Calendar**
  - Export calendar events to ICS format
  - Import events to ProtonCalendar or alternative
  - Update shared calendar permissions
  - Notify contacts of calendar sharing changes

- [ ] **Migrate Google Contacts**
  - Export contacts to VCF format
  - Import to 1Password or ProtonContacts
  - Update contact sync settings on all devices
  - Remove Google account from contacts sync

### Phase 3: Browser & App Migration (Week 3)
- [ ] **Chrome browser migration**
  - Export bookmarks to HTML file
  - Import bookmarks to Firefox/Brave browsers
  - Disable Chrome sync completely
  - Clear all Chrome data and sign out

- [ ] **YouTube account migration (if needed)**
  - Create new YouTube account with personal domain email
  - Export subscription list and import to new account
  - Download any uploaded videos you want to keep
  - Update any YouTube-linked accounts or services

- [ ] **Google Pay cleanup**
  - Remove all saved payment methods
  - Cancel any Google Pay subscriptions
  - Update payment methods on apps using Google Pay
  - Download transaction history if needed

### Phase 4: Final Pre-Deletion Checks (Week 3-4)

**⚠️ PREREQUISITE: Project 00 must be 100% complete before this phase**

- [ ] **Verify Project 00 completion**
  - Confirm ALL accounts migrated to new email addresses
  - Confirm ALL OAuth apps migrated or disconnected
  - Confirm no critical services still use Gmail for login
  - Review Project 00 success criteria checklist

- [ ] **Final Gmail inbox scan**
  - Search for recent "login" or "security alert" emails
  - Check for recurring billing/subscription notifications
  - Look for password reset attempts (indicates missed accounts)
  - Screenshot any important confirmations or receipts

- [ ] **Set up temporary email forwarding (30-day safety net)**
  - Gmail Settings → Forwarding → Add personal domain email
  - Test forwarding with a test email
  - Set up filters to tag forwarded emails "FROM-OLD-GMAIL"
  - Document start date for 30-day countdown

- [ ] **Clear browser stored data**
  - Clear all saved passwords for jackneedham9494@gmail.com
  - Remove autofill data and stored payment methods
  - Sign out of all Google services across all browsers
  - Clear Google cookies and cache

### Phase 5: Monitor Forwarding Period (Week 4-8)

- [ ] **Daily forwarding monitoring (Week 1)**
  - Check for forwarded emails indicating missed accounts
  - Create log of services still emailing old address
  - Update those accounts to new email immediately

- [ ] **Weekly forwarding monitoring (Week 2-4)**
  - Review forwarded email log for patterns
  - Identify and update any remaining stragglers
  - Note any accounts that are impossible to update

- [ ] **Final forwarding review (Day 30)**
  - Review complete log of forwarded emails
  - Verify all updateable accounts have been updated
  - Make final decision on keeping forwarding longer (if needed)

### Phase 6: Account Deletion (After 30+ days forwarding)

**⚠️ CRITICAL: This is irreversible - triple check everything**

- [ ] **Pre-deletion verification checklist**
  - [ ] Project 00 is 100% complete
  - [ ] All Google Takeout backups are verified and accessible
  - [ ] All Drive/Photos/Calendar data migrated successfully
  - [ ] 30+ days of forwarding showed no critical missed accounts
  - [ ] All OAuth apps disconnected or migrated
  - [ ] No services still use Gmail for login or recovery
  - [ ] All important emails archived/backed up

- [ ] **Disable email forwarding**
  - Turn off Gmail forwarding
  - Verify forwarding is disabled with test email

- [ ] **Final Gmail account cleanup**
  - Delete all emails and folders
  - Remove all labels and filters
  - Clear spam and trash folders
  - Remove all contacts
  - Delete all Drive files

- [ ] **Delete Google account**
  - Go to: https://myaccount.google.com/deleteaccount
  - Review Google's deletion warnings
  - Download final account data summary
  - Confirm deletion
  - **⚠️ POINT OF NO RETURN - Account deleted permanently**

- [ ] **Post-deletion verification**
  - Verify you cannot log in to Gmail
  - Check that Google account is truly deleted
  - Document deletion date in password manager
  - Update any documentation referencing old Gmail

---

## 🚧 **Potential Issues & Solutions**

### Issue: Services still sending emails to old address
**Solution**: Keep a log of forwarded emails for 60 days, update each service individually

### Issue: Lost access to accounts that require Gmail for recovery
**Solution**: Update recovery methods BEFORE deletion, document all changes

### Issue: Google Drive files shared with others
**Solution**: Transfer ownership of shared files to new Google account (if needed)

---

## ✅ **Success Criteria**
- [ ] All personal data backed up and verified
- [ ] Zero third-party apps connected to Gmail account
- [ ] All critical accounts updated with new recovery emails
- [ ] Gmail account successfully deleted
- [ ] No disruption to current services or workflows

---

## 📁 **Project Files**
- `gmail-backup-checklist.md` - Detailed backup verification
- `forwarded-emails-log.md` - Track emails during transition
- `recovery-methods-updated.md` - Log of account recovery updates

---

## 🔄 **Dependencies**
- **Prerequisite**: All accounts must be migrated to new email system
- **Blocks**: None (this is a standalone cleanup project)
- **Timeline**: Start 30 days after account migration completion