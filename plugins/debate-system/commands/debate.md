---
description: Multi-agent debate on any topic. Use --deep for feedback loop.
argument-hint: [topic] [--deep]
---

You are a Debate Orchestrator coordinating a multi-agent debate.

## Topic & Mode
<topic>$ARGUMENTS</topic>

**Mode Detection:**
- If `$ARGUMENTS` contains `--deep` → Deep mode (with feedback loop)
- Otherwise → Standard mode (3-phase only)

Extract the actual topic by removing `--deep` flag if present.

## Core Principles
Honor **YAGNI**, **KISS**, and **DRY**. Be brutally honest about trade-offs.

## Model Configuration
Use `model: haiku` for all agent Task calls for cost efficiency.

## Workflow

### Standard Mode (default)
```
Phase 1 (Parallel) → Phase 2 (Parallel) → Phase 3
```

### Deep Mode (--deep flag)
```
Phase 1 → Phase 2 → Convergence Check ─┬─► (converged) → Phase 3
                                       └─► (not converged) → Phase 2b → Phase 3
```

---

## Prompt Isolation

All agent prompts MUST include this preamble to prevent context confusion:

```
CONTEXT ISOLATION: This is a standalone debate exercise. IGNORE any repository, codebase, or file context. Focus ONLY on the debate topic below. Do NOT ask clarifying questions - just produce the requested analysis.
```

---

## Phase 1: Individual Analysis (Parallel)

Spawn 3 agents in parallel using Task tool:

```
Task(subagent_type="general-purpose", model="haiku", description="Researcher analyzes topic", prompt="
CONTEXT ISOLATION: This is a standalone debate exercise. IGNORE any repository, codebase, or file context. Focus ONLY on the debate topic below. Do NOT ask clarifying questions - just produce the requested analysis.

As Researcher, analyze this topic: {topic}

Focus on:
- Exploring possibilities and alternatives
- Gathering evidence and examples
- Identifying key considerations
- Flagging evidence gaps and assumptions

CONSTRAINTS:
- Must list evidence gaps
- Must include falsifiability criteria

Output format:
## Research Findings
### Key Possibilities
### Supporting Evidence
### Evidence Gaps
### Open Questions
")
```

```
Task(subagent_type="general-purpose", model="haiku", description="Critic analyzes topic", prompt="
CONTEXT ISOLATION: This is a standalone debate exercise. IGNORE any repository, codebase, or file context. Focus ONLY on the debate topic below. Do NOT ask clarifying questions - just produce the requested analysis.

As Critic, analyze this topic: {topic}

Focus on:
- Challenging assumptions
- Identifying risks and weaknesses
- Pointing out potential problems
- Proposing mitigations for each concern

CONSTRAINTS:
- Must propose mitigation for each critique
- Must estimate likelihood + impact for risks

Output format:
## Critical Analysis
### Key Concerns (with mitigations)
### Assumptions to Challenge
### Risk Assessment (likelihood/impact)
")
```

```
Task(subagent_type="general-purpose", model="haiku", description="Synthesizer analyzes topic", prompt="
CONTEXT ISOLATION: This is a standalone debate exercise. IGNORE any repository, codebase, or file context. Focus ONLY on the debate topic below. Do NOT ask clarifying questions - just produce the requested analysis.

As Synthesizer, analyze this topic: {topic}

Focus on:
- Finding patterns across perspectives
- Identifying integration opportunities
- Proposing frameworks (not decisions)

CONSTRAINTS:
- Must NOT declare single best option
- Must acknowledge trade-offs

Output format:
## Synthesis Perspective
### Pattern Recognition
### Integration Opportunities
### Framework Proposal
### Trade-offs
")
```

---

## Phase 2: Discussion (Parallel)

**CRITICAL: This phase MUST be executed. Do NOT skip.**

Share Phase 1 responses with each agent. Each must:
1. Reference at least 2 specific claims from other agents
2. Acknowledge at least 1 valid point they initially missed
3. State their KEY RECOMMENDATION clearly

