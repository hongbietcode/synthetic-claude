# Scrum Minimal Team - Workflow

## Overview

A 3-person Scrum team optimized for small projects or solo developers who want Scrum structure without the overhead.

| Role | Pane | Model | Responsibility |
|------|------|-------|----------------|
| PO | 0 | Sonnet | Product backlog, priorities |
| SM | 1 | Opus | Process, facilitation, improvement |
| EX | 2 | Opus | Architecture + Development + QA |

---

## When to Use

- Small projects with 1 developer
- MVPs and prototypes
- Personal projects wanting Scrum structure
- When 6-person team is overkill

---

## Sprint Workflow

### 1. Sprint Planning

```
Boss → PO: "Here's what we need to build"
PO → SM: "Sprint goal is X, here are the items"
SM → EX: "Here's the sprint backlog, any questions?"
EX → SM: "Clear, starting work"
```

### 2. During Sprint

```
EX: Works on tasks
EX → SM: "Task X complete" (update WHITEBOARD)
EX → SM: "Blocked on Y" (if blocked)
SM: Removes blockers, updates status
PO: Answers requirement questions
```

### 3. Sprint Review

```
EX → SM: "All tasks complete"
SM → PO: "Ready for review"
PO: Accepts/rejects work
SM: Updates WHITEBOARD
```

### 4. Retrospective

```
SM: Gathers feedback from PO and EX
SM: Logs to RETROSPECTIVE_LOG.md
SM: Selects 1-2 improvements for next sprint
```

---

## Communication Commands

```bash
# PO to SM
tm-send SM "PO [HH:mm]: Backlog updated, ready for planning"

# SM to EX
tm-send EX "SM [HH:mm]: Sprint started, see SPRINT_BACKLOG"

# EX to SM
tm-send SM "EX [HH:mm]: Feature X complete, running tests"

# EX to PO
tm-send PO "EX [HH:mm]: Question about requirement Y"
```

---

## Files

| File | Owner | Purpose |
|------|-------|---------|
| WHITEBOARD.md | SM | Current status |
| PRODUCT_BACKLOG.md | PO | All backlog items |
| SPRINT_BACKLOG.md | SM | Current sprint items |
| sm/IMPROVEMENT_BACKLOG.md | SM | Process improvements |
| sm/RETROSPECTIVE_LOG.md | SM | Sprint retrospectives |

---

## Setup

```bash
cd /path/to/project
SESSION_NAME=scrum_minimal ./setup-team.sh
```

---

## Comparison with Full Scrum Team

| Aspect | Minimal (3) | Full (6) |
|--------|-------------|----------|
| Roles | PO, SM, EX | PO, SM, TL, BE, FE, QA |
| Overhead | Low | Higher |
| Specialization | None | Role-specific |
| Communication | Simple | More complex |
| Best for | Small projects | Large projects |
