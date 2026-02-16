# Superpowers for Augment - Quick Start

Get up and running with Superpowers in Augment in 5 minutes.

## 1. Install (1 minute)

### macOS / Linux
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/obra/superpowers/main/.augment/install.sh)
```

### Windows (PowerShell)
```powershell
git clone https://github.com/obra/superpowers.git "$env:USERPROFILE\.augment\superpowers"
& "$env:USERPROFILE\.augment\superpowers\.augment\install.ps1"
```

## 2. Add to Your Project (30 seconds)

Create `.augment/instructions.md` in your project root:

```markdown
@~/.augment/superpowers-instructions.md
```

That's it! The `@` syntax includes the superpowers instructions.

## 3. Verify (30 seconds)

Start a new Augment session and ask:

```
Do you have superpowers?
```

Augment should confirm and list available skills.

## 4. Try It Out (3 minutes)

### Example 1: Plan a Feature

```
I need to add user authentication to my app. Let's use the brainstorming skill to design it.
```

Augment will:
- Ask clarifying questions
- Explore alternatives
- Present design in digestible chunks
- Get your approval before coding

### Example 2: Write Code with TDD

```
Let's implement the login function using test-driven-development.
```

Augment will:
- Write a failing test first (RED)
- Make it pass with minimal code (GREEN)
- Refactor if needed
- Repeat for each requirement

### Example 3: Debug Systematically

```
The tests are failing. Use systematic-debugging to find the root cause.
```

Augment will:
- Gather evidence
- Form hypotheses
- Test hypotheses systematically
- Verify the fix

## What You Get

### Automatic Workflows

Skills activate based on context:
- **Planning?** → Brainstorming skill
- **Coding?** → Test-driven development
- **Debugging?** → Systematic debugging
- **Finishing?** → Branch completion workflow

### Available Skills

**Testing:**
- test-driven-development

**Debugging:**
- systematic-debugging
- verification-before-completion

**Collaboration:**
- brainstorming
- writing-plans
- executing-plans
- dispatching-parallel-agents
- requesting-code-review
- receiving-code-review
- using-git-worktrees
- finishing-a-development-branch
- subagent-driven-development

**Meta:**
- writing-skills
- using-superpowers

## Common Commands

### List Skills
```
What superpowers skills are available?
```

### Use a Specific Skill
```
Use the [skill-name] skill for this task
```

### Read a Skill
```
Show me the test-driven-development skill
```

## Tips

1. **Be explicit**: "Follow the TDD skill strictly" works better than "use TDD"
2. **Reference sections**: "Use the RED-GREEN-REFACTOR cycle from the TDD skill"
3. **Trust the process**: Skills are designed to prevent common mistakes
4. **YAGNI**: Skills emphasize "You Aren't Gonna Need It" - build only what's needed

## Philosophy

- **Test-Driven Development** - Write tests first, always
- **Systematic over ad-hoc** - Process over guessing
- **Complexity reduction** - Simplicity as primary goal
- **Evidence over claims** - Verify before declaring success

## Next Steps

- **Full docs**: [docs/README.augment.md](../docs/README.augment.md)
- **All skills**: `~/.augment/skills/superpowers/`
- **Update**: `cd ~/.augment/superpowers && git pull`
- **Issues**: https://github.com/obra/superpowers/issues

## Troubleshooting

### Skills not working?

1. Check installation:
   ```bash
   ~/.augment/superpowers/.augment/test-install.sh
   ```

2. Verify project setup:
   ```bash
   cat .augment/instructions.md
   ```
   Should contain: `@~/.augment/superpowers-instructions.md`

3. Restart IDE and start new Augment session

### Need help?

- Read the skill: `cat ~/.augment/skills/superpowers/[skill-name]/SKILL.md`
- Check docs: [docs/README.augment.md](../docs/README.augment.md)
- Report issues: https://github.com/obra/superpowers/issues (tag with `augment`)

## Example Session

```
You: I need to add a feature to export data to CSV

Augment: Let me use the brainstorming skill to help design this feature.
[Asks clarifying questions about requirements, data format, error handling]

You: [Answers questions]

Augment: Here's the design... [presents in sections]
Does this look good?

You: Yes, let's implement it

Augment: I'll create a plan using the writing-plans skill.
[Breaks work into small tasks with exact file paths and verification steps]

You: Go ahead

Augment: Starting with test-driven-development.
[Writes failing test, makes it pass, refactors, commits]
[Repeats for each task]

Augment: All tasks complete. Running verification...
All tests pass. Ready to merge?

You: Yes

Augment: [Uses finishing-a-development-branch skill to help merge]
```

---

**You now have superpowers. Use them wisely.** 🚀

