# Project Constitution: macOS Security Hardening

## Purpose
Enterprise-grade macOS security configuration toolkit for development environments.

## Core Principles

### 1. Security First
- All configurations prioritize security over convenience
- Use modern cryptography (Ed25519, AES-256-GCM)
- Follow principle of least privilege
- Defense in depth approach

### 2. Idempotency
- All scripts must be safe to run multiple times
- Never overwrite existing keys or configurations without warning
- Check for existing state before making changes

### 3. Transparency
- Log all actions to timestamped log files
- Use color-coded output for clarity
- Explain what each action does before executing

## Code Standards

### Bash Script Structure
```bash
#!/bin/bash
set -euo pipefail

# Color definitions at top
RED='\033[0;31m'
# ... other colors

# Utility functions
log() { ... }
print_success() { ... }
print_error() { ... }

# Feature functions
setup_<feature>() { ... }

# Main entry
main() { ... }

# Guard for sourcing vs executing
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
```

### Function Conventions
- **Naming**: `snake_case` with verb prefixes (`setup_`, `configure_`, `install_`)
- **Size**: Maximum 100 lines per function
- **Documentation**: Comment blocks for each major function
- **Error handling**: Check command success, log errors, fail gracefully

### Output Standards
- `print_success`: Green checkmark for completed actions
- `print_error`: Red X for failures
- `print_warning`: Yellow for cautions
- `print_info`: Blue for informational messages
- `print_header`: ASCII art section headers

### File Organization
```
macos-security-hardening/
├── scripts/                      # All executable scripts
├── tests/                        # Bats test files
├── docs/                         # Documentation
├── digital-privacy-management/   # Privacy management toolkit
├── travel-security-toolkit/      # Travel security checklists
└── .specify/                     # SpecKit specifications
```

### Testing Standards
- Framework: bats-core
- Location: `tests/*.bats`
- Helpers: `tests/helpers/test_helper.bash`
- Coverage: All security-critical functions must have tests
- Isolation: Use mocks for sudo, brew, ssh-keygen

### Security Configurations

#### SSH
- Primary key: Ed25519
- Backup key: RSA-4096
- Permissions: 700 (.ssh), 600 (private), 644 (public)
- Config: Modern ciphers, MACs, key exchange

#### Git
- Signing: SSH-based (not GPG)
- Signing key: `~/.ssh/id_ed25519.pub`
- Allowed signers: `~/.config/git/allowed_signers`
- Pre-commit: gitleaks for secret scanning

#### System
- Firewall: Enabled, stealth mode
- FileVault: Encouraged
- SIP: Must remain enabled

### Documentation Standards
- README.md: User-facing quick start
- CLAUDE.md: AI assistant instructions
- docs/: Detailed guides and logs

### Git Workflow
- Commit format: Conventional commits
- Signing: All commits signed
- Messages: Explain "why" not "what"

### Environment Variables
- `USER_EMAIL`: Email for keys/git
- `GIT_USER_NAME`: Git committer name
- `SSH_KEY_COMMENT`: SSH key comment

### Dependencies
- Required: Homebrew
- Installed via scripts: security tools
- No external services required for core functionality

## Quality Gates

### Before Commit
- [ ] All tests pass (`bats tests/`)
- [ ] No hardcoded secrets
- [ ] Script is idempotent
- [ ] Error handling complete
- [ ] Logging implemented

### Before Release
- [ ] Documentation updated
- [ ] Tests cover new features
- [ ] Manual testing on clean system
- [ ] Security review completed

## Version History
- v1.0.0: Initial security hardening toolkit
- v1.1.0: Added bats-core test framework
