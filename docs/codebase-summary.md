# Codebase Summary

## Project Overview

**Synthetic Claude** is an extensible Claude Code marketplace plugin featuring:
- Multi-agent debate system (3-phase with optional deep mode)
- 7 specialized agents for different roles
- 23 productivity commands
- 26 reusable skills
- Full document processing (PDF, DOCX, PPTX, XLSX)
- Plugin marketplace integration

**Version:** 2.0.0 | **License:** MIT

**Repository:** `/Users/huutri/code/synthetic-claude`

## Directory Structure

```
synthetic-claude/
├── .claude/                     # Claude Code configuration
│   └── settings.json           # IDE settings
├── .claude-plugin/             # Plugin metadata
│   └── marketplace.json        # Component registry
├── agents/                     # AI agents (7 total)
├── commands/                   # User commands (23 total)
├── skills/                     # Reusable capabilities (26 total)
├── docs/                       # Technical documentation
├── plans/                      # Project planning & reports
├── README.md                   # User-facing documentation
└── repomix-output.xml         # Codebase snapshot
```

## Agents (7)

All agents use YAML frontmatter + markdown format. Model: `haiku` (cost efficiency).

| Agent ID | File | Purpose | Role |
|----------|------|---------|------|
| `debate-orchestrator` | `agents/debate-orchestrator.md` | Coordinates multi-phase debate workflow | Master orchestrator |
| `debate-researcher` | `agents/researcher.md` | Gathers evidence, explores possibilities | Evidence-focused |
| `debate-critic` | `agents/critic.md` | Identifies risks, challenges assumptions | Risk-focused |
| `debate-synthesizer` | `agents/synthesizer.md` | Finds patterns, integrates perspectives | Integration-focused |
| `critical-code-reviewer` | `agents/critical-code-reviewer.md` | Reviews code for critical issues | Code QA |
| `research-assistant` | `agents/research-assistant.md` | Conducts research, gathers external info | Research |
| `ui-ux-designer` | `agents/ui-ux-designer.md` | Provides design guidance and UX review | Design |

### Agent Structure (YAML Frontmatter)

```yaml
---
name: agent-id                  # Kebab-case identifier
description: >-                 # One-line user description
  [Optional example block]
model: haiku                    # Always haiku for cost
---

[Markdown instructions and behavioral standards]
```

### Key Sections in Each Agent

1. **Role** - Primary responsibility
2. **Behavioral Standards** - Expected behavior patterns
3. **Behavioral Contract (MUST NOT)** - Anti-patterns to avoid
4. **Output Format** - Exact markdown structure to produce
5. **Discussion Phase Output** - How agent responds to others

### Debate Workflow (debate-orchestrator)

The orchestrator coordinates 3-phase debate:

1. **Phase 1 (Parallel)** - Each agent independently analyzes topic
2. **Phase 2 (Parallel)** - Each agent references others, updates position
3. **Deep Mode Convergence Check** - Compare KEY RECOMMENDATIONs
   - If converged → Proceed to Phase 3
   - If diverged → Execute Phase 2b (second discussion)
4. **Phase 3 (Serial)** - Synthesizer creates final recommendation

## Commands (23)

All commands use YAML frontmatter + markdown format.

### Debate & Analysis Commands

| Command | File | Purpose |
|---------|------|---------|
| `/debate` | `commands/debate.md` | Multi-agent debate with optional --deep mode |
| `/quick-brainstorm` | `commands/quick-brainstorm.md` | Rapid ideation with counter-arguments |
| `/discuss` | `commands/discuss.md` | Quick discussion with critical analysis |
| `/think-hard` | `commands/think-hard.md` | Challenge assumptions and find gaps |

### Development Commands

| Command | File | Purpose |
|---------|------|---------|
| `/px-backend-api` | `commands/px-backend-api.md` | Implement backend APIs from specs |
| `/px-frontend-api` | `commands/px-frontend-api.md` | Frontend integration with backend |
| `/design-guide` | `commands/design-guide.md` | Design analysis without modifying code |
| `/gen-feature-docs` | `commands/gen-feature-docs.md` | Generate developer + user docs |
| `/generate-db-docs` | `commands/generate-db-docs.md` | Create database documentation |
| `/explore-external-APIs` | `commands/explore-external-APIs.md` | Test and document APIs |
| `/fastapi-test` | `commands/fastapi-test.md` | Create comprehensive API tests |

### Project Management Commands

| Command | File | Purpose |
|---------|------|---------|
| `/parallel-work` | `commands/parallel-work.md` | Setup Git worktrees for feature dev |
| `/integrate-parallel-work` | `commands/integrate-parallel-work.md` | Merge parallel features |
| `/refactor-interactive` | `commands/refactor-interactive.md` | Guided refactoring with steps |
| `/tidy-up` | `commands/tidy-up.md` | Cleanup project structure |
| `/tidy-docs` | `commands/tidy-docs.md` | Reorganize documentation |
| `/git-configure` | `commands/git-configure.md` | Configure Git user (personal/work) |

