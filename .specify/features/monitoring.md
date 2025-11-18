# Feature: Security Monitoring

## Status
Retroactive specification for existing feature - **IMPLEMENTED**

## Current Behavior
Creates monitoring scripts and LaunchAgent for automated security scanning. Generates HTML reports on network connections, file integrity, and system state.

## Acceptance Criteria (Current State)

### Monitoring Directory
- GIVEN monitoring setup
  WHEN `setup_monitoring` is executed
  THEN ~/.security-monitoring directory is created

### Network Monitor Script
- GIVEN monitoring setup
  WHEN setup completes
  THEN network-monitor.sh is created

- GIVEN network monitor script
  WHEN script is created
  THEN file is executable

### Integrity Check Script
- GIVEN monitoring setup
  WHEN setup completes
  THEN integrity-check.sh is created

- GIVEN integrity check script
  WHEN script is created
  THEN file is executable

### LaunchAgent (Consolidated Script)
- GIVEN periodic monitoring setup
  WHEN `setup_periodic_monitoring.sh` is executed
  THEN LaunchAgent plist is created

- GIVEN LaunchAgent plist
  WHEN created
  THEN $HOME variable is expanded correctly

- GIVEN LaunchAgent
  WHEN loaded
  THEN runs daily at configured time

### Report Generation
- GIVEN monitoring runs
  WHEN scan completes
  THEN HTML report is generated

- GIVEN HTML report
  WHEN generated
  THEN includes network connections, running processes, file changes

## Technical Implementation
- **Location**: `scripts/security-setup.sh:setup_monitoring()`
- **Location**: `scripts/setup-periodic-monitoring.sh`
- **Output**: `~/.security-monitoring/`
- **LaunchAgent**: `~/Library/LaunchAgents/com.security.monitoring.plist`
- **Dependencies**: bandwhich, lnav (optional)

## Test Coverage
- **File**: `tests/utilities.bats`
- **Tests**: 4 tests
- **Coverage**: Partial (directory/script creation)

## Known Issues / Tech Debt
- [x] LaunchAgent plist $HOME not expanding - FIXED (heredoc quote issue)
- [ ] No log rotation
- [ ] Reports can grow large

## Future Improvements
- [ ] Add report archiving/rotation
- [ ] Add alerting for critical findings
- [ ] Add email notification option
- [ ] Add integration with SIEM
