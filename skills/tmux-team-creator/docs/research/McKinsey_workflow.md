# McKinsey Market Research Methodology

## Overview

McKinsey's approach to market research combines structured problem-solving with rigorous analytical frameworks. This document synthesizes McKinsey's standard methodology for conducting market research, applicable to AI agent teams.

---

## Core Principles

### 1. Hypothesis-Driven Research

**Start with a hypothesis, not open-ended exploration.**

- Formulate an initial hypothesis about the market/problem
- Design research to validate or refute the hypothesis
- Iterate based on findings

**Why?** Reduces wasted effort, focuses data collection, accelerates insights.

### 2. MECE Principle (Mutually Exclusive, Collectively Exhaustive)

**Structure all analysis using MECE.**

- **Mutually Exclusive**: No overlap between categories
- **Collectively Exhaustive**: All possibilities covered

**Example - Market Segmentation:**
```
Market Size
├── Segment A (by geography)
│   ├── North America
│   ├── Europe
│   ├── Asia-Pacific
│   └── Rest of World
├── Segment B (by customer type)
│   ├── Enterprise
│   ├── SMB
│   └── Consumer
└── Segment C (by product line)
    ├── Product 1
    ├── Product 2
    └── Product 3
```

### 3. Pyramid Principle (Communication)

**Lead with the answer, then support with evidence.**

1. **Governing thought** (main conclusion)
2. **Key line** (supporting arguments)
3. **Evidence** (data and analysis)

---

## McKinsey 7-Step Problem-Solving Process

### Step 1: Define the Problem

**Deliverable:** Problem Statement

- Clarify the core question
- Define scope and boundaries
- Identify stakeholders and their needs
- Establish success criteria

**Key questions:**
- What exactly are we trying to solve?
- What decisions will this research inform?
- What are the constraints (time, budget, data)?

### Step 2: Structure the Problem

**Deliverable:** Issue Tree (MECE breakdown)

- Break problem into component parts
- Create issue tree or logic tree
- Identify key drivers and dependencies

**Example Issue Tree - Market Entry:**
```
Should we enter Market X?
├── Is the market attractive?
│   ├── Market size and growth
│   ├── Competitive intensity
│   └── Profitability potential
├── Can we win?
│   ├── Required capabilities
│   ├── Current capability gaps
│   └── Competitive advantage
└── Is it worth it?
    ├── Investment required
    ├── Expected returns
    └── Strategic fit
```

### Step 3: Prioritize Issues

**Deliverable:** Prioritized Research Agenda

- Apply 80/20 rule (Pareto principle)
- Focus on high-impact issues first
- Identify quick wins vs. deep dives

**Prioritization Matrix:**

| Issue | Impact | Effort | Priority |
|-------|--------|--------|----------|
| Market sizing | High | Medium | 1 |
| Competitor analysis | High | High | 2 |
| Customer segmentation | Medium | Medium | 3 |

### Step 4: Plan the Analysis

**Deliverable:** Workplan with Timelines

- Define data sources (primary vs. secondary)
- Assign responsibilities
- Create timeline with milestones
- Identify dependencies

**Workplan Template:**

| Workstream | Lead | Data Source | Timeline | Dependencies |
|------------|------|-------------|----------|--------------|
| Market sizing | Analyst 1 | Industry reports, interviews | Week 1-2 | None |
| Competitor mapping | Analyst 2 | Public filings, web research | Week 1-2 | None |
| Customer interviews | Analyst 3 | Primary research | Week 2-3 | Segmentation |

### Step 5: Conduct the Analysis

**Deliverable:** Analytical Findings

**Primary Research:**
- Expert interviews (5-10 typically)
- Customer surveys
- Field observations

**Secondary Research:**
- Industry reports (Gartner, Forrester, IDC)
- Public company filings (10-K, investor presentations)
- Trade publications
- Government data (census, economic indicators)

**Analytical Techniques:**
- Market sizing (top-down and bottom-up)
- Competitive benchmarking
- Customer segmentation
- Trend analysis
- Scenario modeling

### Step 6: Synthesize Findings

**Deliverable:** Key Insights and Implications

- Identify patterns across data sources
- Triangulate findings (multiple sources confirm)
- Distill into "so what" implications
- Test against original hypothesis

**Synthesis Framework:**

| Finding | Evidence | Implication | Confidence |
|---------|----------|-------------|------------|
| Market growing 15% YoY | 3 sources agree | Attractive opportunity | High |
| Leader has 40% share | Public filings | High barrier to entry | High |
| Customers value X | 6/10 interviews | Focus product on X | Medium |

### Step 7: Communicate Recommendations

**Deliverable:** Final Presentation (Pyramid Structure)

1. **Executive Summary** (1 page)
   - Answer the question directly
   - Key recommendations
   - Critical next steps

2. **Situation Overview** (2-3 pages)
   - Market context
   - Problem framing

3. **Analysis and Findings** (5-10 pages)
   - Structured by issue tree
   - Each section: finding → evidence → implication

4. **Recommendations** (2-3 pages)
   - Prioritized actions
   - Implementation roadmap
   - Risks and mitigations

5. **Appendix**
   - Detailed data
   - Methodology
   - Sources

