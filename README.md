# Synthetic Claude

Extensible Claude Code plugin with multi-agent capabilities.

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

```bash
cd plugins/synthetic-claude
./install.sh
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

## Uninstall

```bash
./uninstall.sh
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
├── install.sh
├── uninstall.sh
└── README.md
```

## Adding New Features

To add new agents/commands:

1. Add agent file to `agents/`
2. Add command file to `commands/`
3. Add skill directory to `skills/`
4. Update `marketplace.json`
5. Update install/uninstall scripts

## License

MIT
