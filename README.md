# agentic-coding

A tiny repository that houses **shared skills and policies** for OpenCode, Claude Code, and Codex. The files here are never executed directly; they are copied into the user's global configuration directories so the agents can discover and enforce the same rules across environments.

## Quick setup

```bash
# Clone the repo (if you haven't already)
git clone <url> ~/agentic-coding

# Install the configuration files
~/agentic-coding/setup.sh
```

The script copies:
- `skills/` → `~/.config/opencode/skills/`, `~/.claude/skills/`, and `~/.codex/skills/`
- `AGENTS.md` → `~/.config/opencode/`, `~/.claude/`, and `~/.codex/`
- `.config/opencode/opencode.json` → `~/.config/opencode/opencode.json`

The script will prompt which agents to configure and warn before overwriting an existing directory.

## Structure

```
AGENTS.md                     — Entry point: hard constraint + execution rule
skills/                       — Auto-discovered skills loaded on demand
  workflow/SKILL.md           —   Understand → Plan → Implement discipline
  branching/SKILL.md          —   Branch naming and feature-branch requirement
  testing-and-review/SKILL.md —   Test policy, code-review gate
  shipping/SKILL.md           —   PR preflight, commit conventions, DoD
  ...                         —   Other skills (code-review, deslop, etc.)
.config/opencode/opencode.json — OpenCode configuration
```

`AGENTS.md` is intentionally concise — it contains only rules that must fire every session. All workflow, branching, testing, and shipping policies live in skills that are auto-discovered and loaded only when relevant.

## Adding a skill

```bash
mkdir -p skills/<name>
cat > skills/<name>/SKILL.md <<'EOF'
---
name: <name>
description: What this skill does AND when to trigger it
---

# Instructions for the agent
...
EOF
```

The skill is automatically discovered by the `skill` tool; no further registration is required.

## Updating configuration

Whenever you add or modify a skill, re-run `~/agentic-coding/setup.sh` to propagate the changes to your global config directories. The script will prompt which agents to reconfigure.

---

*This repository contains only configuration and documentation – no runtime code.*
