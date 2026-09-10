---
name: make-a-commit
description: This skill should be used when the user asks to create a commit, write a commit message, or check commit hygiene. Use when the user asks to stage small, isolated, always-valid commits with plain English messages.
---

# Make a commit

Guidelines for creating commits

---

## 1. Valid State Rule

- Every commit must leave the application in a valid state:
  - builds and compiles
  - tests pass or no regressions introduced
  - app is runnable with no half-applied refactors, broken imports, or commented-out blocks
- Never commit broken or intermediate or WIP state to share. If you are mid-refactor, finish the slice or stash until valid.

If a commit would leave the app invalid:
→ STOP, split or finish the work until valid before committing.

---

## 2. Single-Purpose / Isolated Commits

- One commit = one focused change.
- Small and isolated. Prefer many small commits over one large one.
- Do not mix intents in a single commit:
  - feat plus fix, refactor plus feat, formatting plus logic, chore plus feat → split

**Examples (valid):**
- `add retry logic to fetch wrapper`
- `fix rate limiting on login endpoint`
- `update README with auth setup`

**Invalid:**
- `add retry logic and update README and fix rate limiting` (3 purposes → 3 commits)
- `refactor auth and add rate limiting` (mixed intent)

If scope expands:
→ STOP and create separate commits or branches per `make-a-branch`.

---

## 3. Commit Messages

- Concise and easily understandable and outcome-focused. A reader with zero knowledge of the codebase must understand it.
- Use plain English. Prefer ASD-STE100 Simplified Technical English:
  - Use short sentences with one idea per sentence
  - Use simple verbs and common words
  - Use active voice
  - Use the same word for the same idea everywhere
  - Avoid jargon, idioms, and complex terms
- Use imperative mood, lowercase, no period at end of subject.
- Describe what changed and why it matters, not process or file lists.
- Keep subject line to 72 characters or less. One idea per message.
- No em dashes
- No semi-colons. Use periods to separate ideas.

**Good:**
- `add retry logic with exponential backoff`
- `fix session persistence after restart`
- `chore: update readme auth section`

**Bad:**
- `updated code and fixed issue` (vague)
- `fix bug` (no context)
- `WIP` or `temp` or `stuff`
- `leverage exponential backoff strat to amortize tail latency` (jargon heavy, not plain English)

No co-mingling of conventional prefixes is required, but if used keep it consistent (`feat:`, `fix:`, `chore:`, `test:`).

---

## 4. Commit Descriptions (Body)

- Prefer no body by default. Subject line alone should suffice for simple commits.
- Add a body if and only if the commit is complex and hard to understand from the subject and diff alone.
- When used, body is 1 to 3 concise sentences explaining why or non-obvious what. Not a file list or repeated diff.
- Same language rules apply as subject: plain English, STE100 style, no jargon, no em dashes, no semi-colons. Write for zero-context reader.

**When to add body:**
- Non-obvious tradeoff, workaround, or context (for example why backoff is capped at 30 seconds)
- Complex migration or behavior change needing extra intent

**When NOT to add body:**
- Simple, self-explanatory change (`add rate limiting to login`)
- Body would just restate the subject

Example with body:
```
fix retry storm on 429 responses

Cap backoff at 30 seconds to avoid thundering herd. Upstream requires Retry-After
to be respected per docs. Without cap, concurrent jobs retried at same time.
```

Example that needs bug reference:
```
fix login failure on retry

Server returned 429 without Retry-After. See issue 482. Added fallback wait of
2 seconds. Prevents tight retry loop.
```

If unsure whether a body is needed:
→ Skip it. Concise subject is better than unnecessary body.

---

## 5. Checklist Before Committing

- [ ] Change is isolated to one purpose
- [ ] App is in valid state (build and tests pass)
- [ ] Message is concise and understandable with zero context
- [ ] Language is plain English, no jargon, follows STE100 style
- [ ] No em dashes, no semi-colons
- [ ] Body added only if complex or hard to understand
- [ ] No unrelated files staged (`git status` and `git diff --staged` checked)

If any item fails → STOP and fix before committing.
