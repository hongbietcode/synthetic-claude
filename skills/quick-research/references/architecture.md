# Multi-Agent Research System Architecture

This document captures key architectural insights from Anthropic's multi-agent research system and LangChain's Open Deep Research.

## Core Architecture: Orchestrator-Worker Pattern

```
┌─────────────────────────────────────────────────────────────┐
│                    Lead Researcher                           │
│  (Analyzes query, plans strategy, spawns subagents)         │
└─────────────────────┬───────────────────────────────────────┘
                      │
        ┌─────────────┼─────────────┐
        │             │             │
        ▼             ▼             ▼
┌───────────┐   ┌───────────┐   ┌───────────┐
│ Subagent  │   │ Subagent  │   │ Subagent  │
│ (Topic A) │   │ (Topic B) │   │ (Topic C) │
└─────┬─────┘   └─────┬─────┘   └─────┬─────┘
      │               │               │
      └───────────────┼───────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                  Lead Researcher                             │
│  (Synthesizes findings, spawns more if needed)              │
└─────────────────────┬───────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                    Final Report                              │
│  (Comprehensive answer with citations)                      │
└─────────────────────────────────────────────────────────────┘
```

## Why Multi-Agent for Research?

### Benefits

1. **Parallelization** - Multiple aspects explored simultaneously
2. **Context Isolation** - Each subagent has clean context window for its topic
3. **Compression** - Subagents distill insights before returning to lead
4. **Separation of Concerns** - Distinct tools, prompts, exploration trajectories
5. **Scalability** - Token usage can scale with problem complexity

### Performance Data (from Anthropic)

- Multi-agent with Opus 4 lead + Sonnet 4 subagents outperformed single-agent Opus 4 by **90.2%**
- Token usage explains **80%** of performance variance in BrowseComp evaluation
- Multi-agent systems use ~**15x** more tokens than chat interactions
- Parallel execution reduces research time by up to **90%**

### When Multi-Agent Works Best

- Breadth-first queries with multiple independent directions
- Information exceeds single context window
- Tasks with heavy parallelization potential
- Interfacing with numerous complex tools

### When NOT to Use Multi-Agent

- Tasks requiring all agents to share same context
- Many dependencies between agents
- Tasks where coordination overhead exceeds benefit
- Simple, sequential workflows

## Three-Phase Workflow

### Phase 1: Scope

```
User Messages → Clarification (if needed) → Research Brief
```

**User Clarification**: Users rarely provide sufficient context. Ask clarifying questions if needed for:
- Ambiguous terms or acronyms
- Scope boundaries
- Source preferences

**Brief Generation**: Compress chat interaction into focused brief that serves as north star for research.

### Phase 2: Research

```
Research Brief → Supervisor → Parallel Subagents → Findings
```

**Research Supervisor**:
- Determines if brief can be broken into independent subtopics
- Delegates to subagents with isolated context windows
- Assesses if findings are sufficient or need more research

**Research Subagents**:
- Each focuses on specific subtopic
- Uses search tools in tool-calling loop
- Makes final LLM call to clean/summarize findings
- Returns findings with citations to supervisor

**Key Insight**: Clean subagent research findings before returning. Raw tool feedback is token-heavy and full of irrelevant information.

### Phase 3: Report Writing

```
Findings → Final LLM Call → Comprehensive Report
```

**One-Shot Writing**: Provide LLM with research brief + all findings, generate report in single call.

**Key Insight**: Don't use multi-agent for writing. Earlier versions wrote sections in parallel, but reports were disjoint. Writing must be coordinated, research can be parallel.

## Prompting Principles

### 1. Think Like Your Agents

Build simulations with exact prompts and tools to watch agents work step-by-step. Reveals failure modes:
- Continuing when already have sufficient results
- Overly verbose search queries
- Selecting incorrect tools

### 2. Teach the Orchestrator How to Delegate

Each subagent needs:
- Clear objective
- Output format
- Tool and source guidance
- Clear task boundaries

