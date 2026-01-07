# Project Overview & Product Development Requirements

## Vision

Enable developers to leverage multi-agent AI systems for structured decision-making, deep analysis, and rapid productivity. Synthetic Claude provides extensible agent orchestration, powerful document processing, and specialized development tools as a marketplace plugin.

## Goals

1. **Multi-agent debate as a service** - Structured analysis via multiple AI perspectives
2. **Developer productivity** - Rapid ideation, documentation, code review, refactoring
3. **Document ecosystem** - Seamless PDF, Word, PowerPoint, Excel integration
4. **Extensibility** - Easy skill and agent creation without modifying core
5. **Marketplace distribution** - One-click installation across user/project/local scopes

## Project Scope

### In Scope

| Component | Status | Version |
|-----------|--------|---------|
| Multi-agent debate system | Complete | 2.0.0 |
| 3-phase + deep mode workflow | Complete | 2.0.0 |
| 7 specialized agents | Complete | 2.0.0 |
| 23 productivity commands | Complete | 2.0.0 |
| 26 skills (document processing, design, research) | Complete | 2.0.0 |
| YAML-based configuration | Complete | 2.0.0 |
| Marketplace integration | Complete | 2.0.0 |
| Three installation scopes (user/project/local) | Complete | 2.0.0 |

### Out of Scope

- Real-time collaboration features
- Persistent debate history/database
- Custom LLM model fine-tuning
- IDE integrations beyond Claude Code
- Advanced analytics dashboards

## Target Users

1. **Engineering Teams** - Decision-making via structured debate
2. **Technical Architects** - Trade-off analysis and design verification
3. **Product Managers** - Feature documentation and roadmap planning
4. **Solo Developers** - Rapid productivity with AI assistance
5. **Documentation Teams** - Automated docs generation from specifications

## Use Cases

### Primary Use Cases

1. **Technical Decisions** - Evaluate architectural approaches (monolith vs microservices, SQL vs NoSQL, framework selection)
2. **Code Review** - Get multiple perspectives on implementation quality and alternatives
3. **Feature Planning** - Brainstorm, counter-argue, and synthesize feature requirements
4. **Documentation** - Generate API, database, and user documentation from specifications
5. **Design Analysis** - Discuss and improve UX/UI without modifying files

### Secondary Use Cases

- Project memory and recall systems
- Database documentation automation
- FastAPI/backend testing frameworks
- Git workflow configuration
- Interactive refactoring with explanations
- Team tmux environment management

## Product Requirements

### Functional Requirements

| Req ID | Feature | Success Criteria |
|--------|---------|------------------|
| FR-001 | Multi-agent debate | 3 agents complete independent analysis without interference |
| FR-002 | Discussion phase | Agents reference previous responses and update positions |
| FR-003 | Synthesis phase | Consolidated recommendation with action items |
| FR-004 | Deep mode | Convergence detection triggers second discussion or synthesis |
| FR-005 | Document processing | PDF, DOCX, PPTX, XLSX full read/write capability |
| FR-006 | Skill system | New skills usable via /skill-creator without core modification |
| FR-007 | Marketplace | One-click install, enable/disable, uninstall operations |
| FR-008 | Installation scopes | User/project/local scope configuration respected |

### Non-Functional Requirements

| Req ID | Requirement | Target |
|--------|-------------|--------|
| NFR-001 | Performance | Debate completion < 60 seconds per phase |
| NFR-002 | Extensibility | New agents/commands addable without core changes |
| NFR-003 | Documentation | All agents/commands have YAML+markdown structure |
| NFR-004 | Reliability | Handle malformed input without crashes |
| NFR-005 | Maintainability | Clear YAML schema, documented patterns |
| NFR-006 | Distribution | <100MB total size, <5MB core plugin |

### Acceptance Criteria

- All 23 commands execute without errors
- Debate produces 3 independent analyses + discussion + synthesis
- Deep mode correctly detects convergence
- All 26 skills install and function
- Marketplace add/install/uninstall succeeds across scopes
- Documentation covers 100% of agents, commands, and skills
- Code standards applied consistently throughout codebase

## Current State (v2.0.0)

**Agents (7):**
- debate-orchestrator, researcher, critic, synthesizer
- critical-code-reviewer, research-assistant, ui-ux-designer

**Commands (23):**
- debate, quick-brainstorm, discuss, think-hard
- parallel-work, px-backend-api, px-frontend-api, design-guide
- gen-feature-docs, generate-db-docs, tidy-docs, tidy-up
- [13 more productivity commands]

**Skills (26):**
- debate-workflow, pdf, docx, pptx, xlsx
- skill-creator, mcp-builder, frontend-design
- [19 more specialized skills]

**Metrics:**
- Total commands: 23
- Total agents: 7
- Total skills: 26
- Code size: ~1M tokens (1.04M per repomix)
- Marketplace status: Published

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Installation success rate | 99%+ | Marketplace analytics |
| Time to first debate | <5 minutes | User onboarding |
| Command execution success | 100% | Internal testing |
| Documentation coverage | 100% | Automated audit |
| Skill extensibility | >5 new skills/quarter | Community tracking |
| User satisfaction | 4.5+/5.0 | Reviews |

## Dependencies

- Claude Code marketplace infrastructure
- Claude API (Haiku for cost efficiency)
- Markdown + YAML specification support
- Task-based agent orchestration

## Constraints

- Model usage limited to Haiku for cost efficiency
- YAML frontmatter format required for agents/commands
- No persistent state between sessions (stateless)
- Single-topic debate scope (not multi-topic debates)
- No real-time collaboration or live updates

## Technical Approach

1. **Agent separation** - Each agent runs as independent Task, preventing context bleeding
2. **Declarative configuration** - YAML frontmatter defines behavior, markdown explains implementation
3. **Skill composition** - Agents/commands composed from reusable, documented skills
4. **Convergence feedback** - Deep mode compares KEY RECOMMENDATIONs to detect consensus
5. **Documentation-first** - All components self-documenting via structured markdown

## Risk Mitigation

| Risk | Impact | Mitigation |
|------|--------|-----------|
| Agent context interference | High | CONTEXT ISOLATION preamble in prompts |
| Debate convergence false positives | Medium | Strict comparison of KEY RECOMMENDATIONs |
| Skill incompleteness | Medium | skill-creator scaffolding + templates |
| Marketplace reliability | High | Fallback to local installation |
| Documentation staleness | Medium | Automated audit & version sync |
