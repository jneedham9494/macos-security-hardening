# Feature: SSH Security Hardening

## Status
Retroactive specification for existing feature - **IMPLEMENTED**

## Current Behavior
Generates secure SSH keys (Ed25519 primary, RSA-4096 backup) and configures SSH client with modern, secure defaults including strict cipher suites, key exchange algorithms, and host-specific configurations.

## Acceptance Criteria (Current State)

### Key Generation
- GIVEN a system without SSH keys
  WHEN `setup_ssh_security` is executed
  THEN Ed25519 and RSA-4096 key pairs are generated

- GIVEN existing SSH keys
  WHEN `setup_ssh_security` is executed
  THEN existing keys are preserved (not overwritten)

- GIVEN key generation
  WHEN user is prompted for passphrase
  THEN passphrase is required (not empty)

### Permissions
- GIVEN .ssh directory
  WHEN setup completes
  THEN directory has 700 permissions

- GIVEN private keys
  WHEN setup completes
  THEN files have 600 permissions

- GIVEN public keys
  WHEN setup completes
  THEN files have 644 permissions

### SSH Config
- GIVEN SSH config creation
  WHEN config is written
  THEN modern ciphers are specified (chacha20-poly1305, aes256-gcm)

- GIVEN SSH config creation
  WHEN config is written
  THEN secure MACs are specified (hmac-sha2-256, hmac-sha2-512)

- GIVEN SSH config creation
  WHEN config is written
  THEN password authentication is disabled

- GIVEN SSH config creation
  WHEN config is written
  THEN known hosts are hashed

- GIVEN GitHub/GitLab access
  WHEN config is written
  THEN host-specific configs exist for both

### Idempotency
- GIVEN setup has run previously
  WHEN setup is run again
  THEN no errors occur and config remains valid

## Technical Implementation
- **Location**: `scripts/security-setup.sh:setup_ssh_security()`
- **Config output**: `~/.ssh/config`
- **Key output**: `~/.ssh/id_ed25519`, `~/.ssh/id_rsa`
- **Dependencies**: OpenSSH (system)

## Test Coverage
- **File**: `tests/ssh_security.bats`
- **Tests**: 19 tests
- **Coverage**: Full (key gen, permissions, config content)

## Known Issues / Tech Debt
- [ ] No support for custom key paths
- [ ] No key rotation guidance

## Future Improvements
- [ ] Add hardware key support (YubiKey)
- [ ] Add SSH certificate authority support
- [ ] Add key expiration reminders
