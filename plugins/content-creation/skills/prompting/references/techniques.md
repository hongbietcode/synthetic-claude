# Advanced Prompting Techniques (Late 2025)

## Quick Selection

| Technique | Best For | Avoid When | Cost |
|-----------|----------|------------|------|
| **Atom of Thoughts** | Parallelizable problems, math proofs | Creative writing | 1x |
| **Tree of Thoughts** | Multiple valid paths, exploration | Simple queries | 2-3x |
| **ReAct** | Tool use, external data | Pure reasoning | 1-2x |
| **Self-Consistency** | High-stakes, verification needed | Speed-critical | 3-5x |
| **Role Reversal** | Need +40% accuracy | Quick drafts | 2x |
| **Extended Thinking** | Complex planning, math | Pattern recognition (hurts -36%) | 2-5x |
| **OPRO** | Prompt optimization at scale | One-off prompts | High |
| **GEPA** | Cost optimization, compression | Quality-critical | Low (90x cheaper) |
| **Interleaved Thinking** | Tool use + reasoning (Claude) | Non-tool tasks | 1-2x |

## Techniques Detail

### 1. Atom of Thoughts (AoT)

Break problems into atomic, independent steps using DAG.

```xml
<problem>[Full statement]</problem>
<decomposition>
  - Atom 1: [Independent subproblem]
  - Atom 2: [Independent subproblem]  
  - Atom 3: [Depends on Atom 1]
</decomposition>
<solve_atoms>Solve each independently, then combine.</solve_atoms>
```

**Benefits**: Parallel processing, clear dependencies, self-contained atoms.

---

### 2. Tree of Thoughts (ToT)

Explore multiple reasoning paths, backtrack when needed.

```xml
<problem>[Statement]</problem>
<thought_tree>
  Branch A: [Approach 1] → Evaluate: [Pros/cons]
  Branch B: [Approach 2] → Evaluate: [Pros/cons]
  Branch C: [Approach 3] → Evaluate: [Pros/cons]
</thought_tree>
<best_path>Select highest score branch.</best_path>
```

---

### 3. ReAct (Reasoning + Acting)

Interleave reasoning with tool actions.

```
Thought: [What I need to figure out]
Action: [Tool to use]
Observation: [Result from tool]
Thought: [What this tells me]
... repeat ...
Final Answer: [Conclusion]
```

**Limitations**: Can loop, limited global planning. Enhanced by **PRAct** (planning + ReAct) and **ToolOrchestra** (multi-tool coordination).

---

### 4. Self-Consistency

Generate multiple solutions, take majority vote.

```
Generate 3-5 independent solutions for: [Problem]
Compare results, select most consistent answer.
```

**Trade-off**: 3-5x tokens for significantly higher accuracy.

---

### 5. Role Reversal (DeepMind 2025)

Model critiques and improves its own output.

```
Step 1: [Generate initial response]
Step 2: "Act as critical reviewer. Find flaws above."
Step 3: "Based on critique, provide improved response."
```

**Result**: +40% accuracy boost.

---

### 6. Extended Thinking (Claude)

| Use When | Avoid When (hurts -36%) |
|----------|------------------------|
| Complex multi-step planning | Pattern recognition |
| Mathematical reasoning | Visual classification |
| Code architecture | Simple queries |

**Rule**: If human would do worse by overthinking → extended thinking also hurts.

---

### 7. OPRO (Optimization by PROmpting)

LLM iteratively optimizes prompts. Results: +8% GSM8K, +50% Big-Bench Hard.

```
1. Start with baseline prompt
2. LLM suggests variations
3. Evaluate on test set
4. Select best, repeat
```

---

### 8. Stanford 8-Word Phenomenon

Simple prompts often outperform complex ones on modern models.

| Complex | Simple (equally effective) |
|---------|---------------------------|
| "You are an expert software engineer. Please carefully analyze..." | "Review this code for bugs." |

**Rule**: Start simple, add complexity only if needed.

---

### 9. GEPA (Databricks)

Prompt compression for cost optimization. Up to 90x cheaper operation.

```
1. Finalize working prompt
2. Apply GEPA compression
3. Verify quality maintained
4. Deploy compressed version
```

**Use after**: Prompt is stable and tested. Not for development phase.

---

### 10. Interleaved Thinking (Claude)

Thinking during tool use, not just before.

```
Tool call → Think about result → Next tool call → Think → ...
```

**Benefits**: Better tool coordination, adapts based on intermediate results.

**Enable**: Via API parameter, not prompt text.
