# Agentic Patterns for Coding Agents (Late 2025)

## Quick Selection

| Pattern | Use When | Complexity |
|---------|----------|------------|
| **Orchestrator-Worker** | Multi-step parallel tasks | High |
| **Reflexion** | Iterative improvement needed | Medium |
| **Context Stack** | All agentic workflows | Required |
| **Plan-Execute** | Complex workflows with dependencies | High |
| **Tool Orchestration** | Multi-tool coordination | Medium |

For Memory Patterns, see: `memory-patterns.md`

---

## 1. Orchestrator-Worker

Central orchestrator delegates to specialized workers.

```
┌─────────────────┐
│   Orchestrator  │ ← Plans, delegates
└────────┬────────┘
    ┌────┴────┬────────┬────────┐
    ▼         ▼        ▼        ▼
┌───────┐ ┌───────┐ ┌───────┐ ┌───────┐
│ Code  │ │ Test  │ │Review │ │  Doc  │
└───────┘ └───────┘ └───────┘ └───────┘
```

**Implementation**:
```xml
<orchestrator_prompt>
  <role>Task coordinator and planner</role>
  <capabilities>
    - Analyze requests, break into subtasks
    - Delegate to workers, synthesize results
  </capabilities>
  <workers>
    - CodeWorker: Write/modify code
    - TestWorker: Create/run tests
    - ReviewWorker: Quality check
  </workers>
  <workflow>
    1. Analyze → 2. Plan (DAG) → 3. Delegate → 4. Synthesize
  </workflow>
</orchestrator_prompt>
```

---

## 2. Reflexion

Agent reflects on failures to improve.

```
Task → Execute → Evaluate → Reflect → Retry (improved)
                    ↑                      │
                    └──────────────────────┘
```

**Implementation**:
```xml
<reflexion_prompt>
  <evaluate>Did solution meet requirements? What issues?</evaluate>
  <reflect>Why did issues occur? What differently?</reflect>
  <retry>Apply learnings to improved solution.</retry>
</reflexion_prompt>
```

---

## 3. Context Stack (Required)

**6 Layers (Priority Order)**:

| Layer | Content | Caching |
|-------|---------|---------|
| 1 | System Instructions | Yes (static) |
| 2 | Long-Term Memory | Partial |
| 3 | Retrieved Documents (RAG) | No |
| 4 | Tool Definitions | Yes (static) |
| 5 | Conversation History | No |
| 6 | Current Task | No (recency) |

**Budget Allocation**:
```
System + Tools: 15-20% (cached)
Retrieved Docs: 30-40%
Conversation: 20-30% (compress old)
Current Task: 15-20%
```

**Key**: Static first (caching), current task last (recency bias).

---

## 4. Plan-Execute (Evolution from ReAct)

Global planning before execution.

```
┌─────────┐     ┌─────────┐     ┌──────────┐
│ Planner │ ──► │Executor │ ──► │ Verifier │
│  (DAG)  │     │         │     │          │
└─────────┘     └─────────┘     └──────────┘
      ▲                              │
      └──────────────────────────────┘
               (Replan if needed)
```

**Advantages over ReAct**: Global view, better parallelization, clearer dependencies.

**Implementation**:
```xml
<planner>
  1. Identify all steps
  2. Map dependencies (DAG)
  3. Find parallelizable steps
  4. Define success criteria per step
</planner>
<executor>Follow order, parallelize, report per step</executor>
<verifier>Verify criteria, replan if failed</verifier>
```

---

## 5. Tool Orchestration

Coordinate multiple tools effectively.

```xml
<tools>
  <tool name="search">
    Use when: Need codebase information
    Input: Query → Output: Code snippets
  </tool>
  <tool name="edit">
    Use when: Modify file
    Input: Path, changes → Output: Success/failure
  </tool>
  <tool name="run">
    Use when: Execute command
    Input: Command → Output: stdout/stderr
  </tool>
</tools>

<tool_selection>
  What info needed? → search
  What changes? → edit
  How verify? → run
</tool_selection>
```

**Best Practices**: Clear boundaries, explicit selection criteria, graceful failure handling.
