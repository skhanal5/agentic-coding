---
name: make-a-branch
description: This skill should be used when the user asks to create a branch, name a branch, or check branch naming. Use when the user asks to create a feature branch with operation slash description format or enforce single-purpose branches.
---

# Make a branch

Guidelines for naming a branch

---

## Branch Naming Convention

- Format: `<operation>/<1-3-word-description>`
  - `operation`: type of change such as `feat`, `fix`, `chore`, `test`, `docs`, `refactor`, `perf`, `ci`, `build`
  - `description`: 1–3 words, kebab-case, derived from intent (what, not how)
  - Total slug after `/` must be ≤3 words

**Examples (valid):**
- `feat/add-retry-logic`
- `fix/add-rate-limiting`
- `feat/auth`
- `chore/update-readme`
- `test/add-integ-tests`
- `fix/rate-limit`
- `docs/update-api-guide`

**Invalid:**
- `feat/add-retry-logic-and-update-docs-and-fix-tests` (too many words / multiple purposes)
- `skhanal/login-ui` (old prefix format)
- `feature/add_retry_logic` (wrong operation name / snake_case)
- `feat/AddRetryLogic` (not kebab-case)

If a branch cannot be named per this convention:
→ STOP and ask.

---

## Single-Purpose Rule

- One branch = one focused change.
- A branch must address a single intent/purpose. Do not combine unrelated changes.
- If scope expands during work, split into multiple branches rather than enlarging the current one.

**Examples:**
- Instead of one branch that adds auth + rate limiting + README updates, create:
  - `feat/auth`
  - `fix/add-rate-limiting`
  - `chore/update-readme`
- If `feat/add-retry-logic` starts to also require a test harness overhaul, split the harness work to `test/add-integ-tests` or `chore/update-test-harness`.

If a branch would contain more than one purpose:
→ STOP, split the work, and create separate branches.
