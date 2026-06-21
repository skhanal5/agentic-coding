#!/bin/bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Setting up global config from $REPO_DIR"

# --- Claude Code: skills & rules ---
mkdir -p "$HOME/.claude"

if [ -e "$HOME/.claude/skills" ] && [ ! -L "$HOME/.claude/skills" ]; then
  mv "$HOME/.claude/skills" "$HOME/.claude/skills.bak"
  echo "Backed up existing ~/.claude/skills to ~/.claude/skills.bak"
fi
ln -sfn "$REPO_DIR/skills" "$HOME/.claude/skills"
echo "  ~/.claude/skills -> $REPO_DIR/skills"

if [ -e "$HOME/.claude/rules" ] && [ ! -L "$HOME/.claude/rules" ]; then
  mv "$HOME/.claude/rules" "$HOME/.claude/rules.bak"
  echo "Backed up existing ~/.claude/rules to ~/.claude/rules.bak"
fi
ln -sfn "$REPO_DIR/rules" "$HOME/.claude/rules"
echo "  ~/.claude/rules   -> $REPO_DIR/rules"

# --- OpenCode: config ---
if [ -e "$HOME/.config/opencode" ] && [ ! -L "$HOME/.config/opencode" ]; then
  mv "$HOME/.config/opencode" "$HOME/.config/opencode.bak"
  echo "Backed up existing ~/.config/opencode to ~/.config/opencode.bak"
fi
ln -sfn "$REPO_DIR/.config/opencode" "$HOME/.config/opencode"
echo "  ~/.config/opencode -> $REPO_DIR/.config/opencode"

echo ""
echo "Done! Skills, rules, and OpenCode config are now symlinked."
echo "Edit files in $REPO_DIR and they'll be available everywhere."
