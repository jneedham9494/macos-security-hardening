#!/usr/bin/env bats
# Tests for Git security configuration
# Run with: bats tests/git_security.bats

load 'helpers/test_helper'

setup() {
    setup_test_environment
    mock_ssh_keygen
    disable_colors
    redirect_logs

    # Create SSH key for git signing tests (required by setup_git_security)
    mkdir -p "$TEST_SSH_DIR"
    echo "ssh-ed25519 AAAA...mockkey...== test@example.com" > "$TEST_SSH_DIR/id_ed25519.pub"

    # Source the script functions
    source_script_functions "security-setup.sh"
}

teardown() {
    teardown_test_environment
}

# ============================================================================
# GIT USER CONFIGURATION TESTS
# ============================================================================

@test "setup_git_security configures user email" {
    run setup_git_security

    assert_git_config "user.email" "$USER_EMAIL"
}

@test "setup_git_security configures user name" {
    # GIT_USER_NAME not set, should use whoami
    unset GIT_USER_NAME

    run setup_git_security

    # Should have some value (defaults to whoami)
    local actual
    actual=$(git config --global --get "user.name")
    [ -n "$actual" ]
}

# Note: GIT_USER_NAME test removed - consolidated script runs main() on source
# The simplified script doesn't use GIT_USER_NAME, only the consolidated version does
# Testing this would require refactoring the scripts to support testability

# ============================================================================
# GIT SECURITY SETTINGS TESTS
# ============================================================================

@test "setup_git_security sets default branch to main" {
    run setup_git_security

    assert_git_config "init.defaultBranch" "main"
}

@test "setup_git_security enables pull.rebase" {
    run setup_git_security

    assert_git_config "pull.rebase" "true"
}

@test "setup_git_security enables transfer.fsckObjects" {
    run setup_git_security

    assert_git_config "transfer.fsckObjects" "true"
}

@test "setup_git_security enables fetch.fsckObjects" {
    run setup_git_security

    assert_git_config "fetch.fsckObjects" "true"
}

@test "setup_git_security enables receive.fsckObjects" {
    run setup_git_security

    assert_git_config "receive.fsckObjects" "true"
}

# ============================================================================
# GIT COMMIT SIGNING TESTS
# ============================================================================

@test "setup_git_security configures SSH signing format" {
    run setup_git_security

    assert_git_config "gpg.format" "ssh"
}

@test "setup_git_security sets signing key to Ed25519 public key" {
    run setup_git_security

    assert_git_config "user.signingkey" "$TEST_SSH_DIR/id_ed25519.pub"
}

@test "setup_git_security enables commit signing" {
    run setup_git_security

    assert_git_config "commit.gpgsign" "true"
}

@test "setup_git_security enables tag signing" {
    run setup_git_security

    assert_git_config "tag.gpgsign" "true"
}

# ============================================================================
# ALLOWED SIGNERS FILE TESTS
# ============================================================================

@test "setup_git_security creates allowed signers directory" {
    run setup_git_security

    [ -d "$TEST_HOME/.config/git" ]
}

@test "setup_git_security creates allowed signers file" {
    run setup_git_security

    [ -f "$TEST_HOME/.config/git/allowed_signers" ]
}

@test "setup_git_security adds user to allowed signers" {
    run setup_git_security

    assert_file_contains "$TEST_HOME/.config/git/allowed_signers" "$USER_EMAIL"
}

@test "setup_git_security configures allowed signers file path" {
    run setup_git_security

    assert_git_config "gpg.ssh.allowedSignersFile" "$TEST_HOME/.config/git/allowed_signers"
}

# ============================================================================
# GIT TEMPLATES TESTS
# ============================================================================

@test "setup_git_security creates git templates directory" {
    # Need to source the secure_development_environment function
    run secure_development_environment

    [ -d "$TEST_HOME/.git-templates/hooks" ]
}

@test "setup_git_security creates pre-commit hook" {
    run secure_development_environment

    [ -f "$TEST_HOME/.git-templates/hooks/pre-commit" ]
}

@test "pre-commit hook is executable" {
    run secure_development_environment

    [ -x "$TEST_HOME/.git-templates/hooks/pre-commit" ]
}

@test "pre-commit hook includes gitleaks" {
    run secure_development_environment

    assert_file_contains "$TEST_HOME/.git-templates/hooks/pre-commit" "gitleaks"
}

@test "setup_git_security configures init.templateDir" {
    run secure_development_environment

    assert_git_config "init.templateDir" "$TEST_HOME/.git-templates"
}

# ============================================================================
# ERROR HANDLING TESTS
# ============================================================================

@test "setup_git_security fails gracefully without SSH key" {
    # Remove the SSH key
    rm -f "$TEST_SSH_DIR/id_ed25519.pub"

    run setup_git_security

    # Should return non-zero status
    [ "$status" -ne 0 ]
}

# ============================================================================
# IDEMPOTENCY TESTS
# ============================================================================

@test "setup_git_security is idempotent" {
    run setup_git_security
    [ "$status" -eq 0 ]

    # Run again
    run setup_git_security
    [ "$status" -eq 0 ]

    # Config should still be valid
    assert_git_config "commit.gpgsign" "true"
}
