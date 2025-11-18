#!/bin/bash

# =============================================================================
# CURRENT PHONE APP AUDIT
# Extract and categorize all apps from current phone for travel migration
# =============================================================================

echo "📱 CURRENT PHONE APP AUDIT"
echo "=========================="
echo ""
echo "🎯 Goal: Identify which apps to migrate to travel phone"
echo "📋 Process: Extract → Categorize → Decide → Migrate selectively"
echo ""

# =============================================================================
# METHOD 1: iOS APP LIST EXTRACTION
# =============================================================================

echo "📱 iOS APP LIST EXTRACTION METHODS"
echo "=================================="
echo ""
echo "□ METHOD A: Manual Screenshot Method (Quick)"
echo "=========================================="
echo "1. On your current iPhone:"
echo "   - Go to Settings → General → iPhone Storage"
echo "   - Wait for apps to load (shows all installed apps)"
echo "   - Take screenshots of the full list"
echo "   - This shows app names and storage usage"
echo ""
echo "2. Alternative: App Library view"
echo "   - Swipe to rightmost home screen (App Library)"
echo "   - Tap search bar at top"
echo "   - Shows alphabetical list of ALL apps"
echo "   - Screenshot the complete list"
echo ""

echo "□ METHOD B: iTunes/Finder Backup Method (Detailed)"
echo "=============================================="
echo "1. Connect iPhone to Mac/PC"
echo "2. Open Finder (macOS Catalina+) or iTunes"
echo "3. Select your device"
echo "4. Click 'Back Up Now' (creates app list)"
echo "5. Use third-party tools like 3uTools to extract app list"
echo ""

echo "□ METHOD C: Shortcuts App Method (Automated)"
echo "=========================================="
echo "1. Open Shortcuts app on iPhone"
echo "2. Create new shortcut"
echo "3. Add action: 'Get My Shortcuts' then 'Get Details of Shortcuts'"
echo "4. This can extract some app data programmatically"
echo ""

# =============================================================================
# METHOD 2: ANDROID APP LIST EXTRACTION
# =============================================================================

echo "🤖 ANDROID APP LIST EXTRACTION METHODS"
echo "====================================="
echo ""
echo "□ METHOD A: Settings Menu (Simple)"
echo "=============================="
echo "1. Settings → Apps & notifications → See all apps"
echo "2. This shows complete list of installed apps"
echo "3. Screenshot the entire list"
echo "4. Note: May need to scroll and take multiple screenshots"
echo ""

echo "□ METHOD B: Google Play Store Method"
echo "==================================="
echo "1. Open Google Play Store"
echo "2. Tap profile icon → Manage apps & device"
echo "3. Tap 'Manage' tab"
echo "4. This shows all installed apps from Play Store"
echo "5. Screenshot or manually list"
echo ""

echo "□ METHOD C: ADB Command Line (Advanced)"
echo "====================================="
echo "1. Enable Developer Options & USB Debugging"
echo "2. Connect to computer with ADB installed"
echo "3. Run: adb shell pm list packages -3"
echo "4. This lists all non-system apps"
echo "5. Export to text file for analysis"
echo ""

# =============================================================================
# APP CATEGORIZATION FRAMEWORK
# =============================================================================

echo "📊 APP CATEGORIZATION FRAMEWORK"
echo "==============================="
echo ""
echo "Once you have your app list, categorize each app:"
echo ""

echo "🔴 HIGH PRIVACY RISK - DO NOT MIGRATE"
echo "===================================="
echo "- Google apps (Gmail, Drive, Photos, Maps, Chrome)"
echo "- Social media with political content (Twitter, Reddit)"
echo "- Chinese apps (TikTok, WeChat unless essential)"
echo "- News apps with political content"
echo "- Dating apps"
echo "- Apps with extensive tracking (Facebook, Instagram)"
echo ""

echo "🟡 MEDIUM RISK - MIGRATE WITH CAUTION"
echo "====================================="
echo "- Banking apps (essential but risky if compromised)"
echo "- Work-related apps"
echo "- Cloud storage apps"
echo "- VoIP/calling apps (WhatsApp, Signal)"
echo "- Streaming apps (Netflix, Spotify)"
echo ""

echo "🟢 LOW RISK - SAFE TO MIGRATE"
echo "============================"
echo "- Travel apps (airlines, hotels, ride-sharing)"
echo "- Offline utilities (calculator, flashlight, weather)"
echo "- Translation and maps apps"
echo "- Camera and photo editing apps"
echo "- Health and fitness apps (without social features)"
echo ""

