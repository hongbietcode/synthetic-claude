# Codebase Summary

## Project Overview

**Synthetic Claude** is a modular Claude Code marketplace with 6 specialized plugins:
- Multi-agent debate system with 3-phase workflow
- Document processing (PDF, DOCX, PPTX, XLSX)
- Development tools (API, testing, code review, documentation)
- Design tools (UI/UX, frontend, visual assets)
- Productivity tools (project management, refactoring, research)
- Content creation tools (prompting, documentation, LLM apps)

**Version:** 1.0.0 (6 plugins × v1.0.0 each) | **License:** MIT

**Repository:** `/Users/huutri/code/synthetic-claude`

## Directory Structure

```
synthetic-claude/
├── .claude-plugin/                 # Root aggregator marketplace
│   └── marketplace.json            # References 6 plugins
├── plugins/                        # 6 modular plugins
│   ├── debate-system/
│   │   ├── .claude-plugin/
│   │   │   └── marketplace.json
│   │   ├── agents/ (4 files)
│   │   ├── commands/ (4 files)
│   │   └── skills/
│   │       └── debate-workflow/
│   ├── document-suite/
│   │   ├── .claude-plugin/
│   │   │   └── marketplace.json
│   │   └── skills/ (pdf, docx, pptx, xlsx)
│   ├── dev-tools/
│   │   ├── .claude-plugin/
│   │   │   └── marketplace.json
│   │   ├── agents/ (critical-code-reviewer)
│   │   ├── commands/ (6 files)
│   │   └── skills/ (4 dirs)
│   ├── design-studio/
│   │   ├── .claude-plugin/
│   │   │   └── marketplace.json
│   │   ├── agents/ (ui-ux-designer)
│   │   ├── commands/ (design-guide)
│   │   └── skills/ (6 dirs)
│   ├── productivity-kit/
│   │   ├── .claude-plugin/
│   │   │   └── marketplace.json
│   │   ├── agents/ (research-assistant)
│   │   ├── commands/ (7 files)
│   │   └── skills/ (4 dirs)
│   └── content-creation/
│       ├── .claude-plugin/
│       │   └── marketplace.json
│       ├── commands/ (5 files)
│       └── skills/ (7 dirs)
├── docs/                           # Technical documentation
│   ├── project-overview-pdr.md
│   ├── code-standards.md
│   ├── codebase-summary.md (this file)
│   ├── system-architecture.md
│   └── project-roadmap.md
├── README.md                       # User documentation
└── repomix-output.xml             # Codebase snapshot
```

## Marketplace Architecture

### Root Aggregator
**File:** `.claude-plugin/marketplace.json`

The root marketplace is an **aggregator** that references 6 independent plugins:

| Plugin | Source | Category | Version |
|--------|--------|----------|---------|
| debate-system | `./plugins/debate-system` | workflows | 1.0.0 |
| document-suite | `./plugins/document-suite` | documents | 1.0.0 |
| dev-tools | `./plugins/dev-tools` | development | 1.0.0 |
| design-studio | `./plugins/design-studio` | design | 1.0.0 |
| productivity-kit | `./plugins/productivity-kit` | productivity | 1.0.0 |
| content-creation | `./plugins/content-creation` | content | 1.0.0 |

### Individual Plugins
Each plugin has its own marketplace.json at `plugins/{name}/.claude-plugin/marketplace.json` with:
- Own agents, commands, skills declarations
- Local paths (`./` prefix)
- Version 1.0.0
- Strict: false

## Plugin Inventory

### 1. Debate System
**Path:** `plugins/debate-system/`
**Category:** workflows
**Version:** 1.0.0

**Agents (4):**
| Agent | File | Purpose |
|-------|------|---------|
| debate-orchestrator | agents/debate-orchestrator.md | Coordinates 3-phase debate |
| researcher | agents/researcher.md | Gathers evidence |
| critic | agents/critic.md | Identifies risks |
| synthesizer | agents/synthesizer.md | Integrates perspectives |

**Commands (4):**
| Command | File | Purpose |
|---------|------|---------|
| /debate | commands/debate.md | Multi-agent debate with --deep mode |
| /quick-brainstorm | commands/quick-brainstorm.md | Rapid ideation with counter-arguments |
| /discuss | commands/discuss.md | Quick discussion with critical analysis |
| /think-hard | commands/think-hard.md | Challenge assumptions |

**Skills (1):**
| Skill | Directory | Purpose |
|-------|-----------|---------|
| debate-workflow | skills/debate-workflow/ | 3-phase orchestration |

### 2. Document Suite
**Path:** `plugins/document-suite/`
**Category:** documents
**Version:** 1.0.0

**Skills (4):**
| Skill | Directory | Purpose |
|-------|-----------|---------|
| pdf | skills/pdf/ | PDF extraction, analysis, transformation |
| docx | skills/docx/ | Word document creation/modification |
| pptx | skills/pptx/ | PowerPoint presentation generation |
| xlsx | skills/xlsx/ | Excel spreadsheet creation |

### 3. Dev Tools
**Path:** `plugins/dev-tools/`
**Category:** development
**Version:** 1.0.0

