# Superpowers for Augment

This directory contains the installation and setup files for using Superpowers with [Augment Code](https://www.augmentcode.com).

## Files

- **INSTALL.md** - Complete installation guide with manual and automated options
- **QUICKSTART.md** - 5-minute quick start guide for new users
- **install.sh** - Automated installation script for macOS/Linux
- **install.ps1** - Automated installation script for Windows (PowerShell)
- **test-install.sh** - Verification script to test installation

## Quick Install

### macOS / Linux

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/obra/superpowers/main/.augment/install.sh)
```

### Windows (PowerShell)

```powershell
git clone https://github.com/obra/superpowers.git "$env:USERPROFILE\.augment\superpowers"
& "$env:USERPROFILE\.augment\superpowers\.augment\install.ps1"
```

## What Gets Installed

1. **Repository**: Cloned to `~/.augment/superpowers/`
2. **Skills Symlink**: Created at `~/.augment/skills/superpowers/` → points to skills directory
3. **Instructions File**: Generated at `~/.augment/superpowers-instructions.md`

## Setup Your Project

After installation, add to your project's `.augment/instructions.md`:

```markdown
@~/.augment/superpowers-instructions.md
```

## Verify Installation

```bash
~/.augment/superpowers/.augment/test-install.sh
```

Or start a new Augment session and ask: **"Do you have superpowers?"**

## Documentation

- **Quick Start**: [QUICKSTART.md](QUICKSTART.md)
- **Full Guide**: [../docs/README.augment.md](../docs/README.augment.md)
- **Installation**: [INSTALL.md](INSTALL.md)

## How It Works

### Architecture

Superpowers for Augment uses a custom instructions approach:

1. **Skills** are stored in `~/.augment/skills/superpowers/` (symlinked)
2. **Bootstrap instructions** are in `~/.augment/superpowers-instructions.md`
3. **Project reference** includes the instructions via `@~/.augment/superpowers-instructions.md`

### Skill Activation

Skills can be activated:
- **Automatically** - Based on context (e.g., brainstorming before coding)
- **Explicitly** - User requests a specific skill
- **Manually** - Augment reads skill files when needed

### Tool Mapping

Superpowers skills reference tools from various platforms. Augment equivalents:

| Skill Reference | Augment Tool |
|----------------|--------------|
| `TodoWrite` / `update_plan` | `add_tasks`, `update_tasks`, `view_tasklist` |
| `Skill` tool | Read from `~/.augment/skills/superpowers/{skill}/SKILL.md` |
| `Task` with subagents | `sub-agent-explore`, `sub-agent-plan` |
| `Read` / `Write` / `Edit` | `view`, `save-file`, `str-replace-editor` |
| `Bash` | `launch-process` |

## Available Skills

### Testing
- **test-driven-development** - RED-GREEN-REFACTOR cycle

### Debugging
- **systematic-debugging** - 4-phase root cause analysis
- **verification-before-completion** - Verify fixes work

### Collaboration
- **brainstorming** - Design refinement before coding
- **writing-plans** - Break work into 2-5 minute tasks
- **executing-plans** - Batch execution with checkpoints
- **dispatching-parallel-agents** - Concurrent subagent workflows
- **requesting-code-review** - Pre-review checklist
- **receiving-code-review** - Respond to feedback
- **using-git-worktrees** - Parallel development branches
- **finishing-a-development-branch** - Merge/PR workflow
- **subagent-driven-development** - Fast iteration with review

### Meta
- **writing-skills** - Create new skills
- **using-superpowers** - Introduction to skills system

## Updating

```bash
cd ~/.augment/superpowers && git pull
```

Skills update instantly through the symlink.

## Uninstalling

```bash
rm -rf ~/.augment/superpowers
rm -f ~/.augment/superpowers-instructions.md
```

Remove `@~/.augment/superpowers-instructions.md` from your project's `.augment/instructions.md`.

## Troubleshooting

### Installation Issues

Run the test script:
```bash
~/.augment/superpowers/.augment/test-install.sh
```

### Skills Not Working

1. Verify project setup: `cat .augment/instructions.md`
2. Check instructions exist: `cat ~/.augment/superpowers-instructions.md`
3. Restart IDE and start new Augment session
4. Be explicit: "Follow the test-driven-development skill strictly"

## Support

- **Issues**: https://github.com/obra/superpowers/issues
- **Tag with**: `augment` label
- **Main Repo**: https://github.com/obra/superpowers

## Notes

This is an **experimental integration**. Augment's architecture differs from Claude Code, Codex, and OpenCode:

- No native plugin system → uses custom instructions
- No `Skill` tool → reads skill files directly
- Skill activation may be less automatic
- Some features may require adaptation

Feedback and contributions welcome!

## License

MIT License - see [../LICENSE](../LICENSE) for details

