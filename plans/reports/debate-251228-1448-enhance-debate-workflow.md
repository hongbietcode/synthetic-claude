# Debate Summary: Enhance Debate Workflow

**Date**: 2025-12-28
**Topic**: How to enhance the multi-agent debate workflow system
**Participants**: Researcher, Critic, Synthesizer

---

## Individual Perspectives

### Researcher: Key Findings

**Possibilities Explored:**
1. **Dynamic Agent Pool** - Topic-specific agents (SecurityExpert, PerformanceEngineer) configurable per debate
2. **Iterative Discussion Rounds** - Continue until convergence threshold or max iterations
3. **Voting/Confidence Mechanism** - Weight higher-confidence positions in synthesis
4. **Domain-Specific Profiles** - Predefined configs (security-focus, cost-focus, scalability-focus)
5. **Structured Argumentation** - Claim-Evidence-Warrant-Rebuttal format
6. **Debate Memory/History** - Store and reference past debates
7. **Asynchronous Mode** - Checkpoint and resume capability
8. **Meta-Critic Agent** - Fourth agent evaluating debate quality

**Evidence**: Task tool supports parallel spawning; modular agent files enable easy extension; multi-agent research shows debate improves LLM reasoning.

**Open Questions**: Token budget vs depth trade-off; convergence detection methods; enforcing genuine perspective diversity with same model.

---

### Critic: Key Concerns

**Structural Risks Identified:**
1. **Structural Homogeneity** - Same model + different prompts = synthetic diversity, not genuine cognitive diversity
2. **Phase 2 Implementation Gap** - No concrete Task call pattern documented; may be skipped
3. **Context Explosion** - No truncation/summarization enforcement across phases
4. **Echo Chamber Dynamics** - Agents may produce stylistic variation without substantive disagreement
5. **Model Config Mismatch** - Agent files specify `haiku`, but Task calls use `general-purpose`

**Assumptions Challenged:**
- "3 agents = 3 perspectives" is role-playing, not multi-agent reasoning
- "Discussion refines positions" may be performative
- Parallel execution not guaranteed at inference level

**High Risks:** Model configuration inconsistency, Phase 2 implementation gap, cognitive monoculture

---

### Synthesizer: Key Patterns

**Current Architecture:**
- 3-Phase Linear Flow (Individual → Discussion → Synthesis)
- Fixed Agent Triad with complementary focus
- Parallel-Sequential Hybrid execution
- Token-Conscious Design (~200 word limits)

**Missing Patterns:**
- No iterative refinement loops
- No dynamic agent selection
- No quality gates between phases
- No persistence/caching

**Framework Proposal:** Enhanced architecture with Context Analyzer, Agent Selector, Quality Gate, Adaptive Discussion Loop, Convergence Check, and Confidence Scoring.

---

## Discussion Highlights

### Major Agreements

1. **Phase 2 needs explicit implementation** - All agents agree the Discussion phase lacks concrete Task patterns and may be skipped silently.

2. **Token budget enforcement required** - Context explosion is real; need per-phase limits and auto-summarization.

3. **Model configuration must be clarified** - The mismatch between agent files (`haiku`) and Task calls (`general-purpose`) needs explicit decision.

4. **Quick wins should come first** - YAGNI/KISS principles apply; start with structural fixes before feature additions.

5. **Behavioral contracts enhance diversity** - Rather than relying on model variety, enforce what each agent CAN'T do.

### Major Disagreements

1. **Meta-Critic value** - Researcher proposes it; Critic considers it medium-term at best; Synthesizer omits from MVP.

2. **Domain agents** - Researcher enthusiastic; Critic warns of selection bias; Synthesizer suggests adaptive over pre-selected.

3. **Debate persistence** - Researcher sees value; Critic warns of false pattern recognition; remains deferred.

4. **Convergence detection complexity** - Researcher sees it as essential; Critic notes risk of false convergence signals.

---

## Final Synthesis

### Consensus (All Agree)

| Item | Priority |
|------|----------|
| Fix Phase 2 implementation gap | HIGH |
| Add token budgets per phase | HIGH |
| Clarify model configuration | HIGH |
| Add behavioral contracts per agent | HIGH |
| Implement convergence-based rounds (max 2) | MEDIUM |
| Add confidence scoring with calibration | MEDIUM |

### Tensions (Unresolved)

| Tension | Trade-off |
|---------|-----------|
| **Diversity via prompts vs models** | Prompt-based is cheaper but risks convergence; model diversity costs more |
| **Depth vs tokens** | More rounds improve quality but increase cost |
| **Simplicity vs features** | Domain agents/profiles add value but increase maintenance |
| **Convergence as signal** | Fast convergence may indicate groupthink, not agreement |

### Recommendation

**Phase 1: Structural Fixes (Essential - Do Now)**
1. Document concrete Phase 2 Task patterns with mandatory agent cross-references
2. Add token budgets: Phase 1 (500/agent), Phase 2 (400/agent), Phase 3 (1000)
3. Resolve model config: commit to `haiku` for cost OR `general-purpose` for depth, update all files
4. Add behavioral contracts (what each agent CANNOT do)
5. Add basic error handling between phases

**Phase 2: Anti-Echo-Chamber (High Value - Next)**
1. Inject "Force Counter-Evidence" instruction in Phase 2
2. Implement simple convergence detector (position delta between rounds)
3. If convergence detected too fast → trigger alternative prompt
4. Enable optional second discussion round (max 2 by default)

**Phase 3: Nice-to-Have (Defer Until Proven Needed)**
- Domain-specific agent profiles
- Debate persistence/history
- Meta-Critic agent
- External context integration (web search, codebase)
- Async mode with checkpoints

---

## Next Steps

1. [ ] Update `commands/debate.md` with explicit Phase 2 Task call patterns
2. [ ] Add behavioral contracts to each agent file (`researcher.md`, `critic.md`, `synthesizer.md`)
3. [ ] Document model configuration decision (haiku vs general-purpose)
4. [ ] Add token budget guidance to `skills/debate-workflow/SKILL.md`
5. [ ] Implement convergence-based second round (optional, max 2)
6. [ ] Add error handling for Phase 2 validation failures

---

## Unresolved Questions

1. What's the optimal convergence threshold (66% proposed)?
2. Should structured argumentation (Claim-Evidence-Warrant) be mandatory or optional?
3. How to measure "genuine diversity" vs "stylistic variation" empirically?
4. Is prompt-based constraint sufficient, or do we need model variety for true cognitive diversity?
5. What's acceptable latency/token budget for enhanced workflow?
