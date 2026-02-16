# Installing Superpowers for Augment

Enable superpowers skills in Augment via custom instructions and skill discovery.

## Prerequisites

- Augment Code extension installed (VS Code or IntelliJ)
- Git installed

## Installation

### macOS / Linux

Run this command:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/obra/superpowers/main/.augment/install.sh)
```

Or manually:

1. **Clone the superpowers repository:**
   ```bash
   git clone https://github.com/obra/superpowers.git ~/.augment/superpowers
   ```

2. **Run the installation script:**
   ```bash
   ~/.augment/superpowers/.augment/install.sh
   ```

### Windows (PowerShell)

```powershell
git clone https://github.com/obra/superpowers.git "$env:USERPROFILE\.augment\superpowers"
& "$env:USERPROFILE\.augment\superpowers\.augment\install.ps1"
```

## What Gets Installed

The installer:
1. Clones superpowers to `~/.augment/superpowers/`
2. Creates a skills symlink at `~/.augment/skills/superpowers`
3. Generates custom instructions file at `~/.augment/superpowers-instructions.md`
4. Provides instructions for adding to your Augment workspace

## Adding to Your Workspace

After installation, you need to add the superpowers instructions to your Augment workspace:

### Option 1: Project-Level (Recommended)

Create or edit `.augment/instructions.md` in your project root:

```markdown
<!-- Include superpowers -->
@~/.augment/superpowers-instructions.md

<!-- Your project-specific instructions below -->
```

### Option 2: Global

Add to your global Augment settings (if supported by your Augment version).

## Verify Installation

1. Start a new Augment session
2. Ask: "Do you have superpowers?"
3. Try: "Help me plan this feature" or "Let's use TDD for this"

Augment should recognize and use superpowers skills.

## Usage

### Listing Skills

Ask Augment:
```
What superpowers skills are available?
```

### Using a Skill

Skills activate automatically based on context, or you can explicitly request:
```
Use the brainstorming skill to help me design this feature
```

```
Let's use test-driven-development for this implementation
```

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

Remove the `@~/.augment/superpowers-instructions.md` line from your project's `.augment/instructions.md`.

## Troubleshooting

### Skills not recognized

1. Verify installation: `ls -la ~/.augment/superpowers/skills`
2. Check instructions file exists: `cat ~/.augment/superpowers-instructions.md`
3. Ensure your project's `.augment/instructions.md` includes the reference
4. Restart your IDE and start a new Augment session

### Tool mapping

When skills reference tools from other platforms:
- `TodoWrite` → Use Augment's task management tools
- `Skill` tool → Ask Augment to load/use a specific skill by name
- `Task` with subagents → Use Augment's sub-agent capabilities
- File operations → Augment's native file tools

## Getting Help

- Report issues: https://github.com/obra/superpowers/issues
- Tag issues with `augment` label
- Full documentation: https://github.com/obra/superpowers

## Notes

This is an experimental integration. Augment's architecture differs from Claude Code, Codex, and OpenCode, so some features may work differently or require adaptation.

