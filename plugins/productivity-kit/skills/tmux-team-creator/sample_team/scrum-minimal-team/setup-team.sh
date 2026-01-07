#!/bin/bash

# Scrum Minimal Team - Automated Setup Script
# Creates a tmux session with 3 Claude Code instances (PO, SM, EX)
# EX = Executive (TL + DEV + QA combined)

set -e

PROJECT_ROOT="${PROJECT_ROOT:-$(pwd)}"
SESSION_NAME="${SESSION_NAME:-scrum_minimal}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPTS_DIR="$SCRIPT_DIR/prompts"

echo "Starting Scrum Minimal Team Setup..."
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

# 3. Create 3-pane layout
echo "Creating 3-pane layout..."
tmux split-window -h -t $SESSION_NAME
tmux split-window -h -t $SESSION_NAME
tmux select-layout -t $SESSION_NAME even-horizontal

# 4. Resize for proper pane widths
echo "Resizing window..."
tmux resize-window -t $SESSION_NAME -x 400 -y 50

# 5. Set pane titles and role names
tmux select-pane -t $SESSION_NAME:0.0 -T "PO"
tmux select-pane -t $SESSION_NAME:0.1 -T "SM"
tmux select-pane -t $SESSION_NAME:0.2 -T "EX"

tmux set-option -p -t $SESSION_NAME:0.0 @role_name "PO"
tmux set-option -p -t $SESSION_NAME:0.1 @role_name "SM"
tmux set-option -p -t $SESSION_NAME:0.2 @role_name "EX"

# 6. Get pane IDs
echo "Getting pane IDs..."
PANE_IDS=$(tmux list-panes -t $SESSION_NAME -F "#{pane_id}")
PO_PANE=$(echo "$PANE_IDS" | sed -n '1p')
SM_PANE=$(echo "$PANE_IDS" | sed -n '2p')
EX_PANE=$(echo "$PANE_IDS" | sed -n '3p')

echo "Pane IDs:"
echo "  PO (Pane 0): $PO_PANE"
echo "  SM (Pane 1): $SM_PANE"
echo "  EX (Pane 2): $EX_PANE"

# 7. Verify tm-send is installed globally
echo "Verifying tm-send installation..."

if command -v tm-send >/dev/null 2>&1; then
    echo "tm-send is installed at: $(which tm-send)"
else
    echo ""
    echo "ERROR: tm-send is not installed!"
    echo ""
    echo "tm-send is a GLOBAL tool that must be installed to ~/.local/bin/tm-send"
    echo "Install it first, then re-run this script."
    echo ""
    exit 1
fi

# 8. Start Claude Code in each pane with model assignment
# Model assignment:
#   PO = Sonnet (backlog management)
#   SM = Opus (coordination and process)
#   EX = Opus (architecture + development + testing)
echo "Starting Claude Code in all panes..."

# PO - Sonnet
tmux send-keys -t $SESSION_NAME:0.0 "cd $PROJECT_ROOT && claude --model sonnet" C-m

# SM - Opus (Scrum Master needs high reasoning for coordination)
tmux send-keys -t $SESSION_NAME:0.1 "cd $PROJECT_ROOT && claude --model opus" C-m

# EX - Opus (Executive needs high reasoning for architecture + dev + test)
tmux send-keys -t $SESSION_NAME:0.2 "cd $PROJECT_ROOT && claude --model opus" C-m

# 9. Wait for Claude Code to start
echo "Waiting 20 seconds for Claude Code instances..."
sleep 20

# 10. Initialize roles (Two-Enter Rule + 0.3s sleep to avoid race condition)
echo "Initializing agent roles..."
tmux send-keys -t $SESSION_NAME:0.0 "/init-role PO" C-m
sleep 0.3
tmux send-keys -t $SESSION_NAME:0.0 C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.1 "/init-role SM" C-m
sleep 0.3
tmux send-keys -t $SESSION_NAME:0.1 C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.2 "/init-role EX" C-m
sleep 0.3
tmux send-keys -t $SESSION_NAME:0.2 C-m

# 11. Wait for initialization
echo "Waiting 10 seconds for role initialization..."
sleep 10

# 12. Summary
echo ""
echo "Setup Complete!"
echo ""
echo "Session: $SESSION_NAME"
echo "Project: $PROJECT_ROOT"
echo ""
echo "Scrum Minimal Team Roles:"
echo "  +--------+--------+--------+"
echo "  | PO     | SM     | EX     |"
echo "  | Pane 0 | Pane 1 | Pane 2 |"
echo "  +--------+--------+--------+"
echo ""
echo "Roles:"
echo "  - PO: Product Owner (backlog, priorities)"
echo "  - SM: Scrum Master (process, improvement)"
echo "  - EX: Executive (TL + DEV + QA combined)"
echo ""
echo "Next steps:"
echo "  1. Attach: tmux attach -t $SESSION_NAME"
echo "  2. Boss provides Sprint Goal to PO"
echo "  3. EX implements and tests"
echo "  4. SM facilitates Retrospective"
echo ""
echo "To detach: Ctrl+B, then D"
echo "To kill: tmux kill-session -t $SESSION_NAME"
echo ""

# 13. Move cursor to PO pane
tmux select-pane -t $SESSION_NAME:0.0
echo "Cursor in Pane 0 (PO)."
