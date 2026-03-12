# Troubleshooting

## Common Issues

### `cc` command not found

**Cause:** Shell functions not loaded.

**Fix:**
```bash
source ~/.zshrc
```

If still missing, check that the functions exist in your shell RC file:
```bash
grep "Claude Code Power Setup" ~/.zshrc
```

If not present, re-run:
```bash
bash scripts/install-shell.sh
source ~/.zshrc
```

### `cc` opens tmux but Claude Code doesn't start

**Cause:** Claude Code not in PATH inside tmux, or shell init too slow.

**Fix:** The launcher uses `zsh -l` (login shell) + `sleep 2` before sending the claude command. If your shell takes longer to initialize:

1. Edit `~/claude-launcher.sh`
2. Change `sleep 2` to `sleep 3` or `sleep 4`

If Claude Code is not found at all:
```bash
which claude
# or
ls ~/.local/bin/claude
```

If not installed, re-run:
```bash
bash scripts/install-claude-code.sh
```

### Claude Code flashes and exits immediately

**Cause:** tmux is not providing a proper shell environment.

**Fix:** The launcher script uses `"zsh -l"` as the pane command, which starts a login shell. If you're using bash, edit `~/claude-launcher.sh` and replace `"zsh -l"` with `"bash -l"`.

### tmux-continuum restores old dead sessions

**Cause:** The resurrect plugin saved a previous session state.

**Fix:**
```bash
rm -rf ~/.tmux/resurrect/*
```

The config already sets `@continuum-restore 'off'`, so this should not recur.

### Keybindings don't work (Cmd+N, Cmd+Ctrl+R, etc.)

**Cause:** tmux didn't reload the config, or Ghostty didn't reload.

**Fix:**
1. Kill tmux completely: `tmux kill-server`
2. Reload Ghostty config: `Cmd+Shift+,`
3. Start fresh: `cc`

If the specific binding `Cmd+Ctrl+R` (rename) shows a clock instead, the tmux config needs the `unbind t` line. Verify:
```bash
grep "unbind t" ~/.tmux.conf
```

### Option+Ctrl+arrows don't navigate panels

**Cause:** `macos-option-as-alt` not set in Ghostty.

**Fix:** Verify Ghostty config has:
```
macos-option-as-alt = true
```

Then reload Ghostty: `Cmd+Shift+,`

### Option+Left/Right moves cursor instead of switching panels

**Cause:** You're using `Option+arrows` without `Ctrl`. Those are macOS word-navigation shortcuts.

**Fix:** Use `Option+Ctrl+arrows` (all four directions). This is intentional to avoid conflicting with macOS defaults.

### tmux says "no sessions" when running `cc`

**Cause:** No tmux server is running. This is normal on first use or after `tmux kill-server`.

**Fix:** Just run `cc` - it will create a new session automatically.

### Panels are unevenly sized

**Fix:** Press `Cmd+Shift+=` to redistribute all panels into an equal tiled grid. Or use `Ctrl+arrow keys` to manually resize.

### Mouse scroll doesn't work in tmux

**Cause:** tmux mouse mode not enabled or plugin not installed.

**Fix:** Verify tmux config has:
```
set -g mouse on
```

And the better-mouse-mode plugin is installed:
```bash
ls ~/.tmux/plugins/tmux-better-mouse-mode/
```

If missing, reinstall plugins:
```bash
~/.tmux/plugins/tpm/bin/install_plugins
```

### Copy/paste doesn't work with mouse

**Cause:** tmux-yank plugin not installed.

**Fix:**
```bash
~/.tmux/plugins/tpm/bin/install_plugins
```

After installing, select text with mouse - it automatically copies to system clipboard.

### Colors look wrong in tmux

**Cause:** Terminal doesn't support true color, or tmux config missing overrides.

**Fix:** The tmux config includes:
```
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color:Tc"
```

Your terminal must support true color. Ghostty, iTerm2, Kitty, WezTerm, and Alacritty all do.

### Ghostty not installed

Ghostty must be installed manually. Download from: https://ghostty.org

The installer only configures Ghostty - it does not install the application itself.

### Python tools fail to install

**Cause:** macOS Homebrew Python blocks system-wide pip installs.

**Fix:** The installer creates a virtual environment at `~/claude-tools/.venv/`. If it fails:
```bash
python3 -m venv ~/claude-tools/.venv
source ~/claude-tools/.venv/bin/activate
pip install -e ~/claude-tools/claude-swarm
pip install -e ~/claude-tools/zerg
deactivate
```

### Rust tool (ccswarm) fails to build

**Cause:** Rust/Cargo not installed.

**Fix:** Install Rust:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
```

Then rebuild:
```bash
cd ~/claude-tools/ccswarm && cargo build --release
```

## Nuclear Reset

If everything is broken and you want to start fresh:

```bash
# Kill all tmux
tmux kill-server 2>/dev/null

# Remove tmux config and plugins
rm -f ~/.tmux.conf
rm -rf ~/.tmux/

# Remove Claude launcher
rm -f ~/claude-launcher.sh

# Remove shell functions (manually edit ~/.zshrc and remove the "Claude Code Power Setup" block)

# Remove Claude rules and settings
rm -rf ~/.claude/rules/
rm -f ~/.claude/settings.json

# Remove multi-agent tools
rm -rf ~/claude-tools/

# Then reinstall
cd <this-repo> && ./install.sh
```
