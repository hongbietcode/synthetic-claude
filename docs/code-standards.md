# Code Standards & Implementation Guide

## File Format Standards

### Agent Files (`plugins/{plugin-name}/agents/*.md`)

**Structure:** YAML frontmatter + markdown content

```yaml
---
name: {agent-id}
description: >-
  One-line description.
  <example>
    Context: {scenario}
    user: "{example input}"
    assistant: "{example output}"
    <commentary>
    {explanation}
    </commentary>
  </example>
model: haiku
---

# Agent Content

Main instructions and behavioral standards.
```

**Naming conventions:**
- File: `{kebab-case}.md`
- Name field: `{agent-id}` (kebab-case, used in references)
- Model: Always `haiku` for cost efficiency
- Description: Include `<example>` with input/output/commentary

**Required sections:**
1. **Role** - Primary responsibility (1-2 sentences)
2. **Behavioral Standards** - 3-4 bullet points of desired behavior
3. **Behavioral Contract (MUST NOT)** - Anti-patterns to avoid
4. **Output format** - Exact markdown structure expected from this agent

### Command Files (`plugins/{plugin-name}/commands/*.md`)

**Structure:** YAML frontmatter + markdown content

```yaml
---
description: What user gets when invoking /command
argument-hint: [param1] [param2] [--flag]
allowed-tools: [Tool1, Tool2]  # Optional
---

Command implementation and usage instructions.
```

**Naming conventions:**
- File: `{kebab-case}.md`
- Description: One-line user-facing description
- Argument-hint: Shows expected parameters (use `$ARGUMENTS` for access)
- Allowed-tools: Restrict tools if security-sensitive (optional)

**Variable substitution:**
- `$ARGUMENTS` - Raw user input after command name
- `$FILES` - File arguments specifically
- `$CONCERNS` - Concern/feedback arguments

**Required sections:**
1. **Process** - Step-by-step execution flow
2. **Output** - Expected format/structure
3. **Examples** - At least 1 concrete example

### Skill Files (`plugins/{plugin-name}/skills/{skill-name}/SKILL.md`)

**Structure:** YAML frontmatter + markdown content

```yaml
---
name: {skill-name}
description: One-line description
license: MIT
---

# {Skill Name}

Full skill documentation including concepts and usage patterns.
```

**Skill directory layout:**
```
skills/{skill-name}/
├── SKILL.md              # Main documentation
├── scripts/
│   ├── {script1}.js      # Implementation scripts
│   ├── {script2}.py      # Python when needed
│   └── references/       # External tools/schemas
└── references/           # Documentation references
```

**Naming conventions:**
- Directory: `{kebab-case}`
- Name field: Same as directory (kebab-case)
- License: Always `MIT` (inherited from plugin)
- Description: Clear, concise one-liner

**Required sections:**
1. **When to Use** - Scenarios where this skill applies
2. **Core Concepts** - Key ideas and terminology
3. **Usage** - How to invoke/use (with examples)
4. **Implementation** - Technical details
5. **References** - Links to external documentation

## Naming Conventions

### Identifiers

| Type | Format | Example |
|------|--------|---------|
| Agent name | `kebab-case` | `debate-orchestrator` |
| Command name | `kebab-case` | `quick-brainstorm` |
| Skill name | `kebab-case` | `debate-workflow` |
| File name | `kebab-case.md` | `critical-code-reviewer.md` |
| Directory | `kebab-case/` | `skills/pdf/` |
| Variables | `$UPPER_CASE` | `$ARGUMENTS`, `$FILES` |

### Markdown Headers

- H1 (#) - Page title only (once per file)
- H2 (##) - Major sections
- H3 (###) - Subsections
- H4 (####) - Detail sections
- Avoid H5+ (too granular)

### Code Style

**Markdown emphasis:**
- **Bold** for UI elements, file names, concept names
- *Italic* for emphasis, alternative terms
- `Code` for variables, commands, file paths
- ```lang``` for code blocks with language hint

**Lists:**
- Bullet lists for unordered items
- Numbered lists for sequences
- Use 2-space indentation
- Max 3 nesting levels

## Configuration Schema

### Marketplace.json Structure

**Root Aggregator** (`.claude-plugin/marketplace.json`):
```json
{
  "name": "synthetic-claude",
  "owner": { "name": "hongbietcode" },
  "plugins": [
    {
      "name": "plugin-name",
      "source": "./plugins/plugin-name",
      "description": "Clear description",
      "version": "1.0.0",
      "license": "MIT",
      "keywords": ["keyword1", "keyword2"],
      "category": "workflows|documents|development|design|productivity|content"
    }
  ]
}
```

**Plugin Marketplace** (`plugins/{plugin-name}/.claude-plugin/marketplace.json`):
```json
{
  "name": "plugin-name",
  "owner": { "name": "hongbietcode" },
  "plugins": [
    {
      "name": "plugin-name",
      "source": "./",
      "description": "Clear description",
      "version": "1.0.0",
      "license": "MIT",
      "keywords": ["keyword1", "keyword2"],
      "category": "workflows|documents|development|design|productivity|content",
      "commands": ["./commands/cmd1.md"],
      "agents": ["./agents/agent1.md"],
      "skills": ["./skills/skill1"],
      "strict": false
    }
  ]
}
```

**Guidelines:**
- Root aggregator: References plugin directories via source paths
- Plugin marketplace: Contains local agents, commands, skills with `./` paths
- Version: Each plugin is 1.0.0; aggregator is also 1.0.0
- License: Always `MIT`
- Strict: `false` to allow missing plugin.json in skills
- Categories: workflows, documents, development, design, productivity, content
- Keywords: 5-10 descriptive terms

## Documentation Standards

### Agent Documentation

**Individual phase output format:**
```markdown
## {Phase Title}: {Topic}

### Section 1
- Bullet point
- With details

### Section 2
Key findings or recommendations.
```

**Discussion phase output format:**
```markdown
## Response to Other Perspectives

### Agreements
- What aligns with previous agents

### Additional Evidence
- New information or counterpoints

### Refined Position
Updated perspective based on discussion
```

### Command Documentation

**Execution format:**
```markdown
# {Command Name}

{Description}

## Process
1. {Step 1}
2. {Step 2}
3. {Step 3}

## Output
{Expected format}

## Examples
```bash
/command "example input"
```
```

## Behavioral Standards

### For All Agents

1. **Isolation** - Include `CONTEXT ISOLATION` preamble in Task prompts
2. **Honesty** - Acknowledge uncertainty and limitations
3. **Brevity** - Concise responses avoiding unnecessary verbosity
4. **Structure** - Follow prescribed output formats exactly
5. **Respect** - No assumptions about user knowledge

### For Debate Agents Specifically

1. **Independence** - Make arguments without knowing other agents' positions
2. **Synthesis** - Reference and build on other perspectives in discussion
3. **Convergence** - Update KEY RECOMMENDATION based on discussion
4. **Practicality** - Ground recommendations in real constraints
5. **Actionability** - Provide next steps, not just analysis

### For Productivity Commands

1. **Clarity** - Explain what you're doing and why
2. **Safety** - Never execute destructive commands without confirmation
3. **Guidance** - Show alternatives and trade-offs
4. **Respect user autonomy** - Suggest, don't decide
5. **Version awareness** - Handle missing/different file versions

## Quality Checklist

Before committing new agents, commands, or skills:

- [ ] YAML frontmatter is valid and complete
- [ ] Description field is one-line, clear, user-facing
- [ ] All required sections present in markdown
- [ ] Code examples are tested and accurate
- [ ] Links are relative and file paths verified
- [ ] Markdown formatting is clean (no orphaned blank lines)
- [ ] Naming follows kebab-case convention
- [ ] Output format examples are exact markdown
- [ ] No hardcoded paths or assumptions about file structure
- [ ] Agent prompts include CONTEXT ISOLATION preamble
- [ ] Tested in both standard and edge case scenarios

## Anti-Patterns to Avoid

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Hardcoded paths | Breaks in different environments | Use relative paths, variables |
| Context bleed between agents | Agents influence each other | Add CONTEXT ISOLATION preamble |
| Vague output specs | Inconsistent formatting | Show exact markdown structure |
| Missing examples | Unclear how to use | Include at least 1 complete example |
| Verbose explanations | Slow response times | Be concise, link to docs for detail |
| Unvalidated assumptions | Crashes on edge cases | Handle missing files, null values |
| Mixing concerns | Hard to reuse and test | Keep agents focused on single role |

## Version Management

### Semantic Versioning

- **MAJOR** - Breaking changes to API, output format, or agent behavior
- **MINOR** - New features, agents, commands (backward compatible)
- **PATCH** - Bug fixes, documentation updates, minor improvements

### Version Sync

- Update marketplace.json version for any release
- Document breaking changes in commit messages
- Announce major version changes in README

## Testing Standards

### Agent Testing

1. **Solo phase** - Agent produces independent output matching format spec
2. **Discussion phase** - Agent references other positions, updates KEY RECOMMENDATION
3. **Edge cases** - Handles ambiguous, incomplete, or controversial topics

### Command Testing

1. **Valid input** - Executes successfully with expected output
2. **Missing arguments** - Shows helpful error or uses defaults
3. **Invalid input** - Handles gracefully without crashing
4. **File operations** - Respects file permissions and paths

### Skill Testing

1. **Initialization** - Loads correctly when invoked
2. **Output format** - Returns data in documented schema
3. **Error handling** - Catches and reports errors clearly
4. **Integration** - Works correctly when called from agents/commands

## Documentation Audit

Regular review checklist:

- [ ] All agents/commands documented in codebase-summary.md
- [ ] All referenced files exist and are accessible
- [ ] Version numbers consistent (marketplace.json vs actual)
- [ ] Links are current and working
- [ ] Examples are tested and accurate
- [ ] Terminology consistent throughout
- [ ] No orphaned or deprecated agents/commands
