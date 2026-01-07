#!/bin/bash

# McKinsey Research Team - Automated Setup Script
# Creates a tmux session with 6 Claude Code instances (EM, RL, PR, SR, DA, QR)
# Based on McKinsey's 7-step problem-solving methodology

set -e  # Exit on error

PROJECT_ROOT="${PROJECT_ROOT:-$(pwd)}"
SESSION_NAME="${SESSION_NAME:-mckinsey_research_team}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPTS_DIR="$SCRIPT_DIR/prompts"

echo "Starting McKinsey Research Team Setup..."
echo "Project Root: $PROJECT_ROOT"
echo "Session Name: $SESSION_NAME"

# 1. Check if session already exists
if tmux has-session -t $SESSION_NAME 2>/dev/null; then
    echo "Session '$SESSION_NAME' already exists!"
    read -p "Kill existing session and create new one? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        tmux kill-session -t $SESSION_NAME
        echo "Killed existing session"
    else
        echo "Aborted. Use 'tmux attach -t $SESSION_NAME' to attach"
        exit 0
    fi
fi

# 2. Start new tmux session
echo "Creating tmux session '$SESSION_NAME'..."
cd "$PROJECT_ROOT"
tmux new-session -d -s $SESSION_NAME

# 3. Create 6-pane layout
echo "Creating 6-pane layout..."
tmux split-window -h -t $SESSION_NAME
tmux split-window -h -t $SESSION_NAME
tmux split-window -h -t $SESSION_NAME
tmux split-window -h -t $SESSION_NAME
tmux split-window -h -t $SESSION_NAME
tmux select-layout -t $SESSION_NAME even-horizontal

# 4. Resize for proper pane widths
echo "Resizing window..."
tmux resize-window -t $SESSION_NAME -x 600 -y 50

# 5. Set pane titles and role names
tmux select-pane -t $SESSION_NAME:0.0 -T "EM"
tmux select-pane -t $SESSION_NAME:0.1 -T "RL"
tmux select-pane -t $SESSION_NAME:0.2 -T "PR"
tmux select-pane -t $SESSION_NAME:0.3 -T "SR"
tmux select-pane -t $SESSION_NAME:0.4 -T "DA"
tmux select-pane -t $SESSION_NAME:0.5 -T "QR"

tmux set-option -p -t $SESSION_NAME:0.0 @role_name "EM"
tmux set-option -p -t $SESSION_NAME:0.1 @role_name "RL"
tmux set-option -p -t $SESSION_NAME:0.2 @role_name "PR"
tmux set-option -p -t $SESSION_NAME:0.3 @role_name "SR"
tmux set-option -p -t $SESSION_NAME:0.4 @role_name "DA"
tmux set-option -p -t $SESSION_NAME:0.5 @role_name "QR"

# 6. Get pane IDs
echo "Getting pane IDs..."
PANE_IDS=$(tmux list-panes -t $SESSION_NAME -F "#{pane_id}")
EM_PANE=$(echo "$PANE_IDS" | sed -n '1p')
RL_PANE=$(echo "$PANE_IDS" | sed -n '2p')
PR_PANE=$(echo "$PANE_IDS" | sed -n '3p')
SR_PANE=$(echo "$PANE_IDS" | sed -n '4p')
DA_PANE=$(echo "$PANE_IDS" | sed -n '5p')
QR_PANE=$(echo "$PANE_IDS" | sed -n '6p')

echo "Pane IDs:"
echo "  EM (Pane 0): $EM_PANE"
echo "  RL (Pane 1): $RL_PANE"
echo "  PR (Pane 2): $PR_PANE"
echo "  SR (Pane 3): $SR_PANE"
echo "  DA (Pane 4): $DA_PANE"
echo "  QR (Pane 5): $QR_PANE"

# 7. Verify tm-send is installed globally
# tm-send is a GLOBAL tool at ~/.local/bin/tm-send (not project-specific)
# It uses @role_name pane options directly (set above in step 5)
echo "Verifying tm-send installation..."

if command -v tm-send >/dev/null 2>&1; then
    echo "tm-send is installed at: $(which tm-send)"
else
    echo ""
    echo "ERROR: tm-send is not installed!"
    echo ""
    echo "tm-send is a GLOBAL tool that must be installed to ~/.local/bin/tm-send"
    echo "It is NOT project-specific - one installation serves all projects."
    echo ""
    echo "Install it first, then re-run this script."
    echo ""
    exit 1
fi

