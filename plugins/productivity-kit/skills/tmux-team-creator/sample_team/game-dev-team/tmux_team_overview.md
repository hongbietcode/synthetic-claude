# Game Dev Team - Overview

> AI-powered game development team combining BMGD (BMAD Game Development) methodology with Scrum practices.

---

## Team Structure

```
+--------+--------+--------+--------+--------+
| DS     | SM     | AR     | DV     | QA     |
| Pane 0 | Pane 1 | Pane 2 | Pane 3 | Pane 4 |
+--------+--------+--------+--------+--------+
```

| Role | Name | Responsibility |
|------|------|----------------|
| DS | Game Designer | Mechanics, GDD, player experience |
| SM | Scrum Master | Process, sprints, improvement |
| AR | Game Architect | Engine selection, architecture, 60fps |
| DV | Game Developer | Implementation, TDD, optimization |
| QA | Game QA | Testing, playtesting, profiling |

---

## Development Flow

```
DS (Design) → AR (Architecture) → DV (Implementation) → QA (Testing) → Acceptance
```

### Phase 1: Design (DS)
- Create Game Brief (vision, pillars, core loop)
- Create GDD (mechanics, systems, content)
- Design from player experience first

### Phase 2: Architecture (AR)
- Select engine (Unity/Unreal/Godot)
- Plan systems architecture
- Define performance budgets (60fps target)

### Phase 3: Implementation (DV)
- Implement Sprint stories
- Follow TDD (Red → Green → Refactor)
- Meet frame budget

### Phase 4: Testing (QA)
- Automated tests (unit, integration)
- Playtest sessions
- Performance profiling

---

## Core Principles

1. **60fps is non-negotiable** - Performance is a feature
2. **Playable increments** - Every Sprint delivers playable build
3. **Design from feel** - Start with player emotion
4. **TDD approach** - Tests first, implementation second
5. **Profile before optimize** - Data-driven decisions

---

## Communication

### tm-send Command

All inter-agent communication uses `tm-send`:

```bash
tm-send [ROLE] "FROM -> TO: message"
```

Examples:
```bash
tm-send SM "DV -> SM: Story #3 complete."
tm-send AR "DS -> AR: Need feasibility check."
tm-send DV "SM -> DV: Start Story #4."
```

### Message Format

```
[ROLE] [HH:mm]: message
```

Example:
```
DV [14:30]: Story complete. Tests passing. 60fps stable.
```

---

## Game Engines Supported

| Engine | Testing Framework | Best For |
|--------|------------------|----------|
| Unity | Unity Test Framework | Mobile, 2D, Indie |
| Unreal | Automation System | AAA, FPS, Large scale |
| Godot | GUT Framework | 2D, Small teams, Open source |

---

## Sprint Events

### Sprint Planning
1. DS presents design scope
2. AR confirms feasibility
3. DV estimates stories
4. Team commits to Sprint Backlog

### No Daily Scrum
AI teams message SM when blocked. No scheduled check-ins.

### Sprint Review
- Demo playable build
- Gather player feedback
- Update backlog

### Retrospective
- Quick check: any issues?
- Pick 1-2 improvements
- Update prompts only if recurring

---

## Key Files

| File | Purpose |
|------|---------|
| `prompts/*.md` | Role definitions |
| `WHITEBOARD.md` | Current Sprint status |
| `docs/game-brief.md` | Game vision and pillars |
| `docs/gdd.md` | Game Design Document |
| `docs/game-architecture.md` | Technical architecture |
| `sm/IMPROVEMENT_BACKLOG.md` | Process improvements |
| `sm/RETROSPECTIVE_LOG.md` | Sprint lessons |

---

## Getting Started

1. **DS creates Game Brief** - Vision, pillars, core loop
2. **DS creates GDD** - Detailed mechanics and systems
3. **AR plans architecture** - Engine, systems, performance
4. **SM runs Sprint Planning** - Break into stories
5. **DV implements** - TDD, meet frame budget
6. **QA tests** - Automated + playtest
7. **SM runs Retrospective** - Improve process

---

## Performance Targets

| Metric | Target |
|--------|--------|
| Frame rate | 60 FPS |
| Frame time | < 16.67ms |
| Memory | Platform dependent |
| Load times | < 5 seconds |

---

## Quick Reference

### tm-send Roles
- `DS` - Game Designer
- `SM` - Scrum Master
- `AR` - Game Architect
- `DV` - Game Developer
- `QA` - Game QA

### Key Commands
```bash
# Send message
tm-send SM "DV -> SM: Story complete."

# Check date
date +"%Y-%m-%d"

# Kill session
tmux kill-session -t game_dev_team
```
