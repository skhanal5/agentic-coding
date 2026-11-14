---
name: workflow
description: This skill should be used when the user starts a non-trivial code change, new feature, bug fix, or multi-file edit. Use when the user asks to understand, plan, implement, verify, or create a PR with scope control and stop conditions.
---

# Workflow Discipline

State machine for any non-trivial code change. Skip it for read-only questions and single-line fixes. Scope rules still apply to those.

```
Understand → Plan → Create Branch → Implement → Verify → Create PR → Done
              ↑                          ↑          |
              └── stop and ask           └── stop and fix
```

- Move in order. Do not skip a state.
- Each state has tasks, an exit check, and stop conditions.
- If a stop condition fires, stay in the state. State the issue in bullets, propose options, and wait for input.
- Delegate work and manage context as described in `references/delegation-and-context.md`. Read it before you plan subagent work. Read it again when context reaches 70 percent.

---

## 1. Understand

Goal: know what to build and why before you change code.

- Read all relevant files fully. Do not read snippets.
- Find how the area is used today.
- State assumptions, risks, and unknowns in plain words.

Exit check:
- You can explain the change to a new reader in plain English.
- You know which files and behaviors are in scope.

Stop if requirements are unclear, system context is unclear, or goals conflict.

---

## 2. Plan

Goal: define how to build the change before you write code. A human and an agent must both be able to follow the plan.

- List files to change and files to leave alone.
- Describe behavior changes in bullets.
- Note risks and tradeoffs.
- Give a high-level test strategy. Details are in `testing`.
- For each subagent task, write the goal, scope limits, output format, and model variant.
- Keep it short. Use bullets, file paths, and line numbers.

Exit check:
- A human can approve scope and risks from the plan alone.
- An agent with only the plan can run the next step without questions.
- The scope fits one branch purpose.

Stop if the change needs multi-file or architecture approval you do not have, requirements are unclear, or the plan needs more than one branch.

Ask for confirmation before you move on. Do not start code before then.

---

## 3. Create Branch

- Load `make-a-branch` and follow it.
- If a branch already exists and is wrong, stop and ask. Do not reuse it.

---

## 4. Implement

Goal: build the change in small, valid steps.

This state loops. Each loop makes one small commit. For each loop, load these skills in order:

1. `testing` for code and tests
2. `make-a-code-comment` for comments
3. `make-a-commit` for the commit

Scope control:
- Change only files in the approved plan.
- Add no unrelated refactors and no extra behavior.
- If new complexity appears, stop. Return to Plan and get confirmation. Or split the extra work to a new branch per `make-a-branch`.

Stop if:
- Requirements or correctness are ambiguous.
- You are unsure about the architecture.
- The work needs files outside the plan.
- Tests are missing for the change you just made.
- You cannot keep commits valid and isolated.

Exit check:
- All planned behavior is done.
- All checks from `testing`, `make-a-code-comment`, and `make-a-commit` pass.
- You reviewed all subagent output.

---

## 5. Verify

Goal: prove the change is correct before you open a PR.

- Load `testing` and confirm tests pass.
- Load `shipping` and confirm PR size and the review gate pass.

Stop if tests fail or are missing, the PR is over size without a valid exception, or review finds blocked issues. Return to Implement or Plan as needed.

---

## 6. Create PR

- Load `create-a-pr` for the title and description.
- Load `shipping` for the preflight checklist.
- Fix any unchecked item before you create the PR.

---

## 7. Done

`shipping` defines done. Confirm its checklist is complete.

---

## Which skill when

- Branch: `make-a-branch`
- Implement loop: `testing`, `make-a-code-comment`, `make-a-commit`
- Verify: `testing` and `shipping`
- Create PR: `create-a-pr` and `shipping`

If you skip a skill load, stop and go back to load it.
