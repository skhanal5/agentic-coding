---
name: workflow
description: This skill should be used when the user starts a non-trivial code change, new feature, bug fix, or multi-file edit. Use when the user asks to understand, plan, implement, verify, or create a PR with scope control and stop conditions.
---

# Workflow Discipline

State machine for any non-trivial code change. Use for new features, bug fixes, or multi-file edits. Skip for read-only questions or single-line fixes, but scope rules still apply.

---

## Overview - State Machine

```
Understand → Plan → Create Branch → Implement → Verify → Create PR → Done
              ↑          |               ↑            |
              └──────────┘               └────────────┘
                    ↑                    ↑
              Stop and ask          Stop and fix
```

- Move in order. Do not skip a state.
- Each state has tasks and exit checks.
- If a stop condition fires, stay in the current state and ask or fix before you move forward.

---

## State 1: Understand

Goal: know what to build and why before you change code.

Tasks:
- Read all relevant files fully, not snippets
- Identify system context and how the area is used today
- State assumptions in plain words
- List risks and unknowns

Exit check:
- You can explain the change to a new reader in plain English
- You know which files and behaviors are in scope

Stop conditions:
- Requirements are unclear
- System context is unclear
- You find conflicting goals

If any stop condition is true:
→ STOP. State the issue, propose options, wait for input. Do not move to Plan.

---

## State 2: Plan

Goal: define how to build the change before you write code.

Tasks:
- List files to change and files to leave alone
- Describe expected behavior changes in plain bullets
- Note risks and tradeoffs in plain words
- Define test strategy at a high level. Details are in `testing` skill.

Exit check:
- Plan is written in bullets and is easy to review
- Scope is clear and matches one branch purpose

Stop conditions:
- Multi-file or arch changes are needed but not yet approved
- Requirements are still unclear
- Plan would need more than one branch

If any stop condition is true:
→ STOP. Ask for confirmation before you move to Create Branch. Do not start code.

---

## State 3: Create Branch

Goal: start work on a clean, correctly named branch.

Tasks:
- Load `make-a-branch` skill and follow it

Transitions:
- If branch already exists and is not correct:
→ STOP and ask. Do not reuse a wrong branch.
- After branch is created:
→ Move to Implement.

---

## State 4: Implement

Goal: build the change in small, valid, well commented steps.

This state loops. Each loop is one small commit. For each loop, load and follow these skills in order:

1. `testing` for code and tests
2. `make-a-code-comment` for comments
3. `make-a-commit` for the commit

After each commit, check scope control and stop conditions below before next loop.

### Scope Control (strict, applies for all of Implement)

- Only modify files in the approved plan
- Do not add unrelated refactors
- Do not add extra behavior beyond the plan
- Do not expand scope mid-task. If new complexity appears:
→ STOP. Return to State 2 Plan. Update plan and get confirmation. Or split extra work to a new branch. See `make-a-branch`.

### Stop Conditions During Implement

Stop and surface the issue rather than continue if any of these is true:
- Ambiguity in requirements or correctness
- Arch uncertainty
- Scope would need files outside the plan
- Tests are missing for the change you just made
- You cannot keep commits valid or isolated

When stopped:
1. State the issue clearly in plain bullets
2. Propose options
3. Wait for user input. Do not continue on assumptions.

Exit check for Implement:
- All planned behavior is done
- All checks from `testing`, `make-a-code-comment`, and `make-a-commit` pass

After exit check passes:
→ Move to Verify.

---

## State 5: Verify

Goal: prove the change is correct before you open a PR.

Tasks:
- Load `testing` skill and follow it to verify tests
- Load `shipping` skill and follow it to verify PR size and review gates

Stop conditions:
- Tests fail or are missing
- PR size is over target without a valid exception per `shipping`
- Review finds blocked issues that need scope outside the plan

If any stop condition is true:
→ Stay in Verify or return to Implement or Plan as needed. Do not move to Create PR.

Exit check:
- All checks from `testing` and `shipping` pass

After exit check passes:
→ Move to Create PR.

---

## State 6: Create PR

Goal: open a clear, concise PR that a reviewer can understand.

Tasks:
- Load `create-a-pr` skill and follow it for title and description
- Load `shipping` skill and follow it for preflight checklist

Stop conditions:
- Title or description does not meet `create-a-pr`
- Checklist from `shipping` has any unchecked item

If any stop condition is true:
→ Fix before you create the PR.

---

## State 7: Done

Definition of done is defined by `shipping`. Confirm that `shipping` checklist is complete and all referenced skills are satisfied.

---

## Quick Reference - Which Skill When

- Understand and Plan: this skill
- Create Branch: `make-a-branch`
- Implement loop: `testing`, `make-a-code-comment`, `make-a-commit`
- Verify: `testing` plus `shipping`
- Create PR: `create-a-pr` plus `shipping`

If you skip a skill load:
→ STOP. Go back and load it.
