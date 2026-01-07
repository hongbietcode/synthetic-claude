# Synthetic Claude

Modular Claude Code plugin marketplace with 6 specialized plugins for selective installation.

## Plugins

| Plugin | Description | Components | Docs |
|--------|-------------|------------|------|
| **[debate-system](./plugins/debate-system/)** | Multi-agent debate with 3-phase workflow | 4 agents, 4 commands, 1 skill | [README](./plugins/debate-system/README.md) |
| **[document-suite](./plugins/document-suite/)** | PDF, DOCX, PPTX, XLSX processing | 4 skills | [README](./plugins/document-suite/README.md) |
| **[dev-tools](./plugins/dev-tools/)** | API implementation, testing, code review | 1 agent, 6 commands, 4 skills | [README](./plugins/dev-tools/README.md) |
| **[design-studio](./plugins/design-studio/)** | UI/UX, frontend design, visual assets | 1 agent, 1 command, 6 skills | [README](./plugins/design-studio/README.md) |
| **[productivity-kit](./plugins/productivity-kit/)** | Project management, refactoring, research | 1 agent, 7 commands, 4 skills | [README](./plugins/productivity-kit/README.md) |
| **[content-creation](./plugins/content-creation/)** | Prompting, documentation, LLM apps | 5 commands, 7 skills | [README](./plugins/content-creation/README.md) |

## Installation

### Add Marketplace

```bash
/plugin marketplace add hongbietcode/synthetic-claude
```

### Install Individual Plugins

```bash
# Install only what you need
/plugin install synthetic-claude@debate-system
/plugin install synthetic-claude@document-suite
/plugin install synthetic-claude@dev-tools
/plugin install synthetic-claude@design-studio
/plugin install synthetic-claude@productivity-kit
/plugin install synthetic-claude@content-creation
```

### Install All Plugins

```bash
/plugin install synthetic-claude@debate-system
/plugin install synthetic-claude@document-suite
/plugin install synthetic-claude@dev-tools
/plugin install synthetic-claude@design-studio
/plugin install synthetic-claude@productivity-kit
/plugin install synthetic-claude@content-creation
```

## Plugin Details

### debate-system

Multi-agent debate with optional deep mode for convergence feedback.

**Commands:**
- `/debate` - Multi-agent debate (use `--deep` for convergence check)
- `/quick-brainstorm` - Rapid ideation with counter-arguments
- `/discuss` - Quick discussion with critical analysis
- `/think-hard` - Challenge assumptions and find gaps

**Agents:** debate-orchestrator, researcher, critic, synthesizer

### document-suite

Document processing for office formats.

**Skills:** pdf, docx, pptx, xlsx

### dev-tools

Development and API tools.

**Commands:**
- `/px-backend-api` - Implement backend APIs from specs
- `/px-frontend-api` - Frontend integration with backend
- `/fastapi-test` - Comprehensive API tests
- `/explore-external-APIs` - Test and document APIs
- `/gen-feature-docs` - Generate developer + user docs
- `/generate-db-docs` - Create database documentation

**Agents:** critical-code-reviewer

**Skills:** webapp-testing, mcp-builder, skill-creator, cc-hooks-creator

### design-studio

Design and visual asset tools.

**Commands:**
- `/design-guide` - Design analysis without modifying code

**Agents:** ui-ux-designer

**Skills:** frontend-design, canvas-design, algorithmic-art, theme-factory, brand-guidelines, slack-gif-creator

### productivity-kit

Project management and productivity tools.

**Commands:**
- `/parallel-work` - Setup Git worktrees for feature dev
- `/integrate-parallel-work` - Merge parallel features
- `/refactor-interactive` - Guided refactoring with steps
- `/tidy-up` - Cleanup project structure
- `/tidy-docs` - Reorganize documentation
- `/git-configure` - Configure Git user (personal/work)
- `/tmux-team-restart` - Restart tmux with state preservation

**Agents:** research-assistant

**Skills:** quick-research, tmux-team-creator, coder-memory-store, coder-memory-recall

### content-creation

Content and documentation tools.

**Commands:**
- `/create-project-memory-skills` - Copy memory skills to project
- `/current-prompt-create` - Create current_prompt.md
- `/ecp` - Execute prompt from file
- `/notebook-edit` - Suggest Jupyter notebook changes
- `/py2notebook` - Convert Python to notebook

**Skills:** prompting, doc-coauthoring, internal-comms, llm-apps-creator, power-agent-creator, web-artifacts-builder, templates

## Plugin Management

```bash
# View installed plugins
/plugin list

# Enable/disable specific plugin
/plugin enable synthetic-claude@debate-system
/plugin disable synthetic-claude@document-suite

# Update marketplace
/plugin marketplace update synthetic-claude

# Uninstall plugin
/plugin uninstall synthetic-claude@debate-system

# Remove marketplace
/plugin marketplace remove synthetic-claude
```

## Architecture

```
synthetic-claude/
├── plugins/
│   ├── debate-system/          # Multi-agent debate
│   ├── document-suite/         # Document processing
│   ├── dev-tools/              # Development tools
│   ├── design-studio/          # Design tools
│   ├── productivity-kit/       # Productivity tools
│   └── content-creation/       # Content tools
├── .claude-plugin/
│   └── marketplace.json        # Plugin registry
├── docs/                       # Documentation
└── README.md
```

## Documentation

- **[Project Overview](./docs/project-overview-pdr.md)** - Vision, goals, requirements
- **[System Architecture](./docs/system-architecture.md)** - Plugin structure
- **[Codebase Summary](./docs/codebase-summary.md)** - Component inventory
- **[Code Standards](./docs/code-standards.md)** - File formats, conventions

## License

MIT
