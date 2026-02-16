# Superpowers for Augment

Complete guide for using Superpowers with [Augment Code](https://www.augmentcode.com).

## Quick Install

### macOS / Linux

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/obra/superpowers/main/.augment/install.sh)
```

Or tell Augment:

```
Clone https://github.com/obra/superpowers to ~/.augment/superpowers, then run ~/.augment/superpowers/.augment/install.sh
```

### Windows (PowerShell)

```powershell
git clone https://github.com/obra/superpowers.git "$env:USERPROFILE\.augment\superpowers"
& "$env:USERPROFILE\.augment\superpowers\.augment\install.ps1"
```

## Manual Installation

### Prerequisites

- Augment Code extension installed (VS Code or IntelliJ)
- Git installed

### macOS / Linux

1. Clone the repo:
   ```bash
   git clone https://github.com/obra/superpowers.git ~/.augment/superpowers
   ```

2. Create skills symlink:
   ```bash
   mkdir -p ~/.augment/skills
   ln -s ~/.augment/superpowers/skills ~/.augment/skills/superpowers
   ```

3. The installer creates `~/.augment/superpowers-instructions.md` with the bootstrap content.

### Windows

1. Clone the repo:
   ```powershell
   git clone https://github.com/obra/superpowers.git "$env:USERPROFILE\.augment\superpowers"
   ```

2. Create skills junction:
   ```powershell
   New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.augment\skills"
   cmd /c mklink /J "$env:USERPROFILE\.augment\skills\superpowers" "$env:USERPROFILE\.augment\superpowers\skills"
   ```

3. Run the installer to generate instructions:
   ```powershell
   & "$env:USERPROFILE\.augment\superpowers\.augment\install.ps1"
   ```

## Adding to Your Workspace

After installation, add superpowers to your project:

### Project-Level (Recommended)

Create or edit `.augment/instructions.md` in your project root:

```markdown
@~/.augment/superpowers-instructions.md

<!-- Your project-specific instructions below -->
```

### Global (if supported)

Add to your global Augment settings or user-level instructions file.

## Verify Installation

1. Start a new Augment session in your project
2. Ask: **"Do you have superpowers?"**
3. Augment should confirm and list available skills

## Usage

### Automatic Skill Activation

Skills trigger automatically based on context:

- **Planning a feature?** → `brainstorming` skill activates
- **Writing code?** → `test-driven-development` enforces RED-GREEN-REFACTOR
- **Debugging?** → `systematic-debugging` guides root cause analysis
- **Finishing work?** → `finishing-a-development-branch` helps with merge/PR

### Explicit Skill Usage

Request specific skills:

```
Use the brainstorming skill to help me design this authentication system
```

```
Let's follow test-driven-development for this new feature
```

```
Apply systematic-debugging to find why the tests are failing
```

### Listing Available Skills

```
What superpowers skills are available?
```

```
Show me the skills in ~/.augment/skills/superpowers/
```

## How It Works

### Architecture

1. **Skills Directory**: `~/.augment/skills/superpowers/` (symlinked to installation)
2. **Instructions File**: `~/.augment/superpowers-instructions.md` (bootstrap content)
3. **Project Reference**: `.augment/instructions.md` includes the instructions file

### Skill Structure

Each skill is a directory with a `SKILL.md` file:
```
~/.augment/skills/superpowers/
├── brainstorming/SKILL.md
├── test-driven-development/SKILL.md
├── systematic-debugging/SKILL.md
└── ...
```

### Tool Mapping

Superpowers skills reference tools from various platforms. Augment uses these equivalents:

| Skill Reference | Augment Tool |
|----------------|--------------|
| `TodoWrite` / `update_plan` | `add_tasks`, `update_tasks`, `view_tasklist` |
| `Skill` tool | Read from `~/.augment/skills/superpowers/{skill}/SKILL.md` |
| `Task` with subagents | `sub-agent-explore`, `sub-agent-plan` |
| `Read` / `Write` / `Edit` | `view`, `save-file`, `str-replace-editor` |
| `Bash` | `launch-process` |

## Available Skills

### Testing
- **test-driven-development** - RED-GREEN-REFACTOR cycle enforcement

### Debugging
- **systematic-debugging** - 4-phase root cause analysis
- **verification-before-completion** - Ensure fixes actually work

### Collaboration
- **brainstorming** - Socratic design refinement before coding
- **writing-plans** - Detailed implementation plans
- **executing-plans** - Batch execution with checkpoints
- **dispatching-parallel-agents** - Concurrent subagent workflows
- **requesting-code-review** - Pre-review checklist
- **receiving-code-review** - Responding to feedback
- **using-git-worktrees** - Parallel development branches
- **finishing-a-development-branch** - Merge/PR decision workflow
- **subagent-driven-development** - Fast iteration with two-stage review

### Meta
- **writing-skills** - Create new skills following best practices
- **using-superpowers** - Introduction to the skills system

## The Workflow

1. **brainstorming** - Refine rough ideas, explore alternatives, validate design
2. **using-git-worktrees** - Create isolated workspace on new branch
3. **writing-plans** - Break work into 2-5 minute tasks with exact file paths
4. **subagent-driven-development** - Dispatch subagents per task with two-stage review
5. **test-driven-development** - RED-GREEN-REFACTOR for all implementation
6. **requesting-code-review** - Review against plan, report issues by severity
7. **finishing-a-development-branch** - Verify tests, merge/PR/keep/discard

## Updating

```bash
cd ~/.augment/superpowers && git pull
```

Skills update instantly through the symlink.

## Troubleshooting

### Skills not recognized

1. Verify installation:
   ```bash
   ls -la ~/.augment/superpowers/skills
   ```

2. Check instructions file:
   ```bash
   cat ~/.augment/superpowers-instructions.md
   ```

3. Verify project reference:
   ```bash
   cat .augment/instructions.md
   ```

4. Restart IDE and start new Augment session

### Augment doesn't follow skills

- Skills are guidelines, not hard constraints in Augment
- Be explicit: "Follow the test-driven-development skill strictly"
- Reference specific sections: "Use the RED-GREEN-REFACTOR cycle from the TDD skill"

### Path issues on Windows

Use forward slashes or double backslashes in `.augment/instructions.md`:
```markdown
@~/.augment/superpowers-instructions.md
```

## Differences from Other Platforms

### vs Claude Code
- No native plugin system → uses custom instructions
- No `Skill` tool → read skill files directly
- Manual skill activation may be needed

### vs Codex/OpenCode
- Similar approach (symlinked skills + instructions)
- Different tool names (see Tool Mapping above)
- Augment has built-in sub-agent support

## Getting Help

- **Issues**: https://github.com/obra/superpowers/issues
- **Tag with**: `augment` label
- **Docs**: https://github.com/obra/superpowers

## Notes

This is an **experimental integration**. Augment's architecture differs from other platforms, so:
- Some features may require adaptation
- Skill activation may be less automatic
- Tool mappings may need refinement

Feedback and contributions welcome!