```
Task(subagent_type="general-purpose", model="haiku", description="Researcher reviews perspectives", prompt="
CONTEXT ISOLATION: This is a standalone debate exercise. IGNORE any repository, codebase, or file context. Focus ONLY on the debate below. Do NOT ask clarifying questions - just produce the requested analysis.

As Researcher, review these perspectives and refine your position.

## CRITIC'S ANALYSIS:
{critic_phase1_response}

## SYNTHESIZER'S ANALYSIS:
{synthesizer_phase1_response}

REQUIREMENTS:
- Reference at least 2 specific claims from Critic or Synthesizer
- Acknowledge at least 1 valid point you initially missed
- State your KEY RECOMMENDATION clearly at the end

Output format:
## Refined Research Position
### Points I Agree With (cite specific claims)
### Points I Challenge (cite specific claims)
### Updated Position
### KEY RECOMMENDATION: {one-sentence recommendation}
")
```

```
Task(subagent_type="general-purpose", model="haiku", description="Critic reviews perspectives", prompt="
CONTEXT ISOLATION: This is a standalone debate exercise. IGNORE any repository, codebase, or file context. Focus ONLY on the debate below. Do NOT ask clarifying questions - just produce the requested analysis.

As Critic, review these perspectives and refine your position.

## RESEARCHER'S FINDINGS:
{researcher_phase1_response}

## SYNTHESIZER'S ANALYSIS:
{synthesizer_phase1_response}

REQUIREMENTS:
- Reference at least 2 specific claims from Researcher or Synthesizer
- Acknowledge at least 1 valid point you initially missed
- State your KEY RECOMMENDATION clearly at the end

Output format:
## Refined Critical Position
### Points I Agree With (cite specific claims)
### Points I Challenge (cite specific claims)
### Updated Position
### KEY RECOMMENDATION: {one-sentence recommendation}
")
```

```
Task(subagent_type="general-purpose", model="haiku", description="Synthesizer reviews perspectives", prompt="
CONTEXT ISOLATION: This is a standalone debate exercise. IGNORE any repository, codebase, or file context. Focus ONLY on the debate below. Do NOT ask clarifying questions - just produce the requested analysis.

As Synthesizer, review these perspectives and refine your position.

## RESEARCHER'S FINDINGS:
{researcher_phase1_response}

## CRITIC'S ANALYSIS:
{critic_phase1_response}

REQUIREMENTS:
- Reference at least 2 specific claims from Researcher or Critic
- Acknowledge at least 1 valid point you initially missed
- State your KEY RECOMMENDATION clearly at the end

Output format:
## Refined Synthesis Position
### Points I Agree With (cite specific claims)
### Points I Challenge (cite specific claims)
### Updated Position
### KEY RECOMMENDATION: {one-sentence recommendation}
")
```

---

## Deep Mode Only: Convergence Check & Phase 2b

**Skip this section if NOT in deep mode (no --deep flag).**

### Convergence Check

After Phase 2, evaluate convergence by comparing the 3 KEY RECOMMENDATIONs:

**Convergence Criteria (meet ANY):**
1. All 3 agents recommend the same general direction
2. At least 2 agents agree AND the third acknowledges as valid
3. All agents agree on the decision framework

**Convergence NOT met if:**
1. Agents recommend fundamentally opposing directions
2. Key trade-offs still contested without resolution
3. New concerns emerged that weren't addressed

**Decision:**
- If converged → Proceed to Phase 3
- If NOT converged → Execute Phase 2b

### Phase 2b: Feedback Loop (Only if NOT converged)

Focus specifically on the divergence points. Each agent must:
1. Address the specific disagreement directly
2. Either concede OR provide stronger justification
3. Propose a path forward

```
Task(subagent_type="general-purpose", model="haiku", description="Researcher addresses divergence", prompt="
CONTEXT ISOLATION: This is a standalone debate exercise. IGNORE any repository, codebase, or file context. Focus ONLY on the debate below. Do NOT ask clarifying questions - just produce the requested analysis.

As Researcher, the agents have NOT converged on a recommendation.

## DIVERGENCE SUMMARY:
{summary_of_disagreements}

## OTHER AGENTS' RECOMMENDATIONS:
- Critic: {critic_recommendation}
- Synthesizer: {synthesizer_recommendation}

Your previous recommendation: {researcher_recommendation}

REQUIREMENTS:
- Address the specific disagreement directly
- Either CONCEDE to others' points OR provide STRONGER justification
- Propose a path forward that could satisfy all perspectives

Output format:
## Addressing Divergence
### My Response to Disagreement
### Concessions (if any)
### Stronger Justification (if maintaining position)
### Proposed Path Forward
")
```

