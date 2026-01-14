# Basic Workflow

Comprehensive development workflow with 11 agents, 54 commands, and 16 skills for complete software engineering lifecycle.

## Installation

```bash
/plugin install synthetic-claude@basic-workflow
```

## Components

### Agents (11)

Specialized subagents for complex task delegation:

| Agent | Purpose |
|-------|---------|
| **planner** | Research and create implementation plans |
| **brainstormer** | Evaluate architectural approaches |
| **code-reviewer** | Comprehensive code quality assessment |
| **tester** | Run tests and validate implementations |
| **debugger** | Investigate issues and diagnose problems |
| **researcher** | Technical research and documentation |
| **docs-manager** | Manage technical documentation |
| **git-manager** | Stage, commit, push with conventional commits |
| **project-manager** | Track progress and coordinate tasks |
| **scout** | Locate files across codebase |
| **scout-external** | File search with external tools |

### Commands (54)

#### Planning & Strategy (10)
- `/plan` - Create implementation plans
- `/plan:fast`, `/plan:hard`, `/plan:parallel`, `/plan:two` - Plan variants
- `/plan:ci`, `/plan:cro`, `/plan:archive`, `/plan:validate` - Specialized planning
- `/brainstorm` - Explore architectural approaches

#### Development (14)
- `/code` - Implement with testing
- `/code:auto`, `/code:no-test`, `/code:parallel` - Development variants
- `/cook` - Bootstrap and implement
- `/cook:auto`, `/cook:auto:fast`, `/cook:auto:parallel` - Cook variants
- `/bootstrap` - Initialize project
- `/bootstrap:auto`, `/bootstrap:auto:fast`, `/bootstrap:auto:parallel` - Bootstrap variants

#### Testing & Debugging (11)
- `/test`, `/test:ui` - Run tests
- `/debug` - Investigate issues
- `/fix` - Fix bugs
- `/fix:test`, `/fix:types`, `/fix:ui`, `/fix:ci` - Targeted fixes
- `/fix:fast`, `/fix:hard`, `/fix:parallel`, `/fix:logs` - Fix variants

#### Code Review (2)
- `/review:codebase` - Comprehensive review
- `/review:codebase:parallel` - Parallel review

#### Git Operations (4)
- `/git:cm` - Create commit
- `/git:cp` - Commit and push
- `/git:pr` - Create pull request
- `/git:merge` - Merge branches

#### Documentation (3)
- `/docs:init` - Initialize docs
- `/docs:update` - Update docs
- `/docs:summarize` - Generate summary

#### Skills Management (7)
- `/skill:create`, `/skill:add`, `/skill:update` - Skill CRUD
- `/skill:optimize`, `/skill:optimize:auto` - Optimize skills
- `/skill:plan`, `/skill:fix-logs` - Plan and fix

#### Utility (3)
- `/scout`, `/scout:ext` - Find files
- `/ask` - Gather requirements
- `/watzup` - Check status

### Skills (16)

Domain-specific expertise:

| Skill | Description |
|-------|-------------|
| **backend-development** | Node.js, APIs, databases, auth, security, testing |
| **planning** | Implementation planning and architecture design |
| **debugging** | Systematic debugging with root cause tracing |
| **code-review** | Code quality and best practices |
| **research** | Technical research and documentation |
| **brainstorming** | Solution evaluation and decisions |
| **databases** | MongoDB, PostgreSQL, queries, performance |
| **devops** | Cloudflare, Docker, GCP deployment |
| **web-frameworks** | Next.js, Turborepo, RemixIcon |
| **chrome-devtools** | Browser automation with Puppeteer |
| **ui-ux-pro-max** | 50 styles, 21 palettes, 8 stacks |
| **problem-solving** | Systematic problem-solving techniques |
| **sequential-thinking** | Advanced reasoning patterns |
| **docs-seeker** | Search docs via llms.txt |
| **repomix** | Package codebases for AI |
| **document-skills** | DOCX, PDF, PPTX, XLSX manipulation |

## Key Features

### Complete Development Lifecycle
Plan → Develop → Test → Debug → Review → Document with specialized agents for each phase.

### Parallel Execution
Commands support parallel execution for faster results:
- `/plan:parallel`, `/code:parallel`, `/fix:parallel`, `/review:codebase:parallel`

### Specialized Workflows
- **Fast Bootstrap**: `/bootstrap:auto:fast` for quick project init
- **CI Fixes**: `/fix:ci` for targeted CI/CD issues
- **Type Safety**: `/fix:types` for TypeScript errors
- **UI Debugging**: `/fix:ui` for frontend issues

### Auto Delegation
Tasks automatically delegated to specialized agents:
- Planning → planner agent
- Bugs → debugger agent
- Quality → code-reviewer agent
- Docs → docs-manager agent

## Usage Examples

### Plan and Implement
```bash
/plan Add user authentication
/code Implement authentication
```

### Fix Failures
```bash
/fix:test    # Fix test failures
/fix:types   # Fix type errors
/fix:ci      # Fix CI issues
```

### Git Workflow
```bash
/git:cm "Add auth feature"
/git:pr
```

### Quick Start
```bash
/bootstrap:auto:fast Init Next.js app
```

## Philosophy

Built on software engineering trinity:
- **YAGNI** (You Aren't Gonna Need It)
- **KISS** (Keep It Simple, Stupid)
- **DRY** (Don't Repeat Yourself)

All agents follow these principles for focused, maintainable solutions.

## License

MIT
