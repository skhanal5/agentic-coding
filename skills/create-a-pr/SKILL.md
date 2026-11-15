---
name: create-a-pr
description: Use this skill whenever the user asks to create, open, or draft a pull request, or to write or check a PR title or description. Examples are "create a PR for this branch", "open a pull request", "draft the PR body", and "is my PR title ok". It sets the title format `<operation>: <summary>` and the Background, Changes, Risks, Testing description. Use it every time you are about to run `gh pr create`. Skip it for commits, branch names, and code review.
---

# Create a PR

Guidelines for PR titles and descriptions.

## 1. Title

- Format: `<operation>: <summary>`
- The operation matches the branch operation from `make-a-branch`: `feat`, `fix`, `chore`, `test`, `docs`, `refactor`, `perf`, `ci`, `build`. Use lowercase.
- The summary has 2 to 4 plain words. The title mirrors the branch name. Branch `feat/add-retry-logic` gives title `feat: add retry logic`.
- One short line. No period at the end.

Valid: `feat: add retry logic`, `fix: add rate limiting`, `chore: update readme`.

Invalid:
- `Add retry logic` (no operation)
- `feat/add-retry-logic` (branch format)
- `Feat: Add Retry Logic` (wrong case)
- `feat: leverage exponential backoff strat to amortize tail latency` (jargon)

If the title cannot follow this format, stop and ask.

## 2. Description

A reader with zero knowledge of the codebase must understand it. Use bullets, not paragraphs. Keep it short unless the PR is unusually complex.

Use these headings in this order:

- **Background**: what changes and why. 2 to 4 bullets. Plain terms. For a stacked PR, the first bullet names the parent PR, for example `Stacks on #48.`
- **Changes**: one bullet per key change. Group related changes. Do not list every file.
- **Risks**: include only if the PR adds risk. State each risk and its impact or mitigation. Omit the section if there is no risk. Do not add a placeholder.
- **Testing**: how you validated the change and checked the risks. Name commands or test types.

## 3. Language

- Follow the Language rules in `CLAUDE.md`.
- One idea per bullet.

Good: `Fix login retry. Server returned 429 without Retry-After. Added fallback wait.`

## 4. Template

```
<operation>: <summary>

## Background
- Why this change exists
- What problem it fixes or what goal it meets

## Changes
- High-level change 1
- High-level change 2

## Risks
- Risk 1 and how it is handled (omit section if no risk)

## Testing
- How you tested the change
- How you checked risks
```

For full examples, read `references/examples.md`.

## 5. Checklist before creating the PR

- [ ] Title is `<operation>: <summary>` and matches the branch operation
- [ ] Title is short and plain
- [ ] Description has Background, Changes, Testing, and Risks only if needed
- [ ] Description uses bullets and is concise
- [ ] Language follows `CLAUDE.md`
- [ ] A reader with zero context can understand it

If any item fails, fix it before creating the PR.
