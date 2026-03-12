# ─────────────────────────────────────────────────────────────
#  Shell Functions - Claude Code Power Setup
#  Add these to your ~/.zshrc or ~/.bashrc
# ─────────────────────────────────────────────────────────────

# Claude Code in tmux (passes current directory to launcher)
cc()       { $HOME/claude-launcher.sh attach "$PWD"; }  # Open / reconnect
ccnew()    { $HOME/claude-launcher.sh new "$PWD"; }      # Fresh session
ccresume() { $HOME/claude-launcher.sh resume "$PWD"; }   # Continue last conversation
ccpick()   { $HOME/claude-launcher.sh pick "$PWD"; }     # Choose from past sessions
