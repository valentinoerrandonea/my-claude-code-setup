# ─────────────────────────────────────────────────────────────
#  Shell Functions - Claude Code Power Setup
#  Add these to your ~/.zshrc or ~/.bashrc
# ─────────────────────────────────────────────────────────────

# Claude Code in tmux
cc()       { $HOME/claude-launcher.sh attach; }  # Open / reconnect
ccnew()    { $HOME/claude-launcher.sh new; }      # Fresh session
ccresume() { $HOME/claude-launcher.sh resume; }   # Continue last conversation
ccpick()   { $HOME/claude-launcher.sh pick; }     # Choose from past sessions
