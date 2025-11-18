#!/bin/bash

# Travel Account Migration Priority Strategy
# For secure international travel preparation
# Created: $(date)

echo "=== TRAVEL ACCOUNT MIGRATION PRIORITY ANALYSIS ==="
echo "Created: $(date)"
echo ""

# Create travel directory structure
mkdir -p ~/.email-safety-net/travel-accounts/{critical,high-priority,medium-priority,domestic-only}

echo "🌍 CRITICAL TRAVEL ACCOUNTS (Migrate FIRST - ASAP)"
echo "=================================================="
echo ""

echo "🛫 TIER 1: ESSENTIAL TRAVEL SERVICES"
echo "Must have for any international travel:"

# Create critical travel accounts file
cat > ~/.email-safety-net/travel-accounts/critical/tier1-essential.txt << 'EOF'
CRITICAL TRAVEL ACCOUNTS - TIER 1: ESSENTIAL
===========================================

🛫 AIRLINES & FLIGHTS:
- easyjet.com (jackneedham9494@gmail.com) 
  → MIGRATE TO: Travel Domain (Tor Browser + dedicated travel email)
  → SECURITY RISK: Flight bookings, personal data, payment info
  → URGENCY: CRITICAL - needed for booking/checking in

- britishairways.com (28073351)
  → MIGRATE TO: Travel Domain 
  → SECURITY RISK: Frequent flyer data, travel patterns
  → URGENCY: CRITICAL - primary UK carrier

- united.com (jackneedham9494@gmail.com, BQN21805)
  → MIGRATE TO: Travel Domain
  → SECURITY RISK: US travel history, personal data
  → URGENCY: CRITICAL - US/international travel

🏨 ACCOMMODATION:
- airbnb.co.uk (jackneedham9494@gmail.com)
  → MIGRATE TO: Travel Domain
  → SECURITY RISK: Travel locations, dates, personal safety
  → URGENCY: CRITICAL - accommodation booking

- marriott.com (jackneedham9494@gmail.com)
  → MIGRATE TO: Travel Domain  
  → SECURITY RISK: Hotel loyalty, travel patterns
  → URGENCY: HIGH - hotel bookings

🚗 TRANSPORTATION:
- uber.com (jackneedham9494@gmail.com)
  → MIGRATE TO: Travel Domain
  → SECURITY RISK: Location tracking, movement patterns
  → URGENCY: CRITICAL - essential for airport/city transport

📱 COMMUNICATION:
- verizon.com (4152644501) 
  → MIGRATE TO: Travel Domain
  → SECURITY RISK: US phone service, roaming data
  → URGENCY: CRITICAL - international roaming

- vodafone.co.uk (jackneedham9494@gmail.com)
  → MIGRATE TO: Travel Domain
  → SECURITY RISK: UK phone service, international plans
  → URGENCY: CRITICAL - primary mobile service

EOF

echo "Reading Tier 1 Critical accounts..."
cat ~/.email-safety-net/travel-accounts/critical/tier1-essential.txt
echo ""

echo "🏛️ TIER 2: GOVERNMENT & VISA SERVICES" 
echo "Essential for legal travel compliance:"

cat > ~/.email-safety-net/travel-accounts/critical/tier2-government.txt << 'EOF'
CRITICAL TRAVEL ACCOUNTS - TIER 2: GOVERNMENT
============================================

🏛️ GOVERNMENT SERVICES:
- service.gov.uk (jackneedham9494@gmail.com)
  → MIGRATE TO: High-Security Domain (Brave Browser + deepvault@protonmail.com)
  → SECURITY RISK: Government ID, passport, visa applications
  → URGENCY: CRITICAL - passport/visa services

- gateway.gov.uk (jackneedham9494@gmail.com)  
  → MIGRATE TO: High-Security Domain
  → SECURITY RISK: Government authentication, official documents
  → URGENCY: CRITICAL - official government access

- companieshouse.gov.uk (jackneedham9494@gmail.com)
  → MIGRATE TO: High-Security Domain
  → SECURITY RISK: Business registration for travel purposes
  → URGENCY: MEDIUM - business travel documentation

- towerhamlets.gov.uk (jackneedham9494@gmail.com)
  → MIGRATE TO: High-Security Domain
  → SECURITY RISK: Local council services, address verification
  → URGENCY: MEDIUM - address confirmation for travel docs

🇺🇸 US VISA & IMMIGRATION:
- usvisa-info.com (jackneedham9494@gmail.com)
  → MIGRATE TO: High-Security Domain
  → SECURITY RISK: US visa applications, immigration status
  → URGENCY: CRITICAL - US travel authorization

- ca.gov (jackneedham9494@gmail.com) / ftb.ca.gov (jackn9494)
  → MIGRATE TO: High-Security Domain  
  → SECURITY RISK: California state services, tax records
  → URGENCY: HIGH - US state compliance

EOF

cat ~/.email-safety-net/travel-accounts/critical/tier2-government.txt
echo ""

echo "🚄 HIGH PRIORITY TRAVEL ACCOUNTS"
echo "================================="

cat > ~/.email-safety-net/travel-accounts/high-priority/transport-services.txt << 'EOF'
HIGH PRIORITY - TRANSPORTATION & LOGISTICS
==========================================

