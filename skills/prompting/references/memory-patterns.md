# Memory Patterns for Agents (CoALA Framework)

Based on CoALA paper (Sumers, Yao, Narasimhan, Griffiths 2024).

## Quick Selection

| Memory Type | Store What | Use When |
|-------------|-----------|----------|
| **Procedural** | How to perform tasks | Rarely modified at runtime |
| **Semantic** | Facts, preferences | No fixed "correct way", constant new things |
| **Episodic** | Past successful actions | Patterns/correct way already known |

## Decision Flow

```
What to remember?
│
├─ Facts/preferences about user/project
│   └─► Semantic Memory (personalization)
│
├─ Correct way to do specific actions
│   └─► Episodic Memory (few-shot)
│
└─ Repeating patterns?
    ├─ Yes → Episodic (dynamic few-shot)
    └─ No → Semantic
```

## Memory Types

### Procedural
- **Definition**: How to perform tasks
- **In Agents**: LLM weights + agent code, system prompt
- **Update**: Rarely at runtime

### Semantic
- **Definition**: Long-term knowledge store
- **In Agents**: Facts extracted from conversations
- **Use Case**: Personalization when doing new things constantly

### Episodic
- **Definition**: Recall specific events/actions
- **In Agents**: Few-shot examples from past successes
- **Use Case**: When patterns already known

## Update Strategies

| Strategy | How | Pros | Cons |
|----------|-----|------|------|
| **Hot Path** | Update during conversation | Always fresh | Added latency |
| **Background** | Async process during/after | No latency | Not instant |
| **User Feedback** | Mark good/bad interactions | High quality | Requires user action |

## Implementation

```xml
<memory_management>
  <procedural>
    System prompt, agent code, tool definitions
  </procedural>
  
  <semantic>
    User: Prefers TypeScript, uses Vitest
    Project: Next.js 15, Tailwind CSS
  </semantic>
  
  <episodic>
    Example 1: User asked X → Agent did Y → Success
    Example 2: Error Z → Fixed with approach W
  </episodic>
</memory_management>

<memory_update strategy="background">
  Extract facts → Update semantic
  Positive feedback → Save to episodic
</memory_update>
```

## Practical Tips

- **Semantic**: LLM extracts facts → store in vector DB or structured format
- **Episodic**: Collect examples → enable dynamic few-shot selection
- **Hot path**: Real-time personalization, critical facts
- **Background**: Batch processing, non-urgent updates
