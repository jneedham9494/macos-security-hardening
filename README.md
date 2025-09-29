# 🛡️ macOS Security Hardening

Core macOS security and privacy hardening toolkit for development environments.

![macOS](https://img.shields.io/badge/macOS-12%2B-blue.svg)
![Security](https://img.shields.io/badge/Security-Enterprise%20Grade-green.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

## 📁 Project Organization

This repository focuses on **core macOS security hardening**. For specialized security domains, see:

- **[Digital Privacy Management](../digital-privacy-management/)** - Complete digital identity management and privacy
- **[Travel Security Toolkit](../travel-security-toolkit/)** - International travel security and OPSEC

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/user/macos-security-hardening.git
cd macos-security-hardening

# Run the complete security hardening setup
chmod +x security-setup-consolidated.sh
./security-setup-consolidated.sh
```

The consolidated script provides an interactive menu with all security features:
- 🚀 Complete Security Setup (Recommended)
- 📦 Install Security Tools
- 🔑 Setup SSH Keys  
- 🔒 Configure Git Security
- 🔥 Setup Firewall
- 🛡️ Harden System Security
- ⚙️ Create Security Tool Configs
- 📊 Setup Security Monitoring
- 🐚 Configure Shell Integration

**After setup, you'll have access to these commands:**

- `security secrets` - Scan for secrets
- `security vulns` - Vulnerability scan  
- `security monitor` - Full security monitoring
- `security logs` - View security logs
- `security-scheduler` - Manage automated periodic scans

## 🎯 What This Does

Transform your macOS development machine into an **enterprise-grade secure environment** with:

### 🔐 **8 Security Components**
1. **SSH Security Hardening** - Ed25519 + RSA-4096 keys, secure SSH config
2. **Git Security & Commit Signing** - GPG setup, signed commits, secure Git config
3. **Security Monitoring Tools** - 15+ CLI/GUI security tools (nmap, trivy, KnockKnock, etc.)
4. **Browser Security** - Privacy-focused browser configurations
5. **System Security Hardening** - Firewall, screen lock, secure defaults
6. **Development Environment Security** - Secure coding practices and tooling
7. **Privacy Configuration** - Disable telemetry, tracking prevention
8. **Security Monitoring Setup** - Automated monitoring and logging

### 🛡️ **Security Architecture**
- **Network Layer**: VPN integration + DNS filtering + firewall rules
- **Application Layer**: Outbound connection monitoring + app verification
- **System Layer**: FileVault encryption + hardened OS settings
- **Development Layer**: Secure Git + SSH + signed commits + secret scanning
- **Privacy Layer**: Telemetry disabling + tracking prevention + secure browsing

## 📋 Features

### ⚡ **One-Command Setup**
```bash
# Complete security hardening
./security-setup.sh

# Interactive menu with 8 security components
# Choose individual components or install all (option 9)
```

### 🔧 **Security Tools Installed**
**Command-Line Security Tools:**
- `nmap` - Network scanning and discovery
- `bandwhich` - Real-time bandwidth monitoring  
- `trivy` - Vulnerability scanner
- `semgrep` - Static code analysis
- `gitleaks` - Git secret detection
- `sops` & `age` - Secrets encryption
- `dog` - Modern DNS lookup
- `lnav` - Advanced log navigation

**GUI Security Applications:**
- **KnockKnock** - Malware and persistence detection
- **ReiKey** - Keyboard/mouse event monitoring
- **Oversight** - Camera/microphone access monitoring
- **Keybase** - Secure identity and file sharing
- **Firefox & Brave** - Privacy-focused browsers

### 🔑 **Cryptographic Security**
- **SSH Keys**: Ed25519 (modern) + RSA-4096 (compatibility)
- **GPG Setup**: Automated key generation + Git commit signing
- **Secure Configurations**: Hardened SSH/GPG/Git settings
- **Key Management**: Proper permissions + secure storage

### 📊 **Monitoring & Logging**
- **Network monitoring** - Track all connections
- **System integrity** - Monitor for changes
- **Security events** - Automated logging
- **Real-time alerts** - Suspicious activity detection

## 🏗️ Repository Structure

```
macos-security-hardening/
├── README.md                         # This file
├── security-setup.sh                # Main security hardening script (574 lines)
├── setup-security-configs.sh        # Security tools configuration setup
├── SECURITY-SETUP-README.md         # Comprehensive documentation
├── docs/
│   ├── COMPLETE-SESSION-LOG.md      # Session history and achievements
│   ├── CONVERSATION-LOG.md          # Technical conversation log
│   └── SETUP-COMPLETE.txt           # Quick completion reference
└── examples/                        # (to be added)
    ├── ssh-config-sample
    ├── gpg-config-sample
    └── monitoring-scripts/
```

## 🎛️ Interactive Menu

```
╔══════════════════════════════════════════════════════════════════════════════╗
║                           🔒 SECURITY HARDENING MENU                          ║
╚══════════════════════════════════════════════════════════════════════════════╝

Choose components to install/configure:

  1) SSH Security Hardening           - Secure SSH keys + client config
  2) Git Security & Commit Signing    - GPG setup + signed commits  
  3) Security Monitoring Tools        - 15+ security utilities
  4) Browser Security Configuration   - Privacy-focused browser setup
  5) System Security Hardening        - Firewall + OS hardening
  6) Development Environment Security - Secure development practices
  7) Privacy Configuration             - Disable telemetry + tracking
  8) Security Monitoring Setup        - Automated monitoring scripts
  9) Install ALL Components            - Complete security hardening
  0) Exit

