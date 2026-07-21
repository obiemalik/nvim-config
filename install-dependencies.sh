#!/bin/bash

# Install Neovim dependencies
# This script installs tools commonly used by Neovim plugins.
# It does NOT install language runtimes (Go/Python/Node) — bring your own
# via brew/mise/nvm/pyenv/etc. Mason/LSP toolchain gating is controlled by
# nvim/lua/langs.lua (see nvim/lua/langs.example.lua).

set -e

echo "Installing Neovim dependencies..."

# Check if brew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Please install Homebrew first: https://brew.sh"
    exit 1
fi

# Core tools (always installed)
BREW_TOOLS=(
    "ripgrep"      # Fast grep alternative (telescope)
    "fd"           # Fast find alternative (telescope)
    "fzf"          # Fuzzy finder
    "stylua"       # Lua formatter
    "shfmt"        # Shell script formatter
    "tree-sitter"  # tree-sitter library (CLI binary installed via npm below)
)

echo "Installing brew tools..."
for tool in "${BREW_TOOLS[@]}"; do
    if ! brew list "$tool" &>/dev/null; then
        echo "  Installing $tool..."
        brew install "$tool"
    else
        echo "  $tool already installed"
    fi
done

# tree-sitter CLI (brew only ships the library, not the binary)
echo ""
echo "Installing npm tools..."
if ! command -v tree-sitter &> /dev/null; then
    echo "  Installing tree-sitter-cli..."
    npm install -g tree-sitter-cli
else
    echo "  tree-sitter-cli already installed"
fi

# Remind about langs.lua if it doesn't exist yet
LANGS_FILE="$(dirname "$0")/nvim/lua/langs.lua"
if [[ ! -f "$LANGS_FILE" ]]; then
    echo ""
    echo "NOTE: No nvim/lua/langs.lua found."
    echo "  Copy the example to configure which language tools Neovim enables:"
    echo "  cp nvim/lua/langs.example.lua nvim/lua/langs.lua"
fi

# Check for language runtimes used by Mason / LSP configs
echo ""
echo "Checking language runtimes..."
MISSING=()
command -v go &>/dev/null && echo "  go ✓" || MISSING+=("go — needed for gopls, gofumpt, goimports, golangci-lint…")
command -v python3 &>/dev/null && echo "  python3 ✓" || MISSING+=("python3 — needed for pyright, black, mypy, isort")
command -v node &>/dev/null && echo "  node ✓" || MISSING+=("node — needed for tsc_native, eslint, prettier, tree-sitter-cli")

if [[ ${#MISSING[@]} -gt 0 ]]; then
    echo ""
    echo "Missing runtimes (install via your preferred method):"
    for item in "${MISSING[@]}"; do
        echo "  ✗ $item"
    done
fi

echo ""
echo "✓ Done!"
