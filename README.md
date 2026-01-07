# Synthetic Claude

Extensible Claude Code plugin with multi-agent debate capabilities, productivity tools, and document processing skills.

## Features

### Multi-Agent Debate (`/debate`)

Structured 3-phase debate system with optional deep mode for convergence feedback:

**Standard Mode (3-phase):**
```
Phase 1 (Individual) → Phase 2 (Discussion) → Phase 3 (Synthesis)
```

**Deep Mode (with feedback loop, use `--deep` flag):**
```
Phase 1 → Phase 2 → Convergence Check ─┬─► Phase 3
                                       └─► Phase 2b → Phase 3
```

**Agents:**
- **Researcher** - Explores possibilities, gathers evidence
- **Critic** - Challenges assumptions, identifies risks
- **Synthesizer** - Finds patterns, integrates perspectives

### Productivity Commands

Quick access to structured analysis, brainstorming, refactoring, and project management:
- `/quick-brainstorm` - Generate ideas with counter-arguments
- `/discuss` - Rapid discussion with critical analysis
- `/think-hard` - Challenge assumptions and find gaps
- `/parallel-work` - Setup Git worktrees for feature development
- `/refactor-interactive` - Guided refactoring with step explanations

### Document Processing

Full-featured document manipulation:
- **PDF** - Extract, analyze, and transform PDF content
- **DOCX** - Word document creation and modification
- **PPTX** - PowerPoint presentation generation
- **XLSX** - Excel spreadsheet creation and data manipulation

### Development Tools

Code review, documentation generation, and design assistance:
- `/px-backend-api` - Implement backend APIs from specifications
- `/px-frontend-api` - Frontend integration with backend APIs
- `/gen-feature-docs` - Generate developer and user docs
- `/design-guide` - Analyze and discuss design improvements
- `/generate-db-docs` - Create database documentation

## Installation

### Add Marketplace

```bash
/plugin marketplace add hongbietcode/synthetic-claude
```

### Install Plugin

Choose installation scope:

**User Scope (personal, default):**
```bash
/plugin install synthetic-claude@synthetic-claude --scope user
```

**Project Scope (team/version control):**
```bash
/plugin install synthetic-claude@synthetic-claude --scope project
```

**Local Scope (project-specific override):**
```bash
/plugin install synthetic-claude@synthetic-claude --scope local
```

### Verify Installation

```bash
/plugin list
```

## Usage Examples

### Debate

```bash
# Standard 3-phase debate
/debate "Should we migrate to microservices?"

# Deep mode with convergence feedback
/debate "React vs Vue for new project" --deep

# Complex technical decision
/debate "SQL vs NoSQL for our analytics pipeline"
```

**Output format:**
```markdown
## Debate: {topic}

### Individual Perspectives
- Researcher: {findings with evidence}
- Critic: {risks and concerns}
- Synthesizer: {integrated patterns}

### Discussion Highlights
{key exchanges between agents}

### Final Synthesis
{consolidated recommendation with action items}

### Next Steps
{prioritized actions}
```

### Quick Analysis

```bash
/quick-brainstorm "Mobile app monetization strategies"
/think-hard "Performance optimization for large datasets"
/discuss "API design best practices for our platform"
```

### Document Processing

```bash
# Extract and analyze PDF
[Use PDF skill to process documents]

# Create presentations
[Use PPTX skill for presentation generation]

# Generate spreadsheets
[Use XLSX skill for data export]
```

## Plugin Management

```bash
# View all installed plugins
/plugin list

# Enable/disable
/plugin enable synthetic-claude@synthetic-claude
/plugin disable synthetic-claude@synthetic-claude

# Update marketplace
/plugin marketplace update synthetic-claude

# Uninstall
/plugin uninstall synthetic-claude@synthetic-claude

# Remove marketplace
/plugin marketplace remove synthetic-claude
```

## Architecture Overview

```
synthetic-claude/
├── agents/                    # AI agents for debate and analysis
│   ├── debate-orchestrator    # Coordinates debate workflow
│   ├── researcher            # Evidence gatherer
│   ├── critic                # Risk identifier
│   ├── synthesizer           # Pattern finder
│   ├── critical-code-reviewer # Code analysis
│   ├── research-assistant    # Research support
│   └── ui-ux-designer        # Design guidance
├── commands/                 # User-facing commands (23 total)
│   ├── debate                # Multi-agent debate
│   ├── quick-brainstorm      # Rapid ideation
│   ├── design-guide          # Design analysis
│   └── [20+ productivity commands]
├── skills/                   # Reusable capabilities (26 total)
│   ├── debate-workflow       # Core debate system
│   ├── pdf, docx, pptx, xlsx # Document processing
│   ├── skill-creator         # Skill scaffolding
│   ├── mcp-builder           # MCP server creation
│   ├── frontend-design       # Design assets
│   └── [19+ specialized skills]
└── .claude-plugin/
    └── marketplace.json      # Plugin configuration
```

## Configuration

All configuration is declarative via YAML frontmatter in agent/command files. No setup required beyond installation.

## Documentation

- **[Project Overview & PDR](./docs/project-overview-pdr.md)** - Vision, goals, requirements
- **[System Architecture](./docs/system-architecture.md)** - Plugin structure, component patterns
- **[Codebase Summary](./docs/codebase-summary.md)** - Full inventory of agents, commands, skills
- **[Code Standards](./docs/code-standards.md)** - File formats, conventions
- **[Project Roadmap](./docs/project-roadmap.md)** - Current state, future enhancements

## Support

- Check `/docs` for detailed documentation
- Review agent/command files for implementation details
- See marketplace.json for full component registry

## License

MIT
