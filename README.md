# agentic-coding

Shared skills and rules that work across both [OpenCode](https://opencode.ai) and [Claude Code](https://claude.ai/code).

## Structure

```
agentic-coding/
├── skills/                     Skills — auto-discovered by both tools
│   └── <name>/SKILL.md
├── rules/                      Rules — auto-discovered by Claude Code,
│   ├── commit.md               referenced by OpenCode via opencode.json
│   └── collaboration.md
├── .config/
│   └── opencode/               OpenCode global config
│       └── opencode.json
├── setup.sh                    Symlinks everything into place
└── README.md
```

## Setup

Run once per machine after cloning:

```bash
git clone <url> ~/agentic-coding
~/agentic-coding/setup.sh
```

This symlinks:

| Repo path | Symlinked to | Used by |
|---|---|---|
| `skills/` | `~/.claude/skills/` | OpenCode + Claude Code |
| `rules/` | `~/.claude/rules/` | OpenCode (via `opencode.json`) + Claude Code |
| `.config/opencode/` | `~/.config/opencode/` | OpenCode |

Existing directories are backed up with a `.bak` suffix.

## Adding a skill

```bash
mkdir -p skills/<name>
```

Create `skills/<name>/SKILL.md`:

```markdown
---
name: <name>
description: What this skill does
---

Instructions for the agent when this skill is loaded.
```

Skills are loaded on-demand via the `skill` tool in both OpenCode and Claude Code.

## Adding a rule

Create `rules/<name>.md` with optional YAML frontmatter:

```markdown
---
description: What this rule covers
paths: [src/**/*.ts]    # optional: scope to certain paths (Claude Code)
---

Rule content here.
```

OpenCode picks it up automatically via the `"../rules/*.md"` glob in `opencode.json`. Claude Code auto-discovers it from `~/.claude/rules/`.
