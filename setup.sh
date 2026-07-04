#!/bin/bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "WARNING: This script will OVERWRITE the following folders and their contents:"
printf "  %s\n" "$HOME/.config/opencode" "$HOME/.claude"
read -rp "Do you want to continue? (y/N): " response
response=$(printf '%s' "$response" | tr '[:upper:]' '[:lower:]')
if [[ "$response" != "y" ]]; then
  echo "Aborted. No changes were made."
  exit 1
fi

echo "Setting up global config from $REPO_DIR"

# Copy skills to both OpenCode and Claude config directories (overwrite)
mkdir -p "$HOME/.config/opencode/skills"
cp -R "$REPO_DIR/skills/." "$HOME/.config/opencode/skills/"

mkdir -p "$HOME/.claude/skills"
cp -R "$REPO_DIR/skills/." "$HOME/.claude/skills/"

# Copy opencode.json (overwrite)
mkdir -p "$HOME/.config/opencode"
cp -R "$REPO_DIR/.config/opencode/opencode.json" "$HOME/.config/opencode/"

# Copy AGENTS.md to both OpenCode and Claude config directories (overwrite)
mkdir -p "$HOME/.config/opencode"
cp "$REPO_DIR/AGENTS.md" "$HOME/.config/opencode/"

mkdir -p "$HOME/.claude"
cp "$REPO_DIR/AGENTS.md" "$HOME/.claude/"

echo "Setup complete."
