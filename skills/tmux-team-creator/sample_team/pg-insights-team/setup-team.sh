#!/bin/bash

# P&G Insights Team - Automated Setup Script
# Creates a tmux session with 5 Claude Code instances (IM, MR, IA, SL, QR)
# Based on P&G's Three-Step Insights Formula

set -e  # Exit on error

PROJECT_ROOT="${PROJECT_ROOT:-$(pwd)}"
SESSION_NAME="${SESSION_NAME:-pg_insights_team}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPTS_DIR="$SCRIPT_DIR/prompts"

echo "Starting P&G Insights Team Setup..."
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
tmux select-pane -t $SESSION_NAME:0.0 -T "IM"
tmux select-pane -t $SESSION_NAME:0.1 -T "MR"
tmux select-pane -t $SESSION_NAME:0.2 -T "IA"
tmux select-pane -t $SESSION_NAME:0.3 -T "SL"
tmux select-pane -t $SESSION_NAME:0.4 -T "QR"

tmux set-option -p -t $SESSION_NAME:0.0 @role_name "IM"
tmux set-option -p -t $SESSION_NAME:0.1 @role_name "MR"
tmux set-option -p -t $SESSION_NAME:0.2 @role_name "IA"
tmux set-option -p -t $SESSION_NAME:0.3 @role_name "SL"
tmux set-option -p -t $SESSION_NAME:0.4 @role_name "QR"

# 6. Get pane IDs
echo "Getting pane IDs..."
PANE_IDS=$(tmux list-panes -t $SESSION_NAME -F "#{pane_id}")
IM_PANE=$(echo "$PANE_IDS" | sed -n '1p')
MR_PANE=$(echo "$PANE_IDS" | sed -n '2p')
IA_PANE=$(echo "$PANE_IDS" | sed -n '3p')
SL_PANE=$(echo "$PANE_IDS" | sed -n '4p')
QR_PANE=$(echo "$PANE_IDS" | sed -n '5p')

echo "Pane IDs:"
echo "  IM (Pane 0): $IM_PANE"
echo "  MR (Pane 1): $MR_PANE"
echo "  IA (Pane 2): $IA_PANE"
echo "  SL (Pane 3): $SL_PANE"
echo "  QR (Pane 4): $QR_PANE"

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

# 10. Wait for Claude Code to start
echo "Waiting 20 seconds for Claude Code instances..."
sleep 20

# 11. Initialize roles (Two-Enter Rule + 0.3s sleep to avoid race condition)
echo "Initializing agent roles..."
tmux send-keys -t $SESSION_NAME:0.0 "/init-role IM" C-m
sleep 0.3
tmux send-keys -t $SESSION_NAME:0.0 C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.1 "/init-role MR" C-m
sleep 0.3
tmux send-keys -t $SESSION_NAME:0.1 C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.2 "/init-role IA" C-m
sleep 0.3
tmux send-keys -t $SESSION_NAME:0.2 C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.3 "/init-role SL" C-m
sleep 0.3
tmux send-keys -t $SESSION_NAME:0.3 C-m
sleep 2
tmux send-keys -t $SESSION_NAME:0.4 "/init-role QR" C-m
sleep 0.3
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
echo "P&G Insights Team (Three-Step Formula):"
echo "  +--------+--------+--------+--------+--------+"
echo "  | IM     | MR     | IA     | SL     | QR     |"
echo "  | Pane 0 | Pane 1 | Pane 2 | Pane 3 | Pane 4 |"
echo "  +--------+--------+--------+--------+--------+"
echo ""
echo "P&G Three-Step Workflow:"
echo "  1. Find Everyday Moments That Matter (MR)"
echo "  2. Find How Brand Matters in Those Moments (IA)"
echo "  3. Find the Brand Idea That Makes Moments Matter More (SL)"
echo ""
echo "Next steps:"
echo "  1. Attach: tmux attach -t $SESSION_NAME"
echo "  2. Client provides Consumer Brief to IM"
echo "  3. Team executes Three-Step Formula"
echo "  4. IM facilitates Retrospective"
echo ""
echo "To detach: Ctrl+B, then D"
echo "To kill: tmux kill-session -t $SESSION_NAME"
echo ""

# 14. Move cursor to IM pane
tmux select-pane -t $SESSION_NAME:0.0
echo "Cursor in Pane 0 (IM)."
