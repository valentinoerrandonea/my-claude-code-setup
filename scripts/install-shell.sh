#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  Install shell functions and launcher script
# ─────────────────────────────────────────────────────────────
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

echo "==> Installing Claude Code launcher script..."

# Install launcher script
cp "$REPO_DIR/scripts/claude-launcher.sh" "$HOME/claude-launcher.sh"
chmod +x "$HOME/claude-launcher.sh"
echo "    Installed ~/claude-launcher.sh"

# Detect shell RC file
if [[ -n "${ZSH_VERSION:-}" ]] || [[ "$SHELL" == *"zsh"* ]]; then
    RC_FILE="$HOME/.zshrc"
elif [[ -n "${BASH_VERSION:-}" ]] || [[ "$SHELL" == *"bash"* ]]; then
    RC_FILE="$HOME/.bashrc"
else
    RC_FILE="$HOME/.zshrc"
    echo "    WARNING: Could not detect shell. Defaulting to ~/.zshrc"
fi

echo "==> Adding shell functions to $RC_FILE..."

# Check if functions already exist
MARKER="# Claude Code Power Setup"
if grep -q "$MARKER" "$RC_FILE" 2>/dev/null; then
    echo "    Shell functions already present in $RC_FILE. Skipping."
else
    cat >> "$RC_FILE" << 'SHELL_FUNCS'

# Claude Code Power Setup
cc()       { $HOME/claude-launcher.sh attach; }  # Open / reconnect
ccnew()    { $HOME/claude-launcher.sh new; }      # Fresh session
ccresume() { $HOME/claude-launcher.sh resume; }   # Continue last conversation
ccpick()   { $HOME/claude-launcher.sh pick; }     # Choose from past sessions
SHELL_FUNCS
    echo "    Added cc, ccnew, ccresume, ccpick functions to $RC_FILE"
fi

# Ensure Claude Code is in PATH
if ! grep -q 'local/bin' "$RC_FILE" 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$RC_FILE"
    echo "    Added ~/.local/bin to PATH in $RC_FILE"
fi

echo "==> Shell setup complete! Run: source $RC_FILE"
