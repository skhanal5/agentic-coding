---
name: deslop
description: Use this skill whenever the user wants AI-written code on a branch cleaned up to match the surrounding code. Examples are "deslop", removing noisy comments, over-defensive null checks or try/catch blocks, flattening deeply nested ifs with early returns, and code that looks like an AI wrote it. It edits only what the branch changed and keeps behavior the same. Use it even if the user does not say "slop". Skip it for new features, full reviews, and docstring requests.
---

# Remove AI code slop

Check the diff against main and remove AI-generated slop introduced in the branch.

## Focus Areas

- Extra comments that are unnecessary or inconsistent with local style
- Defensive checks that are abnormal for trusted code paths
- Deeply nested code that should be simplified with early returns
- Other patterns inconsistent with the file and surrounding codebase

## Guardrails

- Keep behavior unchanged unless fixing a clear bug.
- Prefer minimal, focused edits over broad rewrites.
- Keep the final summary concise (1-3 sentences).
