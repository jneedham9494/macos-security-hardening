# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a macOS security hardening toolkit that provides enterprise-grade security configuration for development environments. The project consists of Bash scripts that automate SSH security, Git commit signing, firewall configuration, security tool installation, and system hardening.

## Core Scripts

### Primary Entry Points

1. **security-setup-consolidated.sh** (~970 lines) - Full-featured enterprise script
   - 11 menu options with comprehensive tool installation (79+ security tools)
   - Includes offensive security tools (metasploit, hashcat, etc.) for authorized testing
   - Creates security monitoring LaunchAgent for automated daily reports
   - Logs to `security-setup.log`

2. **security-setup.sh** (~550 lines) - Lightweight version for basic hardening
   - 9 menu options focused on essential security
   - Installs core security tools (9 CLI + 6 GUI apps)
   - Better for personal/development use without offensive tools
   - Logs to `security-setup.log`

### Specialized Scripts

3. **setup-security-configs.sh** (~35KB) - Comprehensive security tool configurations
   - Creates config files for trivy, nmap, GPG, etc.
   - Sets up secure defaults for all tools

4. **setup-periodic-monitoring.sh** (~20KB) - Automated security monitoring
   - LaunchAgent-based periodic security scans
   - HTML report generation

5. **email-password-security.sh** (~15KB) - Email and password security
   - Password manager configuration
   - Secure email setup

6. **shell-integration.sh** (~3KB) - Shell security aliases and functions
   - Adds security commands to .zshrc/.bashrc

7. **travel-security-prep.sh** (~15KB) - Travel security preparation
   - Device hardening for international travel
   - Temporary security profiles

**Usage Recommendations:**
- **Quick setup**: Use `security-setup.sh` for basic hardening
- **Full suite**: Use `security-setup-consolidated.sh` + specialized scripts
- **Travel**: Run `travel-security-prep.sh` before trips

### Script Architecture

All scripts follow this pattern:
- Bash with `set -euo pipefail` for strict error handling
- Utility functions for output (print_header, print_success, print_error, print_info, log)
- Component-based functions (setup_ssh_security, setup_git_security, etc.)
- Interactive menu system with numbered choices
- Logging to `security-setup.log` in the script directory

## Key Security Components

1. **SSH Security Hardening** - Generates Ed25519 and RSA-4096 keys, configures `~/.ssh/config` with secure ciphers
2. **Git Security & SSH Commit Signing** - Uses SSH keys for commit signing (modern alternative to GPG)
3. **Security Tools Installation** - CLI tools (nmap, bandwhich, trivy, semgrep, gitleaks) + GUI apps (KnockKnock, ReiKey, Oversight)
4. **Firewall & System Hardening** - macOS firewall configuration, secure defaults
5. **Development Environment Security** - Git hooks for secret scanning, secure npm config
6. **Privacy Configuration** - Disables telemetry and tracking
7. **Monitoring Setup** - Creates monitoring scripts in `~/.security-monitoring/`

## Important Technical Details

### SSH Configuration
- Uses Ed25519 (primary) and RSA-4096 (compatibility) keys
- SSH config at `~/.ssh/config` with secure ciphers and key exchange algorithms
- Proper permissions: 700 for .ssh/, 600 for private keys, 644 for public keys

### Git Commit Signing
- **Uses SSH-based signing, NOT GPG** (simpler, more modern approach)
- Configures `gpg.format ssh` and `user.signingkey ~/.ssh/id_ed25519.pub`
- Creates allowed signers file at `~/.config/git/allowed_signers`
- Sets `commit.gpgsign true` globally

### Environment Variables
- `USER_EMAIL` - Email for keys (defaults to `whoami@hostname` or `dev@example.com`)
- `GIT_USER_NAME` - Git user name (defaults to `whoami`, consolidated script only)
- `SSH_KEY_COMMENT` - Comment for SSH keys

