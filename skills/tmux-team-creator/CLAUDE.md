# Tmux Team Creator - Skill Project

## This is a Claude Code Skill

The skill is installed at: `~/.claude/skills/tmux-team-creator/`

This repo (`data/tmux-team-creator/`) is a reference copy. Updates are done manually.

---

## Skill Format Requirements

This project MUST follow the Claude Code skill format (see `skill-creator` skill for details):

### Required Structure

```
tmux-team-creator/
├── SKILL.md              # REQUIRED - Skill definition with YAML frontmatter
├── sample_team/          # Bundled resources (like assets/)
│   ├── scrum-team/
│   ├── game-dev-team/
│   ├── mckinsey-research-team/
│   └── pg-insights-team/
├── docs/                 # Reference materials (like references/)
│   └── research/
│       └── McKinsey_workflow.md
└── templates/            # Additional templates
```

### SKILL.md Frontmatter (REQUIRED)

```yaml
---
name: tmux-team-creator
description: [comprehensive description of what skill does and when to use it]
---
```

### What NOT to Include

According to skill-creator guidelines, do NOT add:
- README.md
- INSTALLATION_GUIDE.md
- CHANGELOG.md
- Other auxiliary documentation

CLAUDE.md is an exception - it's for development context, not skill documentation.

---

## Project Purpose

**Create standard workflow templates for different types of teams, workflows, and roles.**

Sample teams are TEMPLATES that users customize for their specific projects.

## Sample Team Categories

### Software Development
- **scrum-team** - Standard Scrum with PO, SM, TL, BE, FE, QA
- **game-dev-team** - Game development with DS, SM, AR, DV, QA

### Research & Analysis
- **mckinsey-research-team** - McKinsey-style research with EM, RL, PR, SR, DA, QR
- **pg-insights-team** - P&G Three-Step consumer insights with IM, MR, IA, SL, QR

### Future Categories (Backlog)
- Test/QA teams
- Content creator teams
- Data pipeline teams
- ML/AI project teams

---

## Development Workflow

### IMPORTANT: New Teams Development Process

**Do NOT develop new teams directly in the skill folder.** Use this workflow:

#### Phase 1: Development (Outside Skill)

Work on new teams in a **separate temporary folder** outside the skill:

```
~/dev/temp-teams/new-team-name/    # Work here first
```

This prevents incomplete teams from appearing in the skill.

#### Phase 2: Review (Before Sync)

When the team is ready, before syncing:

1. **Read skill-creator skill** - Understand skill format requirements
2. **Review against checklist** - Ensure all required files exist
3. **Test the team** - Run setup-team.sh, verify it works
4. **Review SKILL.md changes** - Plan how to update template list

#### Phase 3: Sync (Move to Skill)

When ready to include in skill:

1. **Copy team folder** to `sample_team/{team-name}/`
2. **Update SKILL.md** - Add to template list, descriptions, comparison tables
3. **Verify** - Test that skill can read the new team files
4. **Delete temp folder** - Remove the external development folder

```bash
# Example sync commands
cp -r ~/dev/temp-teams/new-team-name/ sample_team/new-team-name/
rm -rf ~/dev/temp-teams/new-team-name/
```

#### Phase 4: Maintenance

After sync, work in the repo folder:

```
data/tmux-team-creator/sample_team/
```

After making changes, run `./sync-skill.sh` to update the installed skill.

---

### Checklist for New Teams

Before syncing to skill, verify:

- [ ] `workflow.md` - Main documentation
- [ ] `prompts/` - Role prompts (XX_PROMPT.md)
- [ ] `setup-team.sh` - Automated setup script (executable, verifies global tm-send)
- [ ] `WHITEBOARD.md` - Status tracking
- [ ] Improvement folder if applicable (`sm/`, `pm/`, `em/`, `im/`)
- [ ] Skills referenced in prompts (`/frontend-design`, `/quick-research`, etc.)
- [ ] SKILL.md updated with new team

**NOTE**: tm-send is a GLOBAL tool at `~/.local/bin/tm-send` - do NOT include in project!
Role mapping uses `@role_name` pane options (dynamic lookup, no PANE_ROLES.md file)

---

## Development Practices

### Version Tagging for Debugging

**When debugging frontend changes, always increment a version tag in console.log statements.**

Example:
```typescript
console.log("[Feature] Initialized (v4)")  // Increment v3 -> v4 -> v5
```

**Why**: When CDN caching or browser caching is involved, version tags let you instantly verify whether the new code is actually running. Without this, you waste hours debugging "why isn't my fix working" when the real issue is stale cached code.

**Hard-earned lesson**: Spent 2 days debugging headphone button issue before realizing Cloudflare CDN was serving old JavaScript bundles. Version tags would have caught this immediately.

---

## Backlog

### Understanding
- This is a skill - must maintain skill format compliance
- Manual updates between repo and ~/.claude/skills/tmux-team-creator/

### Future Work
- Test/QA team template
- Content creator team template
- Data pipeline team template
- ML/AI project team template