Without detailed descriptions, agents:
- Duplicate work
- Leave gaps
- Misinterpret tasks

### 3. Scale Effort to Query Complexity

Embed scaling rules in prompts:
- Simple fact-finding: 1 agent, 3-10 tool calls
- Direct comparisons: 2-4 subagents, 10-15 calls each
- Complex research: 10+ subagents with divided responsibilities

### 4. Tool Design and Selection

- Examine all available tools first
- Match tool usage to user intent
- Search web for broad external exploration
- Prefer specialized tools over generic ones
- Bad tool descriptions send agents down wrong paths

### 5. Let Agents Improve Themselves

Claude 4 models are excellent prompt engineers:
- Given prompt + failure mode, can diagnose and suggest improvements
- Tool-testing agents can rewrite tool descriptions to avoid failures
- Result: 40% decrease in task completion time

### 6. Start Wide, Then Narrow

Search strategy should mirror expert human research:
- Start with short, broad queries
- Evaluate what's available
- Progressively narrow focus

### 7. Guide the Thinking Process

Extended thinking mode serves as controllable scratchpad:
- Lead agent: Plan approach, assess tools, determine query complexity
- Subagents: Use interleaved thinking after tool results to evaluate and refine

### 8. Parallel Tool Calling

Two kinds of parallelization:
1. Lead agent spins up 3-5 subagents in parallel
2. Each subagent uses 3+ tools in parallel

Result: Research time cut by up to 90% for complex queries.

## Context Engineering

Research is token-heavy (15x more than chat). Mitigate with:

1. **Compress chat to brief** - Prevents token bloat from prior messages
2. **Prune subagent findings** - Remove irrelevant tokens before returning
3. **Subagent output to filesystem** - Bypass main coordinator for some results

Without context engineering:
- Context window limits hit
- Higher token costs
- Model rate limits reached

## Evaluation Strategies

### Start Small, Scale Up

- Begin with ~20 test queries representing real usage
- Large effect sizes early on make small samples sufficient
- Don't delay evals waiting for large test sets

### LLM-as-Judge

Single LLM call with rubric covering:
- Factual accuracy (claims match sources?)
- Citation accuracy (cited sources match claims?)
- Completeness (all aspects covered?)
- Source quality (primary over secondary?)
- Tool efficiency (right tools, reasonable count?)

Output: 0.0-1.0 scores + pass/fail grade

### Human Evaluation

Catches what automation misses:
- Hallucinated answers on unusual queries
- System failures
- Subtle source selection biases (e.g., SEO content farms over academic PDFs)

## Production Considerations

### State Management

- Agents are stateful, run for long periods
- Build resume-from-error capability
- Use model intelligence to handle failures gracefully
- Combine AI adaptability with deterministic safeguards

### Debugging

- Agents are non-deterministic between runs
- Full production tracing essential
- Monitor decision patterns and interaction structures
- Don't monitor individual conversation contents (privacy)

### Deployment

- Rainbow deployments for running agents
- Gradually shift traffic between versions
- Keep both versions running during transition

## Claude Code Integration

In Claude Code, use the **Task tool** with `subagent_type: "research-assistant"`:

```
Task tool call:
  subagent_type: "research-assistant"
  prompt: "Research [specific topic]. Focus on [dimensions].
           Return findings with inline citations [Source](URL).
           Prioritize [source types]."
  run_in_background: false  (wait for results)
```

**Parallel Execution**: Make multiple Task tool calls in a SINGLE message:
```
<message>
  Task call 1: research-assistant for Topic A
  Task call 2: research-assistant for Topic B
  Task call 3: research-assistant for Topic C
</message>
```

This enables true parallel execution. Sequential messages = sequential execution.

## Sources

- Anthropic: "How we built our multi-agent research system" (Jun 2025)
- LangChain: "Open Deep Research" (Jul 2025)
- Anthropic Cookbook: https://github.com/anthropics/anthropic-cookbook/tree/main/patterns/agents/prompts
