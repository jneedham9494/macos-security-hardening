#!/bin/bash
# Periodic Security Monitoring Setup Script
# Sets up automated security scans with reporting

set -euo pipefail

# ============================================================================
# CONFIGURATION
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MONITOR_DIR="$HOME/.security-monitoring"
LAUNCHD_DIR="$HOME/Library/LaunchAgents"
LOG_FILE="$MONITOR_DIR/periodic-setup.log"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

print_header() {
    echo -e "\n${CYAN}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  $(printf "%-74s" "$1")  ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════════════╝${NC}\n"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - SUCCESS: $1" >> "$LOG_FILE"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - INFO: $1" >> "$LOG_FILE"
}

# ============================================================================
# CREATE REPORTING SCRIPTS
# ============================================================================

create_reporting_scripts() {
    print_info "Creating security reporting scripts..."
    
    # Main periodic security scanner with reporting
    cat > "$MONITOR_DIR/periodic-security-scan.sh" << 'EOF'
#!/bin/bash
# Periodic Security Scanner with Reporting
# Runs comprehensive security scans and generates reports

MONITOR_DIR="$HOME/.security-monitoring"
REPORT_DIR="$MONITOR_DIR/reports"
DATE=$(date '+%Y-%m-%d')
TIME=$(date '+%H:%M:%S')
TIMESTAMP="$DATE $TIME"
REPORT_FILE="$REPORT_DIR/security-report-$DATE.html"

# Create reports directory
mkdir -p "$REPORT_DIR"

# Start HTML report
cat > "$REPORT_FILE" << HTML_START
<!DOCTYPE html>
<html>
<head>
    <title>Security Scan Report - $DATE</title>
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, sans-serif; margin: 40px; background: #f5f5f7; }
        .container { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        h1 { color: #1d1d1f; border-bottom: 3px solid #007AFF; padding-bottom: 10px; }
        h2 { color: #333; margin-top: 30px; }
        .status-good { color: #34C759; font-weight: bold; }
        .status-warning { color: #FF9500; font-weight: bold; }
        .status-critical { color: #FF3B30; font-weight: bold; }
        .summary { background: #f1f3f5; padding: 20px; border-radius: 8px; margin: 20px 0; }
        .scan-section { margin: 20px 0; padding: 15px; border-left: 4px solid #007AFF; background: #f8f9fa; }
        pre { background: #2d3748; color: #e2e8f0; padding: 15px; border-radius: 6px; overflow-x: auto; font-size: 12px; }
        .timestamp { color: #666; font-size: 14px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🛡️ Security Scan Report</h1>
        <div class="timestamp">Generated: $TIMESTAMP</div>
        
        <div class="summary">
            <h2>📊 Scan Summary</h2>
            <ul id="summary-list">
HTML_START

# Initialize counters
SECRETS_FOUND=0
VULNS_FOUND=0
CODE_ISSUES=0

echo "[$TIMESTAMP] Starting periodic security scan..." >> "$MONITOR_DIR/periodic-scan.log"

# 1. SECRET SCANNING
echo "<li>🔍 Secret Scanning: " >> "$REPORT_FILE"
if command -v gitleaks &> /dev/null; then
    echo "Running secret scan..." >> "$MONITOR_DIR/periodic-scan.log"
    
    # Run gitleaks scan
    SECRETS_OUTPUT=$(gitleaks detect --config ~/.gitleaks.toml --source "$HOME/development" --no-git 2>&1 || true)
    SECRETS_COUNT=$(echo "$SECRETS_OUTPUT" | grep -c "Finding:" || echo "0")
    
    if [[ $SECRETS_COUNT -gt 0 ]]; then
        echo "<span class='status-warning'>$SECRETS_COUNT secrets detected</span></li>" >> "$REPORT_FILE"
        SECRETS_FOUND=$SECRETS_COUNT
    else
        echo "<span class='status-good'>No secrets detected</span></li>" >> "$REPORT_FILE"
    fi
    
    # Add detailed results
    echo "<div class='scan-section'><h2>🔐 Secret Scan Results</h2><pre>$SECRETS_OUTPUT</pre></div>" >> "$REPORT_FILE"
else
    echo "<span class='status-warning'>Gitleaks not available</span></li>" >> "$REPORT_FILE"
fi

# 2. VULNERABILITY SCANNING
echo "<li>🛡️ Vulnerability Scanning: " >> "$REPORT_FILE"
if command -v trivy &> /dev/null; then
    echo "Running vulnerability scan..." >> "$MONITOR_DIR/periodic-scan.log"
    
    # Run trivy scan
    VULNS_OUTPUT=$(trivy fs --config ~/.trivy.yaml "$HOME/development" 2>&1 || true)
    VULNS_COUNT=$(echo "$VULNS_OUTPUT" | grep -c "HIGH\|CRITICAL" || echo "0")
    
    if [[ $VULNS_COUNT -gt 0 ]]; then
        echo "<span class='status-critical'>$VULNS_COUNT high/critical vulnerabilities</span></li>" >> "$REPORT_FILE"
        VULNS_FOUND=$VULNS_COUNT
    else
        echo "<span class='status-good'>No critical vulnerabilities</span></li>" >> "$REPORT_FILE"
    fi
    
    # Add detailed results
    echo "<div class='scan-section'><h2>🔍 Vulnerability Scan Results</h2><pre>$VULNS_OUTPUT</pre></div>" >> "$REPORT_FILE"
else
    echo "<span class='status-warning'>Trivy not available</span></li>" >> "$REPORT_FILE"
fi

# 3. CODE SECURITY ANALYSIS
echo "<li>🔬 Code Security Analysis: " >> "$REPORT_FILE"
if command -v semgrep &> /dev/null; then
    echo "Running code security analysis..." >> "$MONITOR_DIR/periodic-scan.log"
    
    # Run semgrep scan
    CODE_OUTPUT=$(semgrep --config ~/.semgrep.yml "$HOME/development" 2>&1 || true)
    CODE_COUNT=$(echo "$CODE_OUTPUT" | grep -c "ERROR\|WARNING" || echo "0")
    
    if [[ $CODE_COUNT -gt 0 ]]; then
        echo "<span class='status-warning'>$CODE_COUNT security issues found</span></li>" >> "$REPORT_FILE"
        CODE_ISSUES=$CODE_COUNT
    else
        echo "<span class='status-good'>No security issues detected</span></li>" >> "$REPORT_FILE"
    fi
    
    # Add detailed results
    echo "<div class='scan-section'><h2>🔬 Code Security Analysis Results</h2><pre>$CODE_OUTPUT</pre></div>" >> "$REPORT_FILE"
else
    echo "<span class='status-warning'>Semgrep not available</span></li>" >> "$REPORT_FILE"
fi

# 4. NETWORK MONITORING
echo "<li>🌐 Network Status: " >> "$REPORT_FILE"
NETWORK_OUTPUT=$(lsof -i -n | grep ESTABLISHED | head -10 || echo "No established connections")
CONN_COUNT=$(lsof -i -n | grep ESTABLISHED | wc -l || echo "0")
echo "<span class='status-good'>$CONN_COUNT active connections</span></li>" >> "$REPORT_FILE"
echo "<div class='scan-section'><h2>🌐 Network Connections</h2><pre>$NETWORK_OUTPUT</pre></div>" >> "$REPORT_FILE"

# Close summary list
echo "</ul></div>" >> "$REPORT_FILE"

# OVERALL SECURITY STATUS
TOTAL_ISSUES=$((SECRETS_FOUND + VULNS_FOUND + CODE_ISSUES))

if [[ $TOTAL_ISSUES -eq 0 ]]; then
    SECURITY_STATUS="<span class='status-good'>✅ SECURE</span>"
    NOTIFICATION_TITLE="Security Scan: All Clear"
    NOTIFICATION_MESSAGE="No security issues detected in periodic scan"
elif [[ $TOTAL_ISSUES -le 5 ]]; then
    SECURITY_STATUS="<span class='status-warning'>⚠️ MINOR ISSUES</span>"
    NOTIFICATION_TITLE="Security Scan: Minor Issues"
    NOTIFICATION_MESSAGE="$TOTAL_ISSUES security issues detected - review recommended"
else
    SECURITY_STATUS="<span class='status-critical'>🚨 ATTENTION REQUIRED</span>"
    NOTIFICATION_TITLE="Security Scan: Issues Detected"
    NOTIFICATION_MESSAGE="$TOTAL_ISSUES security issues detected - immediate review required"
fi

# Add security status to report
cat >> "$REPORT_FILE" << HTML_END
        <div class="summary">
            <h2>🎯 Overall Security Status</h2>
            <h3>$SECURITY_STATUS</h3>
            <p>Total Issues Found: <strong>$TOTAL_ISSUES</strong></p>
            <ul>
                <li>Secrets: $SECRETS_FOUND</li>
                <li>Vulnerabilities: $VULNS_FOUND</li>
                <li>Code Issues: $CODE_ISSUES</li>
            </ul>
        </div>
        
        <div class="scan-section">
            <h2>📋 Recommendations</h2>
            <ul>
                <li>Review all detected secrets and remove/rotate them</li>
                <li>Update vulnerable dependencies immediately</li>
                <li>Fix code security issues in development</li>
                <li>Monitor network connections for suspicious activity</li>
            </ul>
        </div>
        
        <div class="timestamp">
            <p>Next scan scheduled in 24 hours</p>
            <p>Reports location: ~/.security-monitoring/reports/</p>
        </div>
    </div>
</body>
</html>
HTML_END

# Send macOS notification
osascript -e "display notification \"$NOTIFICATION_MESSAGE\" with title \"$NOTIFICATION_TITLE\""

# Log completion
echo "[$TIMESTAMP] Periodic security scan completed. Report: $REPORT_FILE" >> "$MONITOR_DIR/periodic-scan.log"

# Open report (optional - comment out if you don't want auto-open)
# open "$REPORT_FILE"

echo "Report generated: $REPORT_FILE"
EOF

    chmod +x "$MONITOR_DIR/periodic-security-scan.sh"
    
    # Quick daily summary script  
    cat > "$MONITOR_DIR/daily-security-summary.sh" << 'EOF'
#!/bin/bash
# Daily Security Summary - Quick Status Check

MONITOR_DIR="$HOME/.security-monitoring"
DATE=$(date '+%Y-%m-%d')

# Check if today's report exists
REPORT_FILE="$MONITOR_DIR/reports/security-report-$DATE.html"

if [[ -f "$REPORT_FILE" ]]; then
    # Extract summary from HTML report
    SUMMARY=$(grep -A 5 "Total Issues Found" "$REPORT_FILE" | sed 's/<[^>]*>//g' | sed 's/^[[:space:]]*//')
    
    osascript -e "display notification \"Daily security summary available. Click to view report.\" with title \"Security Status - $DATE\""
    
    # Log summary
    echo "$(date): Daily Summary - $SUMMARY" >> "$MONITOR_DIR/daily-summary.log"
else
    osascript -e "display notification \"No security scan completed today. Run security monitor manually.\" with title \"Security Status - $DATE\""
fi
EOF

    chmod +x "$MONITOR_DIR/daily-security-summary.sh"
    
    print_success "Security reporting scripts created"
}

# ============================================================================
# CREATE LAUNCHD PLISTS
# ============================================================================

create_scheduled_jobs() {
    print_info "Creating scheduled security scans..."
    
    mkdir -p "$LAUNCHD_DIR"
    
    # Daily comprehensive security scan (runs at 9 AM daily)
    cat > "$LAUNCHD_DIR/com.security.daily-scan.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.security.daily-scan</string>
    <key>ProgramArguments</key>
    <array>
        <string>$MONITOR_DIR/periodic-security-scan.sh</string>
    </array>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>9</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>
    <key>StandardOutPath</key>
    <string>$MONITOR_DIR/daily-scan.log</string>
    <key>StandardErrorPath</key>
    <string>$MONITOR_DIR/daily-scan-error.log</string>
</dict>
</plist>
EOF

    # Evening security summary (runs at 6 PM daily)
    cat > "$LAUNCHD_DIR/com.security.evening-summary.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.security.evening-summary</string>
    <key>ProgramArguments</key>
    <array>
        <string>$MONITOR_DIR/daily-security-summary.sh</string>
    </array>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>18</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>
    <key>StandardOutPath</key>
    <string>$MONITOR_DIR/summary.log</string>
    <key>StandardErrorPath</key>
    <string>$MONITOR_DIR/summary-error.log</string>
</dict>
</plist>
EOF

    # Weekly deep scan (runs Sunday at 10 AM)
    cat > "$LAUNCHD_DIR/com.security.weekly-scan.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.security.weekly-scan</string>
    <key>ProgramArguments</key>
    <array>
        <string>$MONITOR_DIR/security-monitor.sh</string>
    </array>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Weekday</key>
        <integer>0</integer>
        <key>Hour</key>
        <integer>10</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>
    <key>StandardOutPath</key>
    <string>$MONITOR_DIR/weekly-scan.log</string>
    <key>StandardErrorPath</key>
    <string>$MONITOR_DIR/weekly-scan-error.log</string>
</dict>
</plist>
EOF

    print_success "Scheduled jobs created"
}

# ============================================================================
# LOAD SCHEDULED JOBS
# ============================================================================

load_scheduled_jobs() {
    print_info "Loading scheduled security jobs..."
    
    # Load all the jobs
    launchctl load "$LAUNCHD_DIR/com.security.daily-scan.plist" 2>/dev/null || print_info "Daily scan job already loaded or failed to load"
    launchctl load "$LAUNCHD_DIR/com.security.evening-summary.plist" 2>/dev/null || print_info "Evening summary job already loaded or failed to load"
    launchctl load "$LAUNCHD_DIR/com.security.weekly-scan.plist" 2>/dev/null || print_info "Weekly scan job already loaded or failed to load"
    
    print_success "Scheduled jobs loaded"
}

# ============================================================================
# CREATE MANAGEMENT COMMANDS
# ============================================================================

create_management_commands() {
    print_info "Creating periodic security management commands..."
    
    # Security scheduler management command
    cat > "$MONITOR_DIR/security-scheduler" << 'EOF'
#!/bin/bash
# Security Scheduler Management

MONITOR_DIR="$HOME/.security-monitoring"
LAUNCHD_DIR="$HOME/Library/LaunchAgents"

case "$1" in
    "start")
        echo "🚀 Starting security scheduler..."
        launchctl load "$LAUNCHD_DIR/com.security.daily-scan.plist" 2>/dev/null
        launchctl load "$LAUNCHD_DIR/com.security.evening-summary.plist" 2>/dev/null
        launchctl load "$LAUNCHD_DIR/com.security.weekly-scan.plist" 2>/dev/null
        echo "✅ Security scheduler started"
        ;;
    
    "stop")
        echo "⏹️ Stopping security scheduler..."
        launchctl unload "$LAUNCHD_DIR/com.security.daily-scan.plist" 2>/dev/null
        launchctl unload "$LAUNCHD_DIR/com.security.evening-summary.plist" 2>/dev/null
        launchctl unload "$LAUNCHD_DIR/com.security.weekly-scan.plist" 2>/dev/null
        echo "✅ Security scheduler stopped"
        ;;
    
    "status")
        echo "📊 Security Scheduler Status:"
        echo ""
        echo "Daily Scan (9 AM):"
        launchctl list | grep com.security.daily-scan || echo "  Not loaded"
        echo ""
        echo "Evening Summary (6 PM):"
        launchctl list | grep com.security.evening-summary || echo "  Not loaded"
        echo ""
        echo "Weekly Deep Scan (Sunday 10 AM):"
        launchctl list | grep com.security.weekly-scan || echo "  Not loaded"
        ;;
    
    "test")
        echo "🧪 Running test security scan..."
        "$MONITOR_DIR/periodic-security-scan.sh"
        echo "✅ Test completed - check ~/.security-monitoring/reports/"
        ;;
    
    "reports")
        echo "📋 Recent Security Reports:"
        ls -la "$MONITOR_DIR/reports/" | head -10 || echo "No reports found"
        echo ""
        echo "To view latest report:"
        LATEST=$(ls -t "$MONITOR_DIR/reports/"*.html 2>/dev/null | head -1)
        if [[ -n "$LATEST" ]]; then
            echo "open \"$LATEST\""
        fi
        ;;
    
    "logs")
        echo "📝 Security Scheduler Logs:"
        echo ""
        echo "=== Daily Scan Log ==="
        tail -20 "$MONITOR_DIR/daily-scan.log" 2>/dev/null || echo "No daily scan log"
        echo ""
        echo "=== Summary Log ==="
        tail -10 "$MONITOR_DIR/summary.log" 2>/dev/null || echo "No summary log"
        ;;
        
    *)
        echo "🛡️ Security Scheduler Management"
        echo ""
        echo "Available commands:"
        echo "  security-scheduler start    - Start automated scans"
        echo "  security-scheduler stop     - Stop automated scans"
        echo "  security-scheduler status   - Check scheduler status"
        echo "  security-scheduler test     - Run test scan now"
        echo "  security-scheduler reports  - View recent reports"
        echo "  security-scheduler logs     - View scheduler logs"
        echo ""
        echo "📅 Default Schedule:"
        echo "  • Daily Scan: 9:00 AM (comprehensive security scan)"
        echo "  • Evening Summary: 6:00 PM (status notification)"
        echo "  • Weekly Deep Scan: Sunday 10:00 AM (full monitoring)"
        ;;
esac
EOF

    chmod +x "$MONITOR_DIR/security-scheduler"
    
    print_success "Management commands created"
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    print_header "🕐 PERIODIC SECURITY MONITORING SETUP"
    
    print_info "Setting up automated security scanning with reporting..."
    
    # Create directory structure
    mkdir -p "$MONITOR_DIR/reports"
    
    # Create all components
    create_reporting_scripts
    create_scheduled_jobs
    load_scheduled_jobs
    create_management_commands
    
    print_header "🎉 PERIODIC SECURITY MONITORING SETUP COMPLETE!"
    
    echo -e "${GREEN}✅ Automated security scanning is now configured!${NC}"
    echo -e ""
    echo -e "${CYAN}📅 Schedule:${NC}"
    echo -e "   • ${YELLOW}Daily Scan${NC}: 9:00 AM (comprehensive security scan + HTML report)"
    echo -e "   • ${YELLOW}Evening Summary${NC}: 6:00 PM (status notification)"
    echo -e "   • ${YELLOW}Weekly Deep Scan${NC}: Sunday 10:00 AM (full monitoring)"
    echo -e ""
    echo -e "${CYAN}🛠️ Management Commands:${NC}"
    echo -e "   • ${YELLOW}security-scheduler start${NC} - Start automated scans"
    echo -e "   • ${YELLOW}security-scheduler status${NC} - Check status"
    echo -e "   • ${YELLOW}security-scheduler test${NC} - Run test scan now"
    echo -e "   • ${YELLOW}security-scheduler reports${NC} - View recent reports"
    echo -e ""
    echo -e "${CYAN}📊 Reports Location:${NC}"
    echo -e "   • HTML Reports: ${YELLOW}~/.security-monitoring/reports/${NC}"
    echo -e "   • Logs: ${YELLOW}~/.security-monitoring/*.log${NC}"
    echo -e ""
    echo -e "${BLUE}💡 Run 'security-scheduler test' to generate your first report!${NC}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi