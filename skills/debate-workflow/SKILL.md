---
name: debate-workflow
description: Multi-agent debate with 3-phase workflow (Individual → Discussion → Synthesis)
license: MIT
---

# Debate Workflow

Multi-agent debate system with 3-phase workflow.

## When to Use

Activate this skill when:
- User needs multiple perspectives on a decision
- Complex tradeoffs require structured analysis
- Brainstorming needs systematic synthesis
- User invokes `/debate` command

## Core Concepts

### 3-Phase Model

```
Phase 1: Individual    → Agents work independently (parallel)
Phase 2: Discussion    → Agents critique each other
Phase 3: Synthesis     → Consolidate into final answer
```

### Agent Roles

| Agent | Focus | Personality |
|-------|-------|-------------|
| Researcher | Evidence, possibilities | Curious, thorough |
| Critic | Risks, weaknesses | Skeptical, constructive |
| Synthesizer | Patterns, integration | Balanced, practical |

## Implementation Pattern

### Phase 1: Individual (Parallel Execution)

```markdown
Using Task tool, spawn 3 agents in parallel:

1. Task: "As Researcher, analyze: {topic}"
2. Task: "As Critic, analyze: {topic}"
3. Task: "As Synthesizer, analyze: {topic}"

Collect all 3 responses.
```

### Phase 2: Discussion

```markdown
Share all Phase 1 responses with each agent:

Task: "Review these perspectives and provide critique:
- Researcher said: {response1}
- Critic said: {response2}
- Synthesizer said: {response3}

As {agent}, respond to the other perspectives."
```

### Phase 3: Synthesis

```markdown
Consolidate all inputs:

Task: "Based on this debate:
- Individual perspectives: {phase1}
- Discussion points: {phase2}

Produce final synthesis with:
1. Key insights
2. Points of agreement
3. Unresolved tensions
4. Recommended action"
```

## Best Practices

- Keep individual phase responses focused (~200 words each)
- Discussion phase should directly reference others' points
- Synthesis should acknowledge disagreements, not force consensus
- Include actionable next steps in final output

## Token Optimization

- Use Task tool for parallel execution (faster)
- Limit to 1 discussion round for most topics
- Summarize between phases if context grows large

## Output Template

```markdown
## Debate: {topic}

### Phase 1: Individual Perspectives

**Researcher**: {summary}
**Critic**: {summary}
**Synthesizer**: {summary}

### Phase 2: Discussion

{key exchanges and refinements}

### Phase 3: Final Synthesis

**Consensus**: {what all agree on}
**Tensions**: {unresolved disagreements}
**Recommendation**: {proposed action}

### Next Steps
- {action item 1}
- {action item 2}
```
