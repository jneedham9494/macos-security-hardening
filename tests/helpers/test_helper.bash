#!/bin/bash
# Test helper functions for bats tests
# Provides common setup, teardown, and utility functions

# ============================================================================
# TEST ENVIRONMENT SETUP
# ============================================================================

# Create isolated test environment
setup_test_environment() {
    # Create temp directory for test isolation
    export TEST_TEMP_DIR="$(mktemp -d)"
    export TEST_HOME="$TEST_TEMP_DIR/home"
    export TEST_SSH_DIR="$TEST_HOME/.ssh"
    export TEST_GIT_CONFIG="$TEST_HOME/.gitconfig"
    export TEST_SECRETS_DIR="$TEST_HOME/.secrets"

    mkdir -p "$TEST_HOME"
    mkdir -p "$TEST_SSH_DIR"

    # Override HOME for tests
    export ORIGINAL_HOME="$HOME"
    export HOME="$TEST_HOME"

    # Set test-specific variables
    export USER_EMAIL="test@example.com"
    export GIT_USER_NAME="Test User"
    export SSH_KEY_COMMENT="Test Key"
}

# Clean up test environment
teardown_test_environment() {
    # Restore original HOME
    export HOME="$ORIGINAL_HOME"

    # Clean up temp directory
    if [[ -n "$TEST_TEMP_DIR" && -d "$TEST_TEMP_DIR" ]]; then
        rm -rf "$TEST_TEMP_DIR"
    fi
}

# ============================================================================
# SCRIPT SOURCING
# ============================================================================

# Get the project root directory
get_project_root() {
    local helper_dir
    helper_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    echo "$(cd "$helper_dir/../.." && pwd)"
}

# Source a script's functions without running main
source_script_functions() {
    local script_name="$1"
    local project_root
    project_root="$(get_project_root)"
    local script_path="$project_root/scripts/$script_name"

    if [[ ! -f "$script_path" ]]; then
        echo "Script not found: $script_path" >&2
        return 1
    fi

    # Source the script but prevent main from running
    # This works because scripts check: if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
    source "$script_path"
}

# ============================================================================
# MOCK FUNCTIONS
# ============================================================================

# Mock sudo to avoid actual privilege escalation in tests
mock_sudo() {
    sudo() {
        # Log the sudo call for verification
        echo "MOCK_SUDO: $*" >> "$TEST_TEMP_DIR/sudo_calls.log"
        # Execute the command without sudo
        "$@"
    }
    export -f sudo
}

# Mock brew to avoid actual package installation
mock_brew() {
    brew() {
        echo "MOCK_BREW: $*" >> "$TEST_TEMP_DIR/brew_calls.log"
        return 0
    }
    export -f brew
}

# Mock ssh-keygen to create dummy keys
mock_ssh_keygen() {
    ssh-keygen() {
        local key_file=""
        local key_type="ed25519"

        # Parse arguments
        while [[ $# -gt 0 ]]; do
            case "$1" in
                -f) key_file="$2"; shift 2 ;;
                -t) key_type="$2"; shift 2 ;;
                *) shift ;;
            esac
        done

        if [[ -n "$key_file" ]]; then
            # Create dummy private key
            echo "-----BEGIN OPENSSH PRIVATE KEY-----" > "$key_file"
            echo "mock-private-key-content-$key_type" >> "$key_file"
            echo "-----END OPENSSH PRIVATE KEY-----" >> "$key_file"
            chmod 600 "$key_file"

            # Create dummy public key
            echo "ssh-$key_type AAAA...mockkey...== test@example.com" > "${key_file}.pub"
            chmod 644 "${key_file}.pub"
        fi

        echo "MOCK_SSH_KEYGEN: $*" >> "$TEST_TEMP_DIR/ssh_keygen_calls.log"
        return 0
    }
    export -f ssh-keygen
}

# Mock git config to use test directory
mock_git_config() {
    # Git will use HOME for global config, which we've already redirected
    # No additional mocking needed if HOME is set correctly
    :
}

# ============================================================================
# ASSERTION HELPERS
# ============================================================================

# Assert file exists with specific permissions
assert_file_permissions() {
    local file="$1"
    local expected_perms="$2"

    if [[ ! -f "$file" ]]; then
        echo "File does not exist: $file" >&2
        return 1
    fi

    local actual_perms
    actual_perms=$(stat -f "%Lp" "$file" 2>/dev/null || stat -c "%a" "$file" 2>/dev/null)

    if [[ "$actual_perms" != "$expected_perms" ]]; then
        echo "Permission mismatch for $file: expected $expected_perms, got $actual_perms" >&2
        return 1
    fi

    return 0
}

# Assert directory exists with specific permissions
assert_dir_permissions() {
    local dir="$1"
    local expected_perms="$2"

    if [[ ! -d "$dir" ]]; then
        echo "Directory does not exist: $dir" >&2
        return 1
    fi

    local actual_perms
    actual_perms=$(stat -f "%Lp" "$dir" 2>/dev/null || stat -c "%a" "$dir" 2>/dev/null)

    if [[ "$actual_perms" != "$expected_perms" ]]; then
        echo "Permission mismatch for $dir: expected $expected_perms, got $actual_perms" >&2
        return 1
    fi

    return 0
}

# Assert file contains string
assert_file_contains() {
    local file="$1"
    local pattern="$2"

    if [[ ! -f "$file" ]]; then
        echo "File does not exist: $file" >&2
        return 1
    fi

    if ! grep -q "$pattern" "$file"; then
        echo "Pattern not found in $file: $pattern" >&2
        return 1
    fi

    return 0
}

# Assert git config value
assert_git_config() {
    local key="$1"
    local expected="$2"

    local actual
    actual=$(git config --global --get "$key" 2>/dev/null)

    if [[ "$actual" != "$expected" ]]; then
        echo "Git config mismatch for $key: expected '$expected', got '$actual'" >&2
        return 1
    fi

    return 0
}

# ============================================================================
# LOGGING HELPERS
# ============================================================================

# Suppress color output in tests
disable_colors() {
    export RED=''
    export GREEN=''
    export YELLOW=''
    export BLUE=''
    export PURPLE=''
    export CYAN=''
    export NC=''
}

# Redirect log output to test directory
redirect_logs() {
    export LOG_FILE="$TEST_TEMP_DIR/test.log"
}
