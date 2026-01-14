# Basic Workflow

Comprehensive development workflow with agents, commands, and skills for software engineering tasks. This plugin provides a complete toolkit for planning, development, testing, debugging, code review, and documentation.

## Installation

```bash
/plugin install synthetic-claude@basic-workflow
```

## Components

### Agents (11)

Specialized subagents for delegating complex tasks:

| Agent | Description |
|-------|-------------|
| **planner** | Research and create implementation plans |
| **brainstormer** | Evaluate architectural approaches and technical decisions |
| **code-reviewer** | Comprehensive code quality assessment |
| **tester** | Run tests and validate implementations |
| **debugger** | Investigate issues and diagnose problems |
| **researcher** | Comprehensive technical research and documentation |
| **docs-manager** | Manage technical documentation and standards |
| **git-manager** | Stage, commit, and push with conventional commits |
| **project-manager** | Track progress and coordinate multiple tasks |
| **scout** | Locate relevant files across codebase |
| **scout-external** | File search using external agentic tools |

### Commands (64)

#### Planning & Strategy
- `/plan` - Create implementation plans
- `/plan:fast`, `/plan:hard`, `/plan:parallel`, `/plan:two` - Plan variants
- `/plan:ci`, `/plan:cro`, `/plan:archive`, `/plan:validate` - Specialized planning
- `/brainstorm` - Explore architectural approaches

#### Development
- `/code` - Implement features with testing
- `/code:auto`, `/code:no-test`, `/code:parallel` - Development variants
- `/cook` - Bootstrap and implement features
- `/cook:auto`, `/cook:auto:fast`, `/cook:auto:parallel` - Cook variants
- `/bootstrap` - Initialize project structure
- `/bootstrap:auto`, `/bootstrap:auto:fast`, `/bootstrap:auto:parallel` - Bootstrap variants

#### Testing & Debugging
- `/test` - Run test suite
- `/test:ui` - Test UI components
- `/debug` - Investigate and diagnose issues
- `/fix` - Fix bugs and issues
- `/fix:test`, `/fix:types`, `/fix:ui`, `/fix:ci` - Targeted fixes
- `/fix:fast`, `/fix:hard`, `/fix:parallel`, `/fix:logs` - Fix variants

#### Code Review
- `/review:codebase` - Comprehensive codebase review
- `/review:codebase:parallel` - Parallel codebase review

#### Git Operations
- `/git:cm` - Create git commit
- `/git:cp` - Commit and push
- `/git:pr` - Create pull request
- `/git:merge` - Merge branches

#### Documentation
- `/docs:init` - Initialize documentation
- `/docs:update` - Update documentation
- `/docs:summarize` - Generate documentation summary

#### Skills Management
- `/skill:create` - Create new skill
- `/skill:add` - Add skill reference
- `/skill:update` - Update existing skill
- `/skill:optimize` - Optimize skill
- `/skill:optimize:auto` - Auto-optimize skill
- `/skill:plan` - Plan skill creation
- `/skill:fix-logs` - Fix skill logs

#### Utility
- `/scout` - Find relevant files
- `/scout:ext` - External file search
- `/ask` - Ask questions to gather requirements
- `/watzup` - Check project status

### Skills (16)

Domain-specific expertise for specialized tasks:

| Skill | Description |
|-------|-------------|
| **backend-development** | Node.js, APIs, databases, authentication, testing, security |
| **planning** | Implementation planning and architecture design |
| **debugging** | Systematic debugging with root cause tracing |
| **code-review** | Code quality assessment and best practices |
| **research** | Technical research and documentation gathering |
| **brainstorming** | Solution evaluation and architectural decisions |
| **databases** | MongoDB, PostgreSQL, queries, performance, administration |
| **devops** | Cloudflare, Docker, GCP deployment and infrastructure |
| **web-frameworks** | Next.js, Turborepo, RemixIcon integration |
| **chrome-devtools** | Browser automation with Puppeteer |
| **ui-ux-pro-max** | Frontend design with 50 styles, 21 palettes, 8 stacks |
| **problem-solving** | Systematic problem-solving techniques |
| **sequential-thinking** | Advanced reasoning patterns |
| **docs-seeker** | Search technical documentation via llms.txt |
| **repomix** | Package codebases for AI analysis |
| **document-skills** | DOCX, PDF, PPTX, XLSX manipulation |

## Key Features

### Complete Development Lifecycle
- **Planning**: Research-driven implementation plans with architectural analysis
- **Development**: Feature implementation with built-in testing
- **Testing**: Automated test execution and validation
- **Debugging**: Systematic issue investigation and root cause analysis
- **Review**: Comprehensive code quality assessment
- **Documentation**: Automated documentation management

### Parallel Execution
Many commands support parallel execution for faster results:
- `/plan:parallel` - Run multiple planning agents
- `/code:parallel` - Parallel implementation
- `/fix:parallel` - Parallel bug fixes
- `/review:codebase:parallel` - Parallel code review

### Specialized Workflows
- **Bootstrap**: Quick project initialization with `/bootstrap:auto:fast`
- **CI Fixes**: Targeted CI/CD issue resolution with `/fix:ci`
- **Type Safety**: TypeScript error fixes with `/fix:types`
- **UI Debugging**: Frontend-specific debugging with `/fix:ui`

### Agent Delegation
Automatically delegate tasks to specialized agents:
- Complex planning → planner agent
- Bug investigation → debugger agent
- Code quality → code-reviewer agent
- Documentation → docs-manager agent

## Usage Examples

### Plan and Implement Feature
```bash
/plan Add user authentication
# Review plan, then:
/code Implement authentication plan
```

### Fix Test Failures
```bash
/fix:test
# Debugger agent investigates and fixes failing tests
```

### Create Pull Request
```bash
/git:cm "Add authentication feature"
/git:pr
```

### Comprehensive Code Review
```bash
/review:codebase:parallel
# Multiple agents review different aspects in parallel
```

### Bootstrap New Project
```bash
/bootstrap:auto:fast Initialize Next.js app with auth
```

## Philosophy

Built on the holy trinity of software engineering:
- **YAGNI** (You Aren't Gonna Need It)
- **KISS** (Keep It Simple, Stupid)
- **DRY** (Don't Repeat Yourself)

All agents and commands follow these principles to deliver focused, maintainable solutions.

## License

MIT
