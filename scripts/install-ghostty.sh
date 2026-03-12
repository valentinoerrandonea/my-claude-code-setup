#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  Install Ghostty configuration
#  NOTE: Ghostty itself must be installed manually by the user.
#        This script only installs the config file.
# ─────────────────────────────────────────────────────────────
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

echo "==> Configuring Ghostty..."

# Determine config path based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    GHOSTTY_CONFIG_DIR="$HOME/.config/ghostty"
elif [[ "$OSTYPE" == "linux"* ]]; then
    GHOSTTY_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"
else
    GHOSTTY_CONFIG_DIR="$HOME/.config/ghostty"
fi

mkdir -p "$GHOSTTY_CONFIG_DIR"

# Backup existing config
if [[ -f "$GHOSTTY_CONFIG_DIR/config" ]]; then
    cp "$GHOSTTY_CONFIG_DIR/config" "$GHOSTTY_CONFIG_DIR/config.backup.$(date +%s)"
    echo "    Backed up existing Ghostty config"
fi

# Install config
cp "$REPO_DIR/configs/ghostty.conf" "$GHOSTTY_CONFIG_DIR/config"
echo "    Installed Ghostty config to $GHOSTTY_CONFIG_DIR/config"

echo ""
echo "NOTE: If Ghostty is not installed, download it from: https://ghostty.org"
echo "      After installing, restart Ghostty to apply the new config."
echo "      Or press Cmd+Shift+, inside Ghostty to reload."
echo ""
echo "==> Ghostty config complete!"
