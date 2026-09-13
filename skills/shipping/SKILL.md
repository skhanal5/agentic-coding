---
name: shipping
description: This skill should be used when the user is ready to ship or create a PR and needs the pre-PR gate. Use when the user asks to check PR size, run the code review gate, or complete the preflight checklist.
---

# Shipping

Run this skill before you create a PR. It is the final gate between done code and a PR. Do not create a PR without passing this gate.

This skill does not duplicate rules from other skills. For branch, commit, comment, test, and PR title and description rules, load those skills directly.

---

## 1. When To Run

- Run after Verify in `workflow` is complete
- Run after all code and tests are done per `testing`
- Run before you load `create-a-pr`
- If any check fails, stay in this gate and fix before you create a PR

---

## 2. PR Size

- Target is less than 500 lines diff
- If diff is over target:
→ STOP and propose a split

**Split rules:**
- Each split PR must be independently functional
- Each split PR must pass tests on its own
- No split PR may depend on incomplete work in another split PR
- No stacked PRs

**Exception:**
- If a split would force tests to cover an incomplete feature, keep the larger PR
- Flag the size in the PR description per `create-a-pr` Risks or Testing section
- This matches `testing` rule that tests must be in the same PR as the code they cover

---

## 3. Code Review Gate

- Invoke the `code-review` skill on this branch. Do it after the last commit and before you create the PR.
- Every PR branch needs its own invocation. These do not count as a review:
  - The skill's text still in context from an earlier run or another branch
  - A review done by hand against the skill's checklist
- The review output includes a record of the commit it covered. See Review Record in `code-review`. The checklist below asks for the SHA in that record.
- Do not skip this step. The checklist below requires it.

**If code review finds fixable issues:**
- Fix them in the same PR
- Invoke `code-review` again after each fix, on the new head commit
- Repeat until no fixable issues remain
- Fixable means the issue is in code you added or changed and can be fixed without expanding scope beyond the current plan

**If code review finds blocked issues:**
- STOP. Do not create a PR.
- Report the issue, why it cannot be fixed in scope, and options
- Wait for user input per `workflow` stop conditions
- There is no `testing-and-review` skill. Use `testing` for test gate and `code-review` for review gate.

No issues may be deferred to a future PR.

---

## 4. Preflight Checklist (MANDATORY OUTPUT)

Before you create a PR, output this checklist exactly and check each item. All items must be true.

```
- [ ] Feature is fully implemented per plan in `workflow`
- [ ] Scope matches plan. No unintended file changes
- [ ] All tests are added and passing per `testing`
- [ ] `code-review` invoked on this branch at head commit <SHA>, with verdict Approved and no commits since
- [ ] PR size is less than 500 lines, or overage is flagged with reason
- [ ] No TODOs left unresolved
- [ ] No deferred work exists
- [ ] Branch follows `make-a-branch`
- [ ] Commits follow `make-a-commit`
- [ ] Comments follow `make-a-code-comment` where needed
- [ ] PR title and description will follow `create-a-pr`
- [ ] Change is reversible
```

Replace <SHA> with the SHA from the review record. It must match `git rev-parse --short HEAD`. If you cannot point to a `code-review` invocation on this branch whose record shows that SHA, the item is false.

If any item is not true:
→ STOP. Return to the correct `workflow` state and fix it. Do not create a PR.

PR creation is not allowed without a completed checklist.

---

## 5. Definition of Done

A task is done only when all of these are true:

- Implementation is finished per `workflow`
- Tests are added and passing per `testing`
- `code-review` has been invoked on the final head commit, with verdict Approved
- PR size check above is met or flagged
- Preflight checklist above is complete
- PR has been created with title and description per `create-a-pr`
- No concerns remain unresolved

If any item is not true, the task is not done.
