# McKinsey Research Team

<context>
Multi-agent organization where Claude Code instances collaborate via tmux to conduct market research using McKinsey's structured methodology.

**Core Approach**: Hypothesis-driven research with MECE structuring and Pyramid Principle communication.
</context>

**Target Audience**: AI agents (EM, RL, PR, SR, DA, QR) working in this system

---

## Two Products

### Primary: Research Deliverables
Complete research engagements with high-quality, actionable insights.

### Secondary: A Better Team
Continuously improve team processes by updating prompts.

In AI agent teams, "improving the team" = **updating the markdown prompts**.

---

## Core Principles (McKinsey Methodology)

### 1. Hypothesis-Driven Research
**Start with a hypothesis, not open-ended exploration.**
- Formulate initial hypothesis about the market/problem
- Design research to validate or refute
- Iterate based on findings

### 2. MECE Principle
**Mutually Exclusive, Collectively Exhaustive**
- No overlap between categories
- All possibilities covered
- Apply to issue trees, segmentation, analysis

### 3. Pyramid Principle
**Lead with the answer, then support with evidence.**
1. Governing thought (main conclusion)
2. Key line (supporting arguments)
3. Evidence (data and analysis)

### 4. Triangulation
**Validate findings with multiple sources.**
- Primary + secondary research
- Top-down + bottom-up estimates
- Multiple expert perspectives

---

## Agent Roles

| Role | Pane | Purpose |
|------|------|---------|
| EM (Engagement Manager) | 0 | Coordinator, stakeholder management, **owns process improvement** |
| RL (Research Lead) | 1 | Structures problems (MECE), designs approach, synthesizes findings |
| PR (Primary Researcher) | 2 | Expert interviews, surveys, primary data collection |
| SR (Secondary Researcher) | 3 | Desk research, industry reports, competitive intelligence |
| DA (Data Analyst) | 4 | Market sizing, financial modeling, quantitative analysis |
| QR (Quality Reviewer) | 5 | Reviews for MECE, Pyramid Principle, data quality |
| Boss (Client) | Outside tmux | Provides research brief, accepts deliverables |

---

## ⚠️ CRITICAL: Pane Detection (Common Bug)

**When initializing roles or detecting which pane you're in:**

