# Dev Tools

Development tools for API implementation, testing, and code review.

## Installation

```bash
/plugin install synthetic-claude@dev-tools
```

## Components

### Agents (1)

| Agent | Purpose |
|-------|---------|
| critical-code-reviewer | Reviews code for top 3 critical issues only |

### Commands (6)

| Command | Description |
|---------|-------------|
| `/px-backend-api` | Implement backend APIs from specifications |
| `/px-frontend-api` | Frontend integration with backend APIs |
| `/fastapi-test` | Create comprehensive API tests |
| `/explore-external-APIs` | Test and document external APIs |
| `/gen-feature-docs` | Generate developer and user docs |
| `/generate-db-docs` | Create database documentation |

### Skills (4)

| Skill | Description |
|-------|-------------|
| **webapp-testing** | Playwright-based testing with reconnaissance pattern |
| **mcp-builder** | 4-phase guide for MCP server creation (TS/Python) |
| **skill-creator** | Process for building effective Claude Code skills |
| **cc-hooks-creator** | Claude Code lifecycle hooks (PreToolUse, PostToolUse) |

## Code Review Philosophy

The critical-code-reviewer agent focuses only on:
1. Security vulnerabilities
2. Data integrity issues
3. Production-breaking bugs

Minor style issues are intentionally ignored.

## License

MIT