echo "⚪ NEUTRAL - EVALUATE NECESSITY"
echo "=============================="
echo "- Gaming apps"
echo "- Shopping apps"
echo "- Food delivery apps"
echo "- Local service apps"
echo "- Entertainment apps"
echo ""

# =============================================================================
# DECISION MATRIX TEMPLATE
# =============================================================================

echo "📋 APP MIGRATION DECISION MATRIX"
echo "================================"
echo ""
echo "Create a simple table for each app:"
echo ""
echo "| App Name | Category | Essential for Travel? | Privacy Risk | Decision |"
echo "|----------|----------|------------------------|--------------|----------|"
echo "| Example: Uber | Transport | YES | Medium | MIGRATE with new email |"
echo "| Example: Instagram | Social | NO | High | SKIP |"
echo "| Example: Banking App | Finance | YES | Medium | MIGRATE (minimal use) |"
echo "| Example: Google Maps | Navigation | NO | High | SKIP (use Maps.me) |"
echo ""

echo "Decision Options:"
echo "- MIGRATE: Install on travel phone with new compartmentalized email"
echo "- SKIP: Don't install, use alternatives or go without"
echo "- REPLACE: Don't migrate, use privacy-focused alternative"
echo "- WEB-ONLY: Don't install app, use website version if needed"
echo ""

# =============================================================================
# QUICK APP AUDIT TEMPLATE
# =============================================================================

echo "⚡ QUICK APP AUDIT TEMPLATE"
echo "=========================="
echo ""
echo "Go through your phone and quickly categorize apps into these buckets:"
echo ""

echo "📱 ESSENTIAL FOR TRAVEL (Migrate):"
echo "================================="
echo "□ Airlines: ________________________________"
echo "□ Hotels: __________________________________"
echo "□ Transport: _______________________________"
echo "□ Banking: _________________________________"
echo "□ Communication: ___________________________"
echo "□ Maps/Navigation: _________________________"
echo "□ Translation: _____________________________"
echo ""

echo "🎯 CONVENIENT BUT NOT ESSENTIAL (Consider):"
echo "=========================================="
echo "□ Entertainment: ___________________________"
echo "□ Shopping: ________________________________"
echo "□ Food/Delivery: ___________________________"
echo "□ Social: __________________________________"
echo "□ News: ____________________________________"
echo ""

echo "❌ HIGH RISK / NOT NEEDED (Skip):"
echo "==============================="
echo "□ Google Services: _________________________"
echo "□ Political/News: __________________________"
echo "□ Chinese Apps: ____________________________"
echo "□ Heavy Tracking Apps: _____________________"
echo "□ Rarely Used Apps: ________________________"
echo ""

# =============================================================================
# ALTERNATIVE APPS FOR COMMON FUNCTIONS
# =============================================================================

echo "🔄 PRIVACY-FOCUSED ALTERNATIVES"
echo "==============================="
echo ""
echo "Instead of migrating risky apps, use these alternatives:"
echo ""
echo "Navigation:"
echo "- Google Maps → Maps.me (offline)"
echo "- Google Maps → HERE WeGo (offline)"
echo ""
echo "Communication:"
echo "- WhatsApp → Signal (more private)"
echo "- Gmail → ProtonMail (already migrated!)"
echo ""
echo "Browser:"
echo "- Chrome → Brave Browser"
echo "- Safari → DuckDuckGo Browser"
echo ""
echo "Cloud Storage:"
echo "- Google Drive → ProtonDrive"
echo "- iCloud → Local storage + encrypted backup"
echo ""
echo "Social Media:"
echo "- Twitter app → Web version with VPN"
echo "- Reddit app → Web version (safer)"
echo ""
echo "Entertainment:"
echo "- YouTube app → Web version"
echo "- Streaming apps → Download content offline"
echo ""

echo "📝 NEXT STEPS"
echo "============="
echo ""
echo "1. Extract your current app list using preferred method above"
echo "2. Go through each app with the decision matrix"
echo "3. Create your migration list (essential apps only)"
echo "4. Identify alternative apps for privacy-risky ones"
echo "5. Start fresh installation on travel phone"
echo ""
echo "This approach ensures you only migrate what you actually need"
echo "while maintaining maximum privacy for your travel!"
echo ""