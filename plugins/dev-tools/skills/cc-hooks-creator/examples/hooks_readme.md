# Global Claude Code Hooks

These hooks apply to **ALL projects**, not just a specific one.

## Installed Global Hooks

### 1. Memory Store Reminder (`memory_store_reminder.py`)
- **Event**: `Stop`
- **Purpose**: Reminds Claude to store learnings after completing tasks
- **Cooldown**: Disabled (set to 0 for tmux multi-session workflow)
- **Trigger**: When Claude finishes responding
- **Action**: Blocks with message: "Consider storing learnings from this task using memory-store agent if valuable patterns were discovered. Be EXTREMELY selective, don't store trivial patterns, only hard-earned lesson, especiallyfailure patterns."

**Safety Features:**
- 4 layers of infinite loop prevention
- Cooldown timer
- Session limit checks
- Transcript scanning for duplicate invocations

### 2. TodoWrite First Call Detector (`todowrite_first_call.py`)
- **Event**: `PostToolUse:TodoWrite`
- **Purpose**: Reminds Claude to recall memories when starting new tasks
- **Cooldown**: Disabled (set to 0 for tmux multi-session workflow)
- **Trigger**: When a new task is started (oldTodos is empty)
- **Action**: Blocks with message: "Call memory-recall agent to recall relevant memories for this task"

**Detection Logic:**
- Checks if `oldTodos` is empty (reliable first-call indicator)
- Status-agnostic: works with "pending" or "in_progress" todos
- Skips update calls (when oldTodos has content)

## Configuration Location

**Global Settings:** `~/.claude/settings.json`

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/memory_store_reminder.py",
            "timeout": 10
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "TodoWrite",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/todowrite_first_call.py",
            "timeout": 5
          }
        ]
      }
    ]
  }
}
```

## State Files

Both hooks maintain state in your home directory:

- `~/.claude/todowrite_first_call_state.json` - TodoWrite hook cooldown state
- `~/.claude/memory_store_hook_state.json` - Memory store hook state

## Adjusting Cooldown

Edit the Python files directly to change cooldown periods:

```python
# In todowrite_first_call.py
COOLDOWN_MINUTES = 0  # Currently disabled for tmux multi-session workflow

# In memory_store_reminder.py
COOLDOWN_MINUTES = 0  # Currently disabled for tmux multi-session workflow
```

**Note**: Cooldowns are currently disabled to prevent cross-session interference in the 3-agent tmux workflow. With cooldowns enabled, hooks would share state files across all sessions, causing only one session to receive reminders while others are silenced.

## Why Global?

These hooks support the **memory learning workflow** which should apply to all coding sessions:

1. **Start new task** → TodoWrite hook reminds to recall past learnings
2. **Work on task** → Apply recalled patterns
3. **Complete task** → Stop hook reminds to store new learnings
4. **Repeat** → Build knowledge over time

This automated workflow ensures consistent knowledge management across all projects.

## Testing

```bash
# Test TodoWrite hook
echo '{"tool_input": {"todos": [{"status": "pending"}]}, "tool_response": {"oldTodos": []}}' | ~/.claude/hooks/todowrite_first_call.py

# Test Memory Store hook
echo '{"session_id": "test", "stop_hook_active": false}' | ~/.claude/hooks/memory_store_reminder.py
```

## Disabling Temporarily

To disable hooks temporarily, remove or comment out the `"hooks"` section in `~/.claude/settings.json`.

## Original Source

These hooks were developed and tested in the `binance_trading` project before being promoted to global hooks.
