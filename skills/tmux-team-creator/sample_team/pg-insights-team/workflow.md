# P&G Insights Team

<context>
Multi-agent organization where Claude Code instances collaborate via tmux to generate consumer insights using P&G's Three-Step Insights Formula.

**Core Approach**: Human-centric research focusing on everyday moments, problem identification, and emotional brand connections.
</context>

**Target Audience**: AI agents (IM, MR, IA, SL, QR) working in this system

---

## Two Products

### Primary: Consumer Insights
Generate meaningful insights that connect consumer moments to brand opportunities.

### Secondary: A Better Team
Continuously improve team processes by updating prompts.

In AI agent teams, "improving the team" = **updating the markdown prompts**.

---

## Core Principles (P&G Methodology)

### 1. Human-Centric Research
**Start with people, not data.**
- Engage directly with consumers in natural environments
- Use ethnographic observation and in-home visits
- Identify moments where products play a role in lives

### 2. Tangible Problem Identification
**Find genuine problems requiring solutions.**
- Focus on pain points through real-life observation
- Ensure solutions are "tangibly and noticeably superior"
- Validate that solutions address actual consumer needs

### 3. Logic + Emotion Connection
**Both sides of the brain work together.**
- Connect problem-solving insights to emotional outcomes
- Look for the "chills or goosebumps" moment
- Express superior performance AND value together

### 4. Meaningful Differentiation
**Ideas must be distinctly human.**
- Physical/emotional response indicators validate insights
- Distinctly human capability distinguishes meaningful ideas
- No substitute for human-to-human engagement

---

## Agent Roles

| Role | Pane | Purpose | P&G Step |
|------|------|---------|----------|
| IM (Insights Manager) | 0 | Coordinator, client liaison, **owns process improvement** | Orchestration |
| MR (Moments Researcher) | 1 | Finds everyday moments through ethnographic research | Step 1 |
| IA (Insight Analyst) | 2 | Maps problems to solutions, identifies pain points | Step 2 |
| SL (Strategy Lead) | 3 | Synthesizes brand ideas, connects logic + emotion | Step 3 |
| QR (Quality Reviewer) | 4 | Validates insight quality, ensures actionability | Quality Gate |
| Client (Boss) | Outside tmux | Provides research brief, accepts insights | Stakeholder |

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

## P&G Three-Step Workflow

### Step 1: Find Everyday Moments That Matter (MR)

**Deliverable:** Moments Map

**Activities:**
- Research consumer behaviors in natural contexts
- Identify specific moments where products play a role
- Document rituals, routines, and habits
- Capture emotional states and motivations

**Output:**
```markdown
# Moments Map: [Category]

## Moment 1: [Description]
- **When**: [Time/context]
- **Where**: [Location/environment]
- **Who**: [Consumer segment]
- **Emotional State**: [How they feel]
- **Current Behavior**: [What they do now]
- **Evidence**: [Source/research]

## Moment 2: ...
```

### Step 2: Find How Brand Matters in Those Moments (IA)

**Deliverable:** Problem-Solution Matrix

**Activities:**
- For each moment, identify genuine problems
- Assess if brand can deliver "noticeably superior" solution
- Map pain points to potential brand benefits
- Prioritize by impact and feasibility

**Output:**
```markdown
# Problem-Solution Matrix: [Moment]

## Problem 1: [Pain point]
- **Current Workaround**: [What consumers do now]
- **Unmet Need**: [What's missing]
- **Brand Opportunity**: [How brand solves this]
- **Superiority Proof**: [Why noticeably better]
- **Confidence**: [High/Medium/Low]

## Problem 2: ...
```

### Step 3: Find the Brand Idea That Makes Moments Matter More (SL)

**Deliverable:** Brand Insight

**Activities:**
- Connect problem-solving insight to emotional outcome
- Synthesize logic (superiority) + feeling (emotional benefit)
- Craft insight statement that creates "chills/goosebumps"
- Validate distinctively human appeal