🚄 RAIL & GROUND TRANSPORT:
- railcard.co.uk (jackneedham9494@gmail.com)
  → MIGRATE TO: Travel Domain
  → SECURITY RISK: UK rail travel patterns, discounts
  → URGENCY: HIGH - UK domestic travel

- thetrainline.com (JACKNEEDHAM9494@gmail.com)
  → MIGRATE TO: Travel Domain
  → SECURITY RISK: European rail booking, travel patterns
  → URGENCY: HIGH - European travel essential

- northernrail.org (jackneedham9494@gmail.com)
  → MIGRATE TO: Travel Domain
  → SECURITY RISK: Regional rail travel, location data
  → URGENCY: MEDIUM - domestic UK travel

🚇 LOCAL TRANSPORT:
- clippercard.com (jackneedham9494@gmail.com)
  → MIGRATE TO: Travel Domain
  → SECURITY RISK: San Francisco public transport, location tracking
  → URGENCY: HIGH - SF Bay Area essential

📦 TRAVEL LOGISTICS:
- dpd.co.uk (jackneedham9494@gmail.com)
  → MIGRATE TO: Personal Domain (Firefox + streamcode@protonmail.com)
  → SECURITY RISK: Package delivery when away
  → URGENCY: MEDIUM - travel logistics

- parcelforce.co.uk (JACKNEEDHAM9494@gmail.com)
  → MIGRATE TO: Personal Domain
  → SECURITY RISK: Package tracking, delivery scheduling
  → URGENCY: MEDIUM - travel logistics

- royalmail.com (jackneedham9494@gmail.com)
  → MIGRATE TO: Personal Domain
  → SECURITY RISK: Mail forwarding, delivery management  
  → URGENCY: MEDIUM - mail management while away

EOF

cat ~/.email-safety-net/travel-accounts/high-priority/transport-services.txt
echo ""

echo "💡 RECOMMENDED MIGRATION STRATEGY"
echo "================================="

cat > ~/.email-safety-net/travel-accounts/migration-strategy.txt << 'EOF'
TRAVEL ACCOUNT MIGRATION STRATEGY
=================================

🎯 IMMEDIATE ACTIONS (Before Any International Travel):

1. CRITICAL TIER 1 - Airlines & Core Travel (Migrate to Travel Domain):
   - Set up dedicated travel email: travelsafe@protonmail.com
   - Use Tor Browser for all travel-related browsing
   - Create separate 1Password vault: "Travel Domain"
   
   ACCOUNTS TO MIGRATE FIRST:
   ✈️ easyjet.com → travelsafe@protonmail.com
   ✈️ britishairways.com → travelsafe@protonmail.com  
   ✈️ united.com → travelsafe@protonmail.com
   🏨 airbnb.co.uk → travelsafe@protonmail.com
   🏨 marriott.com → travelsafe@protonmail.com
   🚗 uber.com → travelsafe@protonmail.com

2. CRITICAL TIER 2 - Government (Migrate to High-Security Domain):
   - Use existing: deepvault@protonmail.com
   - Use Brave Browser with maximum security
   - Store in existing "High-Security Domain" vault
   
   ACCOUNTS TO MIGRATE:
   🏛️ service.gov.uk → deepvault@protonmail.com
   🏛️ gateway.gov.uk → deepvault@protonmail.com
   🇺🇸 usvisa-info.com → deepvault@protonmail.com
   🇺🇸 ca.gov → deepvault@protonmail.com

3. HIGH PRIORITY - Transportation (Travel Domain):
   🚄 thetrainline.com → travelsafe@protonmail.com
   🚄 railcard.co.uk → travelsafe@protonmail.com
   🚇 clippercard.com → travelsafe@protonmail.com

🔐 SECURITY CONSIDERATIONS FOR TRAVEL:

⚠️  NEVER use public WiFi for these accounts
⚠️  Always use VPN when accessing travel accounts abroad
⚠️  Consider using offline password manager access
⚠️  Screenshot/PDF important booking confirmations offline
⚠️  Have backup 2FA codes printed and stored separately

📱 MOBILE CONSIDERATIONS:
- Download offline maps before travel
- Set up international roaming plans (Verizon/Vodafone)
- Consider burner phone for high-risk destinations
- Use travel-specific apps in separate app folder

🌍 DESTINATION-SPECIFIC RISKS:
- High surveillance countries: Use Tor Browser exclusively
- Data-retention jurisdictions: Minimize digital footprint
- Authoritarian regions: Consider device isolation/burner devices
- High-crime areas: Limit financial account access via mobile

EOF

cat ~/.email-safety-net/travel-accounts/migration-strategy.txt
echo ""

echo "📊 MIGRATION PRIORITY SUMMARY"
echo "============================="
echo "🔴 CRITICAL (Do First): 6 accounts (Airlines, Accommodation, Transport Apps)"
echo "🟡 HIGH (Do Next): 7 accounts (Government, Visa Services, Rail)"  
echo "🟢 MEDIUM (When Convenient): 4 accounts (Delivery Services, Local Transport)"
echo ""
echo "💾 All travel account lists saved to: ~/.email-safety-net/travel-accounts/"
echo ""
echo "⚡ NEXT STEPS:"
echo "1. Set up travelsafe@protonmail.com email address"
echo "2. Create Travel Domain vault in 1Password"  
echo "3. Start with Tier 1 Critical accounts migration"
echo "4. Test access from Tor Browser before travel"
echo ""