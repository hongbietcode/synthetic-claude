#!/bin/bash

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "Uninstalling Synthetic Claude plugin..."

AGENTS=(
    "debate-orchestrator.md"
    "researcher.md"
    "critic.md"
    "synthesizer.md"
)

for agent in "${AGENTS[@]}"; do
    target="$CLAUDE_DIR/agents/$agent"
    if [ -L "$target" ]; then
        echo "  Removing: agents/$agent"
        rm -f "$target"
    fi
done

COMMANDS=("debate")

for cmd in "${COMMANDS[@]}"; do
    target="$CLAUDE_DIR/commands/$cmd"
    if [ -L "$target/$cmd.md" ]; then
        echo "  Removing: commands/$cmd"
        rm -f "$target/$cmd.md"
        rmdir "$target" 2>/dev/null
    fi
done

SKILLS=("debate-workflow")

for skill in "${SKILLS[@]}"; do
    target="$CLAUDE_DIR/skills/$skill"
    if [ -L "$target" ]; then
        echo "  Removing: skills/$skill"
        rm -f "$target"
    fi
done

echo ""
echo "Synthetic Claude plugin uninstalled successfully!"