**Agents (1):**
| Agent | File | Purpose |
|-------|------|---------|
| critical-code-reviewer | agents/critical-code-reviewer.md | Code quality review |

**Commands (6):**
| Command | File | Purpose |
|---------|------|---------|
| /px-backend-api | commands/px-backend-api.md | Implement backend APIs |
| /px-frontend-api | commands/px-frontend-api.md | Frontend integration |
| /fastapi-test | commands/fastapi-test.md | API test generation |
| /explore-external-APIs | commands/explore-external-APIs.md | API testing & docs |
| /gen-feature-docs | commands/gen-feature-docs.md | Developer + user docs |
| /generate-db-docs | commands/generate-db-docs.md | Database documentation |

**Skills (4):**
| Skill | Directory | Purpose |
|-------|-----------|---------|
| webapp-testing | skills/webapp-testing/ | Web app testing framework |
| mcp-builder | skills/mcp-builder/ | MCP server builder |
| skill-creator | skills/skill-creator/ | Scaffold new skills |
| cc-hooks-creator | skills/cc-hooks-creator/ | Claude Code hooks |

### 4. Design Studio
**Path:** `plugins/design-studio/`
**Category:** design
**Version:** 1.0.0

**Agents (1):**
| Agent | File | Purpose |
|-------|------|---------|
| ui-ux-designer | agents/ui-ux-designer.md | Design guidance & UX review |

**Commands (1):**
| Command | File | Purpose |
|---------|------|---------|
| /design-guide | commands/design-guide.md | Design analysis without code changes |

**Skills (6):**
| Skill | Directory | Purpose |
|-------|-----------|---------|
| frontend-design | skills/frontend-design/ | Design system & components |
| canvas-design | skills/canvas-design/ | Canvas-based visual design |
| algorithmic-art | skills/algorithmic-art/ | Algorithmic art generation |
| theme-factory | skills/theme-factory/ | Theme generation engine |
| brand-guidelines | skills/brand-guidelines/ | Brand identity management |
| slack-gif-creator | skills/slack-gif-creator/ | Animated GIF creation |

### 5. Productivity Kit
**Path:** `plugins/productivity-kit/`
**Category:** productivity
**Version:** 1.0.0

**Agents (1):**
| Agent | File | Purpose |
|-------|------|---------|
| research-assistant | agents/research-assistant.md | Research & external info |

**Commands (7):**
| Command | File | Purpose |
|---------|------|---------|
| /parallel-work | commands/parallel-work.md | Git worktree setup |
| /integrate-parallel-work | commands/integrate-parallel-work.md | Merge parallel features |
| /refactor-interactive | commands/refactor-interactive.md | Guided refactoring |
| /tidy-up | commands/tidy-up.md | Project structure cleanup |
| /tidy-docs | commands/tidy-docs.md | Documentation reorganization |
| /git-configure | commands/git-configure.md | Git user configuration |
| /tmux-team-restart | commands/tmux-team-restart.md | tmux team environment |

**Skills (4):**
| Skill | Directory | Purpose |
|-------|-----------|---------|
| quick-research | skills/quick-research/ | Fast research capabilities |
| tmux-team-creator | skills/tmux-team-creator/ | tmux environment creation |
| coder-memory-store | skills/coder-memory-store/ | Store code memory |
| coder-memory-recall | skills/coder-memory-recall/ | Recall code memory |

### 6. Content Creation
**Path:** `plugins/content-creation/`
**Category:** content
**Version:** 1.0.0

**Commands (5):**
| Command | File | Purpose |
|---------|------|---------|
| /create-project-memory-skills | commands/create-project-memory-skills.md | Copy memory skills |
| /current-prompt-create | commands/current-prompt-create.md | Create current_prompt.md |
| /ecp | commands/ecp.md | Execute prompt from file |
| /notebook-edit | commands/notebook-edit.md | Jupyter notebook changes |
| /py2notebook | commands/py2notebook.md | Python to notebook |

**Skills (7):**
| Skill | Directory | Purpose |
|-------|-----------|---------|
| prompting | skills/prompting/ | Prompting best practices |
| doc-coauthoring | skills/doc-coauthoring/ | Collaborative documentation |
| internal-comms | skills/internal-comms/ | Internal communication |
| llm-apps-creator | skills/llm-apps-creator/ | LLM application creation |
| power-agent-creator | skills/power-agent-creator/ | Powerful agent creation |
| web-artifacts-builder | skills/web-artifacts-builder/ | Web artifacts builder |
| templates | skills/templates/ | Reusable templates |

## Component Summary

| Category | Count | Details |
|----------|-------|---------|
| **Plugins** | 6 | Each v1.0.0, independently installable |
| **Agents** | 7 | Distributed: debate(4), dev(1), design(1), productivity(1) |
| **Commands** | 23 | Distributed: debate(4), dev(6), design(1), prod(7), content(5) |
| **Skills** | 26 | Distributed: debate(1), docs(4), dev(4), design(6), prod(4), content(7) |
| **Marketplaces** | 7 | 1 root aggregator + 6 plugin marketplaces |

## Installation Model

### Aggregator Method (Recommended)
Add the root marketplace and install individual plugins:
```bash
/plugin marketplace add hongbietcode/synthetic-claude
/plugin install synthetic-claude@debate-system
/plugin install synthetic-claude@document-suite
# Install only plugins you need
```

### Direct Plugin Method
Install plugins directly if using as template:
```bash
/plugin install path/to/debate-system
/plugin install path/to/document-suite
# Works for local/custom plugins
```

### Scope Selection
Each installation supports three scopes:
- `--scope user` - Global access (default)
- `--scope project` - Version controlled in `.claude/plugins/`
- `--scope local` - Machine-local, not version controlled

## File Format Standards

### YAML Frontmatter + Markdown Pattern

**Agents & Commands:**
```yaml
---
name: identifier (kebab-case)
description: One-liner (user-facing)
model: haiku (agents only)
---

# Markdown content
[Implementation details]
```

**Skills:**
```yaml
---
name: skill-name (kebab-case)
description: One-line purpose
license: MIT
---

# {Skill Name}
[Documentation and usage]
```

### Naming Conventions
- **Directories:** kebab-case (e.g., `debate-system`, `dev-tools`)
- **Files:** kebab-case.md (e.g., `debate.md`, `px-backend-api.md`)
- **Identifiers:** kebab-case (e.g., `debate-orchestrator`, `research-assistant`)
- **Marketplace categories:** workflows, documents, development, design, productivity, content

## File Statistics

| Component | Count | Approximate Tokens | Status |
|-----------|-------|-------------------|--------|
| Agents | 7 | ~15,000 | Complete |
| Commands | 23 | ~80,000 | Complete |
| Skills | 26 | ~950,000 | Complete |
| Documentation | 5 docs | ~12,000 | Complete |
| Marketplaces | 7 files | ~5,000 | Complete |
| **Total** | **68 components** | **~1,062,000** | v1.0.0 |

## Key Design Patterns

### 1. Plugin Modularity
- Each plugin is independently installable
- No inter-plugin dependencies
- Selective installation reduces context usage
- Aggregator pattern enables unified discovery

### 2. YAML-First Configuration
- Declarative behavior in frontmatter
- Machine-readable, human-editable
- Version and metadata centralized

### 3. Context Isolation
- Agents include CONTEXT ISOLATION preamble
- Prevents cross-agent contamination
- Ensures independent Phase 1 analysis

### 4. Stateless Execution
- No persistent state between sessions
- Reproducible results
- Safe sandbox operation

### 5. Skill Composition
- Agents/commands reference skills declaratively
- Skills auto-activate when called
- Modular, extensible architecture

## Development Workflow

### Adding a Component to a Plugin

**1. New Agent:**
```bash
# File: plugins/{plugin}/agents/{name}.md
# Include YAML frontmatter with name, description, model
# Add Role, Behavioral Standards, Output Format sections
# Update: plugins/{plugin}/.claude-plugin/marketplace.json
```

**2. New Command:**
```bash
# File: plugins/{plugin}/commands/{name}.md
# Include YAML frontmatter with description, argument-hint
# Add Process, Output, Examples sections
# Update: plugins/{plugin}/.claude-plugin/marketplace.json
```

**3. New Skill:**
```bash
# Directory: plugins/{plugin}/skills/{skill-name}/
# Create: SKILL.md with YAML frontmatter
# Create: scripts/ subdirectory for implementation
# Update: plugins/{plugin}/.claude-plugin/marketplace.json
```

### Testing
- Agents: Solo output, discussion response, edge cases
- Commands: Valid input, missing args, invalid input
- Skills: Initialization, output format, error handling

## Performance Characteristics

### Latency
- **Phase 1 (3 parallel agents):** 15-20s
- **Phase 2 (3 parallel agents):** 15-20s
- **Phase 3 (serial synthesis):** 10-15s
- **Standard debate total:** 40-55s
- **Deep mode (converged):** 40-55s
- **Deep mode (diverged):** 70-90s (second Phase 2b)

### Token Usage
- **Per debate:** ~2000-3000 tokens (Haiku model)
- **Per skill:** Variable (pdf ~500-1000, docx ~1000-2000)
- **Efficiency:** Haiku minimizes API costs

## Security & Isolation

- Agents run in separate Task contexts
- CONTEXT ISOLATION preamble prevents injection
- No persistent state between sessions
- Standard Claude Code sandbox protections
- No external data persistence

## Version Information

- **Plugin Architecture Version:** 1.0.0
- **Each Plugin Version:** 1.0.0
- **License:** MIT
- **Node/Language:** JavaScript + Python (mixed)
- **Dependencies:** None explicit (Claude Code runtime)

## Related Resources

- **README.md** - User installation & usage guide
- **docs/project-overview-pdr.md** - Vision, goals, requirements
- **docs/system-architecture.md** - Plugin interactions, data flow
- **docs/code-standards.md** - File formats, conventions
- **docs/project-roadmap.md** - Planned features & releases
