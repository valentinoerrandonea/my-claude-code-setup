# Contributing to Claude Code Power Setup

This repo is designed to be a **living project** that grows as we discover new tools, skills, and workflows. Contributions are made via Pull Requests, and those PRs will typically be created by Claude Code on behalf of contributors.

## Rules for Contributing

### 1. Always Work on a New Branch

Never commit directly to `main`. Every change must be on its own branch.

```bash
git checkout -b <type>/<short-description>
```

Branch naming convention:

| Prefix | When to use | Example |
|--------|-------------|---------|
| `tool/` | Adding a new tool or integration | `tool/add-cursor-rules` |
| `skill/` | Adding a new Claude Code skill | `skill/add-deploy-checker` |
| `fix/` | Fixing a bug or broken script | `fix/tmux-plugin-install` |
| `docs/` | Documentation only | `docs/improve-zerg-guide` |
| `config/` | Changing configs (tmux, ghostty, etc.) | `config/add-vim-keybindings` |
| `feat/` | New features to the setup | `feat/auto-update-script` |

### 2. Every Change Must Be Documented

No exceptions. If you add, modify, or remove anything, the documentation must be updated.

**Adding a new tool:**
- Add an install script in `scripts/` (or add to `scripts/install-tools.sh`)
- Add a section in `docs/tools-guide.md` explaining what it does in simple, non-technical language
- Add a row to the tool tables in `README.md`
- If it has keybindings, add them to `docs/keybindings-reference.md`
- Update `CLAUDE.md` with any new install steps

**Adding a new skill or rule:**
- Add the skill/rule files to the appropriate location in the repo
- Add install steps in `scripts/install-rules.sh` (or a new install script)
- Document what the skill/rule does in `docs/tools-guide.md`
- Skills and rules MUST be installed globally (`~/.claude/rules/` or `~/.claude/commands/`)

**Modifying a config:**
- Update the config file in `configs/`
- Document what changed and why in `docs/` (whichever doc is relevant)
- If keybindings changed, update `docs/keybindings-reference.md`

**Fixing a bug:**
- If it was a documented issue, update `docs/troubleshooting.md`
- If the fix changes behavior, update the relevant guide

### 3. Tools and Skills Must Be Global

Everything installed by this setup must work globally - in any directory, any project, any Claude Code session.

- **Rules** go in `~/.claude/rules/common/` (or `/python/`, `/typescript/` for language-specific)
- **Skills/Commands** go in `~/.claude/commands/`
- **Settings** go in `~/.claude/settings.json`
- **Tools** go in `~/claude-tools/`
- **Scripts** go in `~/` (home directory)

Never install anything that only works in a specific project directory.

### 4. PR Structure

Every Pull Request must follow this format:

**Title:** `<type>: <short description>`

Examples:
- `tool: add superagent orchestration framework`
- `skill: add deploy-checker slash command`
- `fix: tmux plugin install fails on Linux`
- `docs: improve Zerg usage examples`
- `config: add kitty terminal support`

**Body:**

```markdown
## What

One paragraph explaining what this PR adds or changes.

## Why

One paragraph explaining why this is useful.

## What Changed

- Bullet list of every file added or modified
- Be specific: "Added `scripts/install-superagent.sh`"
- Include config changes: "Added superagent section to `configs/tmux.conf`"

## Documentation Updated

- [ ] `docs/tools-guide.md` - Added section for [tool name]
- [ ] `README.md` - Added to tool table
- [ ] `docs/keybindings-reference.md` - Added new keybindings (if applicable)
- [ ] `docs/troubleshooting.md` - Added known issues (if applicable)
- [ ] `CLAUDE.md` - Updated install steps (if applicable)

## Install & Test

Steps to verify this works:
1. Run `./install.sh` (or the specific script)
2. Expected result: ...
3. Verified on: macOS / Linux

## Breaking Changes

None / List any breaking changes here.
```

### 5. PR Checklist (Reviewers Will Check This)

Before a PR is merged, it must pass these checks:

- [ ] Branch is NOT `main`
- [ ] All new tools/skills are configured globally
- [ ] `docs/tools-guide.md` is updated with non-technical explanation
- [ ] `README.md` tables are updated
- [ ] Install scripts work (tested or clearly documented)
- [ ] No hardcoded paths to a specific user's home directory (use `$HOME` or `~`)
- [ ] No secrets, tokens, or API keys in any file
- [ ] Config backups are created before overwriting (`*.backup.<timestamp>`)
- [ ] New scripts are executable (`chmod +x`)
- [ ] PR title follows `<type>: <description>` format
- [ ] PR body has all required sections

---

## How to Contribute (Step by Step)

### If You're Using Claude Code (Recommended)

Tell your Claude Code:

> "Clone this repo, create a new branch, add [what you want], update all documentation, and create a PR."

Your Claude Code will read this `CONTRIBUTING.md` and the `CLAUDE.md` and know exactly what to do.

### If You're Contributing Manually

1. Fork or clone the repo
2. Create a branch: `git checkout -b tool/my-new-tool`
3. Make your changes
4. Update ALL relevant documentation
5. Test the install scripts
6. Create a PR following the format above

---

## Writing Documentation for Non-Technical People

When adding to `docs/tools-guide.md`, follow these rules:

1. **Start with "Que es"** - One sentence, plain language
2. **Use an analogy** - Compare it to something from everyday life
3. **Show a concrete example** - What does it look like in practice?
4. **Say when to use it** - In what situation would someone reach for this tool?
5. **Say where it is** - File path or command to run
6. **No jargon without explanation** - If you use a technical term, explain it in parentheses

**Good example:**
> **Que es:** Un panel de control visual para ver que estan haciendo tus agentes.
>
> **Analogia:** Es como el panel de control de un aeropuerto. Cada avion (agente) aparece en la pantalla con su estado.

**Bad example:**
> Overstory is a real-time agent monitoring dashboard built on WebSockets with a React frontend.

---

## Questions?

If you're not sure whether your contribution fits, open an issue first describing what you want to add. Or just tell your Claude Code to open an issue asking about it.
