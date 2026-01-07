#!/usr/bin/env python3
"""
PostToolUse hook to detect the FIRST TodoWrite call for each new task.
Triggers reminder to recall relevant memories when a new task is started.

Detection logic:
1. Check if oldTodos is empty (indicates first call)
2. Cooldown disabled to support tmux multi-session workflow

Note: We don't check todo status because Claude often creates first todos
with "in_progress" status. Empty oldTodos is the reliable first-call indicator.
"""
import json
import sys
from pathlib import Path
from datetime import datetime, timedelta

# Configuration
COOLDOWN_MINUTES = -1  # Disabled for tmux multi-session workflow
STATE_FILE = Path.home() / ".claude" / "todowrite_first_call_state.json"


def load_state():
    """Load hook state from file."""
    if not STATE_FILE.exists():
        return {"last_trigger": None}

    try:
        with open(STATE_FILE, 'r') as f:
            return json.load(f)
    except Exception:
        return {"last_trigger": None}


def save_state(state):
    """Save hook state to file."""
    try:
        STATE_FILE.parent.mkdir(parents=True, exist_ok=True)
        with open(STATE_FILE, 'w') as f:
            json.dump(state, f, indent=2)
    except Exception as e:
        print(f"Warning: Could not save state: {e}", file=sys.stderr)


def is_within_cooldown(state):
    """Check if we're within the cooldown period."""
    if COOLDOWN_MINUTES < 0:
        return False  # Cooldown disabled, always allow reminder
    if not state.get("last_trigger"):
        return False

    last_trigger = datetime.fromisoformat(state["last_trigger"])
    cooldown_end = last_trigger + timedelta(minutes=COOLDOWN_MINUTES)

    return datetime.now() < cooldown_end


def is_first_call(tool_input, tool_response):
    """
    Detect if this is the first TodoWrite call for a new task.

    Returns: (is_first, reason)
    """
    # Check if oldTodos is empty (reliable first-call indicator)
    old_todos = tool_response.get("oldTodos", [])
    if len(old_todos) > 0:
        return False, "oldTodos not empty - this is an update"

    # Verify we have at least one todo
    todos = tool_input.get("todos", [])
    if not todos:
        return False, "No todos provided"

    # oldTodos is empty and we have todos - this is a first call!
    return True, f"First call detected: oldTodos empty, {len(todos)} todos created"


def main():
    try:
        # Load input from stdin
        input_data = json.load(sys.stdin)

        # Extract tool data
        tool_input = input_data.get("tool_input", {})
        tool_response = input_data.get("tool_response", {})

        # Load hook state
        state = load_state()

        # Check if this is a first call
        is_first, reason = is_first_call(tool_input, tool_response)

        if not is_first:
            # Not a first call - allow normal execution
            print(f"[DEBUG] Not first call: {reason}", file=sys.stderr)
            sys.exit(0)

        # Check cooldown
        if is_within_cooldown(state):
            print(f"[DEBUG] First call detected but within {COOLDOWN_MINUTES}-minute cooldown", file=sys.stderr)
            sys.exit(0)

        # This is a first call and cooldown has passed!
        # Record this trigger
        state["last_trigger"] = datetime.now().isoformat()
        save_state(state)

        # Provide feedback to Claude
        output = {
            "decision": "block",
            "reason": "Call coder-memory-recall skill to recall relevant memories for this task",
            "hookSpecificOutput": {
                "hookEventName": "PostToolUse",
                "additionalContext": f"Task started with {len(tool_input.get('todos', []))} todos"
            }
        }
        print(json.dumps(output))
        sys.exit(0)

    except Exception as e:
        # On any error, don't block execution
        print(f"Error in todowrite first-call hook: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
