# 🔒 Security & Privacy Hardening Script

Comprehensive macOS security hardening script for secure development environments.

## 📋 Overview

This automated script configures a secure, privacy-focused development environment on macOS with:

- **SSH Security Hardening** - Secure key generation and configuration
- **Git Security & Commit Signing** - GPG setup and secure Git configuration  
- **Security Monitoring Tools** - Essential security and network monitoring utilities
- **Browser Security** - Privacy-focused browser configuration
- **System Security Hardening** - OS-level security improvements
- **Development Environment Security** - Secure coding practices and tooling
- **Privacy Configuration** - Disable tracking and telemetry
- **Security Monitoring Setup** - Automated monitoring scripts

## 🚀 Quick Start

### Prerequisites
- macOS (tested on macOS 15.x)
- Homebrew installed
- Admin privileges for system-level changes

### Basic Usage
```bash
# Make executable
chmod +x security-setup.sh

# Run interactively
./security-setup.sh

# Or copy to a convenient location
cp security-setup.sh ~/security-setup.sh
~/security-setup.sh
```

## 🛡️ Security Components

### 1. SSH Security Hardening
- **Generates secure SSH keys**: Ed25519 and RSA-4096
- **Configures secure SSH client settings**:
  - Modern encryption ciphers
  - Secure key exchange algorithms
  - Connection timeouts and keep-alives
  - Host key verification
- **Sets proper file permissions** (600 for private keys, 644 for public keys)

### 2. Git Security & Commit Signing  
- **Installs and configures GPG** for commit signing
- **Generates GPG keys** for code authentication
- **Configures Git security settings**:
  - Commit and tag signing
  - Object verification (fsck)
  - Secure defaults (rebase, simple push)
- **Sets up Git templates** with security hooks

### 3. Security Monitoring Tools
**Command-line tools:**
- `nmap` - Network scanning and discovery
- `bandwhich` - Real-time network bandwidth monitoring
- `dog` - Modern DNS lookup tool
- `semgrep` - Static code analysis for security
- `gitleaks` - Detect secrets in Git repositories
- `trivy` - Container and filesystem vulnerability scanner
- `sops` & `age` - Secrets encryption and management
- `lnav` - Advanced log navigation

**GUI Applications:**
- **KnockKnock** - Detect malware and persistent threats
- **ReiKey** - Monitor keyboard and mouse event taps
- **Oversight** - Camera and microphone access monitoring
- **Keybase** - Secure file sharing and identity verification
- **Firefox & Brave** - Privacy-focused browsers

### 4. Browser Security Configuration
- **Automated privacy settings** for Safari
- **Security recommendations** for Firefox and other browsers:
  - uBlock Origin installation
  - Tracking protection configuration
  - DNS over HTTPS setup
  - WebRTC disabling

### 5. System Security Hardening
- **Screen lock security**: Immediate password requirement
- **Firewall configuration**: Enable logging and protection
- **Disable automatic login** and guest account
- **Secure file permissions**: umask 027
- **Network security**: Disable unnecessary multicast advertisements

### 6. Development Environment Security
- **Secure secrets directory** with proper permissions
- **npm security configuration**: Audit settings and security checks
- **Git hooks setup**: Pre-commit secret scanning
- **Development template configuration**

### 7. Privacy Configuration
- **Disable system telemetry** and analytics
- **Configure Safari privacy** settings
- **Spotlight privacy** configuration
- **Recommendations** for manual privacy settings

### 8. Security Monitoring Setup
- **Network monitoring script**: Track active connections
- **System integrity checker**: Monitor for new launch items
- **Automated logging**: Timestamped security events

## 📁 Generated Files & Directories

