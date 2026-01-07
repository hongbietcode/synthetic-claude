# System Architecture

## Plugin Architecture

### Plugin Structure

Synthetic Claude is a Claude Code marketplace plugin with declarative architecture:

```
synthetic-claude (Plugin Root)
├── .claude-plugin/
│   └── marketplace.json          # Plugin registry & configuration
├── agents/
│   ├── {agent-name}.md           # YAML + markdown agent definitions
│   └── [7 total agents]
├── commands/
│   ├── {command-name}.md         # YAML + markdown command definitions
│   └── [23 total commands]
├── skills/
│   ├── {skill-name}/
│   │   ├── SKILL.md              # Skill documentation
│   │   ├── scripts/              # Implementation files (JS/Python/etc)
│   │   └── references/           # External resources
│   └── [26 total skills]
├── README.md                     # User-facing documentation
└── docs/                         # Technical documentation
    ├── project-overview-pdr.md
    ├── code-standards.md
    ├── system-architecture.md
    ├── codebase-summary.md
    └── project-roadmap.md
```

### Marketplace Registration

`marketplace.json` declares all components:

```json
{
  "plugins": [{
    "commands": ["./commands/cmd.md"],
    "agents": ["./agents/agent.md"],
    "skills": ["./skills/skill-dir"],
    "strict": false
  }]
}
```

**Key fields:**
- `commands[]` - Array of command file paths (user-invokable)
- `agents[]` - Array of agent file paths (autonomous responders)
- `skills[]` - Array of skill directory paths (reusable capabilities)
- `strict: false` - Allows installation without plugin.json in skill directories

## Component Interactions

### Agent Orchestration

Agents interact through a **sequential multi-phase workflow**:

```
Phase 1: Individual Analysis
├─ Researcher (parallel)
├─ Critic (parallel)
└─ Synthesizer (parallel)
       ↓
Phase 2: Discussion
├─ Each agent references others' positions
├─ Updates KEY RECOMMENDATION field
└─ Generates refined arguments
       ↓
Deep Mode Check:
├─ Compare all 3 KEY RECOMMENDATIONs
├─ If converged → Phase 3
└─ If diverged → Phase 2b (discussion) → Phase 3
       ↓
Phase 3: Synthesis
└─ Consolidated recommendation with action items
```

**Isolation Pattern:**

Each agent receives:
1. CONTEXT ISOLATION preamble (prevents cross-contamination)
2. Independent prompt (no reference to other agents initially)
3. Previous phase outputs (for discussion/synthesis)
4. Strict format specification (ensures parseable output)

### Command Processing

Commands act as **entry points to agent workflows**:

```
User Input: /debate "topic" [--deep]
         ↓
Command Handler (debate.md)
         ↓
Parse arguments
├─ Extract topic
└─ Detect --deep flag
         ↓
Invoke debate-orchestrator agent
         ↓
Spawn 3 agent Task calls (Phase 1)
├─ Researcher Task
├─ Critic Task
└─ Synthesizer Task
         ↓
Orchestrator collects results
├─ Parses individual outputs
├─ Detects failures
└─ Passes to Phase 2
```

### Skill Integration

Skills are **called from within agents/commands** via standard Claude Code mechanisms:

```
Agent/Command
       ↓
Use PDF skill: Extract, parse, analyze documents
Use DOCX skill: Create/modify Word documents
Use PPTX skill: Generate presentations
Use XLSX skill: Create spreadsheets
Use skill-creator: Scaffold new skills
Use mcp-builder: Build MCP servers
```

**Skill activation:**

Skills auto-activate when:
1. Skill directory exists in `skills/`
2. Registered in marketplace.json
3. Referenced in agent/command prompt
4. SKILL.md documents how to invoke

## Data Flow

### Standard Debate Workflow

```
Input: Topic + Mode
   ↓
[Phase 1]
   ├─→ Researcher Task
   │   ├─ Receives: topic + isolation preamble
   │   └─ Outputs: Research Findings + KEY RECOMMENDATION
   ├─→ Critic Task (parallel)
   │   ├─ Receives: topic + isolation preamble
   │   └─ Outputs: Risk Analysis + KEY RECOMMENDATION
   └─→ Synthesizer Task (parallel)
       ├─ Receives: topic + isolation preamble
       └─ Outputs: Pattern Analysis + KEY RECOMMENDATION
   ↓
[Phase 2]
   ├─→ Researcher Task
   │   ├─ Receives: own Phase 1 output + Critic Phase 1 + Synthesizer Phase 1
   │   ├─ Receives: "Reference others' findings, update your position"
   │   └─ Outputs: Updated perspective + refined KEY RECOMMENDATION
   ├─→ Critic Task (parallel)
   │   ├─ Receives: own Phase 1 output + Researcher Phase 1 + Synthesizer Phase 1
   │   └─ Outputs: Refined critique + updated KEY RECOMMENDATION
   └─→ Synthesizer Task (parallel)
       └─ Outputs: Integrated patterns + updated KEY RECOMMENDATION
   ↓
[Convergence Check - Deep Mode Only]
   ├─ Extract KEY RECOMMENDATION from each Phase 2 output
   ├─ Compare similarity/alignment
   ├─ Decision:
   │  ├─ Converged → Skip Phase 2b, go to Phase 3
   │  └─ Diverged → Execute Phase 2b (second discussion)
   ↓
[Phase 3]
   ├─ All 3 outputs available
   ├─ Synthesizer drafts final recommendation
   ├─ Includes action items
   └─ Outputs: Final Synthesis + Next Steps
   ↓
Output: Formatted debate result
```