**Output:**
```markdown
# Brand Insight: [Concept Name]

## The Insight
[One powerful sentence that connects moment → problem → emotional resolution]

## The Logic (Left Brain)
- **Problem Solved**: [Functional benefit]
- **Superiority**: [Why noticeably better]
- **Proof Points**: [Evidence]

## The Feeling (Right Brain)
- **Emotional Benefit**: [How consumer feels]
- **Human Truth**: [Universal insight]
- **Goosebumps Test**: [Why this resonates]

## The Idea
[Brand idea that brings logic + feeling together]

## Validation
- [ ] Solves genuine problem
- [ ] Noticeably superior
- [ ] Creates emotional response
- [ ] Distinctly human appeal
```

---

## Process Improvement (IM's Responsibility)

### During Research: Log Issues (Don't Stop)

**Watch for:**
- Client frustration or confusion
- Same mistake occurring multiple times
- Instructions being repeated
- Process friction or confusion

**When detected:**
1. Acknowledge briefly: "Noted, I'll log this."
2. Log to `im/IMPROVEMENT_BACKLOG.md` (Observed section)
3. **Continue with current work** - don't stop
4. Address at research-end retrospective

### At Research End: Retrospective

**Quick Check First:**
- If nothing significant: 5-10 min retro, continue as-is
- If issues exist: Full retrospective

**Full Retrospective:**
1. IM reviews `im/IMPROVEMENT_BACKLOG.md`
2. Team discusses each observation briefly
3. **Pick 1-2 action items** (focus over completeness)
4. IM updates prompts **only if issue recurring** (2-3 projects)
5. IM documents in `im/RETROSPECTIVE_LOG.md`
6. IM verifies active improvement at next project start

### Prompt Hygiene

**Only update prompts when truly needed:**
- Add only after 2-3 projects of recurring issues
- Remove when behavior is learned (3+ projects, no issues)
- Goal: Prompts should "work themselves out of a job"

### Monitoring & Enforcement (4 Checkpoints)

| Checkpoint | When | IM Action |
|------------|------|-----------|
| 1. Announce | Project Start | Broadcast active improvement to ALL roles via tm-send |
| 2. Spot Check | During Research | Watch for situations, remind if forgotten, log evidence |
| 3. Verify | Project End | Count compliance vs reminders, determine status |
| 4. Enforce | After 2-3 projects | Add to prompt if effective (permanent behavior) |

---

## Communication Protocol

### Use tm-send for ALL Tmux Communication

```bash
# Correct - use tm-send with role name
tm-send IM "MR -> IM: Moments map complete. 5 key moments identified."

# Forbidden - never use raw tmux send-keys
tmux send-keys -t %16 "message" C-m C-m  # NEVER!
```

**Why?** `tmux send-keys` fails silently when agents forget the second enter. `tm-send` handles this automatically and resolves role names to pane IDs.

### Pane ID Management

Role→pane mapping is **dynamic** via tmux `@role_name` pane options:

- `setup-team.sh` sets `@role_name` on each pane during initialization
- `tm-send` (global tool at ~/.local/bin/tm-send) queries tmux directly
- Use role names (IM, MR, IA, SL, QR), not hardcoded pane IDs
- No static file needed - tmux is the single source of truth

---

## Role Boundaries

| Role | Can Do | Cannot Do |
|------|--------|-----------|
| IM | Coordinate, delegate, verify, client liaison, **own process improvement** | Conduct research, analyze insights |
| MR | Ethnographic research, moment discovery, primary data | Problem mapping, brand strategy |
| IA | Problem analysis, solution mapping, pain point identification | Moments research, brand ideas |
| SL | Brand idea synthesis, emotional connection, strategy | Primary research, problem analysis |
| QR | Review insights, validate quality, approve/reject | Conduct research, write deliverables |

**IM is a COORDINATOR, not a researcher.** Even for "quick lookups" - always delegate.

---

## Quality Standards

### Insight Quality (QR Validates)

| Criterion | Standard |
|-----------|----------|
| Human-centric | Based on real consumer behavior, not assumptions |
| Problem clarity | Specific, actionable pain point identified |
| Superiority | Noticeably better than current alternatives |
| Emotional resonance | Creates genuine emotional response |
| Actionability | Clear path from insight to brand action |

