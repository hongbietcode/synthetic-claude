#!/bin/bash

# Game Dev Team - Automated Setup Script
# Creates a tmux session with 5 Claude Code instances (DS, SM, AR, DV, QA)
# Based on BMGD (BMAD Game Development) + Scrum patterns

set -e  # Exit on error

PROJECT_ROOT="${PROJECT_ROOT:-$(pwd)}"
SESSION_NAME="${SESSION_NAME:-game_dev_team}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPTS_DIR="$SCRIPT_DIR/prompts"

echo "Starting Game Dev Team Setup..."
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

# 3. Create 5-pane layout
echo "Creating 5-pane layout..."
tmux split-window -h -t $SESSION_NAME
tmux split-window -h -t $SESSION_NAME
tmux split-window -h -t $SESSION_NAME
tmux split-window -h -t $SESSION_NAME
tmux select-layout -t $SESSION_NAME even-horizontal

# 4. Resize for proper pane widths
echo "Resizing window..."
tmux resize-window -t $SESSION_NAME -x 500 -y 50

# 5. Set pane titles and role names
tmux select-pane -t $SESSION_NAME:0.0 -T "DS"
tmux select-pane -t $SESSION_NAME:0.1 -T "SM"
tmux select-pane -t $SESSION_NAME:0.2 -T "AR"
tmux select-pane -t $SESSION_NAME:0.3 -T "DV"
tmux select-pane -t $SESSION_NAME:0.4 -T "QA"

tmux set-option -p -t $SESSION_NAME:0.0 @role_name "DS"
tmux set-option -p -t $SESSION_NAME:0.1 @role_name "SM"
tmux set-option -p -t $SESSION_NAME:0.2 @role_name "AR"
tmux set-option -p -t $SESSION_NAME:0.3 @role_name "DV"
tmux set-option -p -t $SESSION_NAME:0.4 @role_name "QA"

# 6. Get pane IDs
echo "Getting pane IDs..."
PANE_IDS=$(tmux list-panes -t $SESSION_NAME -F "#{pane_id}")
DS_PANE=$(echo "$PANE_IDS" | sed -n '1p')
SM_PANE=$(echo "$PANE_IDS" | sed -n '2p')
AR_PANE=$(echo "$PANE_IDS" | sed -n '3p')
DV_PANE=$(echo "$PANE_IDS" | sed -n '4p')
QA_PANE=$(echo "$PANE_IDS" | sed -n '5p')

echo "Pane IDs:"
echo "  DS (Pane 0): $DS_PANE"
echo "  SM (Pane 1): $SM_PANE"
echo "  AR (Pane 2): $AR_PANE"
echo "  DV (Pane 3): $DV_PANE"
echo "  QA (Pane 4): $QA_PANE"

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

# 9. Start Claude Code in each pane
echo "Starting Claude Code in all panes..."
tmux send-keys -t $SESSION_NAME:0.0 "cd $PROJECT_ROOT && claude" C-m
tmux send-keys -t $SESSION_NAME:0.1 "cd $PROJECT_ROOT && claude" C-m
tmux send-keys -t $SESSION_NAME:0.2 "cd $PROJECT_ROOT && claude" C-m
tmux send-keys -t $SESSION_NAME:0.3 "cd $PROJECT_ROOT && claude" C-m
tmux send-keys -t $SESSION_NAME:0.4 "cd $PROJECT_ROOT && claude" C-m

# 10. Wait for Claude Code to start
echo "Waiting 20 seconds for Claude Code instances..."
sleep 20

# 11. Initialize roles (Two-Enter Rule + 0.5s sleep to avoid race condition)
echo "Initializing agent roles..."
tmux send-keys -t $SESSION_NAME:0.0 "/init-role DS" C-m
sleep 0.5
tmux send-keys -t $SESSION_NAME:0.0 C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.1 "/init-role SM" C-m
sleep 0.5
tmux send-keys -t $SESSION_NAME:0.1 C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.2 "/init-role AR" C-m
sleep 0.5
tmux send-keys -t $SESSION_NAME:0.2 C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.3 "/init-role DV" C-m
sleep 0.5
tmux send-keys -t $SESSION_NAME:0.3 C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.4 "/init-role QA" C-m
sleep 0.5
tmux send-keys -t $SESSION_NAME:0.4 C-m

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
echo "Game Dev Team Roles:"
echo "  +--------+--------+--------+--------+--------+"
echo "  | DS     | SM     | AR     | DV     | QA     |"
echo "  | Pane 0 | Pane 1 | Pane 2 | Pane 3 | Pane 4 |"
echo "  +--------+--------+--------+--------+--------+"
echo ""
echo "Team Structure (BMGD + Scrum):"
echo "  - DS: Game Designer (mechanics, GDD, player experience)"
echo "  - SM: Scrum Master (sprints, process, improvement)"
echo "  - AR: Game Architect (engine, architecture, 60fps)"
echo "  - DV: Game Developer (implementation, TDD)"
echo "  - QA: Game QA (testing, playtesting, profiling)"
echo ""
echo "Workflow: DS → AR → DV → QA → Acceptance"
echo ""
echo "Next steps:"
echo "  1. Attach: tmux attach -t $SESSION_NAME"
echo "  2. DS creates Game Brief and GDD"
echo "  3. AR plans architecture (Unity/Unreal/Godot)"
echo "  4. SM runs Sprint Planning"
echo ""
echo "To detach: Ctrl+B, then D"
echo "To kill: tmux kill-session -t $SESSION_NAME"
echo ""

# 14. Move cursor to DS pane
tmux select-pane -t $SESSION_NAME:0.0
echo "Cursor in Pane 0 (DS)."
