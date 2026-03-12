#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  Install and configure tmux with plugins
# ─────────────────────────────────────────────────────────────
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

echo "==> Installing tmux..."

# Detect OS and install tmux
if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew &>/dev/null; then
        echo "ERROR: Homebrew not found. Install it first: https://brew.sh"
        exit 1
    fi
    brew install tmux 2>/dev/null || echo "tmux already installed"
elif [[ -f /etc/debian_version ]]; then
    sudo apt update && sudo apt install -y tmux
elif [[ -f /etc/redhat-release ]]; then
    sudo dnf install -y tmux || sudo yum install -y tmux
elif [[ -f /etc/arch-release ]]; then
    sudo pacman -S --noconfirm tmux
else
    echo "WARNING: Unknown OS. Please install tmux manually."
fi

echo "==> tmux version: $(tmux -V)"

# Install tmux config
echo "==> Installing tmux.conf..."
if [[ -f "$HOME/.tmux.conf" ]]; then
    cp "$HOME/.tmux.conf" "$HOME/.tmux.conf.backup.$(date +%s)"
    echo "    Backed up existing ~/.tmux.conf"
fi
cp "$REPO_DIR/configs/tmux.conf" "$HOME/.tmux.conf"
echo "    Installed ~/.tmux.conf"

# Install TPM (Tmux Plugin Manager)
echo "==> Installing TPM (Tmux Plugin Manager)..."
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [[ -d "$TPM_DIR" ]]; then
    echo "    TPM already installed"
else
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    echo "    TPM installed"
fi

# Install plugins via TPM
echo "==> Installing tmux plugins..."
"$TPM_DIR/bin/install_plugins" 2>/dev/null || true
echo "    Plugins installed"

# Clear any stale resurrect data
echo "==> Clearing stale tmux resurrect data..."
rm -rf "$HOME/.tmux/resurrect/" 2>/dev/null || true
mkdir -p "$HOME/.tmux/resurrect"

echo "==> tmux setup complete!"
