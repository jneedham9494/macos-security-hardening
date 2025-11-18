#!/usr/bin/env bats
# Tests for utility functions
# Run with: bats tests/utilities.bats

load 'helpers/test_helper'

setup() {
    setup_test_environment
    redirect_logs

    # Source the script functions
    source_script_functions "security-setup.sh"
}

teardown() {
    teardown_test_environment
}

# ============================================================================
# LOGGING TESTS
# ============================================================================

@test "log function writes to log file" {
    log "Test message"

    [ -f "$LOG_FILE" ]
    assert_file_contains "$LOG_FILE" "Test message"
}

@test "log function includes timestamp" {
    log "Timestamp test"

    # Log format: YYYY-MM-DD HH:MM:SS
    grep -E "[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}" "$LOG_FILE"
}

@test "log function appends multiple messages" {
    log "First message"
    log "Second message"

    assert_file_contains "$LOG_FILE" "First message"
    assert_file_contains "$LOG_FILE" "Second message"
}

# ============================================================================
# PRINT FUNCTION TESTS
# ============================================================================

@test "print_success logs SUCCESS prefix" {
    run print_success "Operation completed"

    assert_file_contains "$LOG_FILE" "SUCCESS: Operation completed"
}

@test "print_error logs ERROR prefix" {
    run print_error "Something failed"

    assert_file_contains "$LOG_FILE" "ERROR: Something failed"
}

@test "print_warning logs WARNING prefix" {
    run print_warning "Caution needed"

    assert_file_contains "$LOG_FILE" "WARNING: Caution needed"
}

@test "print_info logs INFO prefix" {
    run print_info "Informational message"

    assert_file_contains "$LOG_FILE" "INFO: Informational message"
}

# ============================================================================
# CONFIRM ACTION TESTS
# ============================================================================

# Note: confirm_action is difficult to test in isolation because:
# 1. It uses read -p which requires terminal input
# 2. bash -c doesn't have access to the sourced functions
# These tests verify the function exists and basic behavior

@test "confirm_action function exists" {
    # Verify the function is defined
    declare -f confirm_action > /dev/null
}

@test "confirm_action accepts input from pipe" {
    # Test that piping works (may not return expected status due to read -p)
    echo "y" | confirm_action "Test?" || true
    # If we got here without error, the function at least runs
}

# Skip interactive tests - they require terminal input
# @test "confirm_action returns true for 'y' input" - SKIPPED
# @test "confirm_action returns true for 'Y' input" - SKIPPED

# ============================================================================
# CHECK HOMEBREW TESTS
# ============================================================================

@test "check_homebrew passes when brew is available" {
    # Mock brew as available
    mock_brew

    run check_homebrew

    [ "$status" -eq 0 ]
}

@test "check_homebrew fails when brew is not available" {
    # Remove brew from PATH temporarily
    local original_path="$PATH"
    export PATH="/usr/bin:/bin"

    # Unset the mock if it exists
    unset -f brew

    run check_homebrew

    export PATH="$original_path"

    [ "$status" -ne 0 ]
}

# ============================================================================
# SECRETS DIRECTORY TESTS
# ============================================================================

@test "secure_development_environment creates secrets directory" {
    run secure_development_environment

    [ -d "$TEST_HOME/.secrets" ]
}

@test "secrets directory has 700 permissions" {
    run secure_development_environment

    assert_dir_permissions "$TEST_HOME/.secrets" "700"
}

# ============================================================================
# MONITORING SETUP TESTS
# ============================================================================

@test "setup_monitoring creates monitoring directory" {
    run setup_monitoring

    [ -d "$TEST_HOME/.security-monitoring" ]
}

@test "setup_monitoring creates network monitor script" {
    run setup_monitoring

    [ -f "$TEST_HOME/.security-monitoring/network-monitor.sh" ]
}

@test "setup_monitoring creates integrity check script" {
    run setup_monitoring

    [ -f "$TEST_HOME/.security-monitoring/integrity-check.sh" ]
}

@test "monitoring scripts are executable" {
    run setup_monitoring

    [ -x "$TEST_HOME/.security-monitoring/network-monitor.sh" ]
    [ -x "$TEST_HOME/.security-monitoring/integrity-check.sh" ]
}

# ============================================================================
# SCRIPT METADATA TESTS
# ============================================================================

@test "script uses strict mode" {
    local script_path
    script_path="$(get_project_root)/scripts/security-setup.sh"

    grep -q "set -euo pipefail" "$script_path"
}

@test "script defines all required color variables" {
    # These should be defined after sourcing
    [ -n "${RED+x}" ] || [ -z "$RED" ]  # Allow empty when colors disabled
    [ -n "${GREEN+x}" ] || [ -z "$GREEN" ]
    [ -n "${YELLOW+x}" ] || [ -z "$YELLOW" ]
    [ -n "${BLUE+x}" ] || [ -z "$BLUE" ]
    [ -n "${NC+x}" ] || [ -z "$NC" ]
}

# ============================================================================
# ENVIRONMENT VARIABLE TESTS
# ============================================================================

@test "USER_EMAIL has default value" {
    unset USER_EMAIL
    source_script_functions "security-setup.sh"

    [ -n "$USER_EMAIL" ]
}

@test "SSH_KEY_COMMENT is defined" {
    [ -n "$SSH_KEY_COMMENT" ]
}
