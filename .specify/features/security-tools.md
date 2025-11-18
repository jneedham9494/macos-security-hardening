# Feature: Security Tools Installation

## Status
Retroactive specification for existing feature - **IMPLEMENTED**

## Current Behavior
Installs comprehensive suite of security tools via Homebrew, including CLI tools for scanning/analysis and GUI applications for monitoring. Two versions: lightweight (15 tools) and enterprise (79+ tools).

## Acceptance Criteria (Current State)

### Homebrew Verification
- GIVEN Homebrew is installed
  WHEN `check_homebrew` is executed
  THEN success is returned

- GIVEN Homebrew is not installed
  WHEN `check_homebrew` is executed
  THEN error is returned with install instructions

### Lightweight Installation (security-setup.sh)
- GIVEN Homebrew is available
  WHEN `install_security_tools` is executed
  THEN core CLI tools are installed (nmap, trivy, gitleaks, semgrep)

- GIVEN Homebrew is available
  WHEN `install_security_tools` is executed
  THEN GUI apps are installed (KnockKnock, ReiKey, OverSight)

### Enterprise Installation (security-setup-consolidated.sh)
- GIVEN Homebrew is available
  WHEN `install_security_tools` is executed
  THEN all CLI tools are installed (79+ tools)

- GIVEN Homebrew is available
  WHEN `install_security_tools` is executed
  THEN offensive tools are installed (metasploit, hashcat, john)

### Tool Categories

#### Network Analysis
- nmap, masscan, bandwhich, dog

#### Vulnerability Scanning
- trivy, grype, semgrep, osv-scanner

#### Secret Detection
- gitleaks, trufflehog, detect-secrets

#### Forensics
- volatility, binwalk, foremost

#### Password Auditing
- hashcat, john, hydra

#### Monitoring Apps
- KnockKnock, ReiKey, OverSight, LuLu

### Error Handling
- GIVEN tool installation fails
  WHEN error occurs
  THEN error is logged and script continues

- GIVEN cask is not available
  WHEN installation attempted
  THEN warning is logged

## Technical Implementation
- **Location**: `scripts/security-setup.sh:install_security_tools()`
- **Location**: `scripts/security-setup-consolidated.sh:install_security_tools()`
- **Package manager**: Homebrew
- **Dependencies**: Xcode Command Line Tools

## Test Coverage
- **File**: `tests/utilities.bats`
- **Tests**: 2 tests (check_homebrew)
- **Coverage**: Partial (no full installation tests due to system modification)

## Known Issues / Tech Debt
- [ ] No version pinning for tools
- [ ] No uninstall/cleanup function
- [ ] Duplicate tool in list (nmap appeared twice - fixed)

## Future Improvements
- [ ] Add tool version management
- [ ] Add selective installation by category
- [ ] Add update/upgrade function
- [ ] Add tool verification after install
