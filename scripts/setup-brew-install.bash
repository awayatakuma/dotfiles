#!/usr/bin/env bash
set -eux

# Homebrew packages for macOS
packages=(
    # Modern CLI tools
    bat
    eza
    fd
    ripgrep
    fzf
    
    # Development tools
    git
    curl
    wget
    
    # Shell enhancements
    zsh
    
    # Optional modern tools
    lazygit
    zellij
    neofetch
    
    # Language tools (if needed)
    # nodejs
    # python
    # rust
    # go
)

echo "Installing Homebrew packages..."
for package in "${packages[@]}"; do
    if brew list "$package" &>/dev/null; then
        echo "$package is already installed"
    else
        echo "Installing $package..."
        brew install "$package"
    fi
done

echo "Homebrew package installation completed"