# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a comprehensive digital privacy and identity management system implementing military-grade operational security through compartmentalized identity domains. The project manages migration from legacy services (primarily Gmail/Google ecosystem) to a privacy-focused, domain-segmented architecture.

## Core Architecture

### Identity Compartmentalization Model

The system implements **5 isolated security domains**, each with separate email addresses, password management, and authentication levels:

1. **Personal/Social Domain** - Social media, entertainment, personal shopping
2. **Financial/Banking Domain** - Banking, investments, credit cards, crypto exchanges
3. **Professional/Work Domain** - Corporate email, LinkedIn, work tools
4. **Travel/Temporary Domain** - Disposable accounts for temporary use
5. **High-Security/Crypto Domain** - Cryptocurrency wallets, secure communications

**Critical principle**: Domains must NEVER cross-contaminate. Each domain uses distinct email addresses, browsers/profiles, and authentication methods.

### Email Strategy

- **Personal**: ProtonMail (Swiss privacy laws)
- **Financial**: Tutanota (German privacy laws, zero-knowledge)
- **Professional**: Corporate email (work-managed)
- **Travel**: Guerrilla Mail or disposable services
- **High-Security**: ProtonMail + Tutanota dual-setup

### Password Management Hierarchy

Three-tier architecture:

1. **Tier 1 (Master Vault)**: Bitwarden Business - Financial, crypto, primary emails
2. **Tier 2 (Daily Vault)**: 1Password Personal - Social, shopping, low-risk services
3. **Tier 3 (Disposable)**: Browser/device storage - Travel accounts, temporary services

## Directory Structure

```
digital-privacy-management/
├── docs/                    # Strategy documents and analysis
│   ├── STRATEGY.md         # Complete compartmentalization strategy
│   └── [analysis docs]     # Phone apps, travel risks, migration plans
├── projects/               # 8 independent privacy projects
│   ├── 01-legacy-gmail-cleanup/     # Google ecosystem migration (HIGH PRIORITY)
│   ├── 02-data-broker-removal/      # Remove from data broker sites
│   ├── 03-social-media-hardening/   # Lock down social media privacy
│   ├── 04-financial-privacy/        # Secure financial accounts
│   ├── 05-browser-device-hardening/ # Browser privacy settings
│   ├── 06-subscription-audit/       # Cancel unnecessary subscriptions
│   ├── 07-phone-migration/          # Privacy-first phone setup
│   └── 08-ongoing-monitoring/       # Continuous security monitoring
├── scripts/                # Bash automation scripts (30+ scripts)
│   ├── 1password-*.sh     # Password manager setup and migration
│   ├── account-*.sh       # Account discovery and categorization
│   ├── email-*.sh         # Email migration workflows
│   └── *-app-*.sh         # Phone app analysis and migration
├── domains/                # Domain-specific management files
│   ├── personal/
│   ├── financial/
│   ├── professional/
│   ├── travel/
│   └── high-security/
├── phoneapps/              # Phone app analysis and migration data
├── templates/              # Email templates and configurations
├── tools/                  # Specialized privacy tools
└── monitoring/             # Breach alerts and monitoring
```

## Project Workflow

### Project Dependencies & Timeline

**Phase 1 (Weeks 1-4)**: Foundation cleanup
- Project 01 (gmail cleanup) - **MUST complete first** - blocks Project 04
- Projects 02-03 can run in parallel

**Phase 2 (Weeks 3-6)**: Technical hardening
- Projects 04-06 (independent after Phase 1)

**Phase 3 (When ready)**: New device setup
- Project 07 (phone migration) - **Requires Phase 1 complete**
- Project 08 (monitoring) - Final step

### Current Status
- Account migration to new emails: **COMPLETE** ✅
- Ready for cleanup phase (Projects 01-03)

## Script Conventions

All bash scripts follow this pattern:

1. **Shebang and safety**: `#!/bin/bash` with `set -euo pipefail`
2. **Color definitions**: Consistent color scheme (RED/GREEN/YELLOW/BLUE/CYAN/PURPLE)
3. **Logging**: All actions logged to `$HOME/.email-safety-net/*.log`
4. **Print functions**: `print_header()`, `print_success()`, `print_info()`, `print_action()`, `print_warning()`
5. **User confirmation**: Interactive prompts before destructive operations
6. **Comprehensive output**: Detailed status messages and next steps

### Script Naming Convention
- `1password-*.sh` - Password manager operations
- `*-migration.sh` - Account migration workflows
- `*-setup.sh` - Initial configuration scripts
- `*-analysis.sh` - Discovery and audit scripts
- `*-strategy.sh` - Planning and strategy generation

## Key Files

- `scripts/accounts.csv` - Master account inventory (24,000+ line CSV)
- `scripts/*-app-*.sh` - Phone app analysis scripts
- `docs/STRATEGY.md` - Complete identity compartmentalization strategy
- `projects/README.md` - Master project overview with timeline

## Security Principles

When working with this codebase:

1. **Never mix domains** - Maintain strict separation between identity domains
2. **Validate before deletion** - All cleanup scripts must verify backups before destructive operations
3. **Log everything** - Comprehensive audit trails for all security operations
4. **Privacy-first** - Always prefer privacy-preserving alternatives (ProtonMail over Gmail, etc.)
5. **Recovery planning** - Every security measure requires documented recovery procedures
6. **Encryption by default** - Sensitive data must be encrypted at rest and in transit

## Common Development Tasks

### Creating New Scripts

Scripts should:
- Follow the print function convention (see existing scripts for reference)
- Log to `$HOME/.email-safety-net/[script-name].log`
- Include user confirmations before making changes
- Provide clear next steps at completion
- Handle errors gracefully with informative messages

### Working with Projects

Each project directory contains:
- `README.md` - Complete project guide with detailed checklist
- `scripts/` - Project-specific automation (if applicable)
- `templates/` - Email templates and forms (if applicable)
- `tracking/` - Progress tracking files (if applicable)

### Account Migration Pattern

Standard workflow across all account migrations:
1. Discover accounts (audit scripts)
2. Categorize by domain (categorization scripts)
3. Update to new email (migration scripts)
4. Verify access with new credentials
5. Remove old email from account
6. Document in password manager (appropriate vault tier)

## Testing and Validation

- Scripts output detailed status information - manually verify each step
- Check log files in `$HOME/.email-safety-net/` after script execution
- Always test email forwarding and account access after migration
- Verify backup integrity before deleting any data

## Important Notes

- This is a **personal security project** - treat all information as highly sensitive
- The Google/Gmail cleanup (Project 01) is **HIGH RISK** and irreversible once account is deleted
- Phone migration (Project 07) should only begin after email migration is stable
- Scripts assume macOS environment (may need adaptation for Linux)
