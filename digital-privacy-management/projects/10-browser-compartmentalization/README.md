# Project 10: Advanced Browser Compartmentalization

## 🎯 **Project Overview**

Implement advanced browser compartmentalization using Firefox Multi-Account Containers and separate browser profiles to enforce strict domain isolation. This ensures that Personal, Financial, Professional, Travel, and High-Security domains never cross-contaminate through cookies, sessions, or tracking.

## ⏱️ **Estimated Time**: 3-4 hours

## 🚨 **Risk Level**: LOW - Configuration-focused, easily reversible

---

## ❗ **Why Compartmentalization Matters**

Even with separate email addresses and passwords, browsers can leak information across domains through:
- **Cookies and tracking pixels** that follow you across sites
- **Browser fingerprinting** that links your activities
- **Session tokens** that persist across different purposes
- **Autofill** that suggests information from other contexts
- **Browsing history** that mixes personal and professional activity

**Solution**: Use browser-level compartmentalization to create physical separation between domains.

---

## 📋 **Project Checklist**

### Phase 0: Choose Your Compartmentalization Strategy (Day 1)

**Strategy A: Firefox Multi-Account Containers (Recommended)**
- ✅ One browser, multiple isolated environments
- ✅ Visual color coding per domain
- ✅ Automatic site-to-container assignment
- ✅ Easy to switch between contexts
- ❌ Only works in Firefox

**Strategy B: Separate Browser Profiles**
- ✅ Works in any browser (Chrome, Firefox, Edge, Brave)
- ✅ Complete isolation (extensions, settings, everything)
- ❌ Requires switching profiles/windows
- ❌ More memory intensive

**Strategy C: Different Browsers per Domain (Most Secure)**
- ✅ Maximum isolation
- ✅ Visual distinction (different app icons)
- ❌ Most memory intensive
- ❌ Harder to maintain consistent settings

**Recommended: Strategy A (Firefox Containers) + Strategy C hybrid**
- Safari: Financial domain only
- Firefox with Containers: Personal, Professional, Travel, High-Security
- Brave: Backup for Travel/High-Security with Tor

---

### Phase 1: Firefox Multi-Account Containers Setup (Day 1)

- [ ] **Install Firefox** (if not already installed)
  - Download from: mozilla.org/firefox
  - Set as default browser (optional)

- [ ] **Install Multi-Account Containers extension**
  - Go to: addons.mozilla.org/firefox/addon/multi-account-containers
  - Click "Add to Firefox"
  - Grant necessary permissions

- [ ] **Create domain-specific containers**

  **Personal/Social Container** (Blue)
  - Open Containers menu → Manage Containers → Add New Container
  - Name: "Personal"
  - Color: Blue
  - Icon: Circle
  - Use for: Social media, entertainment, personal shopping

  **Financial Container** (Red)
  - Name: "Financial"
  - Color: Red
  - Icon: Dollar sign
  - Use for: Banking, investments, crypto

  **Professional Container** (Green)
  - Name: "Professional"
  - Color: Green
  - Icon: Briefcase
  - Use for: LinkedIn, work tools, professional email

  **Travel Container** (Yellow)
  - Name: "Travel"
  - Color: Yellow
  - Icon: Suitcase
  - Use for: Airlines, hotels, temporary services

  **High-Security Container** (Purple)
  - Name: "High-Security"
  - Color: Purple
  - Icon: Lock
  - Use for: Secure communications, sensitive accounts

- [ ] **Configure container settings**
  - Containers menu → Settings
  - ✅ Enable "Show container tabs"
  - ✅ Enable "Limit to designated sites" (prevents accidental mixing)
  - ✅ Disable "Use container for all windows"

### Phase 2: Assign Sites to Containers (Day 1-2)

- [ ] **Personal Container Sites**
  - twitter.com → Always open in Personal
  - instagram.com → Always open in Personal
  - reddit.com → Always open in Personal
  - facebook.com → Always open in Personal
  - netflix.com → Always open in Personal
  - spotify.com → Always open in Personal
  - amazon.com (personal) → Always open in Personal
  - discord.com → Always open in Personal

