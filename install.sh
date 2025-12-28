#!/bin/bash

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "Installing Synthetic Claude plugin..."

if [ ! -d "$CLAUDE_DIR" ]; then
    echo "Error: ~/.claude directory not found. Is Claude Code installed?"
    exit 1
fi

mkdir -p "$CLAUDE_DIR/agents"
mkdir -p "$CLAUDE_DIR/commands"
mkdir -p "$CLAUDE_DIR/skills"

for agent in "$PLUGIN_DIR/agents"/*.md; do
    if [ -f "$agent" ]; then
        name=$(basename "$agent")
        target="$CLAUDE_DIR/agents/$name"
        if [ -L "$target" ] || [ -f "$target" ]; then
            echo "  Updating: agents/$name"
            rm -f "$target"
        else
            echo "  Adding: agents/$name"
        fi
        ln -s "$agent" "$target"
    fi
done

for cmd in "$PLUGIN_DIR/commands"/*.md; do
    if [ -f "$cmd" ]; then
        name=$(basename "$cmd" .md)
        target_dir="$CLAUDE_DIR/commands/$name"
        mkdir -p "$target_dir"
        target="$target_dir/$name.md"
        if [ -L "$target" ] || [ -f "$target" ]; then
            echo "  Updating: commands/$name"
            rm -f "$target"
        else
            echo "  Adding: commands/$name"
        fi
        ln -s "$cmd" "$target"
    fi
done

for skill_dir in "$PLUGIN_DIR/skills"/*; do
    if [ -d "$skill_dir" ]; then
        name=$(basename "$skill_dir")
        target="$CLAUDE_DIR/skills/$name"
        if [ -L "$target" ] || [ -d "$target" ]; then
            echo "  Updating: skills/$name"
            rm -rf "$target"
        else
            echo "  Adding: skills/$name"
        fi
        ln -s "$skill_dir" "$target"
    fi
done

echo ""
echo "Synthetic Claude plugin installed successfully!"
echo ""
echo "Available commands:"
echo "  /debate <topic>  - Start multi-agent debate"
echo ""
echo "To uninstall: ./uninstall.sh"
