# agentic-coding

A tiny repository that houses **shared skills and policies** for both OpenCode and Claude Code.  The files here are never executed directly; they are copied into the user’s global configuration directories so the agents can discover and enforce the same rules across environments.

## Quick setup
```bash
# Clone the repo (if you haven’t already)
git clone <url> ~/agentic-coding

# Install the configuration files
~/agentic-coding/setup.sh
```
The script copies:
- `skills/` → `~/.claude/skills/`
- `.config/opencode/opencode.json` → `~/.config/opencode/opencode.json`
- `core/AGENTS.md` → `~/.config/opencode/AGENTS.md`
- `core/AGENTS.md` (for Claude) → `~/.claude/CLAUDE.md`

Running the script again will overwrite the existing configuration without further prompts.

## Adding a skill
```bash
mkdir -p skills/<name>
cat > skills/<name>/SKILL.md <<'EOF'
---
name: <name>
description: What this skill does
---

# Instructions for the agent
...
EOF
```
The skill is automatically discovered by the `skill` tool; no further registration is required.

## Adding a rule / policy
Create a Markdown file under `core/` (or any directory you prefer) that contains the policy text.  The file will be copied to the global Opencode location by `setup.sh`.  OpenCode automatically loads any `*.md` files referenced by `opencode.json`.

## Updating configuration
Whenever you modify a skill or rule, re‑run `~/agentic-coding/setup.sh` to propagate the changes to your global config. The script will overwrite the relevant folders automatically.

---
*This repository contains only configuration and documentation – no runtime code.*
