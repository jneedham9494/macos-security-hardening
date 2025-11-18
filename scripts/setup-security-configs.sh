#!/bin/bash
# Security Tools Configuration Setup Script
# Creates all configuration files and monitoring scripts for security tools

set -euo pipefail  # Exit on error, undefined vars, pipe failures

# ============================================================================
# CONFIGURATION & CONSTANTS
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.security-monitoring"
LOG_FILE="${SCRIPT_DIR}/config-setup.log"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

print_header() {
    echo -e "\n${CYAN}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║$(printf "%78s" | tr ' ' ' ')║${NC}"
    echo -e "${CYAN}║  $(printf "%-74s" "$1")  ║${NC}"
    echo -e "${CYAN}║$(printf "%78s" | tr ' ' ' ')║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════════════╝${NC}\n"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
    log "SUCCESS: $1"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
    log "INFO: $1"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
    log "WARNING: $1"
}

# ============================================================================
# CONFIGURATION CREATION FUNCTIONS
# ============================================================================

create_gitleaks_config() {
    print_info "Creating Gitleaks configuration..."
    
    cat > "$HOME/.gitleaks.toml" << 'EOF'
# Gitleaks Configuration for Enhanced Secret Detection
# This config focuses on development environments and common secret patterns

[extend]
# Use default ruleset and add custom rules
useDefault = true

[[rules]]
id = "custom-api-key"
description = "Generic API key pattern"
regex = '''(?i)(api[_-]?key|apikey)\s*[:=]\s*["']?([a-zA-Z0-9]{20,})["']?'''
secretGroup = 2

[[rules]]
id = "custom-jwt-token"
description = "JWT tokens"
regex = '''eyJ[A-Za-z0-9_/+-]*\.eyJ[A-Za-z0-9_/+-]*\.[A-Za-z0-9_/+-]*'''

[[rules]]
id = "custom-private-key-file"
description = "Private key files"
regex = '''-----BEGIN[A-Z ]*PRIVATE KEY-----'''

[[rules]]
id = "custom-database-url"
description = "Database connection strings"
regex = '''(?i)(database_url|db_url|conn_str|connection_string)\s*[:=]\s*["']?([a-zA-Z0-9+._-]+://[^\s"']+)["']?'''
secretGroup = 2

[allowlist]
description = "Global allowlist for false positives"
paths = [
    ".git/",
    "node_modules/",
    "vendor/",
    ".security-monitoring/",
    "test/",
    "tests/",
    "spec/"
]

regexes = [
    '''example\.com''',
    '''localhost''',
    '''127\.0\.0\.1''',
    '''YOUR_API_KEY_HERE''',
    '''REPLACE_WITH_ACTUAL_KEY'''
]
EOF

    print_success "Gitleaks configuration created at ~/.gitleaks.toml"
}

create_semgrep_config() {
    print_info "Creating Semgrep configuration..."
    
    cat > "$HOME/.semgrep.yml" << 'EOF'
# Semgrep Configuration for Security Analysis
# Focuses on common security vulnerabilities in development

rules:
  - id: hardcoded-secrets
    pattern-either:
      - pattern: password = "..."
      - pattern: api_key = "..."
      - pattern: secret = "..."
      - pattern: token = "..."
    message: Potential hardcoded secret detected
    languages: [python, javascript, typescript, java, go]
    severity: ERROR
    
  - id: sql-injection
    pattern-either:
      - pattern: execute("SELECT * FROM users WHERE id = " + $VAR)
      - pattern: query("... WHERE ... = " + $VAR)
    message: Potential SQL injection vulnerability
    languages: [python, javascript, typescript, java]
    severity: ERROR
    
  - id: command-injection
    pattern-either:
      - pattern: os.system($VAR)
      - pattern: exec($VAR)
      - pattern: shell_exec($VAR)
    message: Potential command injection vulnerability
    languages: [python, php, javascript]
    severity: ERROR

  - id: weak-crypto
    pattern-either:
      - pattern: hashlib.md5(...)
      - pattern: hashlib.sha1(...)
      - pattern: crypto.createHash('md5')
      - pattern: crypto.createHash('sha1')
    message: Weak cryptographic algorithm detected
    languages: [python, javascript, typescript]
    severity: WARNING
EOF

    print_success "Semgrep configuration created at ~/.semgrep.yml"
}

