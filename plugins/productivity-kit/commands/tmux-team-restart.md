---
description: Restart tmux team with state preservation via SM
allowed-tools: Read, Glob, Grep, Bash(tm-send:*), Bash(tmux:*), Bash(sleep:*), Bash(./setup-team.sh), Bash(bash:*)
---

> **NOTE**: Do NOT call coder-memory-recall for this command - this is a well-documented process with all steps below. Just execute the steps.

# Tmux Team Restart Process

Restart the tmux team session while preserving current progress state.

## Execution Steps

### Step 1: Find team tmux session name

Find the `setup-team.sh` script and extract the session name:
```bash
# Find setup-team.sh in the project
find . -name "setup-team.sh" -type f 2>/dev/null | head -1

# Extract SESSION_NAME from the script
grep -E "^SESSION_NAME=" ./path/to/setup-team.sh | cut -d'=' -f2 | tr -d '"' | tr -d "'"
```

**Note**: Session name is typically defined in `setup-team.sh` with format `SESSION_NAME=session_name` or `SESSION_NAME=${SESSION_NAME:-session_name}`.

Verify the session exists:
```bash
tmux has-session -t SESSION_NAME 2>/dev/null && echo "Session found"
```

You can also list all active tmux sessions with roles dynamically:
```bash
tmux list-sessions
tmux list-panes -a -F '#{session_name}:#{pane_index} #{@role_name}'
```

### Step 2: Tell SM to check all roles for unreported progress

Send message to SM using tm-send (use `-s` flag for explicit session):
```bash
tm-send -s SESSION_NAME SM "BOSS -> SM: TEAM RESTART INITIATED. Check ALL roles (PO, TL, BE, FE, QA, etc.) for any unreported work-in-progress. Capture everything before session restart. Report back when done with: (1) List of roles checked, (2) Summary of unreported progress found, (3) Timestamp showing check complete."
```

Wait in 15s loop until SM confirms done:
```bash
# Wait loop - check WHITEBOARD.md modification time or SM response every 15s
# Continue when SM reports completion
sleep 15
```

### Step 3: Tell SM to update WHITEBOARD with all current status

```bash
tm-send -s SESSION_NAME SM "BOSS -> SM: Now update WHITEBOARD.md with complete status: (1) Current sprint progress, (2) All in-progress tasks from each role, (3) Any blockers or key decisions, (4) Next steps for resumption. Reply 'WHITEBOARD UPDATED [timestamp]' when done."
```

Wait in 15s loop until SM confirms WHITEBOARD is updated.

### Step 4: Kill tmux session

```bash
tmux kill-session -t SESSION_NAME
```

### Step 5: Understand team structure

Use dynamic tmux queries to understand the team structure:
```bash
# List all panes with their roles in the session
tmux list-panes -t SESSION_NAME -F '#{pane_index} #{@role_name}'

# Or read workflow.md if it exists
find ./docs/tmux/*/workflow.md -type f 2>/dev/null | head -1
```

**Note**: Role information is stored in tmux pane options (`@role_name`), not in static files. Always query tmux directly for current state.

### Step 6: Run setup-team.sh

```bash
cd /path/to/team/folder && ./setup-team.sh
```

Wait for all panes to initialize (script handles its own delays).

### Step 7: Tell PO to read WHITEBOARD and resume

```bash
tm-send -s SESSION_NAME PO "BOSS -> PO: Team restarted successfully. Read WHITEBOARD.md for current sprint status and all in-progress work. Coordinate with SM and other roles to resume from where we left off. Continue Sprint execution."
```

## Important Notes

- The 15s sleep loop is critical - don't proceed until SM confirms each step
- Session name comes from `setup-team.sh` in the team folder (look for `SESSION_NAME=`)
- WHITEBOARD.md must contain complete state before killing session
- After restart, PO drives resumption based on WHITEBOARD
- **Use tm-send with `-s SESSION_NAME` flag** if auto-detection fails (e.g., `tm-send -s quiz_game SM "message"`)

## ⚠️ CRITICAL BUG WARNING: Pane Detection

**THE BUG**: When determining which tmux pane you're running in, **NEVER use `tmux display-message -p '#{pane_index}'`** - this returns the **ACTIVE/FOCUSED pane** (where user's cursor is), NOT the pane where Claude is actually running.

**THE FIX**: Always use the `$TMUX_PANE` environment variable:

```bash
# WRONG - Returns active pane, not your pane
tmux display-message -p '#{pane_index}'

# CORRECT - Returns YOUR pane
echo $TMUX_PANE
# Then look up this pane ID in the pane list to get role
tmux list-panes -a -F '#{pane_id} #{pane_index} #{@role_name}' | grep $TMUX_PANE
```

**WHY THIS MATTERS**:
- In multi-agent teams, each pane has a role (PO, SM, TL, DEV, QA, etc.)
- Messages must route correctly based on the pane's assigned role
- If you misidentify your pane, you'll send messages to wrong agents
- This wastes hours debugging "why is PO acting like DEV?"

**WHEN CRITICAL**: During Step 7 (role initialization after restart), new Claude instances MUST use `$TMUX_PANE` to identify which pane they're in, NOT the active cursor position.

## Dynamic Queries (No Static Files)

**CRITICAL**: PANE_ROLES.md and tmux_team_overview.md are DEPRECATED and removed from all frameworks.

Always use dynamic tmux queries:
```bash
# Find all sessions
tmux list-sessions

# Find panes with roles in a specific session
tmux list-panes -t SESSION_NAME -F '#{session_name}:#{pane_index} #{@role_name}'

# List all panes across all sessions
tmux list-panes -a -F '#{session_name}:#{pane_index} #{@role_name}'

# Check if session exists
tmux has-session -t SESSION_NAME 2>/dev/null && echo "Exists"
```

The `@role_name` pane option is set by setup scripts and queried dynamically by tm-send.
