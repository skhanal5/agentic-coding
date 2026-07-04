---
name: workflow
description: Understand → Plan → Implement discipline, scope control, and standing stop conditions for any non-trivial code change, new feature, bug fix, or multi-file edit. Skip for read-only questions or single-line fixes.
---

# Workflow Discipline

Read this before starting any non-trivial code change — a new feature,
a bug fix, or anything beyond a single-line edit or a read-only
question. Skip it for trivial asks, but the floor in `AGENTS.md`
(scope, no unrelated file changes) still applies regardless.

---

## 1. Understand Before Acting

Before making any change:

- Read all relevant files fully — not snippets
- Identify system context
- State assumptions explicitly
- Identify risks and unknowns

STOP and ask before proceeding if ambiguity exists.

---

## 2. Plan Before Implementing

Before writing code, produce a step-by-step plan covering:

- files to change
- expected behavior changes
- risks and tradeoffs
- test strategy

STOP and request explicit confirmation before implementing if any of
the following are true:

- multi-file changes are required
- architectural changes are required
- requirements are unclear

No implementation may begin without an approved plan.

---

## 3. Implementation Constraints

- Make minimal, incremental changes
- Scope is LOCKED once implementation begins — do not expand it
  mid-task
- Do not introduce unrelated refactors
- Do not add functionality beyond the approved plan

STOP and return to Planning if new complexity appears mid-implementation.

Once implementation is underway or complete, move to
the `testing-and-review` skill before considering the change shippable.

---

## 4. Scope Control (STRICT)

- Only modify files required for the task
- No unrelated refactoring
- No architectural changes unless requested
- No behavior changes unless explicitly required
- Prefer minimal diffs over ideal redesigns

---

## 5. Standing Stop Conditions

Stop and surface the issue to the user — rather than proceeding —
whenever any of the following is true, regardless of where in the task
you are:

- ambiguity in requirements
- architectural uncertainty
- multi-file changes not yet approved
- PR size likely to exceed target without a valid exception (see
  the `shipping` skill)
- missing tests for planned changes
- unresolved code-review issues
- any uncertainty about correctness

When this happens:
1. State the issue clearly
2. Propose options
3. Wait for user input — do not continue based on assumptions
