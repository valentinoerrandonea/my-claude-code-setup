# Multi-Agent Tools Guide

## Overview

This setup includes several tools for orchestrating multiple Claude Code instances. They range from simple (manual tmux panels) to advanced (programmatic swarm frameworks).

## Tool Comparison

| Tool | Complexity | Best For |
|------|-----------|----------|
| **tmux panels** (built-in) | Simple | 2-4 manual agents, daily work |
| **Claude Swarm** | Medium | YAML-defined agent networks |
| **Zerg** | Medium | Coordinated agent groups |
| **Overstory** | Medium | Visual monitoring of agents |
| **ccswarm** | Advanced | High-performance Rust coordinator |
| **Ruflo** | Advanced | Multi-step workflow pipelines |

## tmux Panels (Built-in)

The simplest approach. No extra tools needed.

**How it works:** Each tmux panel runs an independent Claude Code instance. You manually give each one a task and switch between them.

**Best for:** Daily development with 2-4 agents. For example:
- One agent writes code, another writes tests
- One agent works on frontend, another on backend
- One agent researches while another implements

**Usage:**
```
cc              # Start first agent
Cmd+N           # Spawn second agent
Cmd+N           # Spawn third agent
Cmd+Ctrl+R      # Rename panels for clarity
```

## Claude Swarm

**Location:** `~/claude-tools/claude-swarm`
**Type:** Python
**Repo:** https://github.com/claudio-silva/claude-swarm

Define agent networks in YAML. Each agent has a role, instructions, and can communicate with other agents.

**Example swarm config:**
```yaml
swarm:
  name: "fullstack-team"
  agents:
    architect:
      role: "System architect"
      instructions: "Design the overall system architecture"
    backend:
      role: "Backend developer"
      instructions: "Implement API endpoints and business logic"
    frontend:
      role: "Frontend developer"
      instructions: "Build React components and pages"
    tester:
      role: "QA engineer"
      instructions: "Write and run tests for all components"
```

**Activate:**
```bash
source ~/claude-tools/.venv/bin/activate
cd ~/claude-tools/claude-swarm
# Follow the tool's README for usage
```

## Zerg

**Location:** `~/claude-tools/zerg`
**Type:** Python
**Repo:** https://github.com/codeium/zerg

Swarm framework for spinning up coordinated groups of Claude Code agents. Focused on parallel task execution.

**Activate:**
```bash
source ~/claude-tools/.venv/bin/activate
cd ~/claude-tools/zerg
# Follow the tool's README for usage
```

## Overstory

**Location:** `~/claude-tools/overstory`
**Type:** Bun/Node
**Repo:** https://github.com/overtone-app/overstory

Visual monitoring UI for Claude Code agents. See what each agent is doing in real-time through a web dashboard.

**Run:**
```bash
cd ~/claude-tools/overstory
bun run dev   # or npm run dev
```

Then open the displayed URL in your browser.

## ccswarm

**Location:** `~/claude-tools/ccswarm`
**Type:** Rust
**Repo:** https://github.com/deansher/ccswarm

High-performance coordinator for Claude Code instances. Written in Rust for minimal overhead.

**Build & run:**
```bash
cd ~/claude-tools/ccswarm
cargo build --release
./target/release/ccswarm --help
```

## Ruflo

**Location:** Global (npm)
**Type:** Node.js
**Repo:** https://github.com/ruflo/ruflo

Workflow automation tool. Define multi-step pipelines where each step can be handled by a different agent.

**Usage:**
```bash
ruflo --help
```

## Reference Repositories

These repos are cloned for reference and learning:

| Repo | Description |
|------|-------------|
| `~/claude-tools/awesome-claude-code` | Curated list of Claude Code resources, tips, and tools |
| `~/claude-tools/agents-reference` | Example agent implementations and patterns |
| `~/claude-tools/mcp-servers` | Official Anthropic MCP servers for Claude Code |
| `~/claude-tools/awesome-mcp-servers` | Community-curated list of MCP servers |

## Claude Code Rules (everything-claude-code)

Installed globally to `~/.claude/rules/`. These rules enhance Claude Code's behavior:

| Rule | Purpose |
|------|---------|
| `coding-style` | Immutability, file organization, error handling |
| `testing` | TDD workflow, 80% coverage minimum |
| `security` | No hardcoded secrets, input validation, CSRF/XSS prevention |
| `performance` | Model selection, context management |
| `patterns` | Repository pattern, API response format |
| `agents` | Agent orchestration, parallel execution |
| `git-workflow` | Conventional commits, PR process |
| `development-workflow` | Research-first, plan-first, TDD approach |
| `hooks` | Pre/Post tool hooks, TodoWrite best practices |

These rules are active in ALL projects globally, making every Claude Code session smarter.
