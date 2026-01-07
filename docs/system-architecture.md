# System Architecture

## Multi-Plugin Architecture (v1.0.0)

Synthetic Claude is a **modular marketplace** composed of 6 independent plugins orchestrated through an aggregator pattern.

```
synthetic-claude (Aggregator)
├── .claude-plugin/marketplace.json    # Root registry
└── plugins/                           # 6 independent plugins
    ├── debate-system/
    │   ├── .claude-plugin/marketplace.json
    │   ├── agents/ (4 agents)
    │   ├── commands/ (4 commands)
    │   └── skills/ (1 skill)
    ├── document-suite/
    │   ├── .claude-plugin/marketplace.json
    │   └── skills/ (4 skills)
    ├── dev-tools/
    │   ├── .claude-plugin/marketplace.json
    │   ├── agents/ (1 agent)
    │   ├── commands/ (6 commands)
    │   └── skills/ (4 skills)
    ├── design-studio/
    │   ├── .claude-plugin/marketplace.json
    │   ├── agents/ (1 agent)
    │   ├── commands/ (1 command)
    │   └── skills/ (6 skills)
    ├── productivity-kit/
    │   ├── .claude-plugin/marketplace.json
    │   ├── agents/ (1 agent)
    │   ├── commands/ (7 commands)
    │   └── skills/ (4 skills)
    └── content-creation/
        ├── .claude-plugin/marketplace.json
        ├── commands/ (5 commands)
        └── skills/ (7 skills)
```

## Marketplace Aggregator Pattern

### Root Marketplace (`.claude-plugin/marketplace.json`)

The root marketplace is a **registry** that:
- Declares no agents, commands, or skills directly
- References 6 plugin directories via `source` paths
- Enables unified discovery via single `/plugin marketplace add`

```json
{
  "name": "synthetic-claude",
  "plugins": [
    {
      "name": "debate-system",
      "source": "./plugins/debate-system",
      "version": "1.0.0",
      "category": "workflows"
    },
    {
      "name": "document-suite",
      "source": "./plugins/document-suite",
      "version": "1.0.0",
      "category": "documents"
    },
    // ... 4 more plugins
  ]
}
```

### Plugin Marketplaces

Each plugin directory contains own `.claude-plugin/marketplace.json`:
- Declares agents, commands, skills with `./` relative paths
- Contains full component definitions
- Version 1.0.0 (immutable)
- Can be installed independently

**Example** (`plugins/debate-system/.claude-plugin/marketplace.json`):
```json
{
  "name": "debate-system",
  "plugins": [{
    "name": "debate-system",
    "source": "./",
    "commands": ["./commands/debate.md"],
    "agents": ["./agents/debate-orchestrator.md"],
    "skills": ["./skills/debate-workflow"]
  }]
}
```

## Plugin Catalog

### Plugin 1: Debate System
**Category:** workflows | **Version:** 1.0.0

**Components:**
- **Agents (4):** debate-orchestrator, researcher, critic, synthesizer
- **Commands (4):** /debate, /quick-brainstorm, /discuss, /think-hard
- **Skills (1):** debate-workflow (3-phase orchestration)

**Purpose:** Multi-agent debate with optional convergence feedback

**Installation:**
```bash
/plugin install synthetic-claude@debate-system
```

---

### Plugin 2: Document Suite
**Category:** documents | **Version:** 1.0.0

**Components:**
- **Skills (4):** pdf, docx, pptx, xlsx

**Purpose:** Office document processing and generation

**Installation:**
```bash
/plugin install synthetic-claude@document-suite
```

---

### Plugin 3: Dev Tools
**Category:** development | **Version:** 1.0.0

**Components:**
- **Agents (1):** critical-code-reviewer
- **Commands (6):** /px-backend-api, /px-frontend-api, /fastapi-test, /explore-external-APIs, /gen-feature-docs, /generate-db-docs
- **Skills (4):** webapp-testing, mcp-builder, skill-creator, cc-hooks-creator

**Purpose:** API implementation, testing, code review, documentation

**Installation:**
```bash
/plugin install synthetic-claude@dev-tools
```

---

### Plugin 4: Design Studio
**Category:** design | **Version:** 1.0.0

**Components:**
- **Agents (1):** ui-ux-designer
- **Commands (1):** /design-guide
- **Skills (6):** frontend-design, canvas-design, algorithmic-art, theme-factory, brand-guidelines, slack-gif-creator

**Purpose:** UI/UX design, frontend design systems, visual asset generation

**Installation:**
```bash
/plugin install synthetic-claude@design-studio
```

---

