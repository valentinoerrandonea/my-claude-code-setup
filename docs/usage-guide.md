# Usage Guide

## Getting Started

After installation, open Ghostty and type:

```bash
cc
```

This opens a tmux session with Claude Code running. You're ready to go.

## The Four Launch Commands

### `cc` - Open / Reconnect

The default command. If a tmux session already exists, it reconnects. If not, it creates a new one with Claude Code.

```bash
cc
```

**Use when:** Starting your work day, reopening after closing the terminal, or reconnecting after detaching.

### `ccnew` - Fresh Session

Kills any existing tmux session and starts a brand new Claude Code instance. Previous conversation context is NOT preserved.

```bash
ccnew
```

**Use when:** You want a clean slate, starting a completely new project, or the current session is broken.

### `ccresume` - Continue Last Conversation

Creates a new tmux session but launches Claude Code with `--continue`, which picks up your most recent conversation.

```bash
ccresume
```

**Use when:** You closed everything but want to continue exactly where you left off.

### `ccpick` - Session Picker

Creates a new tmux session and launches Claude Code with `--resume`, which shows a list of your past conversations to choose from.

```bash
ccpick
```

**Use when:** You want to go back to a specific past conversation, not necessarily the most recent one.

## Spawning Multiple Claude Code Instances

The real power of this setup: running multiple Claude Code agents simultaneously in a tiled grid.

### Spawn a New Panel

Press `Cmd+N` inside Ghostty (while in tmux). A new Claude Code instance appears and all panels auto-arrange into a grid.

Press `Cmd+Shift+N` for a vertical split instead of horizontal (both auto-tile after).

### Navigate Between Panels

Use `Option+Ctrl+Arrow keys` to move between panels:
- `Option+Ctrl+Left/Right` - Move horizontally
- `Option+Ctrl+Up/Down` - Move vertically

Or just **click with the mouse** on any panel to focus it.

### Rename Panels

Press `Cmd+Ctrl+R` to rename the current panel. A prompt appears at the bottom of the screen. Type the name (e.g., "frontend", "backend", "tests") and press Enter.

The name appears in the panel's title bar at the top, with a `▶` indicator for the active panel.

### Redistribute Layout

If panels get uneven after resizing, press `Cmd+Shift+=` to redistribute them into an equal tiled grid.

## Workflow Examples

### Solo Development

```
cc                    # Start Claude Code
# Work normally...
# Close terminal when done. Session stays alive.
cc                    # Reconnect later
```

### Multi-Agent Development

```
cc                    # Start first Claude Code
Cmd+N                 # Spawn second (e.g., for tests)
Cmd+N                 # Spawn third (e.g., for docs)
Cmd+Ctrl+R → "main"  # Rename first panel
# Navigate to second panel
Cmd+Ctrl+R → "tests" # Rename second panel
# Navigate to third panel
Cmd+Ctrl+R → "docs"  # Rename third panel
```

Now you have three independent Claude Code agents:
- **main**: Working on feature implementation
- **tests**: Writing and running tests
- **docs**: Updating documentation

Each agent has its own conversation context and can work independently.

### Parallel Task Execution

Give each Claude Code panel a different task:

1. **Panel 1**: "Implement the user authentication API"
2. **Panel 2**: "Write integration tests for the auth endpoints"
3. **Panel 3**: "Set up the database migrations for user tables"

All three work simultaneously. Navigate between them to check progress.

## tmux Tips

### Detach Without Closing

Press `Ctrl+A` then `d` to detach from tmux. The session keeps running in the background. All your Claude Code instances stay alive.

Reconnect with `cc`.

### Scroll Through Output

Use the **mouse scroll wheel** to scroll through past output in any panel.

### Close a Single Panel

Focus the panel and type `exit` or press `Ctrl+D`. The remaining panels auto-adjust.

### Kill Everything

```bash
tmux kill-server
```

This kills all tmux sessions, all panels, all Claude Code instances.

## Quick Terminal (Ghostty Dropdown)

Press `` Cmd+` `` (backtick) for a quick dropdown terminal from the top of the screen. Great for running quick commands without leaving your current tmux session.

Configure the dropdown size in the Ghostty config:
- `quick-terminal-size = 40%` (percentage of screen height)
- `quick-terminal-position = top` (where it appears)

## Multi-Agent Tools

The setup includes several multi-agent orchestration tools installed in `~/claude-tools/`:

| Tool | What it does |
|------|-------------|
| **Claude Swarm** | Define agent networks in YAML with specialized roles and communication |
| **Zerg** | Swarm framework for spinning up coordinated agent groups |
| **Overstory** | Visual monitoring UI to see what your agents are doing |
| **ccswarm** | Rust-based coordinator for Claude Code instances |
| **Ruflo** | Workflow automation with multi-step pipelines |

These are advanced tools for power users who want to go beyond the manual multi-panel approach.
