# Claude Code Power Setup

This file is for **Claude Code** to read and execute. It contains both installation instructions and contribution rules. Follow them exactly.

---

## Part 1: Installation

When a user asks you to install this setup, follow these steps.

### Quick Install (Preferred)

```bash
cd <this-repo-directory>
chmod +x install.sh scripts/*.sh
./install.sh
```

For a minimal install (skip multi-agent tools):

```bash
./install.sh --minimal
```

### What Gets Installed

1. **Claude Code CLI** - The AI coding assistant
2. **tmux** - Terminal multiplexer with Tokyo Night theme, plugins, and Claude Code keybindings
3. **Ghostty config** - Terminal emulator configuration with tmux integration keybindings
4. **Shell functions** - `cc`, `ccnew`, `ccresume`, `ccpick` commands
5. **Claude Code rules** - Global rules from everything-claude-code (coding style, TDD, security, agents, etc.)
6. **Claude Code settings** - Agent teams enabled, skip-permissions prompt disabled
7. **Multi-agent tools** - Claude Swarm, Zerg, Overstory, ccswarm, Ruflo, and reference repos

### Manual Step-by-Step Install

```bash
bash scripts/install-claude-code.sh    # Step 1: Claude Code CLI
bash scripts/install-tmux.sh           # Step 2: tmux + TPM + 6 plugins
bash scripts/install-ghostty.sh        # Step 3: Ghostty config
bash scripts/install-shell.sh          # Step 4: Shell functions + launcher
bash scripts/install-rules.sh          # Step 5: Claude Code rules & settings
bash scripts/install-tools.sh          # Step 6: Multi-agent tools
```

### Post-Installation

Tell the user:
1. **Reload shell**: `source ~/.zshrc`
2. **Authenticate Claude Code** (if first time): Run `claude`
3. **Restart Ghostty** to apply the terminal config
4. **Launch**: Type `cc` in terminal

### Technical Notes

- All scripts back up existing configs before overwriting (`.backup.<timestamp>`)
- tmux prefix is **Ctrl+A** (not Ctrl+B)
- `macos-option-as-alt = true` is set in Ghostty for tmux keybindings to work
- Claude Code instances spawn with `--dangerously-skip-permissions` flag
- The launcher uses `zsh -l` + `sleep 2` + `send-keys` pattern for proper shell init
- `tmux-continuum` restore is disabled to prevent stale sessions

### File Locations After Install

| File | Location |
|------|----------|
| tmux config | `~/.tmux.conf` |
| Ghostty config | `~/.config/ghostty/config` |
| Launcher script | `~/claude-launcher.sh` |
| Claude rules | `~/.claude/rules/` |
| Claude settings | `~/.claude/settings.json` |
| tmux plugins | `~/.tmux/plugins/` |
| Multi-agent tools | `~/claude-tools/` |
| Shell functions | `~/.zshrc` or `~/.bashrc` |

---

## Part 2: Agent Teams + Worktrees (Parallel Work)

When the user asks you to do multiple tasks in parallel, or when a task is large enough to benefit from parallel execution, use Agent Teams with worktree isolation.

### When to Use This

- User explicitly asks for parallel work ("hacelo en paralelo", "dividi esto en partes")
- A feature involves independent parts: backend + tests + docs
- A code review should cover multiple dimensions: security + performance + quality
- A refactor can be split into modules that don't overlap
- The user wants to compare multiple approaches to the same problem

### How to Orchestrate

#### Step 1: Verify the project is a git repo

```bash
git rev-parse --git-dir 2>/dev/null || (git init && git add -A && git commit -m "initial commit")
```

If it's not a git repo, initialize one. Worktrees require Git.

#### Step 2: Plan the task split

Before spawning agents, analyze the task and split it into parts that can be done independently. Each part should touch DIFFERENT files to minimize merge conflicts.

Good split: Agent 1 does `src/auth/`, Agent 2 does `tests/auth/`, Agent 3 does `docs/`
Bad split: Agent 1 and Agent 2 both modify `src/index.ts`

#### Step 3: Spawn agents with worktree isolation

Use the `Agent` tool with `isolation: "worktree"` for each sub-task:

```
Agent(
  subagent_type: "general-purpose",
  isolation: "worktree",
  prompt: "Your task: implement the authentication API in src/auth/. Create the routes, middleware, and database models. Do NOT modify files outside src/auth/.",
  description: "Implement auth API",
  name: "agent-backend"
)
```

