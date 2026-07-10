#!/bin/bash

# Install Neovim dependencies
# This script installs tools commonly used by Neovim plugins

set -e

echo "Installing Neovim dependencies..."

# Check if brew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Please install Homebrew first: https://brew.sh"
    exit 1
fi

# Required tools
TOOLS=(
    "ripgrep"      # Fast grep alternative (used by telescope)
    "fd"           # Fast find alternative
    "fzf"          # Fuzzy finder
    "stylua"       # Lua formatter
    "shfmt"        # Shell script formatter
)

echo "Installing core tools..."
for tool in "${TOOLS[@]}"; do
    if ! brew list "$tool" &>/dev/null; then
        echo "Installing $tool..."
        brew install "$tool"
    else
        echo "$tool is already installed"
    fi
done

echo "✓ Dependencies installed successfully!"