```
~/.ssh/
├── id_ed25519          # Ed25519 private key
├── id_ed25519.pub      # Ed25519 public key  
├── id_rsa              # RSA private key
├── id_rsa.pub          # RSA public key
└── config              # Secure SSH client configuration

~/.gnupg/
├── gpg.conf            # GPG security configuration
└── gpg-agent.conf      # GPG agent settings

~/.git-templates/hooks/
└── pre-commit          # Git secret scanning hook

~/.security-monitoring/
├── network-monitor.sh  # Network monitoring script
├── integrity-check.sh  # System integrity checker
├── network.log         # Network monitoring logs
└── integrity.log       # Integrity check logs

~/.secrets/             # Secure directory for development secrets
```

## 🎛️ Interactive Menu

The script provides a user-friendly menu system:

```
Choose components to install/configure:

  1) SSH Security Hardening
  2) Git Security & Commit Signing
  3) Security Monitoring Tools
  4) Browser Security Configuration
  5) System Security Hardening
  6) Development Environment Security
  7) Privacy Configuration
  8) Security Monitoring Setup
  9) Install ALL Components
  0) Exit
```

## ⚠️ Important Notes

### Security Considerations
- **Review configurations** before running in production
- **Backup existing configs** before making changes
- **Some settings require restart** to take full effect
- **GPG key generation** requires manual input for security

### Permissions
- Script requires **admin privileges** for system-level changes
- Creates files with **secure permissions** (600/700)
- Respects existing configurations (won't overwrite)

### Compatibility
- Designed for **macOS 12+** (tested on macOS 15.x)
- Compatible with **Apple Silicon and Intel Macs**
- Requires **Homebrew package manager**

## 🔧 Customization

### Environment Variables
```bash
export USER_EMAIL="your-email@example.com"  # Set email for SSH/GPG keys
./security-setup.sh
```

### Configuration Files
All configuration files are created with secure defaults but can be customized:
- SSH config: `~/.ssh/config`
- GPG config: `~/.gnupg/gpg.conf`
- Git config: Global Git configuration

## 📊 Logging

All operations are logged to `security-setup.log` in the script directory:
```bash
# View log
tail -f security-setup.log

# Check for errors
grep ERROR security-setup.log
```

## 🧪 Testing

### Verify SSH Security
```bash
# Test SSH key generation
ls -la ~/.ssh/
ssh-keygen -l -f ~/.ssh/id_ed25519.pub

# Test SSH configuration
ssh -F ~/.ssh/config -T git@github.com
```

### Verify Git Security
```bash
# Check GPG configuration
gpg --list-keys
git config --global --get user.signingkey

# Test commit signing
git commit -S -m "Test signed commit"
git log --show-signature
```

### Verify Security Tools
```bash
# Test network monitoring
bandwhich
dog github.com

# Test vulnerability scanning
trivy fs .
```

## 🆘 Troubleshooting

### Common Issues

**GPG Key Generation Fails:**
```bash
# Fix GPG permissions
chmod 700 ~/.gnupg
gpg-agent --daemon --default-cache-ttl 600
```

**SSH Key Permission Issues:**
```bash
# Fix SSH permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_*
chmod 644 ~/.ssh/*.pub
```

**Homebrew Permission Issues:**
```bash
# Fix Homebrew ownership (run as admin)
sudo chown -R $(whoami) /opt/homebrew
```

## 🔄 Updates & Maintenance

### Regular Security Updates
```bash
# Update Homebrew packages
brew update && brew upgrade

# Update security tools
brew upgrade nmap trivy semgrep gitleaks

# Check for system updates
softwareupdate -i -a
```

### Monitor Security
```bash
# Run monitoring scripts
~/.security-monitoring/network-monitor.sh &
~/.security-monitoring/integrity-check.sh

# Check logs
tail ~/.security-monitoring/*.log
```

## 📜 License

This script is provided as-is for educational and security hardening purposes. Review and test thoroughly before using in production environments.

## 🤝 Contributing

Contributions welcome! Areas for improvement:
- Additional security tools
- Enhanced monitoring capabilities  
- Platform compatibility
- Configuration customization options

---

**⚠️ Security Notice:** Always review security scripts before execution. This script makes system-wide changes that affect security settings and installed software.