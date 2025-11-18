# Improvement Roadmap

## Overview
Prioritized list of improvements for the macOS Security Hardening toolkit.

---

## Phase 1: Critical Fixes (Completed)
**Status: ✅ DONE**

### Security Issues Fixed
- [x] LaunchAgent plist $HOME variable not expanding
- [x] Invalid macOS command `--setloggingmode on`
- [x] Dangerous `--setallowsigned off` removed
- [x] Empty SSH passphrases allowed
- [x] Duplicate nmap in tool list

### Testing Infrastructure
- [x] Added bats-core test framework
- [x] 62 tests covering SSH, Git, utilities
- [x] Test isolation with mocks

---

## Phase 2: Testing Improvements (Next)
**Priority: High**
**Effort: Medium**

### Goals
1. Increase test coverage from 55% to 80%
2. Add CI/CD integration
3. Improve testability of scripts

### Tasks
- [ ] **Add GitHub Actions workflow** for automated testing
  - Run `bats tests/` on every PR
  - Require passing tests before merge

- [ ] **Add tests for configure_browser_security**
  - Mock `defaults` command
  - Verify browser security settings

- [ ] **Add tests for configure_privacy_settings**
  - Mock `defaults` command
  - Verify privacy configurations

- [ ] **Refactor scripts for testability**
  - Prevent `main()` from running on source
  - Add guard: `if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then`

- [ ] **Add ShellCheck linting**
  - Add to CI workflow
  - Fix any warnings

---

## Phase 3: Feature Enhancements
**Priority: Medium**
**Effort: High**

### SSH Improvements
- [ ] **Hardware key support (YubiKey)**
  - Detect YubiKey presence
  - Configure for FIDO2/SSH

- [ ] **SSH certificate authority support**
  - For enterprise environments

- [ ] **Key rotation reminders**
  - Track key age
  - Remind after 1 year

### Git Improvements
- [ ] **Multiple developer identities**
  - Support work/personal separation
  - Directory-based git config

- [ ] **GPG signing as alternative**
  - For users who prefer GPG

### Tool Management
- [ ] **Version pinning**
  - Lock tool versions for reproducibility

- [ ] **Selective installation by category**
  - `--category network` for network tools only

- [ ] **Update/upgrade function**
  - `./scripts/security-setup.sh --update`

- [ ] **Tool verification**
  - Verify checksums after install

---

## Phase 4: Operational Improvements
**Priority: Medium**
**Effort: Medium**

### System Hardening
- [ ] **Backup current settings**
  - Save state before modification
  - Enable rollback

- [ ] **Dry-run mode**
  - Show what would change without changing

- [ ] **Granular control**
  - Don't disable SSH server if user needs it
  - Per-setting override

### Monitoring
- [ ] **Log rotation**
  - Prevent logs from growing unbounded
  - Archive old reports

- [ ] **Alerting**
  - Email on critical findings
  - Integration with notification center

- [ ] **SIEM integration**
  - Export in standard formats
  - Syslog support

---

## Phase 5: Enterprise Features
**Priority: Low**
**Effort: High**

### Deployment
- [ ] **Configuration profiles (mobileconfig)**
  - For MDM deployment

- [ ] **Silent/unattended mode**
  - No interactive prompts

- [ ] **Central reporting**
  - Send security status to central server

### Compliance
- [ ] **CIS benchmark alignment**
  - Map settings to CIS macOS benchmarks

- [ ] **Compliance reporting**
  - Generate compliance report

- [ ] **Audit logging**
  - Detailed logs for audit

---

## Phase 6: Documentation
**Priority: Low**
**Effort: Low**

### User Documentation
- [ ] **Video tutorials**
  - Installation walkthrough
  - Feature explanations

- [ ] **FAQ section**
  - Common questions and answers

### Developer Documentation
- [ ] **Contributing guide**
  - How to add new features

- [ ] **Architecture overview**
  - How scripts are organized

---

## Backlog (Unprioritized)

### Travel Security
- [ ] Travel profile templates (high/medium/low risk)
- [ ] Automated backup before travel
- [ ] Duress mode / decoy profile
- [ ] Border crossing logging

### Nice to Have
- [ ] Web UI for configuration
- [ ] Configuration diff tool
- [ ] System integrity verification
- [ ] Baseline comparison tool

---

## Timeline Estimate

| Phase | Timeframe | Dependencies |
|-------|-----------|--------------|
| Phase 2 | 1-2 weeks | None |
| Phase 3 | 2-4 weeks | Phase 2 |
| Phase 4 | 2-3 weeks | None |
| Phase 5 | 4-6 weeks | Phase 3, 4 |
| Phase 6 | Ongoing | None |

---

## Success Metrics

- Test coverage > 80%
- CI/CD passing on all PRs
- No critical security issues
- < 5 minute setup time for new users
- Documentation covers all features
