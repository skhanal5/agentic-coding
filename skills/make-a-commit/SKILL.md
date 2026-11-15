---
name: make-a-commit
description: Use this skill whenever the user asks to commit, stage files, or write a commit message. Examples are "commit this", "commit what I have", "write a commit message for what is staged", and "how should I commit these changes". It sets the rules for small, isolated, always-valid commits with plain English messages. Use it every time you are about to run `git commit`, even if the user only says "commit". Skip it for pushing, branching, and PR text.
---

# Make a commit

Guidelines for creating commits.

## 1. Valid state

Every commit leaves the app in a valid state:
- It builds and compiles.
- Tests pass, or no regressions are added.
- No half-applied refactors, broken imports, or commented-out blocks.

Never commit broken, intermediate, or WIP state. If you are mid-refactor, finish the slice or stash.

If a commit would leave the app invalid, stop. Split or finish the work first.

## 2. One purpose per commit

- One commit is one focused change. Prefer many small commits to one large one.
- Do not mix intents. Split feat plus fix, refactor plus feat, formatting plus logic, and chore plus feat.

Valid: `add retry logic to fetch wrapper`, `fix rate limiting on login endpoint`.

Invalid:
- `add retry logic and update README and fix rate limiting` (3 purposes)
- `refactor auth and add rate limiting` (mixed intent)

If scope expands, stop. Make separate commits or branches per `make-a-branch`.

## 3. Message

- Short, plain, and focused on the outcome. A reader with zero context must understand it.
- Follow the Language rules in `CLAUDE.md`.
- Imperative mood. Lowercase. No period at the end of the subject.
- Say what changed and why it matters. Do not list files or process.
- Subject is 72 characters or less.
- Conventional prefixes (`feat:`, `fix:`, `chore:`, `test:`) are optional. If you use them, use them consistently.

Good: `add retry logic with exponential backoff`, `fix session persistence after restart`.

Bad: `updated code and fixed issue` (vague), `fix bug` (no context), `WIP`, `stuff`.

## 4. Body

- Default to no body. The subject alone is enough for simple commits.
- Add a body only if the commit is complex and the subject and diff do not explain it. Examples are a non-obvious tradeoff, a workaround, or a migration.
- Use 1 to 3 short sentences about why. Do not restate the diff. Same language rules as the subject.
- Add an issue reference if the commit fixes a bug.

```
fix retry storm on 429 responses

Cap backoff at 30 seconds to avoid thundering herd. Upstream requires Retry-After
to be respected per docs. Without cap, concurrent jobs retried at same time.
```

If unsure, skip the body.

## 5. Checklist before committing

- [ ] The change has one purpose
- [ ] The app is valid (build and tests pass)
- [ ] The message is short and clear with zero context
- [ ] The language follows `CLAUDE.md`
- [ ] A body exists only if needed
- [ ] No unrelated files are staged (`git status` and `git diff --staged` checked)

If any item fails, stop and fix it before committing.
