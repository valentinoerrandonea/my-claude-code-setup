# Claude Code Power Setup

A complete, opinionated setup for running Claude Code like a power user. Multiple AI agents in a tiled tmux grid, one-keystroke spawning, global coding rules, and multi-agent orchestration tools.

## What You Get

- **tmux-powered multi-agent workflow**: Spawn multiple Claude Code instances in a tiled grid with a single keystroke
- **Ghostty terminal integration**: Cmd+N to spawn agents, Option+Ctrl+arrows to navigate
- **Smart launcher commands**: `cc`, `ccnew`, `ccresume`, `ccpick`
- **Global coding rules**: TDD, security checks, immutability, conventional commits - active in every project
- **Multi-agent tools**: Claude Swarm, Zerg, Overstory, ccswarm, Ruflo
- **Tokyo Night themed tmux**: Pane titles, status bar, visual indicators

## Quick Start

### Prerequisites

- **macOS** or **Linux**
- **Git** installed
- **Homebrew** (macOS only)
- **Node.js** or **Bun** (for Claude Code installation)
- **Ghostty** terminal (download from [ghostty.org](https://ghostty.org))
- **Claude Code account**: Pro, Max, Teams, or Enterprise

### Install

Clone this repo and run the installer:

```bash
git clone https://github.com/<your-user>/claude-code-power-setup.git
cd claude-code-power-setup
chmod +x install.sh scripts/*.sh
./install.sh
```

Or ask your Claude Code to do it:

> "Clone and install everything from this repo: `<repo-url>`"

Claude Code will read the `CLAUDE.md` file and execute the installation automatically.

For a minimal install (skip multi-agent tools):

```bash
./install.sh --minimal
```

### After Installation

1. Reload your shell: `source ~/.zshrc`
2. Authenticate Claude Code (if first time): `claude`
3. Restart Ghostty to apply the terminal config
4. Launch: `cc`

## Commands

| Command | Action |
|---------|--------|
| `cc` | Open tmux with Claude Code (reconnects if session exists) |
| `ccnew` | Kill existing session, start fresh |
| `ccresume` | Start Claude Code continuing last conversation |
| `ccpick` | Start Claude Code with conversation picker |

## Keybindings (Inside tmux + Ghostty)

### Spawning & Managing Panels

| Keybinding | Action |
|------------|--------|
| `Cmd+N` | New Claude Code panel (auto-tiled) |
| `Cmd+Shift+N` | New Claude Code panel (vertical, auto-tiled) |
| `Cmd+Ctrl+R` | Rename current panel |
| `Cmd+Shift+=` | Redistribute panels equally |

### Navigation

| Keybinding | Action |
|------------|--------|
| `Option+Ctrl+Arrow` | Move between panels |
| `Ctrl+Arrow` | Resize panels |
| Mouse click | Focus panel |
| Mouse scroll | Scroll output |

### tmux Prefix Commands (Ctrl+A, then...)

| Key | Action |
|-----|--------|
| `\|` | Split horizontally |
| `-` | Split vertically |
| `d` | Detach (session stays alive) |
| `r` | Reload tmux config |
| `t` | Rename panel title |

See [docs/keybindings-reference.md](docs/keybindings-reference.md) for the full list.

## Architecture

```
~/.config/ghostty/config     Ghostty terminal config with tmux keybindings
~/.tmux.conf                 tmux config: theme, plugins, Claude Code bindings
~/claude-launcher.sh         Launcher script (cc/ccnew/ccresume/ccpick)
~/.claude/rules/             Global coding rules (TDD, security, style, etc.)
~/.claude/settings.json      Agent teams enabled, permissions config
~/.tmux/plugins/             tmux plugins via TPM
~/claude-tools/              Multi-agent tools and reference repos
```

## What Gets Installed

### Core Stack

| Component | Description |
|-----------|-------------|
| **Claude Code** | AI coding assistant CLI |
| **tmux** | Terminal multiplexer |
| **TPM** | tmux Plugin Manager |
| **tmux-yank** | Copy to system clipboard with mouse |
| **tmux-better-mouse-mode** | Enhanced mouse support (scroll in less/man) |
| **tmux-resurrect** | Save/restore tmux sessions |
| **tmux-continuum** | Auto-save sessions (restore disabled) |
| **tmux-sensible** | Sensible default settings |
| **tmux-open** | Open files/URLs from tmux |

### Claude Code Enhancements

| Component | Description |
|-----------|-------------|
| **Global rules** | From [everything-claude-code](https://github.com/affaan-m/everything-claude-code) |
| **Agent teams** | Experimental multi-agent feature enabled |
| **Bypass permissions** | `--dangerously-skip-permissions` on all instances |

### Multi-Agent Tools

| Tool | Language | Description |
|------|----------|-------------|
| [Claude Swarm](https://github.com/claudio-silva/claude-swarm) | Python | YAML-defined agent networks |
| [Zerg](https://github.com/codeium/zerg) | Python | Coordinated agent swarms |
| [Overstory](https://github.com/overtone-app/overstory) | Bun/Node | Visual agent monitoring UI |
| [ccswarm](https://github.com/deansher/ccswarm) | Rust | High-performance coordinator |
| [Ruflo](https://github.com/ruflo/ruflo) | Node.js | Workflow automation pipelines |

### Reference Repos

| Repo | Description |
|------|-------------|
| [awesome-claude-code](https://github.com/anthropics/awesome-claude-code) | Curated resources and tips |
| [agents](https://github.com/wshobson/agents) | Example agent implementations |
| [claude-code-mcp-servers](https://github.com/anthropics/claude-code-mcp-servers) | Official MCP servers |
| [awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers) | Community MCP servers |

## Workflow Examples

### Daily Solo Development

```bash
cc                          # Start Claude Code
# ... work on features ...
# Close terminal (session stays alive)
cc                          # Reconnect later
```

### Multi-Agent Feature Development

```bash
cc                          # Start main agent
Cmd+N                       # Spawn test agent
Cmd+N                       # Spawn docs agent
Cmd+Ctrl+R → "main"        # Label panels
Cmd+Ctrl+R → "tests"
Cmd+Ctrl+R → "docs"
```

Give each agent its task:
- **main**: "Implement user authentication API"
- **tests**: "Write integration tests for auth endpoints"
- **docs**: "Update API documentation for auth"

### Parallel Exploration

```bash
cc                          # Start agent 1
Cmd+N                       # Agent 2
Cmd+N                       # Agent 3
```

- **Agent 1**: "Research the best approach for caching in this app"
- **Agent 2**: "Analyze the current database query performance"
- **Agent 3**: "Review the security of the auth implementation"

Synthesize findings from all three agents into a single action plan.

## Customization

### Change the tmux Theme

Edit `~/.tmux.conf` and modify the color values. The current theme uses Tokyo Night colors:
- Background: `#1a1b26`
- Foreground: `#a9b1d6`
- Accent: `#7aa2f7`
- Muted: `#3b4261`, `#565f89`

### Change the Ghostty Theme

Edit `~/.config/ghostty/config` and change:
```
theme = catppuccin-mocha
```

Browse available themes: `ghostty +list-themes`

### Add Custom Claude Code Rules

Create `.md` files in `~/.claude/rules/common/` for rules that apply to all projects, or in `~/.claude/rules/python/` / `~/.claude/rules/typescript/` for language-specific rules.

### Disable Bypass Permissions

Edit `~/claude-launcher.sh` and remove `--dangerously-skip-permissions` from the `CLAUDE` variable. Also edit `~/.tmux.conf` and remove it from the `bind n` and `bind N` lines.

## Documentation

- [Tools Guide (No-Tech)](docs/tools-guide.md) - Every tool explained in plain language with analogies
- [Usage Guide](docs/usage-guide.md) - Detailed usage instructions
- [Keybindings Reference](docs/keybindings-reference.md) - Complete keybinding list
- [Multi-Agent Tools](docs/multi-agent-tools.md) - Technical guide to multi-agent tools
- [Troubleshooting](docs/troubleshooting.md) - Common issues and fixes
- [Contributing](CONTRIBUTING.md) - How to add tools, skills, and improvements

## Contributing

This repo is a **living project**. Everyone is welcome to add new tools, skills, configs, and improvements via Pull Requests.

**How it works:** Tell your Claude Code to add something. It reads the `CLAUDE.md` and `CONTRIBUTING.md` files and knows exactly how to:
1. Create a new branch
2. Add the tool/skill/config
3. Update all documentation
4. Create a properly formatted PR

See [CONTRIBUTING.md](CONTRIBUTING.md) for the full rules.

## Uninstall

```bash
# Kill tmux
tmux kill-server

# Remove configs
rm -f ~/.tmux.conf
rm -rf ~/.tmux/
rm -f ~/claude-launcher.sh
rm -rf ~/.claude/rules/
rm -f ~/.claude/settings.json
rm -rf ~/claude-tools/

# Remove shell functions (edit ~/.zshrc, delete the "Claude Code Power Setup" block)

# Restore Ghostty config from backup
ls ~/.config/ghostty/config.backup.*
cp ~/.config/ghostty/config.backup.<timestamp> ~/.config/ghostty/config
```

## License

MIT