### Command Execution

```
Command file receives: $ARGUMENTS
   ↓
Parse YAML frontmatter
├─ Extract description (for UI)
├─ Extract argument-hint (for help)
└─ Extract allowed-tools (optional restrictions)
   ↓
Execute markdown content
├─ Process $ARGUMENTS variable substitution
├─ Call agents/skills as needed
└─ Format output per markdown spec
   ↓
Return: Command result
```

## Key Design Patterns

### 1. YAML-First Configuration

**Pattern:** All behavior defined in frontmatter, implementation in markdown

**Benefit:** Machine-readable configuration, human-readable behavior

```yaml
---
name: agent-id
description: One-liner
model: haiku
---
Instructions and behavior...
```

### 2. Context Isolation

**Pattern:** Prepend CONTEXT ISOLATION preamble before agent prompts

**Benefit:** Prevents agents from influencing each other

```
CONTEXT ISOLATION: This is a standalone debate exercise.
IGNORE repository/codebase context. Focus ONLY on the topic.
```

### 3. Key Recommendation Tracking

**Pattern:** Each agent must output a `KEY RECOMMENDATION` field

**Benefit:** Enables convergence detection in deep mode

```markdown
## Key Recommendation
[Clear, concise recommendation suitable for comparison]
```

### 4. Declarative Skill Composition

**Pattern:** Agents/commands declare skills in prompts; skills auto-activate

**Benefit:** Modular, extensible, no hardcoded dependencies

```
"Please use the PDF skill to analyze the document"
```

### 5. Stateless Execution

**Pattern:** No persistent state between commands/debates

**Benefit:** Reproducible, safe, no unexpected side effects

**Trade-off:** Each debate is independent (no history/memory by default)

## Installation Scopes

Plugin marketplace supports three installation scopes:

### User Scope (Default)
- **Location:** User's global Claude Code config
- **Access:** All projects on user's machine
- **Use case:** Personal agent library
- **Command:** `/plugin install synthetic-claude@synthetic-claude --scope user`
- **Persistence:** Across all projects until uninstalled

### Project Scope
- **Location:** Project's `.claude/plugins/` directory
- **Access:** Team members who clone repo
- **Use case:** Team-shared agents and workflows
- **Command:** `/plugin install synthetic-claude@synthetic-claude --scope project`
- **Persistence:** In version control, shared with git

### Local Scope
- **Location:** Project's local config (not version controlled)
- **Access:** Current user's machine only
- **Use case:** Project-specific overrides, experimental agents
- **Command:** `/plugin install synthetic-claude@synthetic-claude --scope local`
- **Persistence:** Machine-local, survives git updates

### Scope Priority (Highest to Lowest)
```
Local (project-specific) >
Project (team-shared) >
User (global default)
```

When same plugin installed at multiple scopes, local takes precedence.

## Failure Handling

### Agent Task Failures

If an agent Task fails:
1. Orchestrator catches error
2. Logs failure message
3. Continues with other agents (fault-tolerant)
4. Notes failure in final output
5. User sees partial results

### Convergence Detection False Positives

If KEY RECOMMENDATIONs appear different but are semantically similar:
1. Deep mode triggers Phase 2b
2. Agents explicitly reference differences
3. Refined recommendations more likely to converge
4. Worst case: Both Phase 3 proceed with diverse recommendations

### Command Argument Parsing

If arguments invalid:
1. Command checks syntax
2. Shows helpful error message
3. Suggests correct usage
4. Does not execute with bad args

## Performance Characteristics

### Latency

| Operation | Latency | Notes |
|-----------|---------|-------|
| Phase 1 (3 parallel) | ~15-20s | All agents run simultaneously |
| Phase 2 (3 parallel) | ~15-20s | Depends on previous outputs |
| Phase 3 (serial) | ~10-15s | Single agent synthesis |
| Deep convergence check | <1s | Simple string comparison |
| **Total (standard mode)** | **~40-55s** | Typical debate |
| **Total (deep mode, converged)** | **~40-55s** | Same as standard |
| **Total (deep mode, diverged)** | **~70-90s** | +second Phase 2b |

### Token Usage

- **Researcher/Critic:** ~200-300 input tokens, ~100-200 output tokens each
- **Synthesizer:** ~400-500 input tokens (reads others), ~150-250 output
- **Deep mode additional:** ~200-300 input tokens (convergence analysis)
- **Total per debate:** ~2000-3000 tokens (Haiku cost-efficient)

### Scalability

- **Agents:** Limited to current 3-agent model (debate orchestrator role)
- **Commands:** No limit, scales to hundreds
- **Skills:** No limit, scales to hundreds
- **Bottleneck:** Sequential Phase 2/3 execution in deep mode

## Security & Isolation

### Agent Isolation

- Each agent runs in separate Task context
- No shared memory or state
- CONTEXT ISOLATION preamble prevents prompt injection
- Model: Always Haiku (no premium models exposing sensitive data)

### Command Isolation

- Commands validate input before execution
- File operations respect filesystem permissions
- Marked commands can restrict tool access via `allowed-tools`

### Skill Isolation

- Skills run in user's Claude Code environment
- Standard sandbox protections apply
- No network access unless explicitly in SKILL.md

### Data Privacy

- No data persisted to external services
- All debate/analysis ephemeral (session-only)
- File operations respect user file access controls
- Plugin operates within Claude Code's security model
