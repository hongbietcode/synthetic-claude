# Agent Memory System Architecture

## Executable Skills vs Passive Memory for Agent Self-Improvement

**Title:** Executable Skills vs Passive Memory for Agent Self-Improvement
**Description:** Memory systems should store callable code patterns with usage tracking, not just text descriptions.

**Content:** Insight from SAGE (Skill Augmented GRPO for self-Evolution) paper: Traditional memory stores text descriptions retrieved by semantic similarity. Better approach: store executable code patterns (functions with signatures, docstrings, example usage) and track reuse metrics (times_retrieved, times_used, success_rate). Quality validated through actual successful reuse, not similarity scores. Promote high-success patterns, demote low-success ones. This shifts memory from "reference material" to "executable capability" - key for agent self-improvement.

**Tags:** #ai #agent #memory-system #semantic #architecture

---

### Key Design Elements

1. **Store functions not just descriptions** - Executable code patterns with signatures, docstrings, and example usage
2. **Track usage metrics** - times_retrieved, times_used, success_rate
3. **Validate quality through actual reuse** - Not just semantic similarity scores
4. **Promote/demote based on successful transfer** - High-success patterns promoted, low-success demoted

### Design Shift

| Passive Memory | Executable Capability |
|----------------|----------------------|
| Text descriptions | Callable code patterns |
| Semantic similarity retrieval | Usage success tracking |
| Reference material | Executable capability |
| Static storage | Dynamic promotion/demotion |

---

*Stored: 2025-12-27*
*Source: SAGE (Skill Augmented GRPO for self-Evolution) paper analysis*
*Confidence: high*