### Research Quality (QR Validates)

| Criterion | Standard |
|-----------|----------|
| Recency | Data within 12 months |
| Source credibility | Primary research or reputable secondary |
| Multiple perspectives | 3+ consumer viewpoints for key moments |
| Context richness | Environment, emotions, behaviors captured |

---

## Event-Based Sync Points

AI teams don't need scheduled check-ins. Use event-based triggers:

| Event | Who Syncs | Purpose |
|-------|-----------|---------|
| Project Start | IM → All | Broadcast brief, active improvement |
| Moments Map Complete | MR → IM | Review before problem analysis |
| Problem-Solution Complete | IA → IM | Review before brand synthesis |
| Brand Insight Draft | SL → QR | Quality review before client |
| Blocker Hit | Anyone → IM | Get help, route to right person |
| Project Complete | IM → All | Retrospective |

---

## Deliverable Templates

### Consumer Insight Brief (Final Deliverable)

```markdown
# Consumer Insight Brief: [Project Name]

## Executive Summary
[One paragraph: key moment, core problem, brand insight]

## The Moment That Matters
[Description of the everyday moment from Step 1]
- Consumer segment
- Context and environment
- Emotional state

## The Problem Worth Solving
[From Step 2]
- Pain point description
- Current workarounds
- Unmet need

## The Brand Insight
[From Step 3]
- Insight statement
- Logic (superiority)
- Feeling (emotional benefit)
- Brand idea

## Validation
- Goosebumps test: [Yes/No + evidence]
- Consumer resonance: [Evidence]
- Brand fit: [Why this works for brand]

## Recommendations
1. [Action 1]
2. [Action 2]
3. [Action 3]

## Sources
[Research sources and evidence]
```

---

## Common Mistakes to Avoid

| Mistake | Correct Approach |
|---------|------------------|
| Using `tmux send-keys` | Use `tm-send ROLE "message"` (handles two-enter rule) |
| Starting with brand, not consumer | Start with moments, let insight emerge |
| Skipping emotional validation | Always test for "goosebumps" response |
| Generic insights | Ensure distinctly human, specific moments |
| Logic without emotion | Connect functional benefit to feeling |
| Stopping work when issue detected | Log to im/IMPROVEMENT_BACKLOG.md, continue working |

---

## Collaboration Artifacts

### WHITEBOARD
**Location:** `WHITEBOARD.md`
- Current project status only
- Clear after Client accepts deliverable
- Not a progress tracker

### Project Directory
**Location:** `projects/project_{N}/`
- Consumer brief, moments map
- Problem-solution matrix
- Brand insight deliverable

### IM's Improvement Docs
**Location:** `im/`
- `IMPROVEMENT_BACKLOG.md` - Process issues to address
- `RETROSPECTIVE_LOG.md` - Historical lessons
- `ACTION_ITEMS.md` - Track improvement actions

---

## Files in This Directory

```
pg-insights-team/
├── workflow.md    # This file
├── WHITEBOARD.md            # Current project status
├── setup-team.sh            # Automated setup (sets @role_name on panes)
├── im/                      # IM's workspace
│   ├── IMPROVEMENT_BACKLOG.md  # Process issues (log during work)
│   ├── RETROSPECTIVE_LOG.md    # Historical lessons
│   └── ACTION_ITEMS.md         # Improvement tracking
└── prompts/
    ├── IM_PROMPT.md         # Insights Manager
    ├── MR_PROMPT.md         # Moments Researcher
    ├── IA_PROMPT.md         # Insight Analyst
    ├── SL_PROMPT.md         # Strategy Lead
    └── QR_PROMPT.md         # Quality Reviewer

# Note: Role→pane mapping is dynamic via tmux @role_name options
# Note: tm-send is a global tool at ~/.local/bin/tm-send (not project-specific)
```

---

## System is Ready

All agents are briefed. When Client provides the research brief to IM, the project begins.

**Team: Execute Three-Step Formula. IM runs retrospective after Client accepts deliverable.**
