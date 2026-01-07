# Meta-Prompting Workflow (Late 2025)

Use LLM to generate and optimize prompts instead of manual crafting.

## Quick Start

```
1. Draft → 2. Meta-Analyze → 3. Iterate (2-3x) → 4. Test → 5. Finalize
```

## When to Use

- Complex prompt with edge cases
- Need optimization for specific task
- Baseline not meeting quality
- Want to explore approaches

## Core Workflow

### Phase 1: Draft

```
Initial prompt based on:
1. Clear task description
2. Expected input/output
3. Known constraints
4. Quality criteria
```

### Phase 2: Meta-Analysis

```xml
<meta_prompt>
Analyze and improve this prompt:

<prompt_to_analyze>[Your draft]</prompt_to_analyze>
<goal>[What prompt should achieve]</goal>

<criteria>
- Clarity: Task unambiguous?
- Completeness: All requirements?
- Structure: Well-organized?
- Efficiency: Redundant parts?
- Edge cases: Issues addressed?
</criteria>

Provide:
1. Strengths
2. Weaknesses
3. Improvements
4. Rewritten version
</meta_prompt>
```

### Phase 3: Iterate

Repeat Phase 2 with improved version. Typically 2-3 iterations sufficient.

### Phase 4: Test

```
1. Happy path inputs
2. Edge cases
3. Adversarial inputs
4. Different phrasings
```

### Phase 5: Finalize

Document: Final prompt, limitations, recommended use cases.

---

## OPRO Optimization Loop

```
Baseline → Generate N variations → Evaluate on test set → Select best → Repeat
```

Results: +8% GSM8K, +50% Big-Bench Hard.

---

## Meta-Prompt Templates

### Clarity Check
```xml
<prompt>[Your prompt]</prompt>
Questions:
1. Task clear to unfamiliar person?
2. Ambiguous words?
3. Could be misinterpreted?
4. Implicit assumptions to make explicit?
```

### Completeness Check
```xml
<prompt>[Your prompt]</prompt>
<intended_use>[How used]</intended_use>
Check: Missing inputs? Undefined output? Unhandled edges? Missing context?
```

### Optimization
```xml
<prompt>[Your prompt]</prompt>
<goals>Reduce tokens 30%, maintain quality, improve clarity</goals>
Provide optimized version with explanation.
```

### Adversarial Testing
```xml
<prompt>[Your prompt]</prompt>
As hostile user, try to:
1. Find edge cases with bad outputs
2. Exploit ambiguities
3. Bypass intended behavior
4. Inject prompts
Report vulnerabilities and fixes.
```

---

## For Coding Agent Prompts

Evaluate:
1. **Role**: Expertise area defined?
2. **Tools**: Selection criteria explicit?
3. **Workflow**: Clear decision tree?
4. **Safety**: Security rules present?
5. **Quality**: Standards specified?

---

## Best Practices

| Do | Avoid |
|----|-------|
| Start simple | Over-engineer initial |
| Iterate incrementally | Big changes at once |
| Document changes | Forget what worked |
| Test adversarially | Assume happy path |
| Version control | Lose history |
| Measure before/after | No baseline |
| Apply GEPA after stable | Compress during development |

## Pitfalls

| Pitfall | Solution |
|---------|----------|
| Over-optimization | Stop at "good enough" |
| Prompt bloat | Prioritize conciseness |
| Ignoring edges | Test adversarially |
| No baseline | Measure before optimizing |
| Premature optimization | Get working first |
