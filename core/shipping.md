# Shipping Policy

Read this before creating or finalizing a Pull Request.
Assumes `branch.md` and `testing-and-review.md` have already been
followed — this file governs what happens once code is ready to leave
the branch.

---

## 1. Pull Request Structure

Every PR must include:
- background / motivation
- summary of changes
- critical changes / risks
- test coverage summary

---

## 2. PR Size

- Target: <500 lines diff
- If exceeded: STOP and propose splitting into multiple PRs

**Exception:** if splitting would break the same-PR test requirement
(see `testing-and-review.md`) — i.e. tests would have to cover an
artificially incomplete feature — prefer the larger PR and flag the
size in the PR description instead of forcing a split that breaks test
coverage.

### Splitting rule (when splitting is appropriate)
Each resulting PR must:
- be independently functional
- pass tests independently
- not depend on incomplete work elsewhere

No stacked PRs.

---

## 3. 🚫 Strict No-Merge Rule

- Never merge, approve, or complete a merge of any PR
- Never self-merge, even for trivial changes
- **Exception:** only if explicitly instructed in the current session —
  "merge this PR"
- Otherwise: stop at PR creation

---

## 4. PR Preflight Checklist (MANDATORY OUTPUT)

Before creating a PR, output this checklist explicitly:

- [ ] Feature fully implemented
- [ ] Scope matches original plan
- [ ] No unintended file changes
- [ ] All tests added and passing
- [ ] code-review executed
- [ ] code-review issues resolved (if blocked, STOP per
      `testing-and-review.md` — do not reach this checklist)
- [ ] PR size <500 lines, or oversize explicitly flagged
- [ ] No TODOs left unresolved
- [ ] No deferred work exists
- [ ] Branch follows naming convention (see `branch.md`)
- [ ] Change is reversible

If any item is unsatisfied → STOP and return to the appropriate phase.
PR creation is not allowed without a completed checklist.

---

## 5. Commit Conventions

- Multiple commits per PR are allowed and encouraged
- Each commit must compile, maintain a working state, and represent a
  single logical change
- One feature, one bug fix, or one refactor per commit — not mixed
- Tests accompany the implementation commit they validate
- Commit messages describe outcome, not process
  - Good: `fix login session persistence after restart`
  - Bad: `updated code and fixed issue`
- No mixed-intent commits (refactor + feature, formatting + logic, etc.)

---

## 6. Definition of Done

A task is complete only when:

- implementation is finished
- tests are added and passing
- code review has been executed and all issues resolved (a blocked
  task is not done — it remains stopped per `testing-and-review.md`
  until you respond)
- a PR has been created
- the PR is in scope and within the size target (or oversize is
  explicitly flagged)
- the preflight checklist above is complete
- no concerns remain unresolved