# Delegation and Context Management

Use this with the `workflow` skill. It applies to all states.

## Delegate work to subagents

- Delegate when work is independent and has a clear input and output.
- Keep the main agent as owner of the plan and decisions. Subagents do scoped work and return results.
- Do not delegate tightly linked work that needs constant shared state.

Good candidates:
- Codebase search and reading many files
- Independent research
- Parallel checks such as tests, lint, or type checks
- Isolated file edits that do not overlap

Bad candidates:
- Small edits where a direct tool call is faster
- Tasks that use the same files at the same time
- Final decisions on scope, risk, or plan

When you delegate:
- Write a short brief. Include goal, scope, files in scope, files out of scope, and output format.
- Define what to return. Examples are file paths, key lines, risks, and next steps.
- Ask the subagent to verify its own output first.
- Use one subagent per isolated area. Never let two subagents edit the same file at once.
- The main agent reviews and commits after each subagent returns.

## Choose model variant by difficulty

- Simple and read-only (file search, listing, formatting): cheap and fast variant, for example Haiku.
- Routine (edits, test writing, multi-file search with summary, review): standard variant, for example Sonnet.
- Hard (tradeoffs, unclear requirements, high risk, large refactors, architecture): strong variant, for example Opus.
- When in doubt, start with standard. Move to strong only if needed.

Record the choice in the plan.

## Manage context

Large context slows you down and hurts quality. Act early.

- At 70 percent, prepare a compact or handoff note.
- At 80 percent, compact or clear now.
- If you see repeated confusion, lost details, or ignored rules, treat the context as degraded even if the percent is lower.
- Check context at each state exit and after each subagent returns.

Keep:
- Current workflow state
- Approved plan and scope limits
- Key decisions and open questions
- Branch name and commit history
- Test results and next steps

Drop:
- Raw file dumps you already summarized
- Full tool logs you already acted on
- Duplicate file reads

## Compact, or clear and resume

To compact:
- Summarize what is done and what remains in bullets.
- Keep the plan, decisions, risks, and file lists.
- Keep key lines with file path and line number. Drop raw content.
- Keep the exact next action.

To clear and resume:
- Write a handoff note first. Include state, plan, branch, done items, remaining items, and next action.
- Save it where you can reload it, such as a temp file.
- After the clear, reload the note. Confirm scope and plan.
- Check branch, files, and tests again. Do not assume they are unchanged.