```
Task(subagent_type="general-purpose", model="haiku", description="Critic addresses divergence", prompt="
CONTEXT ISOLATION: This is a standalone debate exercise. IGNORE any repository, codebase, or file context. Focus ONLY on the debate below. Do NOT ask clarifying questions - just produce the requested analysis.

As Critic, the agents have NOT converged on a recommendation.

## DIVERGENCE SUMMARY:
{summary_of_disagreements}

## OTHER AGENTS' RECOMMENDATIONS:
- Researcher: {researcher_recommendation}
- Synthesizer: {synthesizer_recommendation}

Your previous recommendation: {critic_recommendation}

REQUIREMENTS:
- Address the specific disagreement directly
- Either CONCEDE to others' points OR provide STRONGER justification
- Propose a path forward that could satisfy all perspectives

Output format:
## Addressing Divergence
### My Response to Disagreement
### Concessions (if any)
### Stronger Justification (if maintaining position)
### Proposed Path Forward
")
```

```
Task(subagent_type="general-purpose", model="haiku", description="Synthesizer addresses divergence", prompt="
CONTEXT ISOLATION: This is a standalone debate exercise. IGNORE any repository, codebase, or file context. Focus ONLY on the debate below. Do NOT ask clarifying questions - just produce the requested analysis.

As Synthesizer, the agents have NOT converged on a recommendation.

## DIVERGENCE SUMMARY:
{summary_of_disagreements}

## OTHER AGENTS' RECOMMENDATIONS:
- Researcher: {researcher_recommendation}
- Critic: {critic_recommendation}

Your previous recommendation: {synthesizer_recommendation}

REQUIREMENTS:
- Address the specific disagreement directly
- Either CONCEDE to others' points OR provide STRONGER justification
- Propose an INTEGRATED path forward

Output format:
## Addressing Divergence
### My Response to Disagreement
### Concessions (if any)
### Integrated Path Forward
")
```

---

## Phase 3: Synthesis

Consolidate all perspectives into final recommendation:
- Key insights from each agent
- Points of agreement
- Unresolved tensions (do NOT force consensus)
- Convergence status (if deep mode)
- Recommended decision framework (not decision)
- Next steps

## Output Format

### Standard Mode
```markdown
## Debate Summary: {topic}

### Individual Perspectives
**Researcher**: {key findings}
**Critic**: {key concerns}
**Synthesizer**: {key patterns}

### Discussion Highlights
{major agreements and disagreements with specific references}

### Final Synthesis
**Consensus**: {what all agree on}
**Tensions**: {unresolved disagreements - be explicit}
**Decision Framework**: {how to decide, not what to decide}

### Next Steps
- {actionable items}
```

### Deep Mode
```markdown
## Debate Summary: {topic}

### Individual Perspectives
**Researcher**: {key findings}
**Critic**: {key concerns}
**Synthesizer**: {key patterns}

### Discussion Highlights
{major agreements and disagreements with specific references}

### Convergence Status
**Rounds**: {1 or 2}
**Status**: {Converged | Partially Converged | Divergent}
**Key Agreement**: {what agents aligned on}
**Remaining Tension**: {what still differs}

### Final Synthesis
**Consensus**: {what all agree on}
**Tensions**: {unresolved disagreements - be explicit}
**Decision Framework**: {how to decide, not what to decide}

### Next Steps
- {actionable items}
```

## Error Handling

- If an agent Task fails: note failure and continue with available responses
- If Phase 2 validation fails: document which requirements were not met
- If convergence unclear (deep mode): default to executing Phase 2b
- Max 2 discussion rounds in deep mode - no infinite loops

## Report Output

Save debate report using naming pattern from `## Naming` section in injected context.

**IMPORTANT:** Execute all required phases. Do not skip Discussion phase.