create_trivy_config() {
    print_info "Creating Trivy configuration..."
    
    cat > "$HOME/.trivy.yaml" << 'EOF'
# Trivy Configuration for Enhanced Vulnerability Scanning
# Optimized for development environments

# Scan settings
format: table
exit-code: 0  # Don't exit with error code
severity: HIGH,CRITICAL
ignore-unfixed: false

# Cache settings
cache:
  dir: ~/.cache/trivy

# Security checks to perform
security-checks:
  - vuln
  - config
  - secret
  - license

# Skip certain directories to speed up scans
skip-dirs:
  - node_modules
  - .git
  - vendor
  - .venv
  - __pycache__
  - .pytest_cache
  - .DS_Store

# Skip certain files
skip-files:
  - "**/*.log"
  - "**/*.tmp"
  - "**/test/**"
  - "**/tests/**"

# License scanning
license:
  full: false
  
# Secret scanning patterns
secret:
  config: ~/.trivy-secret.yaml
EOF

    print_success "Trivy configuration created at ~/.trivy.yaml"
}

create_monitoring_scripts() {
    print_info "Creating security monitoring scripts..."
    
    mkdir -p "$CONFIG_DIR"
    
    # Enhanced security monitor script
    cat > "$CONFIG_DIR/security-monitor.sh" << 'EOF'
#!/bin/bash
# Enhanced Security Monitoring Script
# Uses configured security tools for comprehensive monitoring

MONITOR_DIR="$HOME/.security-monitoring"
LOG_FILE="$MONITOR_DIR/security-scan.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "===========================================" >> "$LOG_FILE"
echo "[$DATE] Security Monitoring Scan Started" >> "$LOG_FILE"
echo "===========================================" >> "$LOG_FILE"

# 1. Secret Scanning with Gitleaks (using config)
echo "[$DATE] Running secret scan with gitleaks..." >> "$LOG_FILE"
gitleaks detect --config ~/.gitleaks.toml --source "$HOME/development" --report-format json --report-path "$MONITOR_DIR/secrets-$(date +%Y%m%d).json" --verbose >> "$LOG_FILE" 2>&1 &

# 2. Code Security Analysis with Semgrep (using config)
if [[ -d "$HOME/development" ]]; then
    echo "[$DATE] Running code security analysis..." >> "$LOG_FILE"
    semgrep --config ~/.semgrep.yml --json --output "$MONITOR_DIR/semgrep-$(date +%Y%m%d).json" "$HOME/development" >> "$LOG_FILE" 2>&1 &
fi

# 3. Vulnerability Scanning with Trivy (using config)
echo "[$DATE] Running vulnerability scan..." >> "$LOG_FILE"
trivy fs --config ~/.trivy.yaml --format json --output "$MONITOR_DIR/trivy-$(date +%Y%m%d).json" "$HOME/development" >> "$LOG_FILE" 2>&1 &

# 4. Network Monitoring with bandwhich (if not already running)
if ! pgrep -f "bandwhich" > /dev/null; then
    echo "[$DATE] Starting network monitoring..." >> "$LOG_FILE"
    # Run bandwhich in background for 60 seconds
    timeout 60 bandwhich --raw --no-resolve > "$MONITOR_DIR/network-$(date +%Y%m%d-%H%M).log" 2>&1 &
fi

# 5. System integrity check with custom script
echo "[$DATE] Running system integrity check..." >> "$LOG_FILE"
~/.security-monitoring/integrity-check.sh >> "$LOG_FILE" 2>&1

# 6. DNS monitoring
echo "[$DATE] Testing DNS resolution..." >> "$LOG_FILE"
doggo google.com @8.8.8.8 >> "$LOG_FILE" 2>&1

echo "[$DATE] Security monitoring scan initiated (background processes running)" >> "$LOG_FILE"
echo "===========================================" >> "$LOG_FILE"
EOF

    # Security command utility
    cat > "$CONFIG_DIR/security" << 'EOF'
#!/bin/bash
# Security Tools Quick Commands
# Easy-to-use commands for manual security checks

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
    echo -e "\n${BLUE}=== $1 ===${NC}"
}