### Plugin 5: Productivity Kit
**Category:** productivity | **Version:** 1.0.0

**Components:**
- **Agents (1):** research-assistant
- **Commands (7):** /parallel-work, /integrate-parallel-work, /refactor-interactive, /tidy-up, /tidy-docs, /git-configure, /tmux-team-restart
- **Skills (4):** quick-research, tmux-team-creator, coder-memory-store, coder-memory-recall

**Purpose:** Project management, refactoring, research, version control

**Installation:**
```bash
/plugin install synthetic-claude@productivity-kit
```

---

### Plugin 6: Content Creation
**Category:** content | **Version:** 1.0.0

**Components:**
- **Commands (5):** /create-project-memory-skills, /current-prompt-create, /ecp, /notebook-edit, /py2notebook
- **Skills (7):** prompting, doc-coauthoring, internal-comms, llm-apps-creator, power-agent-creator, web-artifacts-builder, templates

**Purpose:** Content creation, documentation, LLM application building

**Installation:**
```bash
/plugin install synthetic-claude@content-creation
```

---

## Component Distribution

### Agents by Plugin
| Plugin | Count | Details |
|--------|-------|---------|
| debate-system | 4 | debate-orchestrator, researcher, critic, synthesizer |
| dev-tools | 1 | critical-code-reviewer |
| design-studio | 1 | ui-ux-designer |
| productivity-kit | 1 | research-assistant |
| **Total** | **7** | Distributed across 4 plugins |

### Commands by Plugin
| Plugin | Count | Details |
|--------|-------|---------|
| debate-system | 4 | debate, quick-brainstorm, discuss, think-hard |
| dev-tools | 6 | backend/frontend API, testing, docs |
| design-studio | 1 | design-guide |
| productivity-kit | 7 | git, refactor, documentation |
| content-creation | 5 | prompting, notebooks, memory |
| **Total** | **23** | Distributed across 5 plugins |

### Skills by Plugin
| Plugin | Count | Details |
|--------|-------|---------|
| debate-system | 1 | debate-workflow |
| document-suite | 4 | pdf, docx, pptx, xlsx |
| dev-tools | 4 | webapp-testing, mcp-builder, skill-creator, cc-hooks-creator |
| design-studio | 6 | frontend-design, canvas-design, algorithmic-art, theme-factory, brand-guidelines, slack-gif-creator |
| productivity-kit | 4 | quick-research, tmux-team-creator, coder-memory-store, coder-memory-recall |
| content-creation | 7 | prompting, doc-coauthoring, internal-comms, llm-apps-creator, power-agent-creator, web-artifacts-builder, templates |
| **Total** | **26** | Distributed across 6 plugins |

## Installation Flows

### Discovery Flow
```
User:
  /plugin marketplace add hongbietcode/synthetic-claude
         ↓
Claude Code:
  Fetches root marketplace.json
  Discovers 6 plugins (debate-system, document-suite, dev-tools, design-studio, productivity-kit, content-creation)
  Displays: "Available plugins: ..."
         ↓
User:
  Can now reference via: synthetic-claude@plugin-name
```

### Installation Flow
```
User:
  /plugin install synthetic-claude@debate-system
         ↓
Claude Code:
  Reads root marketplace for plugin reference
  Navigates to: plugins/debate-system/.claude-plugin/marketplace.json
  Reads component declarations:
    - agents: 4 files
    - commands: 4 files
    - skills: 1 directory
         ↓
  Installs components with scope:
    --scope user (default)    → Global access
    --scope project           → Version controlled
    --scope local             → Machine-local
         ↓
Output: "Installed debate-system: 4 agents, 4 commands, 1 skill"
```

### Multi-Plugin Installation
```
User:
  /plugin install synthetic-claude@debate-system
  /plugin install synthetic-claude@dev-tools
  /plugin install synthetic-claude@document-suite
         ↓
Result: 3 plugins available, context reduced by ~65%
        (Uninstalled 3 plugins unused for this project)
```

## Agent Orchestration (Debate System)

The debate-system plugin coordinates multi-phase analysis:

```
Phase 1: Independent Analysis
  ↓
/debate "Should we migrate to microservices?"
  ↓
debate-orchestrator Agent receives topic
  ↓
Spawn 3 parallel Task calls:
  ├─ researcher Task → "Research Findings + KEY RECOMMENDATION"
  ├─ critic Task → "Risk Analysis + KEY RECOMMENDATION"
  └─ synthesizer Task → "Pattern Analysis + KEY RECOMMENDATION"
  ↓
[Wait for all 3 outputs]
  ↓
Phase 2: Discussion
  ↓
Spawn 3 parallel Task calls (each receives all Phase 1 outputs):
  ├─ researcher Task → "Updated perspective + refined KEY RECOMMENDATION"
  ├─ critic Task → "Refined critique + updated KEY RECOMMENDATION"
  └─ synthesizer Task → "Integrated patterns + updated KEY RECOMMENDATION"
  ↓
[Deep mode convergence check]
  ├─ If --deep flag set:
  │   ├─ Compare all 3 KEY RECOMMENDATIONs
  │   ├─ If converged → Skip to Phase 3
  │   └─ If diverged → Execute Phase 2b (second discussion round)
  └─ If standard mode:
      └─ Proceed directly to Phase 3
  ↓
Phase 3: Synthesis
  ↓
synthesizer Task receives all Phase 2 outputs
  ↓
"Final recommendation + action items"
```

**Context Isolation Pattern:**

Each agent receives:
1. CONTEXT ISOLATION preamble:
   ```
   CONTEXT ISOLATION: This is a standalone debate exercise.
   Ignore repository context. Focus ONLY on the topic.
   ```
2. Independent analysis instructions
3. (Phase 2+) Previous outputs for reference
4. Strict output format specification

## Skill Integration Pattern

Skills are **declared in agent/command prompts** and auto-activate:

```
Agent/Command Prompt:
  "Use the PDF skill to extract and analyze the document."
         ↓
Claude Code:
  Detects skill reference
  Looks up: plugins/{plugin}/skills/{skill-name}/SKILL.md
  Invokes skill implementation
         ↓
Skill Return:
  Extracted data, transformations, or generated artifacts
         ↓
Agent/Command:
  Processes skill output
  Formats final response
```

**Example:** Dev-tools plugin with skill-creator

```
User: /gen-feature-docs "Payment processing"
         ↓
Command Handler (dev-tools/commands/gen-feature-docs.md):
  Receives: $ARGUMENTS = "Payment processing"
         ↓
  "Use skill-creator to scaffold documentation structure"
  "Use prompting skill from content-creation for quality"
         ↓
skill-creator (dev-tools/skills/skill-creator/):
  Generates template
         ↓
prompting (content-creation/skills/prompting/):
  Enhances quality
         ↓
Output: Professional feature documentation
```

## Data Flow Patterns

### Standard Command Flow
```
User Input
  ↓
Command File (plugins/{plugin}/commands/{name}.md)
  ├─ Parse YAML frontmatter
  ├─ Variable substitution ($ARGUMENTS, $FILES)
  └─ Execute markdown instructions
  ↓
Agent/Skill References
  ├─ Call agents from marketplace
  ├─ Reference skills declaratively
  └─ Compose outputs
  ↓
Formatted Result
```

### Debate Flow (Detailed)
```
Input: Topic + Mode (--deep or not)
  ↓
[Phase 1 - Parallel]
  Researcher → Evidence-based analysis
  Critic → Risk/challenge analysis
  Synthesizer → Pattern recognition
  ↓
[Collect Phase 1 outputs]
  ↓
[Phase 2 - Parallel]
  Each agent receives ALL Phase 1 outputs
  "Reference others' perspectives, update your position"
  ↓
[Collect Phase 2 outputs]
  ↓
[Deep Mode Convergence Check - If --deep]
  Extract KEY RECOMMENDATION from each agent
  Compare similarity:
    ├─ >80% alignment → CONVERGED
    └─ <80% alignment → DIVERGED

  If DIVERGED:
    [Phase 2b - Second Discussion Round]
    Agents reference Phase 2 outputs
    "Build consensus or document differences"
  ↓
[Phase 3 - Serial]
  Synthesizer reads all previous outputs
  Creates final recommendation
  ↓
Output: Formatted debate result with action items
```

## Scope Management

### Installation Scopes

Each plugin installation can target 3 scopes:

| Scope | Path | Visibility | Priority |
|-------|------|-----------|----------|
| **user** | `~/.claude/plugins/` | All projects | 3 (lowest) |
| **project** | `./.claude/plugins/` | Team in git | 2 (middle) |
| **local** | Project config (not versioned) | Current machine | 1 (highest) |

**Scope Resolution Example:**

```
User installs synthetic-claude@debate-system 3 times:
  /plugin install synthetic-claude@debate-system --scope user
  /plugin install synthetic-claude@debate-system --scope project
  /plugin install synthetic-claude@debate-system --scope local

When /debate command runs:
  Local plugin used (if local version exists)
  └─ Highest priority
     ├─ Overrides project version
     └─ Overrides user version
```

## File System Layout

