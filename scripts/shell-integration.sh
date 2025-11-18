#!/bin/bash
# Shell Integration for Periodic Security Monitoring
# Adds enhanced security commands to your shell

echo "🛡️ Adding security monitoring integration to your shell..."

# Add enhanced security commands to .zshrc
cat >> ~/.zshrc << 'EOF'

# ============================================================================
# SECURITY MONITORING INTEGRATION
# ============================================================================

# Enhanced security commands with reporting
alias security-secrets='echo "🔍 Running secret scan..." && ~/.security-monitoring/periodic-security-scan.sh && echo "📊 Report generated in ~/.security-monitoring/reports/"'
alias security-vulns='echo "🛡️ Running vulnerability scan..." && trivy fs --config ~/.trivy.yaml "$HOME/development"'
alias security-monitor='echo "🔬 Running full security monitoring..." && ~/.security-monitoring/security-monitor.sh'
alias security-logs='echo "📝 Recent security logs:" && tail -20 ~/.security-monitoring/*.log'

# Quick security status
alias security-status='echo "🛡️ Security Status:" && security-scheduler status && echo "" && echo "📊 Recent Activity:" && tail -5 ~/.security-monitoring/periodic-scan.log 2>/dev/null || echo "No recent activity"'

# Open latest security report
alias security-report='LATEST=$(ls -t ~/.security-monitoring/reports/*.html 2>/dev/null | head -1); if [[ -n "$LATEST" ]]; then echo "📊 Opening latest report..." && open "$LATEST"; else echo "❌ No reports found - run security-scheduler test"; fi'

# Security dashboard
alias security-dashboard='echo "🛡️ Security Dashboard" && echo "===================" && security-scheduler status && echo "" && echo "📊 Latest Reports:" && ls -t ~/.security-monitoring/reports/*.html 2>/dev/null | head -3 | sed "s|$HOME|~|g" || echo "No reports found"'

EOF

echo "✅ Shell integration added to ~/.zshrc"
echo ""
echo "🔄 To activate new commands, run: source ~/.zshrc"
echo ""
echo "🛠️ New Commands Available:"
echo "   • security-secrets  - Quick secret scan with report"  
echo "   • security-vulns    - Vulnerability scan"
echo "   • security-monitor  - Full monitoring scan"
echo "   • security-logs     - View recent logs"
echo "   • security-status   - Check scheduler status"
echo "   • security-report   - Open latest report"
echo "   • security-dashboard - Security overview"
echo ""
echo "📅 Automated Schedule:"
echo "   • Daily: 9:00 AM (comprehensive scan + HTML report)"
echo "   • Evening: 6:00 PM (status notification)" 
echo "   • Weekly: Sunday 10:00 AM (full monitoring)"