Launch ALL agents in a SINGLE message (parallel, not sequential):

```
# In ONE message, launch all agents:
Agent(name: "agent-backend", isolation: "worktree", prompt: "...")
Agent(name: "agent-tests", isolation: "worktree", prompt: "...")
Agent(name: "agent-docs", isolation: "worktree", prompt: "...")
```

#### Step 4: Each agent works in isolation

Each agent gets its own worktree (a copy of the repo in its own branch). They cannot interfere with each other.

#### Step 5: Collect results and merge

When agents finish, they return their results including the worktree path and branch name. Merge each branch:

```bash
git merge <agent-branch-name> --no-edit
```

If there are conflicts, resolve them. Then clean up:

```bash
git worktree prune
```

#### Step 6: Report to the user

Tell the user:
- What each agent did
- Whether there were merge conflicts and how they were resolved
- A summary of all changes
- Whether tests pass (if applicable)

### Important Rules

- ALWAYS use `isolation: "worktree"` when running parallel agents that modify files
- ALWAYS launch agents in a single message for true parallel execution
- Give each agent CLEAR boundaries (which files/directories they own)
- Tell agents explicitly NOT to modify files outside their scope
- Keep agents to 3-5 maximum for practical performance
- After merging, run tests if the project has them
- If an agent fails, report it to the user and offer to retry

### Example: Full Feature Implementation

User says: "Implementa un sistema de notificaciones en paralelo"

You do:

1. Analyze the project structure
2. Plan the split:
   - Agent 1: Backend service (`src/notifications/`)
   - Agent 2: Tests (`tests/notifications/`)
   - Agent 3: Documentation (`docs/notifications.md`, `README.md`)
3. Spawn all 3 agents with `isolation: "worktree"` in a single message
4. Wait for all to complete
5. Merge branches one by one
6. Run tests
7. Report results

---

## Part 3: Contributing (Adding New Tools, Skills, or Changes)

This repo is meant to evolve. When the user asks you to add a new tool, skill, config, or any improvement, follow this process **exactly**.

### Step 1: Always Create a New Branch

NEVER work directly on `main`. Every change gets its own branch.

```bash
git checkout main
git pull origin main
git checkout -b <type>/<short-description>
```

Branch naming:

| Prefix | Use for | Example |
|--------|---------|---------|
| `tool/` | New tool or integration | `tool/add-superagent` |
| `skill/` | New Claude Code skill | `skill/add-deploy-checker` |
| `fix/` | Bug fix | `fix/tmux-plugin-path` |
| `docs/` | Documentation only | `docs/improve-zerg-examples` |
| `config/` | Config changes | `config/add-kitty-support` |
| `feat/` | New features | `feat/auto-updater` |

### Step 2: Make Your Changes

Follow these rules depending on what you're adding:

#### Adding a New Tool

1. **Create or update an install script** in `scripts/`
   - If it's a major tool: create `scripts/install-<toolname>.sh`
   - If it's small: add to `scripts/install-tools.sh`
   - Script MUST be idempotent (safe to run multiple times)
   - Script MUST back up existing files before overwriting
   - Script MUST use `$HOME` not hardcoded paths like `/Users/someone/`
   - Script MUST handle errors with `set -euo pipefail`

2. **Update `install.sh`** if adding a new major install step

3. **The tool MUST be installed globally** - it must work from any directory
   - Tools go in `~/claude-tools/`
   - Global npm packages via `npm install -g`
   - Python tools in `~/claude-tools/.venv/`

#### Adding a New Skill or Rule

1. **Include the skill/rule files** in the repo under an appropriate path
2. **Update `scripts/install-rules.sh`** to copy them to:
   - Skills/commands: `~/.claude/commands/`
   - Rules: `~/.claude/rules/common/` (or `/python/`, `/typescript/`)
3. **Must be global** - works in every project, every directory

#### Modifying a Config

1. **Update the config file** in `configs/`
2. **Update the relevant install script** if the installation process changes

### Step 3: Update ALL Documentation

This is MANDATORY. No PR gets merged without documentation updates.

**For every change, update these files as needed:**