# 8. Verify SessionStart hook is configured (CRITICAL for context recovery)
echo "Verifying SessionStart hook..."
HOOK_FILE="$PROJECT_ROOT/.claude/hooks/session_start_team_docs.py"
SETTINGS_FILE="$PROJECT_ROOT/.claude/settings.json"

if [ ! -f "$HOOK_FILE" ]; then
    echo ""
    echo "WARNING: SessionStart hook not found at $HOOK_FILE"
    echo ""
    echo "Without this hook, agents will lose context after auto-compact!"
    echo ""
    echo "To fix:"
    echo "  1. Copy hook template:"
    echo "     cp ~/.claude/skills/tmux-team-creator/hooks/session_start_team_docs.py \\"
    echo "        $PROJECT_ROOT/.claude/hooks/"
    echo "  2. Edit TEAM_CONFIGS in the hook file for your team"
    echo "  3. Ensure .claude/settings.json has SessionStart hook configured"
    echo ""
    echo "See tmux-team-creator skill for details."
    echo ""
fi

if [ ! -f "$SETTINGS_FILE" ]; then
    echo "WARNING: .claude/settings.json not found"
    echo "SessionStart hook may not be configured."
    echo ""
fi

# 9. Start Claude Code in each pane
echo "Starting Claude Code in all panes..."
tmux send-keys -t $SESSION_NAME:0.0 "cd $PROJECT_ROOT && claude" C-m
tmux send-keys -t $SESSION_NAME:0.1 "cd $PROJECT_ROOT && claude" C-m
tmux send-keys -t $SESSION_NAME:0.2 "cd $PROJECT_ROOT && claude" C-m
tmux send-keys -t $SESSION_NAME:0.3 "cd $PROJECT_ROOT && claude" C-m
tmux send-keys -t $SESSION_NAME:0.4 "cd $PROJECT_ROOT && claude" C-m
tmux send-keys -t $SESSION_NAME:0.5 "cd $PROJECT_ROOT && claude" C-m

# 10. Wait for Claude Code to start
echo "Waiting 20 seconds for Claude Code instances..."
sleep 20

# 11. Initialize roles (Two-Enter Rule + 0.3s sleep to avoid race condition)
echo "Initializing agent roles..."
tmux send-keys -t $SESSION_NAME:0.0 "/init-role EM" C-m
sleep 0.3
tmux send-keys -t $SESSION_NAME:0.0 C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.1 "/init-role RL" C-m
sleep 0.3
tmux send-keys -t $SESSION_NAME:0.1 C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.2 "/init-role PR" C-m
sleep 0.3
tmux send-keys -t $SESSION_NAME:0.2 C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.3 "/init-role SR" C-m
sleep 0.3
tmux send-keys -t $SESSION_NAME:0.3 C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.4 "/init-role DA" C-m
sleep 0.3
tmux send-keys -t $SESSION_NAME:0.4 C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.5 "/init-role QR" C-m
sleep 0.3
tmux send-keys -t $SESSION_NAME:0.5 C-m

# 12. Wait for initialization
echo "Waiting 15 seconds for role initialization..."
sleep 15

# 13. Summary
echo ""
echo "Setup Complete!"
echo ""
echo "Session: $SESSION_NAME"
echo "Project: $PROJECT_ROOT"
echo ""
echo "McKinsey Research Team:"
echo "  +--------+--------+--------+--------+--------+--------+"
echo "  | EM     | RL     | PR     | SR     | DA     | QR     |"
echo "  | Pane 0 | Pane 1 | Pane 2 | Pane 3 | Pane 4 | Pane 5 |"
echo "  +--------+--------+--------+--------+--------+--------+"
echo ""
echo "McKinsey 7-Step Workflow:"
echo "  1. Define Problem (EM ↔ Client)"
echo "  2. Structure Problem (RL - MECE issue tree)"
echo "  3. Prioritize Issues (EM + RL)"
echo "  4. Plan Analysis (EM)"
echo "  5. Conduct Analysis (PR, SR, DA)"
echo "  6. Synthesize Findings (RL)"
echo "  7. Communicate Recommendations (EM + RL → QR → Client)"
echo ""
echo "Next steps:"
echo "  1. Attach: tmux attach -t $SESSION_NAME"
echo "  2. Client provides Research Brief to EM"
echo "  3. Team executes 7-step workflow"
echo "  4. EM facilitates Retrospective"
echo ""
echo "To detach: Ctrl+B, then D"
echo "To kill: tmux kill-session -t $SESSION_NAME"
echo ""

# 14. Move cursor to EM pane
tmux select-pane -t $SESSION_NAME:0.0
echo "Cursor in Pane 0 (EM)."
