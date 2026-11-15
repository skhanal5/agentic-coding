---
name: shipping
description: This skill should be used when the user is ready to ship or create a PR and needs the pre-PR gate. Use when the user asks to check PR size, run the code review gate, or complete the preflight checklist.
---

# Shipping

Run this skill before you create a PR. It is the final gate between finished code and a PR. Do not create a PR without passing it.

This skill does not repeat rules from other skills. For branch, commit, comment, test, and PR rules, load those skills.

## 1. When to run

- After Verify in `workflow` is complete.
- After all code and tests are done per `testing`.
- Before you load `create-a-pr`.
- If a check fails, stay in this gate and fix it.

## 2. PR size

- Target is under 500 lines of diff.
- If the diff is over target, stop and propose a split.

Split rules:
- Each split PR works on its own.
- Each split PR passes tests at its own head commit.
- A split PR may stack on another split PR. For stacked PR commands and rules, read `references/stacked-prs.md`.

Exception:
- If a split would force tests to cover an incomplete feature, keep the larger PR.
- Flag the size in the PR description under Risks or Testing per `create-a-pr`.

## 3. Code review gate

- Invoke the `code-review` skill on this branch. Do it after the last commit and before you create the PR.
- Each PR branch needs its own invocation. These do not count:
  - The skill text still in context from an earlier run or another branch
  - A manual review against the skill checklist
- The review output has a record of the commit it covered. See Review record in `code-review`. The checklist below needs that SHA.

If review finds fixable issues:
- Fix them in the same PR. Fixable means the issue is in code you changed and the fix does not expand scope.
- Invoke `code-review` again on the new head commit.
- Repeat until no fixable issues remain.

If review finds blocked issues:
- Stop. Do not create a PR.
- Report the issue, why it cannot be fixed in scope, and the options.
- Wait for user input per `workflow` stop conditions.

Defer no issue to a future PR.

## 4. Preflight checklist (required output)

Before you create a PR, output this checklist exactly. Check each item. All items must be true.

```
- [ ] Feature is fully implemented per plan in `workflow`
- [ ] Scope matches plan. No unintended file changes
- [ ] Tests are added and passing per `testing`
- [ ] `code-review` invoked on this branch at head commit <SHA>, with verdict Approved and no commits since
- [ ] PR size is less than 500 lines, or overage is flagged with reason
- [ ] No TODOs left unresolved and no deferred work
- [ ] Change is reversible
```

Branch, commit, comment, and PR text rules are not in this list. Their own skills own them. Load those skills at their steps in `workflow`.

Replace `<SHA>` with the SHA from the review record. It must match `git rev-parse --short HEAD`. If you cannot point to a `code-review` invocation on this branch with that SHA, the item is false.

If any item is not true, stop. Return to the right `workflow` state and fix it. Do not create a PR.

## 5. Definition of done

A task is done only when all of these are true:

- Implementation is finished per `workflow`.
- Tests are added and passing per `testing`.
- `code-review` ran on the final head commit with verdict Approved.
- The PR size check is met or flagged.
- The preflight checklist is complete.
- The PR exists with a title and description per `create-a-pr`.
- No concerns remain unresolved.
