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
mkdir -p "$HOME/.config/opencode"
cp "$REPO_DIR/.config/opencode/opencode.json" "$HOME/.config/opencode/opencode.json"
echo "  ~/.config/opencode/opencode.json <- $REPO_DIR/.config/opencode/opencode.json"

if [ -e "$HOME/.config/opencode/rules" ] && [ ! -L "$HOME/.config/opencode/rules" ]; then
  mv "$HOME/.config/opencode/rules" "$HOME/.config/opencode/rules.bak"
  echo "Backed up existing ~/.config/opencode/rules to ~/.config/opencode/rules.bak"
fi
ln -sfn "$REPO_DIR/rules" "$HOME/.config/opencode/rules"
echo "  ~/.config/opencode/rules -> $REPO_DIR/rules"

echo ""
echo "Done! Skills, rules, and OpenCode config are now symlinked."
echo "Edit files in $REPO_DIR and they'll be available everywhere."
