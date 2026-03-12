#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  Install Claude Code global rules and settings
#  Sources: everything-claude-code + custom power-setup rules
# ─────────────────────────────────────────────────────────────
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
CLAUDE_DIR="$HOME/.claude"
RULES_DIR="$CLAUDE_DIR/rules"

echo "==> Installing Claude Code rules and settings..."

# Create directories
mkdir -p "$RULES_DIR/common"
mkdir -p "$RULES_DIR/python"
mkdir -p "$RULES_DIR/typescript"

# ── Clone everything-claude-code if needed ───────────────────
ECC_DIR="/tmp/everything-claude-code"
if [[ ! -d "$ECC_DIR" ]]; then
    echo "    Cloning everything-claude-code..."
    git clone https://github.com/affaan-m/everything-claude-code.git "$ECC_DIR" 2>/dev/null
fi

# ── Install rules from everything-claude-code ────────────────
echo "    Installing rule files..."

# Common rules (language-agnostic)
COMMON_RULES=(
    "coding-style"
    "git-workflow"
    "development-workflow"
    "testing"
    "performance"
    "patterns"
    "hooks"
    "security"
    "agents"
)

for rule in "${COMMON_RULES[@]}"; do
    src="$ECC_DIR/rules/common/${rule}.md"
    if [[ -f "$src" ]]; then
        cp "$src" "$RULES_DIR/common/${rule}.md"
        echo "      common/${rule}.md"
    fi
done

# Python rules
LANG_RULES=("coding-style" "hooks" "patterns" "security" "testing")
for rule in "${LANG_RULES[@]}"; do
    src="$ECC_DIR/rules/python/${rule}.md"
    if [[ -f "$src" ]]; then
        cp "$src" "$RULES_DIR/python/${rule}.md"
        echo "      python/${rule}.md"
    fi
done

# TypeScript rules
for rule in "${LANG_RULES[@]}"; do
    src="$ECC_DIR/rules/typescript/${rule}.md"
    if [[ -f "$src" ]]; then
        cp "$src" "$RULES_DIR/typescript/${rule}.md"
        echo "      typescript/${rule}.md"
    fi
done

# ── Install Claude settings ─────────────────────────────────
echo "==> Installing Claude Code settings..."
SETTINGS_FILE="$CLAUDE_DIR/settings.json"

if [[ -f "$SETTINGS_FILE" ]]; then
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup.$(date +%s)"
    echo "    Backed up existing settings.json"
fi

cp "$REPO_DIR/configs/claude-settings.json" "$SETTINGS_FILE"
echo "    Installed settings.json (agent teams enabled, skip-permissions prompt disabled)"

# ── Cleanup ──────────────────────────────────────────────────
rm -rf "$ECC_DIR"

echo ""
echo "==> Claude Code rules installed!"
echo "    Rules location: $RULES_DIR"
echo "    Settings: $SETTINGS_FILE"
