#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  Git post-merge hook: auto-sync configs to ~/.claude/
#  Runs automatically after every git pull / git merge
# ─────────────────────────────────────────────────────────────
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo ""
echo "🔄 Auto-syncing configs to $CLAUDE_DIR..."

# Agents
if [[ -d "$REPO_DIR/configs/agents" ]]; then
    mkdir -p "$CLAUDE_DIR/agents"
    cp "$REPO_DIR/configs/agents/"*.md "$CLAUDE_DIR/agents/" 2>/dev/null || true
    AGENT_COUNT=$(ls "$CLAUDE_DIR/agents/"*.md 2>/dev/null | wc -l | tr -d ' ')
    echo "   $AGENT_COUNT agents synced"
fi

# Strategy
if [[ -d "$REPO_DIR/configs/strategy" ]]; then
    mkdir -p "$CLAUDE_DIR/strategy"
    cp -r "$REPO_DIR/configs/strategy/"* "$CLAUDE_DIR/strategy/"
    echo "   Strategy playbooks synced"
fi

echo "   Done!"
echo ""
