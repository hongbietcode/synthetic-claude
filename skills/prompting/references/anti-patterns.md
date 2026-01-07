# Prompting Anti-Patterns (Late 2025)

## Quick Reference

| Anti-Pattern | Impact | Do This Instead |
|--------------|--------|-----------------|
| **Trusting CoT for safety** | **94-99% hijack rate** | **Validate OUTPUT, not reasoning** |
| Manual CoT with reasoning models | +20-80% time, wastes tokens | Zero-shot with explicit goal |
| Few-shot for logic | Hurts reasoning models (confirmed) | Zero-shot logic, few-shot FORMAT only |
| ALL CAPS / "MUST" / "ALWAYS" | Ignored by model | Clear structure and logic |
| Vague prompts ("Make it better") | Unpredictable results | Explicit specifications |
| Mega-prompts (all use cases) | Impossible to optimize | Modular: one task, one prompt |
| Negative constraints ("Don't X") | Pink elephant effect | Positive: "Do Y" |
| Temperature != 1.0 (Gemini 3) | Unpredictable behavior | Always 1.0, use thinking_level |
| Query before long context | -30% quality | Context FIRST, query LAST |
| No input sanitization | Security risk, injection | Validate inputs, XML boundaries |
| Dynamic content first | Wastes 50-90% caching savings | Static first, dynamic last |
| Extended thinking on simple tasks | Can hurt -36% | Only for complex reasoning |

## Details

### Manual CoT with Reasoning Models

**Pattern**: "Think step by step", "Let's work through this"

**Why bad**: Reasoning models (o3, o4, GPT-5, Claude Extended Thinking) have implicit CoT. Only +2.9% accuracy but +20-80% time/tokens.

---

### ALL CAPS / Excessive Emphasis

**Pattern**: "MUST", "ALWAYS", "NEVER", "CRITICAL!!!"

**Why bad**: Models prioritize context and logic, not typography. Can cause unexpected behavior.

---

### Vague/Ambiguous Prompts

**Pattern**: "Make it better", "Fix this", "Help me"

**Why bad**: Modern models follow LITERAL instructions. Don't infer intent.

---

### One-Prompt-to-Rule-Them-All

**Pattern**: Mega-prompt covering all use cases

**Why bad**: Impossible to optimize, bloated context, conflicting instructions.

---

### Few-Shot for Logic

**Pattern**: Giving reasoning examples to o3, o4, DeepSeek R1

**Why bad**: CONFIRMED performance degradation. Model has own reasoning patterns.

---

### Negative Constraints Overload

**Pattern**: "Don't do X", "Never Y", "Avoid Z"

**Why bad**: Pink elephant effect - focusing on what to avoid triggers it.

---

### Temperature Tuning (Gemini 3)

**Pattern**: Setting temperature != 1.0

**Why bad**: Google official guidance: keep at 1.0. Model calibrated for this value.

---

### Context at End

**Pattern**: Query first, then long document

**Why bad**: -30% quality. Model attention favors recency, important context buried.

---

### Prompt Injection Vulnerability

**Pattern**: Not sanitizing user input

**Why bad**: Security risk - users can override instructions. CoT Hijacking: 99% success on some models.

**Fix**: Separate system/user with XML tags, validate inputs.

---

### Ignoring Prompt Caching

**Pattern**: Dynamic content first, static last

**Why bad**: Wastes 50-90% cost savings, higher latency.

---

### Extended Thinking Misuse

**Pattern**: Using extended thinking on simple pattern recognition

**Why bad**: Can HURT performance by -36%. Rule: if human overthinking would hurt, so will extended thinking.

---

### Trusting CoT for Safety

**Pattern**: Relying on model's reasoning chain for security decisions

**Why bad**: CoT Hijacking attacks have 94-99% success rate. Always validate OUTPUT.
