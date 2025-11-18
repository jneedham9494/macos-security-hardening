# Project 07: Phone Migration with Privacy Focus

## 🎯 **Project Overview**

Set up your new phone with maximum privacy, using compartmentalized apps that align with your email domain strategy.

## ⏱️ **Estimated Time**: 4-6 hours over 2-3 days

## 🚨 **Risk Level**: MEDIUM - Critical for maintaining security compartmentalization

---

## 📋 **Pre-Migration Preparation**

### Phase 1: Documentation & Backup

- [ ] **Document current phone setup**
  - Screenshot all app arrangements and folders
  - List critical apps and their login methods
  - Note custom settings and configurations
  - Document which apps use which email addresses

- [ ] **Backup critical data**
  - Export contacts to 1Password (avoid cloud sync)
  - Save important photos to encrypted storage
  - Backup important messages/conversations
  - Document all 2FA backup codes and recovery methods

- [ ] **Prepare 1Password access**
  - Ensure 1Password desktop app has all current passwords
  - Verify access to all domain vaults
  - Test password sharing between devices
  - Document emergency access procedures

---

## 📱 **New Phone Setup Strategy**

### Phase 2: Foundation Apps (Install First)

**Security Infrastructure (Priority 1)**
- [ ] **1Password app**
  - Install and configure BEFORE any other apps
  - Verify access to all vaults (Personal, Financial, High-Security, Travel)
  - Test autofill functionality
  - Set up Face ID/Touch ID

- [ ] **ProtonMail app**
  - Configure personal domain email
  - Configure high-security domain email  
  - Configure travel domain email
  - Test email access and notifications

- [ ] **Privacy browsers**
  - Brave Browser (primary private browser)
  - DuckDuckGo Browser (backup private browser)
  - Standard Safari (for financial domain only)

### Phase 3: Domain-Specific App Installation

**Personal Domain Apps (Firefox/Personal Email)**
- [ ] **Social & Entertainment**
  - Reddit app (TheBearWithWings account)
  - Discord app (personal domain email)
  - Spotify/Music apps
  - YouTube (personal account only)

- [ ] **Gaming & Entertainment**
  - Steam Mobile app
  - Game-specific apps (minimal permissions)
  - Streaming apps (Netflix, etc.)

**Financial Domain Apps (Safari/Financial Email)**
- [ ] **Banking & Investment**
  - Primary bank app
  - Credit card apps
  - Investment portfolio apps (Fidelity, etc.)
  - Credit monitoring apps

- [ ] **Cryptocurrency**
  - Coinbase app (strict security settings)
  - Kraken app (if actively trading)
  - Hardware wallet apps (Ledger, etc.)

**Travel Domain Apps (Brave/Travel Email)**
- [ ] **Airlines**
  - EasyJet app
  - British Airways app  
  - United Airlines app

- [ ] **Accommodation & Transport**
  - Airbnb app
  - Marriott Bonvoy app
  - Uber app
  - Local transport apps

**High-Security Domain Apps (Brave/High-Security Email)**
- [ ] **Work & Professional**
  - Work-related apps (Ripple/Okta)
  - Professional development apps
  - Government service apps
  - Secure communication apps (Signal)

---

## 🔒 **App Permission Hardening**

### For EVERY App Installation

- [ ] **Location permissions**
  - Default: "Ask Next Time" or "Never"
  - Only "While Using App" for essential travel apps
  - Never allow "Always" location access

- [ ] **Camera & Microphone**
  - Only allow for communication apps
  - Deny for social media and shopping apps
  - Review and audit regularly

- [ ] **Contacts & Photos**
  - Deny for most apps unless absolutely necessary
  - Use "Select Photos" instead of "All Photos"
  - Never allow contact access for games/entertainment

- [ ] **Notifications**
  - Disable for non-critical apps
  - Use "Deliver Quietly" for promotional content
  - Only allow badges for security-critical services

---

## 🛡️ **iOS/Android Privacy Settings**

### System-Level Privacy Configuration

- [ ] **iOS Privacy Settings**
  - Settings → Privacy & Security → Analytics: OFF
  - Settings → Privacy & Security → Apple Advertising: OFF
  - Settings → Privacy & Security → Tracking: Ask App Not to Track
  - Siri: Disable or limit data sharing
  - Face ID/Touch ID: Enable for 1Password and banking only

- [ ] **Network Privacy**
  - Wi-Fi → Use random MAC addresses: ON
  - Cellular → Limit Ad Tracking: ON
  - Consider VPN setup for public Wi-Fi

- [ ] **iCloud Settings (if using)**
  - Minimize synced data
  - Disable iCloud Analytics
  - Use encrypted backups only
  - Consider ProtonDrive as alternative

---

## 🔍 **Post-Migration Verification**

### Phase 4: Testing & Validation

- [ ] **Test critical functions**
  - 1Password access to all vaults
  - Email access in all domains
  - 2FA codes working for critical accounts
  - Banking app functionality

- [ ] **Security verification**
  - All apps using correct domain email addresses
  - No old email remnants in app settings
  - Backup codes safely stored in 1Password
  - Emergency access methods documented

- [ ] **Privacy audit**
  - Review all app permissions one final time
  - Test that tracking is minimized
  - Verify no unnecessary data sharing
  - Confirm backup and sync settings align with privacy goals

---

## ✅ **Success Criteria**

- [ ] All critical apps installed with correct domain emails
- [ ] App permissions minimized across all installations
- [ ] 1Password working seamlessly with all apps
- [ ] Domain compartmentalization maintained on mobile
- [ ] No privacy leaks or cross-domain contamination
- [ ] Emergency access and backup procedures documented

---

## 📁 **Project Files**

- `app-installation-checklist.csv` - Track app installation and permissions
- `domain-app-mapping.md` - Which apps use which email domains
- `privacy-settings-backup.md` - Document all privacy configurations

---

## 🔄 **Dependencies**

- **Prerequisite**: All email domains must be fully configured
- **Prerequisite**: 1Password must have all current passwords
- **Blocks**: Projects 1-6 (foundation must be solid first)
- **Timeline**: Start only after completing email migration and cleanup