# Debate System

Multi-agent debate with 3-phase workflow and optional deep mode for convergence feedback.

## Installation

```bash
/plugin install synthetic-claude@debate-system
```

## Components

### Agents (4)

| Agent | Purpose |
|-------|---------|
| debate-orchestrator | Coordinates multi-phase debate workflow |
| researcher | Explores possibilities, gathers evidence |
| critic | Challenges assumptions, identifies risks |
| synthesizer | Finds patterns, integrates perspectives |

### Commands (4)

| Command | Description |
|---------|-------------|
| `/debate` | Multi-agent debate (use `--deep` for convergence check) |
| `/quick-brainstorm` | Rapid ideation with counter-arguments |
| `/discuss` | Quick discussion with critical analysis |
| `/think-hard` | Challenge assumptions and find gaps |

### Skills (1)

- **debate-workflow** - Core 3-phase debate orchestration

## Workflow

**Standard Mode (3-phase):**
```
Phase 1 (Individual) → Phase 2 (Discussion) → Phase 3 (Synthesis)
```

**Deep Mode (with feedback loop):**
```
Phase 1 → Phase 2 → Convergence Check ─┬─► Phase 3
                                       └─► Phase 2b → Phase 3
```

## Usage

```bash
# Standard debate
/debate "Should we migrate to microservices?"

# Deep mode with convergence feedback
/debate "React vs Vue for new project" --deep
```

## License

MIT
