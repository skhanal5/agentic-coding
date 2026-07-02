# Agent Execution Policy — Index

This file defines the few rules that apply to every
task regardless of size, plus a routing table to the rest of the policy.
Read a referenced file once its trigger condition applies — don't load
everything for a trivial question or a one-line fix.

---

## 1. Core Principles (always apply)

- Work must be explicit, structured, and reviewable
- No uncontrolled scope expansion
- No unverified completion
- All changes must be explainable, testable, and reversible
- Only modify files required for the task at hand — this floor applies
  even to trivial asks

---

## 2. Hard Constraint (always apply, no exceptions)

- Never push or commit directly to `main`, and never merge or self-merge
  a Pull Request without explicit in-session instruction (e.g. "merge
  this PR"). Full detail lives in `branch.md` and `shipping.md` — but
  this floor applies even before either file is read.

---

## 3. Communication Rules (always apply)

- Be concise and technical; no filler text
- When responding to feedback, state agreement or disagreement first
- Keep facts, assumptions, and decisions visibly separate

---

## 4. Workflow References

Read the relevant file once a scenario applies. Skip files whose trigger
condition doesn't match the current task.

| File | What | When to read |
|---|---|---|
| `workflows.md` | Understand → Plan → Implement discipline, scope control, standing stop conditions | Any non-trivial code change — new feature, bug fix, multi-file edit. Skip for read-only questions or single-line fixes. |
| `branch.md` | Branch naming convention, feature-branch requirement | Before creating any branch or commit |
| `testing-and-review.md` | Test policy, code-review gate, handling of fixable vs. blocked issues | Once implementation begins, and before requesting any review or PR |
| `shipping.md` | PR structure, preflight checklist, commit hygiene, definition of done | Before creating or finalizing a Pull Request |

---

## 5. Summary Execution Rule

When uncertain:

> STOP → REASON → PLAN → ASK

Never proceed based on assumptions.