# kitty-ai-subagent

Spawn parallel AI agent workers from [Kitty terminal](https://sw.kovidgoyal.net/kitty/).

Delegate subtasks to Claude, Codex, Gemini or any CLI-based AI agent without losing context from your current session.

## Features

- **Context capture** - Automatically captures scrollback from your current terminal
- **Smart summarization** - Summarizes large contexts using Claude or Gemini
- **Parallel agents** - Spawn multiple agents in separate tabs
- **Works with any CLI agent** - Claude, Codex, Gemini, or custom agents

## Requirements

- [Kitty terminal](https://sw.kovidgoyal.net/kitty/) with remote control enabled
- At least one CLI AI agent installed (claude, codex, gemini, etc.)
- Python 3 (for parsing Kitty's JSON output)

## Installation

```bash
# Clone the repository
git clone https://github.com/softaworks/kitty-ai-subagent.git
cd kitty-ai-subagent

# Make executable and copy to PATH
chmod +x kitty-ai-subagent
cp kitty-ai-subagent ~/.local/bin/
```

Or use the install script:

```bash
./install.sh
```

## Kitty Configuration

Add to your `~/.config/kitty/kitty.conf`:

```bash
# Required for remote control
allow_remote_control yes
listen_on unix:/tmp/kitty-$KITTY_PID
```

### Optional: Keyboard shortcuts

```bash
# Spawn agents with Ctrl+Shift + Numpad keys
map ctrl+shift+kp_4 launch --type=overlay zsh -ilc "kitty-ai-subagent prompt-spawn claude"
map ctrl+shift+kp_5 launch --type=overlay zsh -ilc "kitty-ai-subagent prompt-spawn codex"
map ctrl+shift+kp_6 launch --type=overlay zsh -ilc "kitty-ai-subagent prompt-spawn gemini"
```

Reload config with `Ctrl+Shift+F5`.

## Usage

### Interactive mode (prompts for task)

```bash
kitty-ai-subagent prompt-spawn claude
```

### Direct spawn with task

```bash
kitty-ai-subagent spawn --agent claude --task "Review this code for bugs"
```

### Quick spawn (no context capture)

```bash
kitty-ai-subagent quick gemini "What is the capital of France?"
```

### List active subagents

```bash
kitty-ai-subagent list
```

## How it works

1. **Captures context** from your current terminal (last 1000 lines)
2. **Summarizes** if context is large (>500 lines) using Claude/Gemini
3. **Opens new tab** in Kitty with the specified agent
4. **Injects the task** with context automatically

The subagent receives:
```xml
<context>
[Your terminal context or summary]
</context>

<task>
Your task here

Constraints:
- Do not create or modify files unless the task explicitly asks you to.
- Respond in this chat/session output (no writing to disk).
</task>
```

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `KITTY_SUBAGENT_CONTEXT_LINES` | 1000 | Max lines to capture |
| `KITTY_SUBAGENT_SUMMARIZE_MIN_LINES` | 500 | Summarize if exceeds this |
| `KITTY_SUBAGENT_SUMMARIZATION_TOOL` | claude | Tool for summarization (claude/gemini) |
| `KITTY_SUBAGENT_SUMMARIZATION_MODEL` | sonnet | Model for Claude summarization |
| `KITTY_SUBAGENT_STARTUP_DELAY_SECS` | 2 | Delay before injecting prompt |

## Inspired by

[tmux-subagent](https://github.com/kaushikgopal/dotfiles/blob/master/bin/tmux-subagent) by Kaushik Gopal - same concept but for tmux.

## License

MIT
