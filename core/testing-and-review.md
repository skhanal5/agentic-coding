# Testing and Code Review

Read this once implementation begins, and before requesting any review
or PR. Assumes `workflows.md` has already been followed for planning
and scope.

---

## 1. Verification (MANDATORY before any PR)

Before considering work complete:

- Run build / compilation check (if applicable)
- Run all relevant tests
- Add tests for every non-trivial change introduced
- Validate behavior against requirements
- Run the `code-review` skill if invoked or relevant; otherwise perform
  an equivalent structured self-review against this document

If verification fails → return to Implementation in `workflows.md`.

---

## 2. Test Policy

- No deferred test work, no follow-up PRs for missing tests
- Every functional change must include corresponding tests in the same
  PR
- Tests must validate the exact change they accompany
- Follow the target language's standard testing idiom (e.g.
  table-driven tests in Go, parameterized tests elsewhere) where
  applicable
- Prefer small, deterministic tests
- Follow TDD-style reasoning when practical

**Exception:** if splitting a PR to hit the size target (see
`shipping.md`) would break the same-PR test requirement — i.e. tests
would have to cover an artificially incomplete feature — prefer the
larger PR and flag the size in the PR description instead of forcing a
split that breaks test coverage.

---

## 3. Code Review Enforcement (HARD GATE)

After verification, code review must be run and resolved before PR
creation.

### Issue handling

**Fixable issues**
- Must be resolved in the same PR
- Return to Implementation immediately; cannot be deferred
- This includes structural/abstraction findings (e.g. from a deep or
  "thermonuclear" code-review pass) **when the finding is about code
  introduced or directly modified by the current task, and can be
  resolved without touching files outside the current task's plan.**
  Fix it in the same PR, same as a correctness bug.

**Blocked issues** (e.g. unclear requirements, missing user input,
architectural uncertainty, risk of unintended system-wide impact —
**or** a structural finding that would require expanding into files or
systems outside the current task's plan to resolve)
- STOP immediately — do not proceed to PR creation
- Report: the issue, why it can't be resolved in-scope, and possible
  options (e.g. "fix now as a scope expansion," "file as separate
  follow-up work," "leave as-is")
- Await user decision

### Rules
- No issues may be deferred to future PRs; no partial acceptance of
  known issues
- Review loop: fix → re-run code review → repeat until clean or blocked
- A PR is only valid if all fixable issues are resolved and no
  unresolved review debt exists
- PR creation is allowed only once: code review has been run, all
  fixable issues are resolved, and any blocked issues are explicitly
  acknowledged by the user — not silently dropped. A blocked task is
  not done; see `shipping.md` (Definition of Done).