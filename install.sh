#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  Claude Code Power Setup - Master Installer
#
#  Installs and configures:
#    1. Claude Code CLI
#    2. tmux + plugins (TPM)
#    3. Ghostty terminal config
#    4. Shell functions (cc, ccnew, ccresume, ccpick)
#    5. Claude Code rules & settings (from everything-claude-code)
#    6. Multi-agent tools (Claude Swarm, Zerg, Overstory, etc.)
#
#  Usage:
#    ./install.sh           # Install everything
#    ./install.sh --minimal # Skip multi-agent tools
# ─────────────────────────────────────────────────────────────
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MINIMAL=false

if [[ "${1:-}" == "--minimal" ]]; then
    MINIMAL=true
fi

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║       Claude Code Power Setup - Installer                ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# ── Prerequisites check ──────────────────────────────────────
echo "==> Checking prerequisites..."

if ! command -v git &>/dev/null; then
    echo "ERROR: git is required. Install it first."
    exit 1
fi

if [[ "$OSTYPE" == "darwin"* ]] && ! command -v brew &>/dev/null; then
    echo "ERROR: Homebrew is required on macOS."
    echo "Install it: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

echo "    All prerequisites met."
echo ""

# ── Step 1: Claude Code ─────────────────────────────────────
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Step 1/6: Claude Code CLI"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
bash "$SCRIPT_DIR/scripts/install-claude-code.sh"
echo ""

# ── Step 2: tmux ─────────────────────────────────────────────
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Step 2/6: tmux + Plugins"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
bash "$SCRIPT_DIR/scripts/install-tmux.sh"
echo ""

# ── Step 3: Ghostty config ──────────────────────────────────
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Step 3/6: Ghostty Configuration"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
bash "$SCRIPT_DIR/scripts/install-ghostty.sh"
echo ""

# ── Step 4: Shell functions ──────────────────────────────────
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Step 4/6: Shell Functions & Launcher"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
bash "$SCRIPT_DIR/scripts/install-shell.sh"
echo ""

# ── Step 5: Claude Code rules ───────────────────────────────
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Step 5/6: Claude Code Rules & Settings"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
bash "$SCRIPT_DIR/scripts/install-rules.sh"
echo ""

# ── Step 6: Multi-agent tools ───────────────────────────────
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Step 6/6: Multi-Agent Tools"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [[ "$MINIMAL" == true ]]; then
    echo "    Skipped (--minimal flag)"
else
    bash "$SCRIPT_DIR/scripts/install-tools.sh"
fi
echo ""

# ── Done ─────────────────────────────────────────────────────
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║              Installation Complete!                      ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""
echo "  Next steps:"
echo ""
echo "  1. Reload your shell:"
echo "     source ~/.zshrc"
echo ""
echo "  2. If not authenticated, run:"
echo "     claude"
echo ""
echo "  3. Start Claude Code in tmux:"
echo "     cc          # Open / reconnect"
echo "     ccnew       # Fresh session"
echo "     ccresume    # Continue last conversation"
echo "     ccpick      # Choose from past sessions"
echo ""
echo "  4. Inside tmux (with Ghostty):"
echo "     Cmd+N              → Spawn new Claude Code panel"
echo "     Cmd+Shift+N        → Spawn new panel (vertical)"
echo "     Option+Ctrl+arrows → Navigate between panels"
echo "     Cmd+Ctrl+R         → Rename panel"
echo "     Cmd+Shift+=        → Redistribute panels (tiled)"
echo ""
echo "  5. Restart Ghostty to apply terminal config."
echo ""
echo "  See docs/ folder for detailed usage guides."
