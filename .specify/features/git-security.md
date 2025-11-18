# Feature: Git Security & SSH Commit Signing

## Status
Retroactive specification for existing feature - **IMPLEMENTED**

## Current Behavior
Configures Git with secure defaults and SSH-based commit signing (modern alternative to GPG). Creates allowed signers file and pre-commit hooks for secret scanning.

## Acceptance Criteria (Current State)

### Git Configuration
- GIVEN git config setup
  WHEN `setup_git_security` is executed
  THEN user.email is configured

- GIVEN git config setup
  WHEN `setup_git_security` is executed
  THEN user.name is configured (defaults to whoami)

- GIVEN git config setup
  WHEN `setup_git_security` is executed
  THEN init.defaultBranch is set to "main"

- GIVEN git config setup
  WHEN `setup_git_security` is executed
  THEN pull.rebase is enabled

### Security Settings
- GIVEN git security config
  WHEN setup completes
  THEN transfer.fsckObjects is enabled

- GIVEN git security config
  WHEN setup completes
  THEN fetch.fsckObjects is enabled

- GIVEN git security config
  WHEN setup completes
  THEN receive.fsckObjects is enabled

### SSH Commit Signing
- GIVEN commit signing setup
  WHEN setup completes
  THEN gpg.format is set to "ssh"

- GIVEN commit signing setup
  WHEN setup completes
  THEN user.signingkey points to Ed25519 public key

- GIVEN commit signing setup
  WHEN setup completes
  THEN commit.gpgsign is enabled

- GIVEN commit signing setup
  WHEN setup completes
  THEN tag.gpgsign is enabled

### Allowed Signers
- GIVEN allowed signers setup
  WHEN setup completes
  THEN ~/.config/git/allowed_signers exists

- GIVEN allowed signers setup
  WHEN setup completes
  THEN user email is in allowed signers

- GIVEN allowed signers setup
  WHEN setup completes
  THEN gpg.ssh.allowedSignersFile is configured

### Git Templates
- GIVEN git templates setup
  WHEN `secure_development_environment` is executed
  THEN ~/.git-templates/hooks exists

- GIVEN git templates setup
  WHEN setup completes
  THEN pre-commit hook is executable

- GIVEN git templates setup
  WHEN setup completes
  THEN pre-commit hook includes gitleaks

### Error Handling
- GIVEN no SSH key exists
  WHEN `setup_git_security` is executed
  THEN error is returned (non-zero exit)

### Idempotency
- GIVEN setup has run previously
  WHEN setup is run again
  THEN no errors occur and config remains valid

## Technical Implementation
- **Location**: `scripts/security-setup.sh:setup_git_security()`
- **Templates**: `scripts/security-setup.sh:secure_development_environment()`
- **Config output**: `~/.gitconfig`
- **Allowed signers**: `~/.config/git/allowed_signers`
- **Templates**: `~/.git-templates/hooks/`
- **Dependencies**: Git, SSH keys

## Test Coverage
- **File**: `tests/git_security.bats`
- **Tests**: 22 tests
- **Coverage**: Full (config, signing, templates, error handling)

## Known Issues / Tech Debt
- [ ] Consolidated script runs main() on source, preventing isolated testing
- [ ] No support for multiple signing keys

## Future Improvements
- [ ] Support for GPG signing as alternative
- [ ] Support for multiple developer identities
- [ ] Automatic signing key rotation
