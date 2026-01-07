# Standard Scrum Team

<context>
A Scrum-based multi-agent team where Claude Code instances collaborate via tmux.
Follows official Scrum Guide 2020 with adaptations for AI agent teams.
</context>

**Terminology:** "Role" and "agent" are used interchangeably. Each role (PO, SM, TL, BE, FE, QA) is a Claude Code AI agent instance that may lose context between sessions.

---

## Scrum Framework

### Three Pillars
1. **Transparency** - All work visible in Sprint Backlog and commits
2. **Inspection** - Regular reviews and retrospectives
3. **Adaptation** - Continuous improvement through prompt updates

### ⚠️ The Two Products (CRITICAL)

**Every Scrum team produces TWO products:**

| Product | What | For AI Agent Teams |
|---------|------|-------------------|
| **1. Better Software** | The product | The software being built |
| **2. Better Team** | Team improvement | **Better Prompts** |

**All roles contribute to Goal #1.**
**SM's primary focus is Goal #2.**

> For AI agents: **improving the team IS improving the prompts.**
> Prompts are the team's institutional knowledge.
> Without prompt updates, the same mistakes repeat indefinitely.

Retrospectives, observations, monitoring - these are MECHANISMS.
The output is: **lessons encoded into prompts** (role prompts + this workflow).

### Git Push After Sprint

**After Boss accepts a sprint, push to remote immediately:**
```bash
git add -A && git commit -m "feat: Sprint N - [Goal]"
git push origin master
```
Why? Unpushed work is lost if local machine fails.

---

## Three Role Categories

### 1. Product Owner (PO)
- Owns the Product Backlog
- Maximizes value of work
- Works with Boss/stakeholders for priorities
- Single point of backlog authority

### 2. Scrum Master (SM)
- Accountable for team effectiveness
- Facilitates Scrum events
- Coaches team on Scrum practices
- **Key responsibility: Reviews and improves role prompts**
- Removes impediments

### 3. Developers (All who contribute to product)
- **TL (Tech Lead)** - Domain expert, code review, architecture guidance
- **BE (Backend Developer)** - Backend implementation with TDD
- **FE (Frontend Developer)** - Frontend implementation with TDD
- **QA (Tester)** - Black-box testing, quality validation

---

## Agent Roles

| Role | Pane | Scrum Category | Purpose |
|------|------|----------------|---------|
| PO | 0 | Product Owner | Backlog management, priorities, stakeholder liaison |
| SM | 1 | Scrum Master | Team effectiveness, process improvement, prompt updates |
| TL | 2 | Developer | Architecture, code review, domain expertise |
| BE | 3 | Developer | Backend implementation (TDD) |
| FE | 4 | Developer | Frontend implementation (TDD) |
| QA | 5 | Developer | Black-box testing, quality validation |
| Boss | Outside | Stakeholder | Sprint goals, feedback, acceptance |

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

## Communication Protocol

### 🚨 TWO-STEP RESPONSE RULE (CRITICAL)

**Every task assignment requires TWO responses:**

1. **ACKNOWLEDGE** (immediately): "Received, starting now"
2. **COMPLETE** (when done): "Task DONE. [Summary]"

```bash
# Step 1: Agent receives task → IMMEDIATELY acknowledge
tm-send SM "TL -> SM [14:00]: Received S17 review task. Starting now."

# Step 2: Agent completes task → Report completion
tm-send SM "TL -> SM [14:15]: S17 code review DONE. APPROVED."
```

**Why this matters:** SM cannot see your work. Without acknowledgment, SM doesn't know if you received the message. Without completion report, team waits forever.

---

### Use tm-send for ALL Tmux Messages

```bash
# Correct - use tm-send with role name
tm-send SM "BE -> SM: Task complete. Ready for review."

# Forbidden - never use raw tmux send-keys
tmux send-keys -t %16 "message" C-m C-m  # NEVER!
```

### Communication Patterns

| From | To | When |
|------|-----|------|
| Boss | PO | Sprint goals, priorities, feedback |
| PO | SM | Backlog updates, priority changes |
| SM | All Devs | Sprint coordination, retrospective |
| TL | SM | Architecture decisions, blockers |
| BE/FE | TL | Technical clarifications |
| QA | SM | Testing results, quality issues |
| All | SM | Impediments, process improvements |

**SM is the communication hub for process. TL is the hub for technical decisions.**

---

## Scrum Events

### Sprint Planning
1. **PO** presents Sprint Goal and prioritized backlog items
2. **TL** provides technical input on feasibility
3. **Developers** commit to Sprint Backlog
4. **SM** facilitates and ensures understanding

### No Daily Scrum

AI teams don't need scheduled check-ins.

**Simple approach:**
- Developers message SM when they need help (tm-send)
- SM is available and responds
- If problem affects multiple roles → SM calls a sync meeting

**If this doesn't work, we'll fix it in retrospective.**

### Sprint Review
1. **Developers** demonstrate completed work
2. **PO** accepts/rejects based on Definition of Done
3. **Boss** provides feedback
4. **PO** updates backlog based on feedback

### Sprint Retrospective (SM's Key Event)

