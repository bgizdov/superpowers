# Installation script for Superpowers on Augment (Windows)
# PowerShell script for Windows users

param(
    [switch]$Force
)

$ErrorActionPreference = "Stop"

# Helper functions
function Write-Info { Write-Host "ℹ $args" -ForegroundColor Blue }
function Write-Success { Write-Host "✓ $args" -ForegroundColor Green }
function Write-Warn { Write-Host "⚠ $args" -ForegroundColor Yellow }
function Write-Error { Write-Host "✗ $args" -ForegroundColor Red }

# Determine script location
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent $ScriptDir

# Installation paths
$AugmentDir = Join-Path $env:USERPROFILE ".augment"
$InstallDir = Join-Path $AugmentDir "superpowers"
$SkillsDir = Join-Path $AugmentDir "skills"
$InstructionsFile = Join-Path $AugmentDir "superpowers-instructions.md"

Write-Host ""
Write-Info "Installing Superpowers for Augment..."
Write-Host ""

# Step 1: Ensure .augment directory exists
if (-not (Test-Path $AugmentDir)) {
    Write-Info "Creating $AugmentDir..."
    New-Item -ItemType Directory -Path $AugmentDir -Force | Out-Null
    Write-Success "Created $AugmentDir"
}

# Step 2: Check if we're running from the repo or need to clone
if ($RepoRoot -eq $InstallDir) {
    Write-Info "Already running from installation directory"
} else {
    if (Test-Path $InstallDir) {
        Write-Warn "Installation directory already exists: $InstallDir"
        if ($Force) {
            $update = $true
        } else {
            $response = Read-Host "Update existing installation? (y/N)"
            $update = $response -match "^[Yy]$"
        }
        
        if ($update) {
            Write-Info "Updating from repository..."
            Push-Location $InstallDir
            git pull
            Pop-Location
            Write-Success "Updated superpowers repository"
        }
    } else {
        Write-Info "Copying superpowers to $InstallDir..."
        Copy-Item -Path $RepoRoot -Destination $InstallDir -Recurse -Force
        Write-Success "Copied superpowers to $InstallDir"
    }
}

# Step 3: Create skills junction (Windows symlink equivalent)
Write-Info "Setting up skills directory..."
if (-not (Test-Path $SkillsDir)) {
    New-Item -ItemType Directory -Path $SkillsDir -Force | Out-Null
}

$SkillsLink = Join-Path $SkillsDir "superpowers"
if (Test-Path $SkillsLink) {
    Write-Warn "Skills junction already exists"
    Remove-Item $SkillsLink -Force -Recurse
}

$SkillsSource = Join-Path $InstallDir "skills"
cmd /c mklink /J "$SkillsLink" "$SkillsSource" | Out-Null
Write-Success "Created skills junction: $SkillsLink -> $SkillsSource"

# Step 4: Generate instructions file
Write-Info "Generating Augment instructions file..."

$InstructionsContent = @'
# Superpowers for Augment

You have superpowers - a complete software development workflow built on composable skills.

## Core Principle

**Before starting any significant work, check if there's a relevant superpowers skill to guide you.**

Skills are located in `~/.augment/skills/superpowers/`. Each skill is in its own directory with a `SKILL.md` file.

## Available Skills

### Testing
- **test-driven-development** - RED-GREEN-REFACTOR cycle enforcement

### Debugging  
- **systematic-debugging** - 4-phase root cause analysis
- **verification-before-completion** - Ensure fixes actually work

### Collaboration
- **brainstorming** - Socratic design refinement before coding
- **writing-plans** - Detailed implementation plans with 2-5 minute tasks
- **executing-plans** - Batch execution with human checkpoints
- **dispatching-parallel-agents** - Concurrent subagent workflows
- **requesting-code-review** - Pre-review checklist
- **receiving-code-review** - Responding to feedback
- **using-git-worktrees** - Parallel development branches
- **finishing-a-development-branch** - Merge/PR decision workflow
- **subagent-driven-development** - Fast iteration with two-stage review

### Meta
- **writing-skills** - Create new skills following best practices
- **using-superpowers** - Introduction to the skills system

## How to Use Skills

1. **Automatic activation**: Skills trigger based on context (e.g., brainstorming before coding, TDD during implementation)
2. **Explicit request**: User asks to use a specific skill
3. **Skill discovery**: Read the skill file from `~/.augment/skills/superpowers/{skill-name}/SKILL.md`

## Workflow

1. **brainstorming** - Before writing code, refine the design
2. **using-git-worktrees** - Create isolated workspace on new branch
3. **writing-plans** - Break work into bite-sized tasks
4. **subagent-driven-development** or **executing-plans** - Execute the plan
5. **test-driven-development** - RED-GREEN-REFACTOR for all code
6. **requesting-code-review** - Review against plan between tasks
7. **finishing-a-development-branch** - Merge, PR, or cleanup

## Tool Mapping for Augment

When skills reference tools from other platforms, use Augment equivalents:
- **TodoWrite / update_plan** → Use Augment's task management tools (add_tasks, update_tasks, view_tasklist)
- **Skill tool** → Read skill files directly from `~/.augment/skills/superpowers/{skill-name}/SKILL.md`
- **Task tool with subagents** → Use Augment's sub-agent system (sub-agent-explore, sub-agent-plan)
- **Read/Write/Edit/Bash** → Use Augment's native tools (view, save-file, str-replace-editor, launch-process)

## Philosophy

- **Test-Driven Development** - Write tests first, always
- **Systematic over ad-hoc** - Process over guessing  
- **Complexity reduction** - Simplicity as primary goal
- **Evidence over claims** - Verify before declaring success

## Reading Skills

To use a skill, read its content from the file system. Each skill file contains:
- Frontmatter with name and description
- When to use the skill
- Detailed instructions
- Examples and best practices

## Important Notes

- Skills are **mandatory workflows**, not suggestions
- Always check for relevant skills before starting work
- Follow skill instructions precisely
- Skills emphasize YAGNI (You Aren't Gonna Need It) and DRY principles
- True TDD is non-negotiable: RED-GREEN-REFACTOR

---

**Installation location**: `~/.augment/superpowers/`
**Skills location**: `~/.augment/skills/superpowers/`
**Version**: Installed from https://github.com/obra/superpowers
'@

Set-Content -Path $InstructionsFile -Value $InstructionsContent -Encoding UTF8
Write-Success "Generated instructions file: $InstructionsFile"

# Step 5: Final instructions
Write-Host ""
Write-Success "Installation complete!"
Write-Host ""
Write-Info "Next steps:"
Write-Host ""
Write-Host "  1. Add superpowers to your project:"
Write-Host "     Create or edit .augment\instructions.md in your project root:"
Write-Host ""
Write-Host "     @~/.augment/superpowers-instructions.md" -ForegroundColor Yellow
Write-Host ""
Write-Host "  2. Verify installation:"
Write-Host "     Start a new Augment session and ask:"
Write-Host "     `"Do you have superpowers?`"" -ForegroundColor Yellow
Write-Host ""
Write-Host "  3. Try it out:"
Write-Host "     `"Help me plan this feature`"" -ForegroundColor Yellow
Write-Host "     `"Let's use TDD for this implementation`"" -ForegroundColor Yellow
Write-Host ""
Write-Info "To update: cd ~/.augment/superpowers; git pull"
Write-Info "Documentation: https://github.com/obra/superpowers"
Write-Host ""