### Support Commands

| Command | File | Purpose |
|---------|------|---------|
| `/create-project-memory-skills` | `commands/create-project-memory-skills.md` | Copy memory skills to project |
| `/notebook-edit` | `commands/notebook-edit.md` | Suggest Jupyter notebook changes |
| `/py2notebook` | `commands/py2notebook.md` | Convert Python to notebook |
| `/ecp` | `commands/ecp.md` | Execute prompt from file |
| `/tmux-team-restart` | `commands/tmux-team-restart.md` | Restart tmux with state preservation |
| `/current-prompt-create` | `commands/current-prompt-create.md` | Create current_prompt.md |

### Command Structure (YAML Frontmatter)

```yaml
---
description: User-facing one-liner
argument-hint: [param1] [param2] [--flag]
allowed-tools: [Tool1, Tool2]    # Optional restrictions
---

[Markdown content using $ARGUMENTS, $FILES, $CONCERNS variables]
```

## Skills (26)

All skills are directories with YAML frontmatter + markdown documentation.

### Core Debate System

| Skill | Directory | Purpose |
|-------|-----------|---------|
| `debate-workflow` | `skills/debate-workflow/` | Core 3-phase debate orchestration |

### Document Processing

| Skill | Directory | Purpose |
|-------|-----------|---------|
| `pdf` | `skills/pdf/` | PDF extraction, analysis, transformation |
| `docx` | `skills/docx/` | Word document creation/modification |
| `pptx` | `skills/pptx/` | PowerPoint presentation generation |
| `xlsx` | `skills/xlsx/` | Excel spreadsheet creation |

### Development & Code

| Skill | Directory | Purpose |
|-------|-----------|---------|
| `skill-creator` | `skills/skill-creator/` | Scaffold new skills |
| `mcp-builder` | `skills/mcp-builder/` | Build MCP servers |
| `coder-memory-store` | `skills/coder-memory-store/` | Store code memory for recall |
| `coder-memory-recall` | `skills/coder-memory-recall/` | Recall stored code memory |
| `webapp-testing` | `skills/webapp-testing/` | Web app testing framework |

### Design & Frontend

| Skill | Directory | Purpose |
|-------|-----------|---------|
| `frontend-design` | `skills/frontend-design/` | Design system and components |
| `canvas-design` | `skills/canvas-design/` | Canvas-based visual design |
| `algorithmic-art` | `skills/algorithmic-art/` | Generate algorithmic art |
| `theme-factory` | `skills/theme-factory/` | Theme generation engine |
| `slack-gif-creator` | `skills/slack-gif-creator/` | Create animated GIFs |

### Content & Communication

| Skill | Directory | Purpose |
|-------|-----------|---------|
| `internal-comms` | `skills/internal-comms/` | Internal communication templates |
| `doc-coauthoring` | `skills/doc-coauthoring/` | Collaborative documentation |
| `prompting` | `skills/prompting/` | Prompting best practices |
| `brand-guidelines` | `skills/brand-guidelines/` | Brand identity management |

### Specialized Tools

| Skill | Directory | Purpose |
|-------|-----------|---------|
| `quick-research` | `skills/quick-research/` | Fast research capabilities |
| `llm-apps-creator` | `skills/llm-apps-creator/` | Create LLM applications |
| `power-agent-creator` | `skills/power-agent-creator/` | Create powerful agents |
| `cc-hooks-creator` | `skills/cc-hooks-creator/` | Create Claude Code hooks |
| `tmux-team-creator` | `skills/tmux-team-creator/` | Create tmux team environment |
| `web-artifacts-builder` | `skills/web-artifacts-builder/` | Build web artifacts |
| `templates` | `skills/templates/` | Reusable templates |

### Skill Structure (YAML Frontmatter)

```yaml
---
name: skill-name                # Kebab-case identifier
description: One-line purpose
license: MIT
---

[Markdown documentation]

## When to Use
[Activation criteria]

## Core Concepts
[Key ideas]

## Usage
[How to invoke/use]
```

### Skill Directory Layout

```
skills/{skill-name}/
├── SKILL.md                     # Documentation
├── scripts/
│   ├── {script1}.js            # JavaScript implementations
│   ├── {script2}.py            # Python implementations
│   └── references/             # External tools/specs
└── references/                 # Optional external docs
```

## Configuration

### marketplace.json

Located at `.claude-plugin/marketplace.json`, this file registers all components:

```json
{
  "name": "synthetic-claude",
  "owner": { "name": "hongbietcode" },
  "plugins": [{
    "name": "synthetic-claude",
    "source": "./",
    "description": "Multi-agent debate...",
    "version": "2.0.0",
    "license": "MIT",
    "keywords": ["multi-agent", "debate", ...],
    "category": "workflows",
    "commands": ["./commands/..."],
    "agents": ["./agents/..."],
    "skills": ["./skills/..."],
    "strict": false
  }]
}
```

