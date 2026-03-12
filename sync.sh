#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  Sync: pull del repo + copiar todo a ~/.claude/
#  Uso: ./sync.sh  (o "csync" si agregaste el alias)
# ─────────────────────────────────────────────────────────────
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "==> Pulling latest from origin/main..."
cd "$REPO_DIR"
git pull origin main

echo ""
echo "==> Syncing agents..."
mkdir -p "$CLAUDE_DIR/agents"
cp "$REPO_DIR/configs/agents/"*.md "$CLAUDE_DIR/agents/"
AGENT_COUNT=$(ls "$CLAUDE_DIR/agents/"*.md 2>/dev/null | wc -l | tr -d ' ')
echo "    $AGENT_COUNT agents synced to $CLAUDE_DIR/agents/"

echo ""
echo "==> Syncing rules..."
mkdir -p "$CLAUDE_DIR/rules/common"
if [[ -d "$CLAUDE_DIR/rules/common" ]]; then
    # Only overwrite rules that exist in the repo configs
    # (install-rules.sh handles the full install from everything-claude-code)
    echo "    Rules directory exists, skipping (run install-rules.sh for full install)"
fi

echo ""
echo "==> Syncing strategy playbooks..."
if [[ -d "$REPO_DIR/configs/strategy" ]]; then
    mkdir -p "$CLAUDE_DIR/strategy"
    cp -r "$REPO_DIR/configs/strategy/"* "$CLAUDE_DIR/strategy/"
    echo "    Strategy playbooks synced to $CLAUDE_DIR/strategy/"
fi

echo ""
echo "==> Syncing settings..."
if [[ -f "$REPO_DIR/configs/claude-settings.json" ]]; then
    if [[ -f "$CLAUDE_DIR/settings.json" ]]; then
        echo "    settings.json exists, skipping (delete it first to overwrite)"
    else
        cp "$REPO_DIR/configs/claude-settings.json" "$CLAUDE_DIR/settings.json"
        echo "    settings.json installed"
    fi
fi

echo ""
echo "==> Done! Everything synced."
