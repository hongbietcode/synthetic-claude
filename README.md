# Synthetic Claude

Extensible Claude Code plugin with multi-agent debate capabilities.

## Features

### Agent Debate (`/debate`)

Multi-agent debate with 3-phase workflow:

```
Individual → Discussion → Synthesis
```

**Agents:**
- **Researcher** - explores possibilities, gathers evidence
- **Critic** - challenges assumptions, identifies risks
- **Synthesizer** - finds patterns, integrates perspectives

## Installation

### Add Marketplace

```bash
/plugin marketplace add hongbietcode/synthetic-claude
```

### Install Plugin

```bash
/plugin install synthetic-claude@synthetic-claude
```

### Scope Options

```bash
/plugin install synthetic-claude@synthetic-claude --scope user     # Personal (default)
/plugin install synthetic-claude@synthetic-claude --scope project  # Team/version control
/plugin install synthetic-claude@synthetic-claude --scope local    # Project-specific
```

## Usage

```bash
/debate "How should we implement authentication?"
/debate "Best approach for database migration"
/debate "React vs Vue for new frontend"
```

## Output

```markdown
## Debate: {topic}

### Individual Perspectives
- Researcher: {findings}
- Critic: {concerns}
- Synthesizer: {patterns}

### Discussion Highlights
{key exchanges}

### Final Synthesis
{consolidated recommendation}

### Next Steps
- {action items}
```

## Plugin Management

```bash
/plugin marketplace list                           # List marketplaces
/plugin marketplace update synthetic-claude        # Update marketplace
/plugin marketplace remove synthetic-claude        # Remove marketplace

/plugin disable synthetic-claude@synthetic-claude      # Disable plugin
/plugin enable synthetic-claude@synthetic-claude       # Enable plugin
/plugin uninstall synthetic-claude@synthetic-claude    # Uninstall plugin
```

## Structure

```
synthetic-claude/
├── .claude-plugin/
│   └── marketplace.json
├── agents/
│   ├── debate-orchestrator.md
│   ├── researcher.md
│   ├── critic.md
│   └── synthesizer.md
├── commands/
│   └── debate.md
├── skills/
│   └── debate-workflow/
│       └── SKILL.md
└── README.md
```

## Adding New Features

1. Add agent file to `agents/`
2. Add command file to `commands/`
3. Add skill directory to `skills/`
4. Update `marketplace.json` to register components

## License

MIT
