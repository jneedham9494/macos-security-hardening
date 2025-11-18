#!/usr/bin/env bats
# Tests for SSH security configuration
# Run with: bats tests/ssh_security.bats

load 'helpers/test_helper'

setup() {
    setup_test_environment
    mock_ssh_keygen
    disable_colors
    redirect_logs

    # Source the script functions
    source_script_functions "security-setup.sh"
}

teardown() {
    teardown_test_environment
}

# ============================================================================
# SSH DIRECTORY TESTS
# ============================================================================

@test "setup_ssh_security creates .ssh directory" {
    run setup_ssh_security

    [ -d "$TEST_SSH_DIR" ]
}

@test "setup_ssh_security sets .ssh directory permissions to 700" {
    run setup_ssh_security

    assert_dir_permissions "$TEST_SSH_DIR" "700"
}

# ============================================================================
# SSH KEY GENERATION TESTS
# ============================================================================

@test "setup_ssh_security generates Ed25519 key" {
    run setup_ssh_security

    [ -f "$TEST_SSH_DIR/id_ed25519" ]
    [ -f "$TEST_SSH_DIR/id_ed25519.pub" ]
}

@test "setup_ssh_security generates RSA key" {
    run setup_ssh_security

    [ -f "$TEST_SSH_DIR/id_rsa" ]
    [ -f "$TEST_SSH_DIR/id_rsa.pub" ]
}

@test "setup_ssh_security sets private key permissions to 600" {
    run setup_ssh_security

    assert_file_permissions "$TEST_SSH_DIR/id_ed25519" "600"
    assert_file_permissions "$TEST_SSH_DIR/id_rsa" "600"
}

@test "setup_ssh_security sets public key permissions to 644" {
    run setup_ssh_security

    assert_file_permissions "$TEST_SSH_DIR/id_ed25519.pub" "644"
    assert_file_permissions "$TEST_SSH_DIR/id_rsa.pub" "644"
}

@test "setup_ssh_security skips existing Ed25519 key" {
    # Create existing key
    echo "existing-key" > "$TEST_SSH_DIR/id_ed25519"

    run setup_ssh_security

    # Key should not be overwritten
    run cat "$TEST_SSH_DIR/id_ed25519"
    [ "$output" = "existing-key" ]
}

@test "setup_ssh_security skips existing RSA key" {
    # Create existing key
    echo "existing-rsa-key" > "$TEST_SSH_DIR/id_rsa"

    run setup_ssh_security

    # Key should not be overwritten
    run cat "$TEST_SSH_DIR/id_rsa"
    [ "$output" = "existing-rsa-key" ]
}

# ============================================================================
# SSH CONFIG TESTS
# ============================================================================

@test "setup_ssh_security creates SSH config file" {
    run setup_ssh_security

    [ -f "$TEST_SSH_DIR/config" ]
}

@test "setup_ssh_security sets config file permissions to 600" {
    run setup_ssh_security

    assert_file_permissions "$TEST_SSH_DIR/config" "600"
}

@test "SSH config contains AddKeysToAgent setting" {
    run setup_ssh_security

    assert_file_contains "$TEST_SSH_DIR/config" "AddKeysToAgent"
}

@test "SSH config contains secure ciphers" {
    run setup_ssh_security

    assert_file_contains "$TEST_SSH_DIR/config" "chacha20-poly1305"
    assert_file_contains "$TEST_SSH_DIR/config" "aes256-gcm"
}

@test "SSH config contains secure MACs" {
    run setup_ssh_security

    assert_file_contains "$TEST_SSH_DIR/config" "hmac-sha2-256"
    assert_file_contains "$TEST_SSH_DIR/config" "hmac-sha2-512"
}

@test "SSH config contains secure key exchange algorithms" {
    run setup_ssh_security

    assert_file_contains "$TEST_SSH_DIR/config" "curve25519-sha256"
}

@test "SSH config disables password authentication" {
    run setup_ssh_security

    assert_file_contains "$TEST_SSH_DIR/config" "PasswordAuthentication no"
}

@test "SSH config hashes known hosts" {
    run setup_ssh_security

    assert_file_contains "$TEST_SSH_DIR/config" "HashKnownHosts yes"
}

@test "SSH config includes GitHub host configuration" {
    run setup_ssh_security

    assert_file_contains "$TEST_SSH_DIR/config" "Host github.com"
}

@test "SSH config includes GitLab host configuration" {
    run setup_ssh_security

    assert_file_contains "$TEST_SSH_DIR/config" "Host gitlab.com"
}

# ============================================================================
# IDEMPOTENCY TESTS
# ============================================================================

@test "setup_ssh_security is idempotent (safe to run twice)" {
    run setup_ssh_security
    [ "$status" -eq 0 ]

    # Run again
    run setup_ssh_security
    [ "$status" -eq 0 ]

    # Config should still exist and be valid
    [ -f "$TEST_SSH_DIR/config" ]
    assert_file_permissions "$TEST_SSH_DIR/config" "600"
}