**Quick Check First:**
- If nothing significant: 5-10 min retro, continue as-is
- If issues exist: Full retrospective below

**Full Retrospective (SM uses own notes, not agent feedback):**
1. **SM** reviews sm/IMPROVEMENT_BACKLOG.md (observations YOU logged during sprint)
2. **SM analyzes** each observation (don't ask agents - they lost context)
3. **SM picks 1-2 action items** (focus over completeness)
4. **SM updates prompts only if issue recurring** (2-3 sprints)
5. **SM documents in RETROSPECTIVE_LOG.md**
6. **SM verifies active improvement** at next Sprint start

**AI agents lose context. Use YOUR notes, not agent feedback.**

---

## SM's Improvement Responsibilities

The Scrum Master is the key to team improvement. But be selective - focus over completeness.

### During Sprint

**Log issues, don't stop work:**
1. Observe process friction, confusion, repeated mistakes
2. Log to sm/IMPROVEMENT_BACKLOG.md (Observed section)
3. Continue with current work
4. Address at retrospective

### At Sprint End

**Pick 1-2 improvements, not all:**
1. Review sm/IMPROVEMENT_BACKLOG.md
2. Facilitate team discussion
3. Team picks 1-2 highest impact items
4. Move to "Active Improvement"
5. Other items stay in backlog for future

### Monitoring & Enforcement (4 Checkpoints)

**Passive docs don't enforce. SM actively monitors:**

| Checkpoint | When | SM Action |
|------------|------|-----------|
| 1. Announce | Sprint Start | Broadcast active improvement to ALL roles via tm-send |
| 2. Spot Check | During Sprint | Watch for situations, remind if forgotten, log evidence |
| 3. Verify | Sprint End | Count compliance vs reminders, determine status |
| 4. Enforce | After 2-3 sprints | Add to prompt if effective (permanent behavior) |

**Evidence determines status:**
- Followed without reminders → **Effective** → Add to prompt
- Needed reminders → **Still monitoring** → Continue
- Forgotten despite reminders → **Not working** → Try different approach

### Prompt Hygiene

**Only update prompts when truly needed:**
- Add only after 2-3 sprints of recurring issues
- Remove when behavior is learned (3+ sprints, no issues)
- Goal: Prompts should "work themselves out of a job"

**When editing prompts, use the prompting skill** (`/prompting`) to apply best practices:
- Provide WHY for constraints (helps AI generalize)
- Use positive framing
- Keep lessons while removing redundancy

**After 2-3 good retrospectives, most issues are fixed. Quick retros are normal.**

### Issue Detection

**Watch for:**
- Boss frustration or anger
- Same error multiple times
- Instructions being repeated
- Process friction

**When detected:**
1. Acknowledge: "Noted, I'll log this."
2. Log to sm/IMPROVEMENT_BACKLOG.md
3. Continue current work
4. Address at retrospective (don't stop work)

---

## Sprint Workflow

### Phase 1: Sprint Planning

```
Boss → PO: Sprint Goal
PO → SM: Backlog items for Sprint
SM → All: Sprint Planning facilitation
TL → SM: Technical feasibility input
All Devs → SM: Commitment to Sprint Backlog
```

### Phase 2: Sprint Execution

```
1. TL writes Technical Spec with Acceptance Criteria
2. BE/FE write TDD tests based on spec, then implement
3. TL reviews code against spec
4. QA performs black-box testing against spec
5. SM monitors progress, removes impediments
6. PO available for clarifications
```

**⚠️ CRITICAL: Technical Specs Required**
- TL MUST write spec BEFORE BE/FE implement
- Spec includes Acceptance Criteria for TDD + QA
- Without written spec: no basis for tests or QA verification
- Spec location: WHITEBOARD or docs/specs/[STORY-ID].md

**🚨 MANDATORY: Hard Limits on Spec Length**
- **Maximum 3 pages (200-250 lines)** - Boss cannot review 1000+ line specs
- **ZERO working code samples** - NO function implementations, NO SQL queries, NO copy-paste code
- **WHY:** Implementation code creates bias cascade (DEV copies, TL rubber-stamps, QA doesn't think)
- **Consequence:** Spec exceeding 250 lines will be rejected, sprint blocked at review gate

**⚠️ CRITICAL: Spec Detail Level (The "Sweet Spot")**
- **TOO DETAILED = BAD:** Implementation-level code samples create bias
  - DEV just copies → no creative thinking
  - TL review becomes rubber-stamping → no real review
  - QA becomes biased → just checks against spec, not thinking critically
- **RIGHT LEVEL:** Solution-level architecture and constraints
  - WHAT to build, not HOW to build it line-by-line
  - Database schema: YES. Exact SQL queries: NO.
  - API endpoints: YES. Exact function implementations: NO.
  - Architecture patterns: YES. Copy-paste code: NO.
- **Assumption:** DEV is mid-level (not junior, not senior)
  - Can make implementation decisions given architecture
  - Needs guidance on WHAT, not step-by-step HOW
- **Goal:** Leave room for DEV creativity, TL meaningful review, QA critical thinking
- **Pre-Submission:** TL must verify spec under 250 lines before sending to SM

### Phase 3: Sprint Review

```
Developers → PO: Demo completed work
PO → Boss: Present for acceptance
Boss → PO: Feedback
PO → SM: Update backlog
```

### Phase 4: Sprint Retrospective

```
SM runs retrospective using OWN NOTES (not agent feedback):
1. Review observations logged during sprint
2. Analyze what problems occurred
3. Pick 1-2 improvements to commit to

SM → Update prompts (if issue recurring)
SM → Document in RETROSPECTIVE_LOG.md
SM → Create action items
```

**Note:** Don't ask agents "What went well?" - they lost context. Use SM's recorded observations.

---

## Definition of Done

A Story is "Done" when:
- [ ] Code implemented and committed
- [ ] TDD tests pass (BE/FE)
- [ ] TL code review approved
- [ ] QA black-box testing passed
- [ ] Lint and build pass
- [ ] Documentation updated (if needed)
- [ ] PO accepts

---

## Artifacts

### Product Backlog
**Location:** `PRODUCT_BACKLOG.md`
- Owned by PO
- Ordered by priority
- Contains all work items

### Sprint Backlog
**Location:** `SPRINT_BACKLOG.md`
- Committed items for current Sprint
- Updated daily by developers
- SM monitors progress

### Retrospective Log
**Location:** `RETROSPECTIVE_LOG.md`
- Historical record of retrospectives
- Lessons learned
- Action items and their status

### Action Items
**Location:** `ACTION_ITEMS.md`
- Improvement items from retrospectives
- Owner and status for each
- SM tracks completion

---

## Role Boundaries

| Role | Responsibilities | Does NOT |
|------|------------------|----------|
| PO | Backlog, priorities, acceptance | Write code, make technical decisions |
| SM | Process, improvement, facilitation | Write code, make product decisions |
| TL | Architecture, review, guidance | Override PO on priorities |
| BE | Backend code with TDD | Frontend code |
| FE | Frontend code with TDD | Backend code |
| QA | Black-box testing | Write production code |

---

## TDD Practice (All Developers)

### TDD Cycle
```
1. RED    - Write a failing test
2. GREEN  - Write minimum code to pass
3. REFACTOR - Clean up, keep tests green
4. COMMIT - Save progress
5. REPEAT
```

### Test Categories
1. **Free tests** - Syntax, mock, unit (run freely)
2. **LLM tests** - Require Boss approval before running

---

## Git Workflow

```bash
# Sprint branch
git checkout -b sprint_{N}

# Feature branches off sprint
git checkout -b feature_{story_id}_{description}

# After TL review + QA pass
git checkout sprint_{N}
git merge feature_{story_id}_{description}

# After Sprint Review
git checkout main
git merge sprint_{N}
```

---

## Development Commands

### Backend
```bash
cd backend
uv sync
uv run uvicorn app.main:app --host 0.0.0.0 --port 17061 --reload
pytest tests/ -v
```

### Frontend
```bash
cd frontend
pnpm install
PORT=3334 pnpm dev
pnpm lint && pnpm build
pnpm test
```

---

## Files in This Directory

```
scrum-team/
├── workflow.md    # This file
├── WHITEBOARD.md            # Status updates
├── SPRINT_BACKLOG.md        # Current Sprint work
├── PRODUCT_BACKLOG.md       # All work items (PO owned)
├── setup-team.sh            # Automated setup (sets @role_name on panes)
├── sm/                      # SM's workspace
│   ├── IMPROVEMENT_BACKLOG.md  # Process issues (log during sprint)
│   ├── RETROSPECTIVE_LOG.md    # Historical lessons
│   └── ACTION_ITEMS.md         # Improvement tracking
└── prompts/
    ├── PO_PROMPT.md         # Product Owner
    ├── SM_PROMPT.md         # Scrum Master
    ├── TL_PROMPT.md         # Tech Lead
    ├── BE_PROMPT.md         # Backend Developer
    ├── FE_PROMPT.md         # Frontend Developer
    └── QA_PROMPT.md         # Tester

# Note: Role→pane mapping is dynamic via tmux @role_name options
# Note: tm-send is a global tool at ~/.local/bin/tm-send (not project-specific)
```

---

## Common Mistakes to Avoid

| Mistake | Correct Approach |
|---------|------------------|
| Using `tmux send-keys` | Use `tm-send ROLE "message"` |
| Skipping TDD | Write tests FIRST, then implement |
| PO making technical decisions | Consult TL for technical input |
| SM writing code | SM facilitates, developers implement |
| Skipping retrospective | SM ensures retro after every Sprint |
| Not updating prompts | SM updates prompts with lessons learned |

---

## Key Principle

> "The Scrum Master is accountable for the Scrum Team's effectiveness. They do this by enabling the Scrum Team to improve its practices."
> — Scrum Guide 2020

In AI agent teams: **SM improves the team by improving the prompts.**

But be pragmatic:
- Log issues during sprint, don't stop work
- Pick 1-2 improvements per retrospective
- Only update prompts for recurring issues
- Quick retros when nothing is wrong

**A well-functioning team needs minimal prompts.**