### Plugin Structure (Example: dev-tools)

```
plugins/dev-tools/
├── .claude-plugin/
│   └── marketplace.json                    # Plugin declaration
├── agents/
│   └── critical-code-reviewer.md           # 1 agent file
├── commands/
│   ├── px-backend-api.md                   # 6 command files
│   ├── px-frontend-api.md
│   ├── fastapi-test.md
│   ├── explore-external-APIs.md
│   ├── gen-feature-docs.md
│   └── generate-db-docs.md
└── skills/
    ├── webapp-testing/
    │   ├── SKILL.md
    │   ├── scripts/
    │   │   ├── test-framework.js
    │   │   └── helpers.py
    │   └── references/
    ├── mcp-builder/
    ├── skill-creator/
    └── cc-hooks-creator/
```

## Component Lifecycle

### Adding a New Command to Dev-Tools

```
1. Create file:
   plugins/dev-tools/commands/{name}.md

2. Add YAML frontmatter:
   ---
   description: User-facing one-liner
   argument-hint: [param1] [--flag]
   ---

3. Add markdown instructions:
   Agents/skills to call, output format, examples

4. Update marketplace:
   plugins/dev-tools/.claude-plugin/marketplace.json
   Add entry: "commands": ["./commands/{name}.md"]

5. Test:
   /plugin list
   /command (should show new command)
```

### Adding a New Skill to Design-Studio

```
1. Create directory:
   plugins/design-studio/skills/{skill-name}/

2. Create documentation:
   plugins/design-studio/skills/{skill-name}/SKILL.md

3. Create implementation:
   plugins/design-studio/skills/{skill-name}/scripts/
   (JavaScript, Python, etc.)

4. Update marketplace:
   plugins/design-studio/.claude-plugin/marketplace.json
   Add entry: "skills": ["./skills/{skill-name}"]

5. Test:
   Agents can reference in prompts:
   "Use {skill-name} skill to..."
```

## Performance Characteristics

### Plugin Load Time
- **Root marketplace discovery:** <1s (cached)
- **Plugin marketplace fetch:** <1s per plugin
- **Component registration:** <100ms per component

### Execution Latency
- **Command execution:** 1-5s (depends on complexity)
- **Agent Phase (3 parallel):** 15-20s
- **Skill invocation:** 500ms-5s (varies by skill)

### Context Usage Reduction
- **Monolithic (all 7 agents, 23 commands, 26 skills):** ~1M tokens
- **Debate-only (4 agents, 4 commands, 1 skill):** ~100K tokens
- **Dev-tools (1 agent, 6 commands, 4 skills):** ~150K tokens
- **Savings:** Install only needed plugins → 65-90% context reduction

## Security & Isolation

### Plugin Isolation
- Each plugin is independently sandboxed
- No inter-plugin memory sharing
- Standard Claude Code permissions apply

### Agent Isolation (Debate System)
- Each agent runs in separate Task context
- CONTEXT ISOLATION preamble in prompts
- No cross-agent contamination

### Skill Isolation
- Skills run within Claude Code runtime
- File operations respect user permissions
- No privilege escalation

## Future Extensibility

### Adding a New Plugin

To add a 7th plugin (e.g., analytics):

```
1. Create plugin directory:
   plugins/analytics/

2. Create .claude-plugin/marketplace.json:
   - Declare agents, commands, skills
   - Version 1.0.0

3. Update root aggregator:
   .claude-plugin/marketplace.json
   Add: {
     "name": "analytics",
     "source": "./plugins/analytics",
     "version": "1.0.0",
     "category": "analytics"
   }

4. Announce via /plugin marketplace update
```

### Inter-Plugin Communication

Plugins communicate through **agent/command composition**:
- Command in plugin A calls agent from plugin B
- Skills can be referenced across plugins (if discoverable)
- No direct dependency declarations needed

**Example:**
```
User: /gen-feature-docs "Payment API"
  (from dev-tools plugin)
         ↓
Command calls skill-creator (dev-tools)
Command calls prompting skill (content-creation)
         ↓
Result: Cross-plugin composition without coupling
```

## Versioning Strategy

### Plugin Versions
- Each plugin: **1.0.0** (frozen)
- Root aggregator: **1.0.0** (frozen)
- All versions immutable in v1.0.0

### Future Updates
- **v1.1.0:** Bug fixes within plugin
- **v1.2.0:** New commands/agents (backward compatible)
- **v2.0.0:** Breaking changes (new marketplace entry)

### Backward Compatibility
- v1.x agents work in v1.x commands
- v1.x skills work across all v1.x components
- No deprecations in v1.x lifecycle
