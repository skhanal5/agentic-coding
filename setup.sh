#!/bin/bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Setting up global config from $REPO_DIR"
echo

prompt() {
  local label="$1" path="$2" options="$3" default="$4" choice
  echo "  $label found at $path" >&2
  echo "    $options" >&2
  if [ -t 0 ]; then
    read -r -p "    Action [$default]: " choice </dev/tty
    echo "${choice:-$default}"
  else
    echo "    (non-interactive, using default: $default)" >&2
    echo "$default"
  fi
}

install_copy() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  cp -R "$src" "$dst"
  echo "    $dst <- $src"
}

backup_and_replace() {
  local src="$1" dst="$2"
  mv "$dst" "$dst.bak"
  echo "    (backed up $dst -> $dst.bak)"
  cp -R "$src" "$dst"
  echo "    $dst <- $src"
}

merge_into() {
  local src="$1" dst="$2"
  cp -R "$src/." "$dst/"
  echo "    $src -> $dst (merged)"
}

install_target() {
  local label="$1" src="$2" dst="$3" check_flag="$4" options="$5" default="$6"
  if [ "$check_flag" "$dst" ]; then
    local choice
    choice=$(prompt "$label" "$dst" "$options" "$default")
    case "$choice" in
      [Mm]) merge_into "$src" "$dst" ;;
      [Rr]|[Oo]) backup_and_replace "$src" "$dst" ;;
      [Ss]) echo "    skipped" ;;
    esac
  else
    install_copy "$src" "$dst"
  fi
}

install_target "~/.claude/skills"     "$REPO_DIR/skills"                          "$HOME/.claude/skills"              -d "[M]erge  [R]eplace  [S]kip" M
# install_target "~/.claude/rules"      "$REPO_DIR/rules"                           "$HOME/.claude/rules"               -d "[R]eplace  [S]kip"           S
install_target "opencode.json"        "$REPO_DIR/.config/opencode/opencode.json"  "$HOME/.config/opencode/opencode.json" -f "[O]verwrite  [S]kip"     S
# No longer copy rules directory as we don't use rules
install_target "AGENTS.md" "$REPO_DIR/AGENTS.md" "$HOME/.config/opencode/AGENTS.md" -f "[O]verwrite  [S]kip" S
install_target "CLAUDE.md" "$REPO_DIR/AGENTS.md" "$HOME/.claude/CLAUDE.md" -f "[O]verwrite  [S]skip" S

echo
echo "Done!"
