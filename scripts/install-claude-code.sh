#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  Install Claude Code CLI
# ─────────────────────────────────────────────────────────────
set -euo pipefail

echo "==> Checking Claude Code installation..."

# Check if already installed
if command -v claude &>/dev/null; then
    echo "    Claude Code already installed: $(claude --version)"
    exit 0
fi

if [[ -f "$HOME/.local/bin/claude" ]]; then
    echo "    Claude Code already installed: $($HOME/.local/bin/claude --version)"
    exit 0
fi

# Install via npm (preferred method)
echo "==> Installing Claude Code..."
if command -v npm &>/dev/null; then
    npm install -g @anthropic-ai/claude-code
    echo "    Claude Code installed via npm"
elif command -v bun &>/dev/null; then
    bun install -g @anthropic-ai/claude-code
    echo "    Claude Code installed via bun"
else
    echo "ERROR: Neither npm nor bun found."
    echo "Install Node.js (https://nodejs.org) or Bun (https://bun.sh) first."
    exit 1
fi

# Verify installation
if command -v claude &>/dev/null; then
    echo "    Version: $(claude --version)"
elif [[ -f "$HOME/.local/bin/claude" ]]; then
    echo "    Version: $($HOME/.local/bin/claude --version)"
else
    echo "WARNING: Claude Code installed but not found in PATH."
    echo "Add to your shell config: export PATH=\"\$HOME/.local/bin:\$PATH\""
fi

echo ""
echo "IMPORTANT: You must authenticate before using Claude Code."
echo "Run: claude"
echo "This will open a browser for login. You need a Pro, Max, Teams, or Enterprise account."