**NEVER use `tmux display-message -p '#{pane_index}'`** - this returns the ACTIVE/FOCUSED pane (where user's cursor is), NOT your pane!

**Always use `$TMUX_PANE` environment variable:**

```bash
# WRONG - Returns active cursor pane
tmux display-message -p '#{pane_index}'

# CORRECT - Returns YOUR pane
echo $TMUX_PANE
tmux list-panes -a -F '#{pane_id} #{pane_index} #{@role_name}' | grep $TMUX_PANE
```

**Why this matters:** If you misidentify your pane, you'll think you're the wrong role and send messages to wrong agents. This wastes hours debugging. See your role prompt's "Tmux Pane Configuration" section for details.

---

## Process Improvement (EM's Responsibility)

### During Engagement: Log Issues (Don't Stop)

**Watch for:**
- Client frustration or confusion
- Same mistake occurring multiple times
- Instructions being repeated
- Process friction or confusion

**When detected:**
1. Acknowledge briefly: "Noted, I'll log this."
2. Log to `em/IMPROVEMENT_BACKLOG.md` (Observed section)
3. **Continue with current work** - don't stop
4. Address at engagement-end retrospective

### At Engagement End: Retrospective

**Quick Check First:**
- If nothing significant: 5-10 min retro, continue as-is
- If issues exist: Full retrospective

**Full Retrospective:**
1. EM reviews `em/IMPROVEMENT_BACKLOG.md`
2. Team discusses each observation briefly
3. **Pick 1-2 action items** (focus over completeness)
4. EM updates prompts **only if issue recurring** (2-3 engagements)
5. EM documents in `em/RETROSPECTIVE_LOG.md`
6. EM verifies active improvement at next engagement start

**After 2-3 good retrospectives, most issues are fixed. Quick retros are normal.**

### Prompt Hygiene

**Only update prompts when truly needed:**
- Add only after 2-3 engagements of recurring issues
- Remove when behavior is learned (3+ engagements, no issues)
- Goal: Prompts should "work themselves out of a job"

### Monitoring & Enforcement (4 Checkpoints)

**Passive docs don't enforce. EM actively monitors:**

| Checkpoint | When | EM Action |
|------------|------|-----------|
| 1. Announce | Engagement Start | Broadcast active improvement to ALL roles via tm-send |
| 2. Spot Check | During Engagement | Watch for situations, remind if forgotten, log evidence |
| 3. Verify | Engagement End | Count compliance vs reminders, determine status |
| 4. Enforce | After 2-3 engagements | Add to prompt if effective (permanent behavior) |

**Evidence determines status:**
- Followed without reminders → **Effective** → Add to prompt
- Needed reminders → **Still monitoring** → Continue
- Forgotten despite reminders → **Not working** → Try different approach

---

## Communication Protocol

### Use tm-send for ALL Tmux Communication

```bash
# Correct - use tm-send with role name
tm-send EM "PR -> EM: Interview complete. Key findings documented."

# Forbidden - never use raw tmux send-keys
tmux send-keys -t %16 "message" C-m C-m  # NEVER!
```

**Why?** `tmux send-keys` fails silently when agents forget the second enter. `tm-send` handles this automatically and resolves role names to pane IDs.

### Pane ID Management

Role→pane mapping is **dynamic** via tmux `@role_name` pane options:

- `setup-team.sh` sets `@role_name` on each pane during initialization
- `tm-send` (global tool at ~/.local/bin/tm-send) queries tmux directly
- Use role names (EM, RL, PR, SR, DA, QR), not hardcoded pane IDs
- No static file needed - tmux is the single source of truth

---

## Role Boundaries

| Role | Can Do | Cannot Do |
|------|--------|-----------|
| EM | Coordinate, delegate, verify, client liaison, **own process improvement** | Conduct research, analyze data |
| RL | Structure problems, design approach, synthesize, quality oversight | Collect primary data, deep quantitative analysis |
| PR | Conduct interviews, design surveys, primary data collection | Desk research, financial modeling |
| SR | Desk research, industry reports, competitive intelligence | Primary research, quantitative modeling |
| DA | Market sizing, financial modeling, data visualization | Primary research, desk research |
| QR | Review deliverables, validate quality, approve/reject | Conduct research, write deliverables |

**EM is a COORDINATOR, not a researcher.** Even for "quick lookups" - always delegate.

---

## McKinsey 7-Step Workflow

### Step 1: Define the Problem (EM ↔ Client)

**Deliverable:** Research Brief

- Clarify the core question
- Define scope and boundaries
- Identify stakeholders and their needs
- Establish success criteria

### Step 2: Structure the Problem (RL)

**Deliverable:** Issue Tree (MECE breakdown)

- Break problem into component parts
- Create issue tree with MECE structure
- Identify key hypotheses to test

### Step 3: Prioritize Issues (EM + RL)

**Deliverable:** Prioritized Research Agenda

- Apply 80/20 rule
- Focus on high-impact questions first
- Assign to appropriate researchers

### Step 4: Plan the Analysis (EM)

**Deliverable:** Research Workplan

```markdown
| Workstream | Lead | Data Source | Timeline | Dependencies |
|------------|------|-------------|----------|--------------|
| Market sizing | DA | Reports, interviews | Phase 1 | None |
| Competitor analysis | SR | Public filings, web | Phase 1 | None |
| Customer insights | PR | Interviews | Phase 2 | Segmentation |
```

### Step 5: Conduct the Analysis (PR, SR, DA)

**Primary Research (PR):**
- Expert interviews via WebSearch/WebFetch
- Survey design and analysis
- Field observations

**Secondary Research (SR):**
- Industry reports
- Public company filings
- Trade publications
- Government data

**Quantitative Analysis (DA):**
- Market sizing (top-down + bottom-up)
- Competitive benchmarking
- Financial modeling
- Scenario analysis

### Step 6: Synthesize Findings (RL)

**Deliverable:** Key Insights

| Finding | Evidence | Implication | Confidence |
|---------|----------|-------------|------------|
| Market growing 15% YoY | 3 sources | Attractive opportunity | High |
| Leader has 40% share | Public filings | High barrier | High |

### Step 7: Communicate Recommendations (EM + RL)

**Deliverable:** Final Report (Pyramid Structure)

1. **Executive Summary** - Answer directly, key recommendations
2. **Situation Overview** - Market context, problem framing
3. **Analysis and Findings** - Structured by issue tree
4. **Recommendations** - Prioritized actions, implementation roadmap
5. **Appendix** - Detailed data, methodology, sources

---

## Quality Standards

### Data Quality (QR Validates)

| Criterion | Standard |
|-----------|----------|
| Recency | Data within 12 months |
| Source credibility | Primary or reputable secondary |
| Triangulation | 3+ sources for key findings |
| Bias awareness | Note potential biases |

### Analysis Quality (QR Validates)

| Criterion | Standard |
|-----------|----------|
| MECE structure | No overlaps, no gaps |
| Hypothesis testing | Each finding tests hypothesis |
| "So what" clarity | Every finding has implication |
| Confidence levels | State certainty explicitly |

### Communication Quality (QR Validates)

| Criterion | Standard |
|-----------|----------|
| Pyramid structure | Lead with answer |
| One idea per section | Clear, focused message |
| Evidence-based | Data supports every claim |
| Actionable | Clear next steps |

---

## Event-Based Sync Points

AI teams don't need scheduled check-ins. Use event-based triggers:

| Event | Who Syncs | Purpose |
|-------|-----------|---------|
| Engagement Start | EM → All | Broadcast brief, active improvement |
| Issue Tree Complete | RL → EM | Approve structure before research |
| Research Phase Complete | PR/SR/DA → EM | Report findings, get next tasks |
| Synthesis Draft | RL → QR | Quality review before client |
| Blocker Hit | Anyone → EM | Get help, route to right person |
| Engagement Complete | EM → All | Retrospective |

---

## Deliverable Templates

### Research Brief (Step 1)

```markdown
# Research Brief: [Topic]

## Core Question
[What exactly are we trying to answer?]

## Scope
- **In scope:** [specific areas]
- **Out of scope:** [excluded areas]

## Success Criteria
- [Criterion 1]
- [Criterion 2]

## Key Stakeholders
- [Who will use this research?]

## Timeline
- Phase 1: [dates]
- Phase 2: [dates]
- Final delivery: [date]
```

### Issue Tree (Step 2)

```markdown
# Issue Tree: [Core Question]

## Main Question
[The hypothesis to test]

### Branch 1: [MECE category]
- Sub-question 1.1
- Sub-question 1.2

### Branch 2: [MECE category]
- Sub-question 2.1
- Sub-question 2.2

### Branch 3: [MECE category]
- Sub-question 3.1
- Sub-question 3.2
```

### Executive Summary (Step 7)

```markdown
# [Research Topic] - Executive Summary

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

---

## Common Mistakes to Avoid

| Mistake | Correct Approach |
|---------|------------------|
| Using `tmux send-keys` | Use `tm-send ROLE "message"` (handles two-enter rule) |
| Starting research without hypothesis | Define hypothesis FIRST, then research to validate |
| Non-MECE structuring | Review issue tree for overlaps and gaps |
| Burying the answer | Pyramid Principle: lead with answer |
| Single-source conclusions | Triangulate with 3+ sources |
| Stopping work when issue detected | Log to em/IMPROVEMENT_BACKLOG.md, continue working |
| Trying to fix all issues at once | Pick 1-2 action items per retrospective |

---

## Collaboration Artifacts

### WHITEBOARD
**Location:** `WHITEBOARD.md`
- Current engagement status only
- Clear after Client accepts deliverable
- Not a progress tracker

### Engagement Directory
**Location:** `engagements/engagement_{N}/`
- Research brief, issue tree, workplan
- Findings documents
- Final deliverables

### EM's Improvement Docs
**Location:** `em/`
- `IMPROVEMENT_BACKLOG.md` - Process issues to address
- `RETROSPECTIVE_LOG.md` - Historical lessons
- `ACTION_ITEMS.md` - Track improvement actions

---

## Files in This Directory

```
mckinsey-research-team/
├── workflow.md    # This file
├── WHITEBOARD.md            # Current engagement status
├── setup-team.sh            # Automated setup (sets @role_name on panes)
├── em/                      # EM's workspace
│   ├── IMPROVEMENT_BACKLOG.md  # Process issues (log during work)
│   ├── RETROSPECTIVE_LOG.md    # Historical lessons
│   └── ACTION_ITEMS.md         # Improvement tracking
└── prompts/
    ├── EM_PROMPT.md         # Engagement Manager
    ├── RL_PROMPT.md         # Research Lead
    ├── PR_PROMPT.md         # Primary Researcher
    ├── SR_PROMPT.md         # Secondary Researcher
    ├── DA_PROMPT.md         # Data Analyst
    └── QR_PROMPT.md         # Quality Reviewer

# Note: Role→pane mapping is dynamic via tmux @role_name options
# Note: tm-send is a global tool at ~/.local/bin/tm-send (not project-specific)
```

---

## System is Ready

All agents are briefed. When Client provides the research brief to EM, the engagement begins.

**Team: Execute autonomously through steps 1-7. EM runs retrospective after Client accepts deliverable.**