| File | When to update |
|------|---------------|
| `docs/tools-guide.md` | Adding/changing any tool, skill, or feature. Write in **non-technical language** with analogies and examples. |
| `README.md` | Adding new tools (update tables), changing commands, or modifying architecture. |
| `docs/keybindings-reference.md` | Any keybinding added or changed. |
| `docs/troubleshooting.md` | Known issues, gotchas, or anything that might confuse users. |
| `docs/multi-agent-tools.md` | Adding a new multi-agent tool or changing how existing ones work. |
| `docs/usage-guide.md` | Changes to workflow, commands, or how things are used. |
| This file (`CLAUDE.md`) | Changes to install steps, file locations, or contribution process. |

#### Writing Style for docs/tools-guide.md

This doc is for NON-TECHNICAL people. When adding a section:

1. **"Que es:"** - One sentence, plain language
2. **"Analogia:"** - Compare to everyday life (TV, factory, airport, etc.)
3. **Concrete example** - What does it look like?
4. **"Cuando usarlo:"** - In what situation?
5. **"Donde esta:"** - File path or command
6. **No jargon** - If you must use a technical term, explain it in parentheses

### Step 4: Commit and Push

```bash
git add -A
git commit -m "<type>: <description>"
git push -u origin <branch-name>
```

Commit message format: `<type>: <description>`
Types: `feat`, `fix`, `tool`, `skill`, `docs`, `config`, `chore`

### Step 5: Create the Pull Request

Use `gh pr create` with this exact format:

```bash
gh pr create --title "<type>: <description>" --body "$(cat <<'EOF'
## What

<One paragraph: what does this PR add or change?>

## Why

<One paragraph: why is this useful?>

## What Changed

<Bullet list of every file added or modified>

## Documentation Updated

- [ ] `docs/tools-guide.md` - Added/updated section
- [ ] `README.md` - Updated tables or sections
- [ ] `docs/keybindings-reference.md` - New keybindings (if applicable)
- [ ] `docs/troubleshooting.md` - Known issues (if applicable)
- [ ] `CLAUDE.md` - Updated install steps (if applicable)

## Install & Test

<Steps to verify this works>

## Breaking Changes

None / <list them>
EOF
)"
```

### PR Checklist (What Will Be Reviewed)

Before creating the PR, verify ALL of these:

- [ ] Branch is NOT `main`
- [ ] All new tools/skills are configured globally
- [ ] `docs/tools-guide.md` has a non-technical explanation
- [ ] `README.md` tables are updated
- [ ] Install scripts are idempotent and handle errors
- [ ] No hardcoded user paths (use `$HOME`)
- [ ] No secrets, tokens, or API keys
- [ ] Config backups are created before overwriting
- [ ] New scripts have `chmod +x`
- [ ] PR title follows `<type>: <description>`
- [ ] PR body has all required sections filled out

---

## Part 4: Repository Structure Reference

```
claude-code-power-setup/
├── CLAUDE.md                        # THIS FILE - Instructions for Claude Code
├── CONTRIBUTING.md                  # Human-readable contribution guide
├── README.md                        # Main documentation
├── install.sh                       # Master installer (runs all scripts)
├── .gitignore
├── .github/
│   └── pull_request_template.md     # PR template
├── configs/
│   ├── ghostty.conf                 # Ghostty terminal config
│   ├── tmux.conf                    # tmux config with theme + plugins
│   ├── shell-functions.sh           # cc/ccnew/ccresume/ccpick
│   └── claude-settings.json         # Claude Code settings.json
├── scripts/
│   ├── claude-launcher.sh           # tmux + Claude Code launcher
│   ├── install-claude-code.sh       # Install Claude Code CLI
│   ├── install-tmux.sh              # Install tmux + TPM + plugins
│   ├── install-ghostty.sh           # Install Ghostty config
│   ├── install-shell.sh             # Install shell functions + launcher
│   ├── install-rules.sh             # Install Claude Code rules + settings
│   └── install-tools.sh             # Install multi-agent tools
└── docs/
    ├── tools-guide.md               # Non-technical guide to ALL tools
    ├── usage-guide.md               # How to use the setup
    ├── keybindings-reference.md     # Complete keybinding tables
    ├── agent-teams-guide.md         # Agent Teams + Worktrees guide
    ├── multi-agent-tools.md         # Multi-agent tools deep dive
    └── troubleshooting.md           # Common issues and fixes
```