case "$1" in
    "secrets")
        print_header "Secret Scanning"
        echo -e "${YELLOW}Scanning for secrets in current directory...${NC}"
        gitleaks detect --config ~/.gitleaks.toml --source . --verbose
        ;;
    
    "vulns")
        print_header "Vulnerability Scanning"
        echo -e "${YELLOW}Scanning for vulnerabilities...${NC}"
        trivy fs --config ~/.trivy.yaml .
        ;;
    
    "code")
        print_header "Code Security Analysis"
        echo -e "${YELLOW}Analyzing code for security issues...${NC}"
        semgrep --config ~/.semgrep.yml .
        ;;
    
    "network")
        print_header "Network Monitoring"
        echo -e "${YELLOW}Monitoring network for 30 seconds...${NC}"
        sudo bandwhich --raw --no-resolve | head -20
        ;;
    
    "dns")
        print_header "DNS Testing"
        echo -e "${YELLOW}Testing DNS resolution...${NC}"
        doggo google.com
        doggo github.com @1.1.1.1
        ;;
    
    "nmap")
        print_header "Network Scanning"
        echo -e "${YELLOW}Scanning local network...${NC}"
        # Get default gateway
        GATEWAY=$(route get default | grep gateway | awk '{print $2}')
        NETWORK=$(echo $GATEWAY | cut -d. -f1-3).0/24
        nmap -sn "$NETWORK" | grep -E "(Nmap scan report|Host is up)"
        ;;
    
    "monitor")
        print_header "Full Security Monitoring"
        echo -e "${YELLOW}Running comprehensive security monitoring...${NC}"
        ~/.security-monitoring/security-monitor.sh
        echo -e "${GREEN}Security monitoring started (check ~/.security-monitoring/security-scan.log)${NC}"
        ;;
    
    "logs")
        print_header "Security Logs"
        echo -e "${YELLOW}Recent security monitoring logs:${NC}"
        lnav ~/.security-monitoring/*.log
        ;;
        
    *)
        print_header "Security Tools Quick Commands"
        echo -e "${GREEN}Available commands:${NC}"
        echo -e "  ${YELLOW}security secrets${NC}   - Scan for secrets/credentials"
        echo -e "  ${YELLOW}security vulns${NC}     - Scan for vulnerabilities"
        echo -e "  ${YELLOW}security code${NC}      - Analyze code security"
        echo -e "  ${YELLOW}security network${NC}   - Monitor network activity"
        echo -e "  ${YELLOW}security dns${NC}       - Test DNS resolution"
        echo -e "  ${YELLOW}security nmap${NC}      - Scan local network"
        echo -e "  ${YELLOW}security monitor${NC}   - Run full monitoring"
        echo -e "  ${YELLOW}security logs${NC}      - View security logs"
        echo -e "\n${BLUE}Configuration files:${NC}"
        echo -e "  ~/.gitleaks.toml   - Secret scanning config"
        echo -e "  ~/.semgrep.yml     - Code analysis config"
        echo -e "  ~/.trivy.yaml      - Vulnerability scan config"
        ;;
esac
EOF

    # OverSight security response scripts (all versions)
    cat > "$CONFIG_DIR/oversight-proper.sh" << 'EOF'
#!/bin/bash
# OverSight Security Response Script with Proper Argument Handling
# Handles OverSight's specific argument format

LOG_FILE="$HOME/.security-monitoring/oversight-detailed.log"
TIMESTAMP=$(date)

# Initialize variables
DEVICE=""
EVENT=""
PROCESS_PID=""
ACTIVE_COUNT=""

# Parse OverSight arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --device)
            DEVICE="$2"
            shift 2
            ;;
        --event)
            EVENT="$2"
            shift 2
            ;;
        --process)
            PROCESS_PID="$2"
            shift 2
            ;;
        --activeCount)
            ACTIVE_COUNT="$2"
            shift 2
            ;;
        *)
            shift
            ;;
    esac
done

# Log the security alert with detailed information
echo "===========================================" >> "$LOG_FILE"
echo "$TIMESTAMP: OVERSIGHT SECURITY ALERT" >> "$LOG_FILE"
echo "Device: $DEVICE" >> "$LOG_FILE"
echo "Event: $EVENT" >> "$LOG_FILE"
echo "Process PID: $PROCESS_PID" >> "$LOG_FILE"
echo "Active Device Count: $ACTIVE_COUNT" >> "$LOG_FILE"
echo "===========================================" >> "$LOG_FILE"

# Get process name from PID
if [[ -n "$PROCESS_PID" ]]; then
    PROCESS_NAME=$(ps -p "$PROCESS_PID" -o comm= 2>/dev/null || echo "Unknown")
    PROCESS_DETAILS=$(ps -p "$PROCESS_PID" -o pid,ppid,comm,args 2>/dev/null || echo "Process not found")
    echo "$TIMESTAMP: Process Details:" >> "$LOG_FILE"
    echo "$PROCESS_DETAILS" >> "$LOG_FILE"
else
    PROCESS_NAME="Unknown"
fi

# Show notification with specific details
osascript -e "display notification \"$DEVICE access: $EVENT by PID $PROCESS_PID ($PROCESS_NAME)\" with title \"OverSight Security Alert\""

# Enhanced security response based on event type
if [[ "$EVENT" == "on" ]]; then
    echo "$TIMESTAMP: Device activation detected - running security scans..." >> "$LOG_FILE"
    
    # Quick network scan (background)
    echo "$TIMESTAMP: Active network connections:" >> "$LOG_FILE"
    lsof -i -n | grep -E "(ESTABLISHED|LISTEN)" >> "$LOG_FILE" 2>/dev/null
    
    # Check for suspicious processes
    echo "$TIMESTAMP: Current running processes:" >> "$LOG_FILE"
    ps aux | head -15 >> "$LOG_FILE"
    
    # If camera is activated, take extra security measures
    if [[ "$DEVICE" == "camera" ]]; then
        echo "$TIMESTAMP: CAMERA ACTIVATION - Enhanced security scan initiated" >> "$LOG_FILE"
        # Run secret scan in background
        gitleaks detect --source "$HOME" --no-git --verbose >> "$LOG_FILE" 2>&1 &
    fi
    
elif [[ "$EVENT" == "off" ]]; then
    echo "$TIMESTAMP: Device deactivation - $DEVICE turned off by $PROCESS_NAME" >> "$LOG_FILE"
fi

# Log active device status
if [[ "$ACTIVE_COUNT" -gt 0 ]]; then
    echo "$TIMESTAMP: WARNING - $ACTIVE_COUNT device(s) still active" >> "$LOG_FILE"
else
    echo "$TIMESTAMP: All devices deactivated" >> "$LOG_FILE"
fi

echo "$TIMESTAMP: Security response completed" >> "$LOG_FILE"
echo "===========================================" >> "$LOG_FILE"
EOF

    # Network and integrity monitoring scripts
    cat > "$CONFIG_DIR/network-monitor.sh" << 'EOF'
#!/bin/bash
# Simple network connection monitor
log_file="$HOME/.security-monitoring/network.log"
echo "$(date): Network monitoring started" >> "$log_file"

while true; do
    # Log new connections
    lsof -i -n | grep ESTABLISHED | while read line; do
        echo "$(date): $line" >> "$log_file"
    done
    sleep 60
done
EOF

    cat > "$CONFIG_DIR/integrity-check.sh" << 'EOF'
#!/bin/bash
# Basic system integrity monitoring
log_file="$HOME/.security-monitoring/integrity.log"
echo "$(date): System integrity check started" >> "$log_file"

# Check for new launch agents/daemons
find /Library/Launch* /System/Library/Launch* ~/Library/Launch* -name "*.plist" -newer /tmp/last_integrity_check 2>/dev/null | while read file; do
    echo "$(date): New launch item detected: $file" >> "$log_file"
done

touch /tmp/last_integrity_check
EOF

    # Make all scripts executable
    chmod +x "$CONFIG_DIR"/*.sh
    chmod +x "$CONFIG_DIR/security"
    
    print_success "Security monitoring scripts created in $CONFIG_DIR"
}

update_shell_config() {
    print_info "Adding security command to shell configuration..."
    
    # Add to .zshrc if not already there
    if ! grep -q ".security-monitoring" ~/.zshrc 2>/dev/null; then
        echo 'export PATH="$HOME/.security-monitoring:$PATH"' >> ~/.zshrc
        print_success "Added security tools to PATH in ~/.zshrc"
    else
        print_info "Security tools already in PATH"
    fi
}

# ============================================================================
# PERIODIC MONITORING SETUP
# ============================================================================

setup_periodic_monitoring() {
    print_info "Setting up periodic security monitoring..."
    
    # Create periodic security scan script
    cat > "$CONFIG_DIR/periodic-security-scan.sh" << 'EOF'
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

# Function to clean HTML output
clean_html_output() {
    local input="$1"
    # Remove ANSI color codes
    local cleaned=$(echo "$input" | sed 's/\x1b\[[0-9;]*m//g')
    # Remove progress characters and symbols
    cleaned=$(echo "$cleaned" | sed 's/[│╲○░▪▫◦◯⚪⚫]/./g')
    # HTML escape special characters
    cleaned=$(echo "$cleaned" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')
    echo "$cleaned"
}

# Start HTML report
cat > "$REPORT_FILE" << HTML_START
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        <h1>&#x1F6E1;&#xFE0F; Security Scan Report</h1>
        <div class="timestamp">Generated: $TIMESTAMP</div>
        
        <div class="summary">
            <h2>&#x1F4CA; Scan Summary</h2>
            <ul id="summary-list">
HTML_START

# Initialize counters
SECRETS_FOUND=0
VULNS_FOUND=0
CODE_ISSUES=0

echo "[$TIMESTAMP] Starting periodic security scan..." >> "$MONITOR_DIR/periodic-scan.log"

# 1. SECRET SCANNING
echo "<li>&#x1F50D; Secret Scanning: " >> "$REPORT_FILE"
if command -v gitleaks &> /dev/null; then
    echo "Running secret scan..." >> "$MONITOR_DIR/periodic-scan.log"
    
    # Run gitleaks scan
    SECRETS_OUTPUT=$(gitleaks detect --config ~/.gitleaks.toml --source "$HOME/development" --no-git 2>&1 || true)
    SECRETS_COUNT=0
    if echo "$SECRETS_OUTPUT" | grep -q "Finding:"; then
        SECRETS_COUNT=$(echo "$SECRETS_OUTPUT" | grep -c "Finding:" 2>/dev/null || echo 0)
    fi
    
    if [[ "$SECRETS_COUNT" -gt 0 ]]; then
        echo "<span class='status-warning'>$SECRETS_COUNT secrets detected</span></li>" >> "$REPORT_FILE"
        SECRETS_FOUND=$SECRETS_COUNT
    else
        echo "<span class='status-good'>No secrets detected</span></li>" >> "$REPORT_FILE"
    fi
    
    # Add detailed results
    CLEAN_SECRETS_OUTPUT=$(clean_html_output "$SECRETS_OUTPUT")
    echo "<div class='scan-section'><h2>&#x1F510; Secret Scan Results</h2><pre>$CLEAN_SECRETS_OUTPUT</pre></div>" >> "$REPORT_FILE"
else
    echo "<span class='status-warning'>Gitleaks not available</span></li>" >> "$REPORT_FILE"
fi

# 2. VULNERABILITY SCANNING
echo "<li>&#x1F6E1;&#xFE0F; Vulnerability Scanning: " >> "$REPORT_FILE"
if command -v trivy &> /dev/null; then
    echo "Running vulnerability scan..." >> "$MONITOR_DIR/periodic-scan.log"
    
    # Run trivy scan
    VULNS_OUTPUT=$(trivy fs --config ~/.trivy.yaml "$HOME/development" 2>&1 || true)
    VULNS_COUNT=0
    if echo "$VULNS_OUTPUT" | grep -q -E "HIGH|CRITICAL"; then
        VULNS_COUNT=$(echo "$VULNS_OUTPUT" | grep -c -E "HIGH|CRITICAL" 2>/dev/null || echo 0)
    fi
    
    if [[ "$VULNS_COUNT" -gt 0 ]]; then
        echo "<span class='status-critical'>$VULNS_COUNT high/critical vulnerabilities</span></li>" >> "$REPORT_FILE"
        VULNS_FOUND=$VULNS_COUNT
    else
        echo "<span class='status-good'>No critical vulnerabilities</span></li>" >> "$REPORT_FILE"
    fi
    
    # Add detailed results
    CLEAN_VULNS_OUTPUT=$(clean_html_output "$VULNS_OUTPUT")
    echo "<div class='scan-section'><h2>&#x1F50D; Vulnerability Scan Results</h2><pre>$CLEAN_VULNS_OUTPUT</pre></div>" >> "$REPORT_FILE"
else
    echo "<span class='status-warning'>Trivy not available</span></li>" >> "$REPORT_FILE"
fi

# 3. CODE SECURITY ANALYSIS
echo "<li>&#x1F52C; Code Security Analysis: " >> "$REPORT_FILE"
if command -v semgrep &> /dev/null; then
    echo "Running code security analysis..." >> "$MONITOR_DIR/periodic-scan.log"
    
    # Run semgrep scan
    CODE_OUTPUT=$(semgrep --config ~/.semgrep.yml "$HOME/development" 2>&1 || true)
    CODE_COUNT=0
    if echo "$CODE_OUTPUT" | grep -q -E "ERROR|WARNING"; then
        CODE_COUNT=$(echo "$CODE_OUTPUT" | grep -c -E "ERROR|WARNING" 2>/dev/null || echo 0)
    fi
    
    if [[ "$CODE_COUNT" -gt 0 ]]; then
        echo "<span class='status-warning'>$CODE_COUNT security issues found</span></li>" >> "$REPORT_FILE"
        CODE_ISSUES=$CODE_COUNT
    else
        echo "<span class='status-good'>No security issues detected</span></li>" >> "$REPORT_FILE"
    fi
    
    # Add detailed results
    CLEAN_CODE_OUTPUT=$(clean_html_output "$CODE_OUTPUT")
    echo "<div class='scan-section'><h2>&#x1F52C; Code Security Analysis Results</h2><pre>$CLEAN_CODE_OUTPUT</pre></div>" >> "$REPORT_FILE"
else
    echo "<span class='status-warning'>Semgrep not available</span></li>" >> "$REPORT_FILE"
fi

# 4. NETWORK MONITORING
echo "<li>&#x1F310; Network Status: " >> "$REPORT_FILE"
NETWORK_OUTPUT=$(lsof -i -n | grep ESTABLISHED | head -10 2>/dev/null || echo "No established connections")
CONN_COUNT=$(lsof -i -n | grep ESTABLISHED | wc -l 2>/dev/null | tr -d ' ' || echo 0)
echo "<span class='status-good'>$CONN_COUNT active connections</span></li>" >> "$REPORT_FILE"
CLEAN_NETWORK_OUTPUT=$(clean_html_output "$NETWORK_OUTPUT")
echo "<div class='scan-section'><h2>&#x1F310; Network Connections</h2><pre>$CLEAN_NETWORK_OUTPUT</pre></div>" >> "$REPORT_FILE"

# Close summary list
echo "</ul></div>" >> "$REPORT_FILE"

# OVERALL SECURITY STATUS
TOTAL_ISSUES=$((SECRETS_FOUND + VULNS_FOUND + CODE_ISSUES))

if [[ $TOTAL_ISSUES -eq 0 ]]; then
    SECURITY_STATUS="<span class='status-good'>&#x2705; SECURE</span>"
    NOTIFICATION_TITLE="Security Scan: All Clear"
    NOTIFICATION_MESSAGE="No security issues detected in periodic scan"
elif [[ $TOTAL_ISSUES -le 5 ]]; then
    SECURITY_STATUS="<span class='status-warning'>&#x26A0;&#xFE0F; MINOR ISSUES</span>"
    NOTIFICATION_TITLE="Security Scan: Minor Issues"
    NOTIFICATION_MESSAGE="$TOTAL_ISSUES security issues detected - review recommended"
else
    SECURITY_STATUS="<span class='status-critical'>&#x1F6A8; ATTENTION REQUIRED</span>"
    NOTIFICATION_TITLE="Security Scan: Issues Detected"
    NOTIFICATION_MESSAGE="$TOTAL_ISSUES security issues detected - immediate review required"
fi

# Add security status to report
cat >> "$REPORT_FILE" << HTML_END
        <div class="summary">
            <h2>&#x1F3AF; Overall Security Status</h2>
            <h3>$SECURITY_STATUS</h3>
            <p>Total Issues Found: <strong>$TOTAL_ISSUES</strong></p>
            <ul>
                <li>Secrets: $SECRETS_FOUND</li>
                <li>Vulnerabilities: $VULNS_FOUND</li>
                <li>Code Issues: $CODE_ISSUES</li>
            </ul>
        </div>
        
        <div class="scan-section">
            <h2>&#x1F4CB; Recommendations</h2>
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

echo "Report generated: $REPORT_FILE"
EOF
    
    chmod +x "$CONFIG_DIR/periodic-security-scan.sh"
    
    # Create daily summary script
    cat > "$CONFIG_DIR/daily-security-summary.sh" << 'EOF'
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
    
    chmod +x "$CONFIG_DIR/daily-security-summary.sh"
    
    # Create launchd job files
    LAUNCHD_DIR="$HOME/Library/LaunchAgents"
    mkdir -p "$LAUNCHD_DIR"
    
    # Daily comprehensive security scan (9 AM)
    cat > "$LAUNCHD_DIR/com.security.daily-scan.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.security.daily-scan</string>
    <key>ProgramArguments</key>
    <array>
        <string>$CONFIG_DIR/periodic-security-scan.sh</string>
    </array>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>9</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>
    <key>StandardOutPath</key>
    <string>$CONFIG_DIR/daily-scan.log</string>
    <key>StandardErrorPath</key>
    <string>$CONFIG_DIR/daily-scan-error.log</string>
</dict>
</plist>
EOF
    
    # Evening summary (6 PM)
    cat > "$LAUNCHD_DIR/com.security.evening-summary.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.security.evening-summary</string>
    <key>ProgramArguments</key>
    <array>
        <string>$CONFIG_DIR/daily-security-summary.sh</string>
    </array>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>18</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>
    <key>StandardOutPath</key>
    <string>$CONFIG_DIR/summary.log</string>
    <key>StandardErrorPath</key>
    <string>$CONFIG_DIR/summary-error.log</string>
</dict>
</plist>
EOF
    
    # Weekly deep scan (Sunday 10 AM)
    cat > "$LAUNCHD_DIR/com.security.weekly-scan.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.security.weekly-scan</string>
    <key>ProgramArguments</key>
    <array>
        <string>$CONFIG_DIR/security-monitor.sh</string>
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
    <string>$CONFIG_DIR/weekly-scan.log</string>
    <key>StandardErrorPath</key>
    <string>$CONFIG_DIR/weekly-scan-error.log</string>
</dict>
</plist>
EOF
    
    # Create security scheduler management command
    cat > "$CONFIG_DIR/security-scheduler" << 'EOF'
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
        ls -la "$MONITOR_DIR/reports/" 2>/dev/null | head -10 || echo "No reports found"
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
    
    chmod +x "$CONFIG_DIR/security-scheduler"
    
    # Load the scheduled jobs
    launchctl load "$LAUNCHD_DIR/com.security.daily-scan.plist" 2>/dev/null || true
    launchctl load "$LAUNCHD_DIR/com.security.evening-summary.plist" 2>/dev/null || true
    launchctl load "$LAUNCHD_DIR/com.security.weekly-scan.plist" 2>/dev/null || true
    
    print_success "Periodic monitoring system configured and activated"
    print_info "Scheduled scans: Daily (9 AM), Evening Summary (6 PM), Weekly (Sunday 10 AM)"
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    print_header "🛡️ SECURITY TOOLS CONFIGURATION SETUP"
    
    log "Security configuration setup started by $(whoami)"
    
    print_info "Setting up comprehensive security tool configurations..."
    
    # Create all configurations
    create_gitleaks_config
    create_semgrep_config  
    create_trivy_config
    create_monitoring_scripts
    setup_periodic_monitoring
    update_shell_config
    
    print_header "🎉 SECURITY CONFIGURATION SETUP COMPLETE! 🎉"
    
    echo -e "${GREEN}✅ All security tool configurations have been created!${NC}"
    echo -e "${CYAN}📁 Configuration Files:${NC}"
    echo -e "   • ~/.gitleaks.toml - Secret detection configuration"
    echo -e "   • ~/.semgrep.yml - Code security analysis rules"
    echo -e "   • ~/.trivy.yaml - Vulnerability scanning settings"
    echo -e "   • ~/.security-monitoring/ - All monitoring scripts"
    echo -e ""
    echo -e "${CYAN}🚀 Quick Commands Available:${NC}"
    echo -e "   • ${YELLOW}security secrets${NC} - Scan for secrets"
    echo -e "   • ${YELLOW}security vulns${NC} - Vulnerability scan"
    echo -e "   • ${YELLOW}security monitor${NC} - Full security monitoring"
    echo -e ""
    echo -e "${CYAN}⏰ Periodic Monitoring:${NC}"
    echo -e "   • ${YELLOW}security-scheduler start${NC} - Start automated scans"
    echo -e "   • ${YELLOW}security-scheduler status${NC} - Check scheduler status"
    echo -e "   • ${YELLOW}security-scheduler test${NC} - Run test scan now"
    echo -e "   • ${YELLOW}security-scheduler reports${NC} - View recent reports"
    echo -e ""
    echo -e "${CYAN}📅 Automated Schedule:${NC}"
    echo -e "   • Daily Scan: 9:00 AM (comprehensive security scan + HTML report)"
    echo -e "   • Evening Summary: 6:00 PM (status notification)"
    echo -e "   • Weekly Deep Scan: Sunday 10:00 AM (full monitoring)"
    echo -e ""
    echo -e "${CYAN}🔧 OverSight Integration:${NC}"
    echo -e "   Use: ${YELLOW}~/.security-monitoring/oversight-proper.sh${NC}"
    echo -e "   (Don't forget to check 'Pass Arguments' in OverSight)"
    echo -e ""
    echo -e "${BLUE}💡 Restart your terminal or run: source ~/.zshrc${NC}"
    
    log "Security configuration setup completed successfully"
}

# Run the script
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi