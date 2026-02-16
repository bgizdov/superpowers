#!/usr/bin/env bash
# Installation script for Superpowers on Augment
# Supports macOS and Linux

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
info() { echo -e "${BLUE}ℹ${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }
error() { echo -e "${RED}✗${NC} $1"; }

# Determine script location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# Installation paths
AUGMENT_DIR="${HOME}/.augment"
INSTALL_DIR="${AUGMENT_DIR}/superpowers"
SKILLS_DIR="${AUGMENT_DIR}/skills"
INSTRUCTIONS_FILE="${AUGMENT_DIR}/superpowers-instructions.md"

echo ""
info "Installing Superpowers for Augment..."
echo ""

# Step 1: Ensure .augment directory exists
if [ ! -d "$AUGMENT_DIR" ]; then
    info "Creating ${AUGMENT_DIR}..."
    mkdir -p "$AUGMENT_DIR"
    success "Created ${AUGMENT_DIR}"
fi

# Step 2: Check if we're running from the repo or need to clone
if [ "$REPO_ROOT" = "$INSTALL_DIR" ]; then
    info "Already running from installation directory"
else
    if [ -d "$INSTALL_DIR" ]; then
        warn "Installation directory already exists: ${INSTALL_DIR}"
        read -p "Update existing installation? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            info "Updating from repository..."
            cd "$INSTALL_DIR"
            git pull
            success "Updated superpowers repository"
        fi
    else
        info "Copying superpowers to ${INSTALL_DIR}..."
        cp -r "$REPO_ROOT" "$INSTALL_DIR"
        success "Copied superpowers to ${INSTALL_DIR}"
    fi
fi

# Step 3: Create skills symlink
info "Setting up skills directory..."
mkdir -p "$SKILLS_DIR"

if [ -L "${SKILLS_DIR}/superpowers" ]; then
    warn "Skills symlink already exists"
    rm -f "${SKILLS_DIR}/superpowers"
fi

ln -s "${INSTALL_DIR}/skills" "${SKILLS_DIR}/superpowers"
success "Created skills symlink: ${SKILLS_DIR}/superpowers -> ${INSTALL_DIR}/skills"

# Step 4: Generate instructions file
info "Generating Augment instructions file..."

cat > "$INSTRUCTIONS_FILE" << 'EOF'
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

To use a skill, read its content from the file system:
```
~/.augment/skills/superpowers/{skill-name}/SKILL.md
```

Each skill file contains:
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
EOF

success "Generated instructions file: ${INSTRUCTIONS_FILE}"

# Step 5: Final instructions
echo ""
success "Installation complete!"
echo ""
info "Next steps:"
echo ""
echo "  1. Add superpowers to your project:"
echo "     Create or edit .augment/instructions.md in your project root:"
echo ""
echo "     ${YELLOW}@~/.augment/superpowers-instructions.md${NC}"
echo ""
echo "  2. Verify installation:"
echo "     Start a new Augment session and ask:"
echo "     ${YELLOW}\"Do you have superpowers?\"${NC}"
echo ""
echo "  3. Try it out:"
echo "     ${YELLOW}\"Help me plan this feature\"${NC}"
echo "     ${YELLOW}\"Let's use TDD for this implementation\"${NC}"
echo ""
info "To update: cd ~/.augment/superpowers && git pull"
info "Documentation: https://github.com/obra/superpowers"
echo ""