---

## McKinsey 7S Framework

For organizational analysis within market research, McKinsey uses the 7S Framework.

### The Seven Elements

**Hard S's (Tangible, easier to change):**

| Element | Definition | Research Questions |
|---------|------------|-------------------|
| **Strategy** | Plan to achieve competitive advantage | What is their go-to-market strategy? |
| **Structure** | Organizational hierarchy | How are they organized? Centralized vs. decentralized? |
| **Systems** | Processes and procedures | What operational systems do they use? |

**Soft S's (Intangible, harder to change):**

| Element | Definition | Research Questions |
|---------|------------|-------------------|
| **Shared Values** | Core beliefs and culture | What drives their decisions? |
| **Style** | Leadership approach | How does management operate? |
| **Staff** | Employee capabilities | What talent do they have? |
| **Skills** | Organizational competencies | What are they best at? |

### Application in Competitive Analysis

Use 7S to analyze competitors:

```
Competitor Analysis Template
├── Strategy: What markets? What positioning?
├── Structure: How organized? Speed of decision-making?
├── Systems: Technology stack? Operational efficiency?
├── Shared Values: Customer-centric? Innovation-focused?
├── Style: Aggressive? Conservative?
├── Staff: Key talent? Culture?
└── Skills: Core competencies? Weaknesses?
```

---

## Market Sizing Methodology

### Top-Down Approach

Start with total market, narrow down:

```
Total Addressable Market (TAM)
└── Global IT spending: $5T
    └── Cloud segment: $500B (10%)
        └── Cloud security: $50B (10%)
            └── Target segment: $5B (10%)
                └── Serviceable market: $1B (20% of segment)
```

### Bottom-Up Approach

Build from unit economics:

```
# of potential customers: 10,000 companies
× Adoption rate: 20%
× Average deal size: $100K
= Market size: $200M
```

### Triangulation

Always validate with multiple approaches:
- Top-down estimate: $180M
- Bottom-up estimate: $200M
- Analyst reports: $190M
- **Triangulated estimate: $190M (±10%)**

---

## Deliverable Templates

### Market Research Executive Summary

```markdown
# [Market/Topic] Research Summary

## Key Question
[What we were asked to answer]

## Answer
[Direct answer in 1-2 sentences]

## Key Findings
1. [Finding 1] - [Implication]
2. [Finding 2] - [Implication]
3. [Finding 3] - [Implication]

## Recommendations
1. [Action 1] - [Rationale]
2. [Action 2] - [Rationale]

## Next Steps
- [Immediate action] (Owner, Deadline)
- [Follow-up research] (Owner, Deadline)
```

### Competitive Landscape Summary

```markdown
# Competitive Landscape: [Market]

## Market Structure
- Total market: $[X]B
- Growth rate: [X]% CAGR
- Key segments: [A], [B], [C]

## Key Players

| Player | Share | Strategy | Strengths | Weaknesses |
|--------|-------|----------|-----------|------------|
| Leader | 35% | Premium | Brand, R&D | Price |
| Challenger | 20% | Value | Cost | Scale |
| Niche | 10% | Specialist | Expertise | Narrow |

## Competitive Dynamics
- [Key trend 1]
- [Key trend 2]
- [Emerging threat]

## Implications for Client
1. [Implication 1]
2. [Implication 2]
```

---

## Quality Standards

### Data Quality

| Criterion | Standard |
|-----------|----------|
| Recency | Data within 12 months |
| Source credibility | Primary or reputable secondary |
| Triangulation | 3+ sources for key findings |
| Bias awareness | Note potential biases |

### Analysis Quality

| Criterion | Standard |
|-----------|----------|
| MECE structure | No overlaps, no gaps |
| Hypothesis testing | Each finding tests hypothesis |
| "So what" clarity | Every finding has implication |
| Confidence levels | State certainty explicitly |

### Communication Quality

| Criterion | Standard |
|-----------|----------|
| Pyramid structure | Lead with answer |
| One idea per slide | Clear, focused message |
| Evidence-based | Data supports every claim |
| Actionable | Clear next steps |

---

## Applying to AI Agent Teams

### Role Mapping

| McKinsey Role | AI Agent Equivalent |
|---------------|---------------------|
| Engagement Manager | PM (Project Manager) |
| Associate Partner | SA (Solution Architect) |
| Business Analyst | Research Agent |
| Expert Interviews | WebSearch/WebFetch tools |
| Data Analyst | Data Processing Agent |

### Workflow Adaptation

```
McKinsey Process → AI Agent Workflow

1. Define Problem → PM receives brief, creates research question
2. Structure Problem → PM creates MECE issue tree
3. Prioritize → PM identifies critical questions
4. Plan Analysis → PM assigns research tasks to agents
5. Conduct Analysis → Research agents execute in parallel
6. Synthesize → PM consolidates findings
7. Communicate → PM creates summary for Boss
```

---

## References

- McKinsey & Company. "The McKinsey Way" - Core methodology
- Barbara Minto. "The Pyramid Principle" - Communication framework
- Ethan Rasiel. "The McKinsey Mind" - Problem-solving approach
- McKinsey Quarterly - Industry research examples
