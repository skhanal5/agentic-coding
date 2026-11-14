#!/bin/bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "This script installs skills and CLAUDE.md into $CLAUDE_DIR."

if [ -d "$CLAUDE_DIR/skills" ]; then
  read -rp "WARNING: $CLAUDE_DIR/skills already exists. Skills with the same name will be overwritten. Continue? (y/N): " response
  response=$(printf '%s' "$response" | tr '[:upper:]' '[:lower:]')
  if [ "$response" != "y" ]; then
    echo "Skipped."
    exit 0
  fi
fi

mkdir -p "$CLAUDE_DIR/skills"
# Evals are for development only. Do not install them.
rsync -a --exclude 'evals/' "$REPO_DIR/skills/" "$CLAUDE_DIR/skills/"
echo "skills/ → $CLAUDE_DIR/skills/"

cp "$REPO_DIR/templates/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
echo "templates/CLAUDE.md → $CLAUDE_DIR/CLAUDE.md"

echo "Done."
