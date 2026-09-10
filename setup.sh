#!/bin/bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Select agents to set up (space-separated numbers):"
printf "  1) OpenCode   (~/.config/opencode)\n"
printf "  2) Claude     (~/.claude)\n"
printf "  3) Codex      (~/.codex)\n"
read -rp "Enter selection: " selection

setup_agent() {
  local name="$1"
  local dir="$2"
  local copy_opencode_json="$3"

  echo ""
  echo "Setting up $name..."

  if [ -d "$dir" ]; then
    read -rp "  WARNING: $dir already exists and will be overwritten. Continue? (y/N): " response
    response=$(printf '%s' "$response" | tr '[:upper:]' '[:lower:]')
    if [ "$response" != "y" ]; then
      echo "  Skipped."
      return
    fi
  fi

  mkdir -p "$dir/skills"
  cp -R "$REPO_DIR/skills/." "$dir/skills/"
  echo "  skills/ → $dir/skills/"

  if [ "$name" = "Claude" ]; then
    cp "$REPO_DIR/templates/AGENTS.md" "$dir/CLAUDE.md"
    echo "  templates/AGENTS.md → $dir/CLAUDE.md"
  else
    cp "$REPO_DIR/templates/AGENTS.md" "$dir/AGENTS.md"
    echo "  templates/AGENTS.md → $dir/AGENTS.md"
  fi

  if [ "$copy_opencode_json" = "yes" ]; then
    mkdir -p "$dir"
    cp "$REPO_DIR/.config/opencode/opencode.json" "$dir/"
    echo "  opencode.json → $dir/"
  fi

  echo "  ✓ $name setup complete."
}

any=false
for num in $selection; do
  case "$num" in
    1) setup_agent "OpenCode" "$HOME/.config/opencode" "yes"; any=true ;;
    2) setup_agent "Claude" "$HOME/.claude" "no"; any=true ;;
    3) setup_agent "Codex" "$HOME/.codex" "no"; any=true ;;
  esac
done

if [ "$any" = false ]; then
  echo ""
  echo "No agents selected. Nothing done."
  exit 0
fi

echo ""
echo "Done."