- [ ] **Financial Container Sites**
  - All banking URLs (chase.com, bankofamerica.com, etc.)
  - Investment platforms (fidelity.com, vanguard.com, etc.)
  - Crypto exchanges (coinbase.com, kraken.com, etc.)
  - paypal.com → Always open in Financial
  - Credit card sites
  - insurance provider sites

- [ ] **Professional Container Sites**
  - linkedin.com → Always open in Professional
  - Your work email domain
  - Professional development sites
  - Work-related SaaS tools
  - github.com (work projects) → Professional

- [ ] **Travel Container Sites**
  - easyjet.com → Always open in Travel
  - ba.com (British Airways) → Always open in Travel
  - united.com → Always open in Travel
  - airbnb.com → Always open in Travel
  - marriott.com → Always open in Travel
  - uber.com → Always open in Travel
  - booking.com → Always open in Travel

- [ ] **High-Security Container Sites**
  - protonmail.com → Always open in High-Security
  - tutanota.com → Always open in High-Security
  - signal.org → Always open in High-Security
  - Hardware wallet interfaces
  - VPN provider sites

### Phase 3: Configure Container-Specific Settings (Day 2)

- [ ] **Install Temporary Containers extension** (optional but powerful)
  - addons.mozilla.org/firefox/addon/temporary-containers
  - Automatically opens unknown sites in disposable containers
  - Containers are deleted after closing
  - Great for random browsing

- [ ] **Set up cookie preferences per container**
  - about:preferences#privacy
  - Enhanced Tracking Protection: Strict
  - Delete cookies when Firefox closes: OFF (for assigned containers)
  - Use Temporary Containers for: Sites not assigned to specific containers

