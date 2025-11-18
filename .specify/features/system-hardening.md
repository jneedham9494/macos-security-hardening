# Feature: System Hardening

## Status
Retroactive specification for existing feature - **IMPLEMENTED**

## Current Behavior
Configures macOS security settings including firewall, Gatekeeper, screensaver lock, and various system-level protections.

## Acceptance Criteria (Current State)

### Firewall Configuration
- GIVEN macOS firewall
  WHEN `harden_system_security` is executed
  THEN firewall is enabled

- GIVEN macOS firewall
  WHEN `harden_system_security` is executed
  THEN stealth mode is enabled

### Gatekeeper
- GIVEN Gatekeeper settings
  WHEN `harden_system_security` is executed
  THEN Gatekeeper is enabled

### Screen Security
- GIVEN screensaver settings
  WHEN `harden_system_security` is executed
  THEN password is required immediately on wake

- GIVEN screensaver settings
  WHEN `harden_system_security` is executed
  THEN screensaver starts after 5 minutes

### Finder Security
- GIVEN Finder settings
  WHEN `harden_system_security` is executed
  THEN file extensions are shown

### SSH Server
- GIVEN remote login
  WHEN `harden_system_security` is executed
  THEN SSH server is disabled (for security)

### Automatic Updates
- GIVEN software update settings
  WHEN `harden_system_security` is executed
  THEN automatic updates are enabled

### FileVault
- GIVEN FileVault status
  WHEN `harden_system_security` is executed
  THEN user is prompted to enable FileVault if not active

## Technical Implementation
- **Location**: `scripts/security-setup.sh:harden_system_security()`
- **Commands**: `defaults write`, `sudo /usr/libexec/ApplicationFirewall/socketfilterfw`
- **Dependencies**: Admin privileges (sudo)

## Test Coverage
- **Coverage**: None (requires system modification)
- **Testing approach**: Manual testing only

## Known Issues / Tech Debt
- [x] Invalid command `--setloggingmode on` - FIXED
- [x] Dangerous `--setallowsigned off` removed - FIXED
- [ ] No rollback function
- [ ] No pre-check for current settings

## Future Improvements
- [ ] Add backup of current settings before modification
- [ ] Add rollback function
- [ ] Add dry-run mode
- [ ] Add granular control (don't disable SSH server for some users)
