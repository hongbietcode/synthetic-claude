# Productivity Kit

Productivity tools for project management, refactoring, and research.

## Installation

```bash
/plugin install synthetic-claude@productivity-kit
```

## Components

### Agents (1)

| Agent | Purpose |
|-------|---------|
| research-assistant | WebSearch/WebFetch agent for fact gathering |

### Commands (7)

| Command | Description |
|---------|-------------|
| `/parallel-work` | Setup Git worktrees for feature development |
| `/integrate-parallel-work` | Merge parallel features back |
| `/refactor-interactive` | Guided refactoring with step explanations |
| `/tidy-up` | Cleanup project structure |
| `/tidy-docs` | Reorganize documentation |
| `/git-configure` | Configure Git user (personal/work) |
| `/tmux-team-restart` | Restart tmux with state preservation |

### Skills (4)

| Skill | Description |
|-------|-------------|
| **quick-research** | Multi-agent research orchestration |
| **tmux-team-creator** | Multi-agent team templates (Scrum, McKinsey, etc.) |
| **coder-memory-store** | Store code patterns for recall |
| **coder-memory-recall** | Retrieve stored code patterns |

## Team Templates

From tmux-team-creator:
- **Scrum Team**: PO, SM, TL, BE, FE, QA roles
- **Game Dev Team**: SM, AR, DS, DV, QA roles
- **McKinsey Research**: EM, PR, SR, QR, RL, DA roles
- **P&G Insights**: IM, MR, SL, IA, QR roles

## Memory System

Three memory types:
- **Episodic**: User interaction patterns
- **Semantic**: Domain knowledge and concepts
- **Procedural**: Step-by-step processes

## License

MIT
