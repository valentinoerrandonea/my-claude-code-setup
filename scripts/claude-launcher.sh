#!/usr/bin/env zsh
# ─────────────────────────────────────────────────────────────
#  Claude Code tmux Launcher
#  Usage: claude-launcher.sh [attach|new|resume|pick]
# ─────────────────────────────────────────────────────────────

# Ensure Homebrew and Claude Code are in PATH
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi
export PATH="$HOME/.local/bin:$PATH"

# Detect Claude Code binary
if command -v claude &>/dev/null; then
    CLAUDE_BIN="claude"
else
    CLAUDE_BIN="$HOME/.local/bin/claude"
fi

CLAUDE="$CLAUDE_BIN --dangerously-skip-permissions"
SESSION="claude-work"
MODE="${1:-attach}"

case $MODE in
    new)
        # Kill existing session and create a fresh one
        tmux kill-session -t $SESSION 2>/dev/null
        tmux new-session -d -s $SESSION -n "claude" "zsh -l"
        sleep 2
        tmux send-keys -t $SESSION "$CLAUDE" Enter
        tmux attach -t $SESSION
        ;;
    resume)
        # New tmux + Claude Code resuming last conversation
        tmux kill-session -t $SESSION 2>/dev/null
        tmux new-session -d -s $SESSION -n "claude" "zsh -l"
        sleep 2
        tmux send-keys -t $SESSION "$CLAUDE --continue" Enter
        tmux attach -t $SESSION
        ;;
    pick)
        # New tmux + Claude Code with session picker
        tmux kill-session -t $SESSION 2>/dev/null
        tmux new-session -d -s $SESSION -n "claude" "zsh -l"
        sleep 2
        tmux send-keys -t $SESSION "$CLAUDE --resume" Enter
        tmux attach -t $SESSION
        ;;
    attach|*)
        # Reconnect to existing session, or create new if none exists
        tmux has-session -t $SESSION 2>/dev/null
        if [ $? -eq 0 ]; then
            tmux attach -t $SESSION
        else
            tmux new-session -d -s $SESSION -n "claude" "zsh -l"
            sleep 2
            tmux send-keys -t $SESSION "$CLAUDE" Enter
            tmux attach -t $SESSION
        fi
        ;;
esac