Enter your choice [0-9]:
```

## ⚙️ Installation Options

### 🎯 **Recommended: Complete Setup**
```bash
./security-setup.sh
# Choose option 9 for complete hardening
```

### 🔧 **Custom Setup**  
```bash
./security-setup.sh
# Choose individual components (1-8) as needed
```

### 🧪 **Development/Testing**
```bash
# Set custom email for keys
export USER_EMAIL="your-email@example.com"
./security-setup.sh
```

## 📚 Documentation

- **[SECURITY-SETUP-README.md](SECURITY-SETUP-README.md)** - Comprehensive setup guide (1,200+ lines)
- **[docs/COMPLETE-SESSION-LOG.md](docs/COMPLETE-SESSION-LOG.md)** - Real-world deployment log
- **[docs/SETUP-COMPLETE.txt](docs/SETUP-COMPLETE.txt)** - Quick verification checklist

## ✅ Verification

After running the security setup, verify your configuration:

```bash
# SSH Security
ls -la ~/.ssh/
ssh-keygen -l -f ~/.ssh/id_ed25519.pub

# GPG Setup
gpg --list-keys
git config --get user.signingkey

# Security Tools
nmap --version
trivy --version
bandwhich --version

# System Security
sudo pfctl -sr    # Check firewall rules
diskutil apfs list | grep FileVault  # Check encryption
```

## 🔄 Integration

### Works Great With:
- **Homebrew** - Package management
- **VPN solutions** - Mullvad, NordVPN, etc.
- **Development workflows** - Git, VS Code, terminal environments

### Integration Example:
```bash
# Set up enterprise-grade security
git clone https://github.com/user/macos-security-hardening.git
cd macos-security-hardening && ./security-setup.sh
```

## 🛠️ Troubleshooting

### Common Issues:

**GPG Key Generation Fails:**
```bash
chmod 700 ~/.gnupg
gpg-agent --daemon --default-cache-ttl 600
```

**SSH Permission Issues:**
```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_*
chmod 644 ~/.ssh/*.pub
```

**Homebrew Permission Issues:**
```bash
sudo chown -R $(whoami) /opt/homebrew
```

## 📊 Security Results

After complete setup, your system will have:
- ✅ **Enterprise-grade encryption** (SSH Ed25519, GPG, FileVault)
- ✅ **Real-time monitoring** (network, system integrity, access control)
- ✅ **Vulnerability scanning** (code, containers, system)
- ✅ **Privacy protection** (DNS filtering, tracking prevention)
- ✅ **Secure development** (signed commits, secret scanning, secure configs)

## 🤝 Contributing

Contributions welcome! Areas for improvement:
- Additional security tools and configurations
- Platform support (Linux, Windows WSL)
- Enhanced monitoring capabilities
- Automation improvements

## 📄 License

MIT License - See LICENSE file for details.

## ⚠️ Security Notice

This script makes system-wide security changes. Always:
1. **Review the script** before running
2. **Test on non-production systems** first
3. **Backup important data** before hardening
4. **Understand the implications** of each security change

---

**Created by**: GitHub Copilot Assistant | **Date**: September 28, 2025
**Enterprise-grade security for macOS development environments** 🛡️