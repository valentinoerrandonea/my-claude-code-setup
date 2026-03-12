# Keybindings Reference

## Shell Commands

| Command | Action |
|---------|--------|
| `cc` | Open tmux with Claude Code (or reconnect to existing session) |
| `ccnew` | Kill existing session and start fresh Claude Code |
| `ccresume` | Start Claude Code continuing last conversation |
| `ccpick` | Start Claude Code with session picker (choose from history) |

## Inside tmux (via Ghostty keybindings)

These keybindings work when running tmux inside Ghostty. They send the tmux prefix sequence (Ctrl+A) followed by the mapped key.

| Keybinding | Action |
|------------|--------|
| `Cmd+N` | Spawn new Claude Code panel (horizontal split + auto-tiled) |
| `Cmd+Shift+N` | Spawn new Claude Code panel (vertical split + auto-tiled) |
| `Cmd+Shift+=` | Redistribute all panels equally (tiled layout) |
| `Cmd+Ctrl+R` | Rename current panel title |

## tmux Panel Navigation

| Keybinding | Action |
|------------|--------|
| `Option+Ctrl+Left` | Move to left panel |
| `Option+Ctrl+Right` | Move to right panel |
| `Option+Ctrl+Up` | Move to panel above |
| `Option+Ctrl+Down` | Move to panel below |
| Mouse click | Click on any panel to focus it |

## tmux Panel Resizing

| Keybinding | Action |
|------------|--------|
| `Ctrl+Left` | Shrink panel left |
| `Ctrl+Right` | Expand panel right |
| `Ctrl+Up` | Shrink panel up |
| `Ctrl+Down` | Expand panel down |
| Mouse drag | Drag pane border to resize |

## tmux Pane Splitting (with prefix)

| Keybinding | Action |
|------------|--------|
| `Ctrl+A` then `\|` | Split horizontally (side by side) |
| `Ctrl+A` then `-` | Split vertically (top and bottom) |

## tmux General

| Keybinding | Action |
|------------|--------|
| `Ctrl+A` then `r` | Reload tmux config |
| `Ctrl+A` then `d` | Detach from session (session stays alive) |
| `Ctrl+A` then `c` | New tmux window |
| `Ctrl+A` then `1-9` | Switch to window by number |
| `Ctrl+D` or `exit` | Close current panel |
| Mouse scroll | Scroll through output |

## Ghostty General

| Keybinding | Action |
|------------|--------|
| `Cmd+T` | New Ghostty tab |
| `Cmd+W` | Close current surface |
| `Cmd+Shift+Left` | Previous Ghostty tab |
| `Cmd+Shift+Right` | Next Ghostty tab |
| `Cmd+=` | Increase font size |
| `Cmd+-` | Decrease font size |
| `Cmd+0` | Reset font size |
| `Cmd+K` | Clear screen |
| `` Cmd+` `` | Toggle quick terminal (dropdown from top) |
| `Cmd+Shift+,` | Reload Ghostty config |