- [ ] **Configure autofill per container**
  - Settings → Privacy & Security → Forms and Autofill
  - Disable autofill globally (you'll use 1Password instead)
  - Or: Configure different autofill per container (requires manual setup)

### Phase 4: Browser Profile Strategy (Day 3)

For maximum isolation, create separate Firefox profiles:

- [ ] **Create Financial Profile** (for sensitive banking only)
  - Open: about:profiles
  - Create New Profile: "Financial"
  - Install only essential extensions (1Password, uBlock Origin)
  - No containers needed (dedicated profile)
  - Launch: firefox -P Financial

- [ ] **Keep Default Profile for containers** (Personal/Professional/Travel/High-Security)
  - All non-financial browsing
  - Uses Multi-Account Containers

**When to use which:**
- Financial Profile: Banking, investments, anything involving money
- Default Profile with Containers: Everything else

### Phase 5: Safari for Financial (macOS) (Day 3)

- [ ] **Configure Safari as dedicated Financial browser**
  - Safari → Settings → Privacy: Prevent cross-site tracking ON
  - Block all cookies: OFF (needed for banking)
  - Website tracking: Ask websites not to track me
  - Hide IP address: From trackers

- [ ] **Install only essential extensions**
  - 1Password for Safari
  - No other extensions (attack surface reduction)

- [ ] **Disable Safari for all non-financial use**
  - Only use for banking and financial institutions
  - Never use for general browsing
  - This creates physical separation from other activities

### Phase 6: Verification & Testing (Day 3-4)

- [ ] **Test container isolation**
  - Log into Twitter in Personal container
  - Open new tab in Financial container
  - Visit Twitter → Should NOT be logged in (different containers)
  - If still logged in: Container assignment didn't work

- [ ] **Test cross-container tracking**
  - Visit shopping site in Personal container
  - Open Financial container
  - Check if ads follow you (they shouldn't)

- [ ] **Verify autofill doesn't cross containers**
  - Start typing email in Personal container → Should suggest personal email
  - Start typing in Financial container → Should suggest financial email
  - If wrong email suggested: 1Password vault assignment needs fixing

- [ ] **Test "Always Open in Container" assignments**
  - Close all Firefox windows
  - Open Firefox, type "twitter.com"
  - Should automatically open in Personal (Blue) container
  - Repeat for banking site → Should open in Financial (Red) container

### Phase 7: Maintenance & Documentation (Day 4)

- [ ] **Document container assignments**
  - Create `container-assignments.md` file
  - List all frequently visited sites and their containers
  - Include reasoning for assignments
  - Update when adding new services

- [ ] **Create quick reference guide**
  - Visual guide: What color = what domain
  - Blue (Personal), Red (Financial), Green (Professional), Yellow (Travel), Purple (High-Security)
  - Print and keep near computer for first few weeks

- [ ] **Set up periodic review**
  - Monthly: Review unassigned sites (Temporary Containers log)
  - Assign frequently visited sites to appropriate containers
  - Remove assignments for sites you no longer use

---

## 🔍 **Advanced Configuration**

### Firefox about:config Tweaks

Additional privacy settings (optional):

```
privacy.firstparty.isolate = true
network.cookie.cookieBehavior = 5
privacy.resistFingerprinting = true
```

⚠️ Warning: These may break some sites. Test carefully.

### Container Sync Across Devices

Multi-Account Containers **do NOT sync** across Firefox installations. To maintain consistency:

- [ ] Export container settings: Containers menu → Export
- [ ] Save to: `firefox-container-export.json`
- [ ] Import on other devices: Containers menu → Import

---

## 🚧 **Common Issues & Solutions**

### Issue: Site won't work in assigned container
**Solution**: Some sites (especially banks) detect "unusual" sessions. Temporarily open in private window, then reassign to correct container.

### Issue: Forgot which container for which site
**Solution**: Check URL bar - colored underline indicates active container. Or check Containers menu → Manage Containers → See assigned sites.

### Issue: Too many containers getting confusing
**Solution**: Start with just 3 containers (Personal, Financial, Professional). Add Travel and High-Security only when needed.

### Issue: Accidentally opened site in wrong container
**Solution**: Containers menu → Open in Different Container → Select correct one. Firefox will reload the page in the right container.

### Issue: Want to share login between containers
**Solution**: Don't. This defeats the purpose. If you need same account across contexts, you're mixing domains incorrectly.

---

## ✅ **Success Criteria**

- [ ] Firefox Multi-Account Containers installed and configured
- [ ] 5 containers created with distinct colors and icons
- [ ] 20+ frequently visited sites assigned to appropriate containers
- [ ] Test verified: Containers are truly isolated (no cookie leakage)
- [ ] Safari configured as dedicated financial browser
- [ ] Container assignments documented
- [ ] Quick reference guide created
- [ ] Comfortable using containers without thinking about it

---

## 📁 **Project Files**

- `container-assignments.md` - Master list of site-to-container mappings
- `firefox-container-export.json` - Backup of container configuration
- `quick-reference-guide.pdf` - Visual guide to container colors and purposes

---

## 🔄 **Dependencies**

- **Prerequisite**: Project 00 complete (all accounts using correct domain emails)
- **Prerequisite**: 1Password vaults organized by domain
- **Recommended**: Project 05 complete (general browser hardening)
- **Blocks**: None
- **Timeline**: Can implement anytime after Project 00

---

## 💡 **Usage Tips**

**Daily Workflow:**
1. Opening Firefox → Automatically in last-used container
2. Type URL → Auto-opens in assigned container (if configured)
3. Need different context → Ctrl+. (container menu) → Select container
4. Unknown site → Opens in Temporary Container (disposable)

**Visual Cues:**
- **Blue tabs** = Personal stuff (social media, entertainment)
- **Red tabs** = Financial stuff (never mix with anything else)
- **Green tabs** = Professional stuff (work, LinkedIn)
- **Yellow tabs** = Travel stuff (temporary, disposable feel)
- **Purple tabs** = High-security stuff (crypto, secure comms)

**Mental Model:**
Think of containers as separate browsers living inside one Firefox window. Each container has its own cookies, sessions, and tracking - completely isolated from others.

---

**Remember**: Compartmentalization is only as good as your discipline. Always check the container color before entering sensitive information! 🔒
