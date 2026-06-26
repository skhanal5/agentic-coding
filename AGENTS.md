# Shared Skills & Rules Repository

- Contains skills (`skills/<name>/SKILL.md`) and rules (`rules/*.md`) shared between OpenCode and Claude Code.  
- Global locations: `~/.claude/skills`, `~/.config/opencode/rules`, `~/.config/opencode/opencode.json`.  
- **Always modify files under this repo**, then run `./setup.sh` to copy them to global locations.
- Claude Code reads its rules from `~/.claude/CLAUDE.md` (or the global `AGENTS.md`).  
- `setup.sh` prompts for merge/replace/skip when a target already exists; run it after any change.  
- OpenCode loads rules via the `"rules/*.md"` glob defined in `opencode.json`.  
- Skills are auto‑discovered on‑demand via the `skill` tool; no extra registration needed.  
- Do not edit files directly in `~/.claude/...`; changes will be overwritten on next `setup.sh`.  
- Keep `opencode.json` in sync only by adding/removing rule files; manual edits are discouraged.  
- Ensure `setup.sh` is executable (`chmod +x setup.sh`) and backed up before major changes.  
- This repo is for configuration only—no production code or libraries should be placed here.