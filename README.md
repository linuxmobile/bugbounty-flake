# Bug Bounty Development Environment with Nix

A comprehensive and modular Nix development environment for bug bounty hunting,
featuring carefully curated tools organized by category and custom scripts to
enhance your workflow.

## 🚀 Features

- **Modular Organization**: Tools are organized into logical categories for
  better management
- **Custom Scripts**: Helpful scripts for reconnaissance, scanning, and
  environment setup
- **Integrated Terminal Multiplexer**: Preconfigured Zellij setup with custom
  layout for bug bounty workflows
- **Easy to Extend**: Simple structure to add or remove tools as needed

## 📋 Included Tools Categories

- **Reconnaissance**: `amass`, `subfinder`, `dnsx`, `nmap`, and more
- **Vulnerability Scanning**: `nuclei`, `sqlmap`, `metasploit`, `dalfox`, etc.
- **Web Proxies**: `burpsuite`, `wireshark`, `mitmproxy`
- **API Testing**: `postman`, `insomnia`
- **Network Analysis**: `interactsh`, `cdncheck`, `tcpdump`, etc.
- **Content Discovery**: `ffuf`, `feroxbuster`, `gobuster`, `katana`, etc.
- **Code Analysis**: `gitleaks`, `semgrep`, `trufflehog`, etc.

## 🛠️ Installation

1. Make sure you have Nix installed with flakes enabled
2. Clone the repository:

```bash
git clone https://github.com/linuxmobile/bugbounty-flake
cd bugbounty-flake
```

3. Enter the development environment:

```bash
nix develop -c $SHELL
```

Or if you don't want to clone the repository.

```bash
# Using the latest commit from main branch
nix develop github:linuxmobile/bugbounty-flake -c $SHELL
```

## 📚 Usage

### Basic Commands

```bash
# Set up the initial directory structure
setup-bugbounty

# Start the bug bounty environment with Zellij
start-environment

# Perform subdomain enumeration
recon-subdomain example.com

# Run vulnerability scanning
scan-vulnerabilities targets.txt
```

### Zellij Layout

The environment comes with a predefined Zellij layout with three tabs:

- **Recon**: Split pane for reconnaissance tools and results
- **Web**: Split layout for browser/Burp Suite and notes
- **Shell**: Full terminal for general commands

## 🔧 Customization

### Adding New Tools

1. Choose or create appropriate category in `modules/packages/`
2. Add your tool to the relevant category file:

```nix
# modules/packages/your-category.nix
{ pkgs }:
with pkgs; [
  existing-tools
  your-new-tool    # Add your tool here
]
```

3. Add the category to `modules/default.nix`:

```nix
{
  packages = {
    existing-categories = ...
    newCategory = import ./packages/your-category.nix { inherit pkgs; };
  };
}
```

### Removing Tools/Modules

1. Remove unwanted tools from the respective category file
2. To remove an entire category:
   - Delete the category file from `modules/packages/`
   - Remove its entry from `modules/default.nix`

### Modifying Scripts

Custom scripts are located in `modules/scripts/`. You can:

- Modify existing scripts in their respective files
- Add new scripts by creating a new file and adding it to
  `modules/scripts/default.nix`

## 📂 Project Structure

```
bugbounty-flake/
├── modules/
│   ├── packages/           # Tool categories
│   ├── scripts/           # Custom utility scripts
│   ├── software/          # Configuration files
│   └── default.nix        # Module organization
└── flake.nix             # Main flake configuration
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests with:

- New tools or categories
- Improvements to existing scripts
- Bug fixes
- Documentation improvements

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for
details.

## ⚠️ Disclaimer

This environment is for educational purposes and authorized security testing
only. Always ensure you have permission before testing any systems or networks.