### File Locations
- Logs: `./security-setup.log`, `./config-setup.log` (relative to script directory)
- SSH: `~/.ssh/` (keys and config)
- Git templates: `~/.git-templates/hooks/` (pre-commit hook for gitleaks)
- Monitoring: `~/.security-monitoring/` (network-monitor.sh, integrity-check.sh)
- Secrets: `~/.secrets/` (secure directory for development secrets)
- LaunchAgents: `~/Library/LaunchAgents/` (periodic monitoring plist)

### Documentation
- `docs/IPHONE-TRAVEL-SECURITY.md` - iPhone hardening for travel
- `docs/TRAVEL-SECURITY-STRATEGY.md` - Comprehensive travel security planning
- `docs/PERIODIC-MONITORING-COMPLETE.md` - Monitoring system documentation
- `docs/logs/SECURITY-SESSION-RESTART.md` - Session state checkpoint

## Common Development Commands

### Running Scripts
```bash
# Make executable
chmod +x scripts/*.sh

# Run interactively
./scripts/security-setup.sh                    # Lightweight version
./scripts/security-setup-consolidated.sh       # Full version

# Run with custom email
USER_EMAIL="custom@example.com" ./scripts/security-setup-consolidated.sh
```

### Testing Components
```bash
# Test SSH setup
ls -la ~/.ssh/
ssh-keygen -l -f ~/.ssh/id_ed25519.pub

# Test Git signing
git config --get gpg.format
git config --get user.signingkey

# Test security tools
nmap --version
trivy --version
gitleaks version
```

### Verification
```bash
# Check firewall
sudo pfctl -sr

# Check encryption
diskutil apfs list | grep FileVault

# View logs
tail -f security-setup.log
```

## Project Structure

```
macos-security-hardening/
├── scripts/                             # All executable scripts
│   ├── security-setup.sh                # Lightweight hardening (550 lines)
│   ├── security-setup-consolidated.sh   # Full enterprise script (970 lines)
│   ├── setup-security-configs.sh        # Tool configurations (35KB)
│   ├── setup-periodic-monitoring.sh     # Automated monitoring (20KB)
│   ├── email-password-security.sh       # Email/password security (15KB)
│   ├── shell-integration.sh             # Shell aliases/functions (3KB)
│   └── travel-security-prep.sh          # Travel preparation (15KB)
├── docs/                                # All documentation
│   ├── SECURITY-SETUP-README.md         # Comprehensive setup guide
│   ├── GITHUB-SETUP.md                  # Repository setup instructions
│   ├── IPHONE-TRAVEL-SECURITY.md        # iPhone travel hardening
│   ├── TRAVEL-SECURITY-STRATEGY.md      # Travel security planning
│   ├── PERIODIC-MONITORING-COMPLETE.md  # Monitoring documentation
│   └── logs/                            # Session logs
│       └── SECURITY-SESSION-RESTART.md  # Session checkpoint
├── README.md                            # User-facing documentation
├── CLAUDE.md                            # Project instructions
├── LICENSE                              # MIT License
└── .gitignore
```

## Code Style

- Bash scripts with strict mode (`set -euo pipefail`)
- Color-coded output using ANSI codes (RED, GREEN, YELLOW, BLUE, PURPLE, CYAN, NC)
- ASCII art headers for visual sections
- Functions organized in logical blocks with comment separators
- Comprehensive error handling and user confirmations
- No external dependencies except Homebrew

## Security Notes

- **Never commit actual keys or secrets** - all generated in user directories
- Scripts require admin privileges for system-level changes
- Always test on non-production systems first
- Scripts are idempotent (safe to run multiple times)
- Pre-commit hooks scan for secrets using gitleaks

## Git Workflow

- Main branch: `master` (legacy, should be `main`)
- Commits should be signed (automatically configured by script)
- No specific branching strategy required
- Project is open source (MIT License)

## Related Repositories

Per README, this project is part of a security toolkit suite:
- **Digital Privacy Management** - Complete digital identity management (separate repo)
- **Travel Security Toolkit** - International travel security (separate repo)
