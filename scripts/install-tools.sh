#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  Install multi-agent tools for Claude Code
# ─────────────────────────────────────────────────────────────
set -euo pipefail

TOOLS_DIR="$HOME/claude-tools"
mkdir -p "$TOOLS_DIR"

echo "==> Installing multi-agent tools to $TOOLS_DIR..."

# ── Python virtual environment ───────────────────────────────
echo "==> Creating Python virtual environment..."
if ! command -v python3 &>/dev/null; then
    echo "ERROR: python3 not found. Install Python 3.10+ first."
    exit 1
fi

VENV_DIR="$TOOLS_DIR/.venv"
if [[ ! -d "$VENV_DIR" ]]; then
    python3 -m venv "$VENV_DIR"
fi
source "$VENV_DIR/bin/activate"

# ── Claude Swarm ─────────────────────────────────────────────
echo "==> Installing Claude Swarm..."
if [[ ! -d "$TOOLS_DIR/claude-swarm" ]]; then
    git clone https://github.com/affaan-m/claude-swarm.git "$TOOLS_DIR/claude-swarm"
fi
cd "$TOOLS_DIR/claude-swarm"
pip install -e . 2>/dev/null || pip install -r requirements.txt 2>/dev/null || true
echo "    Claude Swarm installed"

# ── Zerg ─────────────────────────────────────────────────────
echo "==> Installing Zerg..."
if [[ ! -d "$TOOLS_DIR/zerg" ]]; then
    git clone https://github.com/rocklambros/zerg.git "$TOOLS_DIR/zerg"
fi
cd "$TOOLS_DIR/zerg"
pip install -e . 2>/dev/null || pip install -r requirements.txt 2>/dev/null || true
echo "    Zerg installed"

deactivate

# ── Overstory (Bun/Node) ────────────────────────────────────
echo "==> Installing Overstory..."
if [[ ! -d "$TOOLS_DIR/overstory" ]]; then
    git clone https://github.com/jayminwest/overstory.git "$TOOLS_DIR/overstory"
fi
cd "$TOOLS_DIR/overstory"
if command -v bun &>/dev/null; then
    bun install 2>/dev/null || true
elif command -v npm &>/dev/null; then
    npm install 2>/dev/null || true
fi
echo "    Overstory installed"

# ── ccswarm (Rust) ───────────────────────────────────────────
echo "==> Installing ccswarm..."
if [[ ! -d "$TOOLS_DIR/ccswarm" ]]; then
    git clone https://github.com/nwiizo/ccswarm.git "$TOOLS_DIR/ccswarm"
fi
cd "$TOOLS_DIR/ccswarm"
if command -v cargo &>/dev/null; then
    cargo build --release 2>/dev/null || echo "    WARNING: Rust build failed. Install Rust: https://rustup.rs"
else
    echo "    WARNING: Rust not found. Install it: https://rustup.rs"
fi
echo "    ccswarm installed"

# ── Ruflo (npm global) ──────────────────────────────────────
echo "==> Installing Ruflo..."
if [[ ! -d "$TOOLS_DIR/ruflo" ]]; then
    git clone https://github.com/ruvnet/ruflo.git "$TOOLS_DIR/ruflo"
fi
cd "$TOOLS_DIR/ruflo"
if command -v npm &>/dev/null; then
    npm install 2>/dev/null || true
    echo "    Ruflo installed"
else
    echo "    WARNING: npm not found. Skipping Ruflo."
fi

# ── Reference repos (clone only) ────────────────────────────
echo "==> Cloning reference repositories..."

repos=(
    "modelcontextprotocol/servers:mcp-servers"
    "punkpeye/awesome-mcp-servers:awesome-mcp-servers"
    "hesreallyhim/awesome-claude-code:awesome-claude-code"
    "wshobson/agents:agents-reference"
)

for entry in "${repos[@]}"; do
    repo="${entry%%:*}"
    dirname="${entry##*:}"
    if [[ ! -d "$TOOLS_DIR/$dirname" ]]; then
        git clone "https://github.com/$repo.git" "$TOOLS_DIR/$dirname" 2>/dev/null || \
            echo "    WARNING: Could not clone $repo"
    fi
    echo "    $dirname cloned"
done

echo ""
echo "==> All tools installed in $TOOLS_DIR"
echo ""
echo "Tools summary:"
echo "  - Claude Swarm:  Multi-agent orchestration (Python)"
echo "  - Zerg:          Agent swarm framework (Python)"
echo "  - Overstory:     Agent monitoring UI (Bun/Node)"
echo "  - ccswarm:       Rust-based swarm coordinator"
echo "  - Ruflo:         Workflow automation (npm global)"
echo "  - Reference repos: awesome-claude-code, agents, MCP servers"