**Key fields:**
- `strict: false` - Allows installation without plugin.json in skill dirs
- `commands[]` - Paths to all 23 command files
- `agents[]` - Paths to all 7 agent files
- `skills[]` - Paths to all 26 skill directories

## File Statistics

| Category | Count | Total Tokens | Status |
|----------|-------|--------------|--------|
| Agents | 7 | ~15,000 | Complete |
| Commands | 23 | ~80,000 | Complete |
| Skills | 26 | ~950,000 | Complete (includes schemas) |
| Documentation | 6 docs | ~12,000 | Complete |
| **Total** | **62 components** | **~1,045,663** | v2.0.0 |

## Installation Scopes

Plugin supports three installation scopes:

| Scope | Location | Visibility | Use Case |
|-------|----------|-----------|----------|
| **user** | Global Claude Code config | All projects | Personal library |
| **project** | `.claude/plugins/` | Team in version control | Team-shared workflows |
| **local** | Project local config | Current machine only | Project-specific overrides |

**Priority:** Local > Project > User

## Documentation Structure

| Document | Purpose | Audience |
|----------|---------|----------|
| `README.md` | User guide, installation, usage | All users |
| `docs/project-overview-pdr.md` | Vision, goals, requirements | Team leads, architects |
| `docs/code-standards.md` | File formats, naming, patterns | Contributors |
| `docs/system-architecture.md` | Plugin structure, data flow | Technical leads |
| `docs/codebase-summary.md` | Inventory, structure (this file) | Developers |
| `docs/project-roadmap.md` | Current state, future plans | Team |

## Key Design Patterns

### 1. YAML-First Configuration
- Behavior declarative in YAML frontmatter
- Implementation in markdown
- Machine-readable, human-understandable

### 2. Context Isolation
- Each agent receives CONTEXT ISOLATION preamble
- Prevents cross-agent contamination
- Ensures independence in Phase 1

### 3. Key Recommendation Tracking
- Each agent outputs KEY RECOMMENDATION field
- Enables convergence detection in deep mode
- Critical for Phase 2 → Phase 3 decision

### 4. Stateless Execution
- No persistent state between commands
- Reproducible results
- Safe sandbox operation

### 5. Skill Composition
- Agents/commands declare needed skills
- Skills auto-activate when referenced
- Modular, extensible architecture

## Development Workflow

### Adding a New Agent

1. Create `agents/{agent-name}.md`
2. Include YAML frontmatter (name, description, model)
3. Add Role, Behavioral Standards, Output Format sections
4. Add entry to `marketplace.json`
5. Test behavior in isolation

### Adding a New Command

1. Create `commands/{command-name}.md`
2. Include YAML frontmatter (description, argument-hint)
3. Add Process, Output, Examples sections
4. Use `$ARGUMENTS`, `$FILES` variables as needed
5. Add entry to `marketplace.json`
6. Test with sample inputs

### Adding a New Skill

1. Create `skills/{skill-name}/` directory
2. Create `SKILL.md` with YAML frontmatter
3. Add scripts to `scripts/` subdirectory
4. Add references as needed
5. Add entry to `marketplace.json`
6. Test skill invocation from agent/command

### Testing

- Agents: Solo output, discussion response, edge cases
- Commands: Valid input, missing args, invalid input
- Skills: Initialization, output format, error handling
- Integration: Cross-component workflows

## Performance Characteristics

### Latency
- **Phase 1:** 15-20s (3 parallel agents)
- **Phase 2:** 15-20s (3 parallel agents)
- **Phase 3:** 10-15s (serial synthesis)
- **Standard mode total:** 40-55s
- **Deep mode (converged):** 40-55s
- **Deep mode (diverged):** 70-90s (additional Phase 2b)

### Token Usage
- **Per debate:** ~2000-3000 tokens (Haiku model)
- **Per skill:** Varies (pdf ~500-1000, docx ~1000-2000)
- **Cost efficiency:** Haiku model minimizes API costs

## Security & Isolation

- Agents run in separate Task contexts
- CONTEXT ISOLATION preamble prevents prompt injection
- No persistent state between executions
- Standard Claude Code sandbox protections apply
- No external data persistence

## Version Information

- **Current Version:** 2.0.0
- **License:** MIT
- **Repository:** `/Users/huutri/code/synthetic-claude`
- **Node/Language:** JavaScript + Python (mixed)
- **Dependencies:** None explicit (runs in Claude Code)

## Related Resources

- **Marketplace:** hongbietcode/synthetic-claude
- **Installation:** See README.md for all 3 scope options
- **Contribution:** See code-standards.md for patterns
- **Architecture:** See system-architecture.md for design details
