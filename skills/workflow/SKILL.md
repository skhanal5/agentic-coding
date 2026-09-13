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

## Delegation and Context Management

This section applies to all states. Use it to decide when to delegate and how to keep context healthy.

### Delegate Work to Subagents

- Delegate when work is independent and has a clear input and output.
- Keep the main agent as the owner of the plan and decisions. Subagents do scoped work and return results.
- Do not delegate tightly linked work that needs constant shared state.

Good candidates to delegate:
- Codebase search and reading many files
- Independent research tasks
- Parallel checks such as tests, lint, or type checks
- Isolated file edits that do not overlap with other edits

Bad candidates to delegate:
- Small edits where a direct tool call is faster
- Tasks that depend on the same files at the same time
- Final decisions on scope, risk, or plan

When you delegate:
- Write a short subagent brief. Include goal, scope, files in scope, files out of scope, and expected output format.
- Define what to return. Example is file paths, key lines, risks, and next steps.
- Ask the subagent to verify its own output before it returns.

### Choose Model Variant By Task Difficulty

Use a cheaper model when the task is simple. Use a stronger model when the task needs deep reasoning. This saves cost and keeps speed high.

- Simple tasks use cheap and fast variant. Example is Haiku. Use for file search, pattern search, listing files, simple reads, and formatting.
- Medium tasks use standard variant. Example is Sonnet. Use for routine edits, test writing, multi-file search with summary, and review.
- Complex tasks use strong variant. Example is Opus. Use for hard reasoning, arch decisions, large refactors, and ambiguous bug fixes.

How to choose:
- If the task is read only and has clear steps, use cheap variant.
- If the task needs code changes or some reasoning, use standard variant.
- If the task needs tradeoffs, unclear requirements, or high risk, use strong variant.
- When in doubt, start with standard variant. Move to strong variant only if needed.

Record the choice in the plan so the reader knows which variant does which task.

### Manage Context

Context degrades when it gets too large. Large context slows you down and hurts quality. Monitor context and act early.

Thresholds:
- At 70 percent of context, prepare a compact or handoff note.
- At 80 percent of context, compact or clear now. Do not wait.
- If you notice repeated confusion, lost details, or ignored rules, treat it as a degraded context even if the percent is lower.

What to keep:
- Current state in the workflow
- Approved plan and scope limits
- Key decisions and open questions
- Branch name and commit history
- Test results and next steps

What to drop:
- Raw file dumps you already summarized
- Full tool logs you already acted on
- Duplicated file reads

### How to Clear or Compact and Resume

You can clear or compact your own context. You must still resume work without loss.

To compact:
- Summarize what is done and what remains. Use bullets.
- Keep the plan, decisions, risks, and file lists.
- Drop raw content. Keep only summaries and key lines with file path and line number.
- Keep the next action. State the exact next state and task.

To clear and resume:
- Before you clear, write a handoff note. Include current state, plan, branch, done items, remaining items, and next action.
- Save the handoff note where you can reload it. Example is a temp file or the branch itself.
- After you clear, reload the handoff note first. Confirm scope and plan before you continue.
- Verify branch, files, and tests again after resume. Do not assume they are still correct.

Check context at each state exit and after each subagent return. If a threshold is hit, compact or clear before the next step.

---

## State 1: Understand

Goal: know what to build and why before you change code.

Tasks:
- Read all relevant files fully, not snippets
- Identify system context and how the area is used today
- State assumptions in plain words
- List risks and unknowns
- Delegate search and reading to subagents when the area is large. Use cheap variant for pure search. Use standard variant if summary and reasoning are needed.

Exit check:
- You can explain the change to a new reader in plain English
- You know which files and behaviors are in scope

Stop conditions:
- Requirements are unclear
- System context is unclear
- You find conflicting goals

If any stop condition is true:
→ STOP. State the issue, propose options, wait for input. Do not move to Plan.

Context check:
- If context is at or above 70 percent, compact before you move to Plan.

---

## State 2: Plan

Goal: define how to build the change before you write code. The plan must be clear for both a human and an agent.

Tasks:
- List files to change and files to leave alone
- Describe expected behavior changes in plain bullets
- Note risks and tradeoffs in plain words
- Define test strategy at a high level. Details are in `testing` skill.
- Break the work into subagent tasks where it helps. For each subagent task write:
  - Goal in one sentence
  - Inputs and scope limits
  - Expected output format
  - Model variant to use and why. Use cheap for simple, standard for routine, strong for complex.
- Make the plan executable. A new agent with only the plan can do the next step without extra questions.
- Keep the plan short. Use bullets. Use file paths and line numbers where needed.

Exit check:
- Plan is written in bullets and is easy to review
- Scope is clear and matches one branch purpose
- A human can approve scope and risks from the plan alone
- An agent can run the plan without asking for missing details. Inputs, outputs, and model variants are clear for each subagent task.

Stop conditions:
- Multi-file or arch changes are needed but not yet approved
- Requirements are still unclear
- Plan would need more than one branch
- Plan is not clear enough for a new agent to run

If any stop condition is true:
→ STOP. Ask for confirmation before you move to Create Branch. Do not start code.

Context check:
- If context is at or above 70 percent, compact before you move to Create Branch. Keep the full plan in the compacted context.

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

Context check:
- If context is at or above 80 percent, compact or clear and resume with a handoff note before Implement.

---

## State 4: Implement

Goal: build the change in small, valid, well commented steps.

This state loops. Each loop is one small commit. For each loop, load and follow these skills in order:

1. `testing` for code and tests
2. `make-a-code-comment` for comments
3. `make-a-commit` for the commit

After each commit, check scope control and stop conditions below before next loop.

Use subagents in this state when it helps:
- Delegate isolated edits or independent test writes to subagents. Assign model variant by difficulty. Use cheap for simple edits and standard for routine edits. Use strong only for hard edits.
- Keep one subagent per isolated area. Do not let two subagents edit the same file at the same time.
- The main agent reviews and commits after each subagent returns.

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
- All subagent outputs are reviewed and integrated

After exit check passes:
→ Move to Verify.

Context check:
- After each subagent return and after each commit, check context.
- At 70 percent, prepare a compact. At 80 percent, compact or clear and resume before the next loop. Keep plan, scope, branch, and remaining tasks.

---

## State 5: Verify

Goal: prove the change is correct before you open a PR.

Tasks:
- Load `testing` skill and follow it to verify tests
- Load `shipping` skill and follow it to verify PR size and review gates
- Delegate independent verification checks to subagents where it helps. Example is one subagent for tests and one for lint or type check. Use cheap variant for checks with no reasoning.

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

Context check:
- If context is at or above 70 percent, compact before Create PR. Keep test results and shipping checks in the compacted context.

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

Context check:
- If context is degraded, compact first. Keep PR title, description, and checklist in the compacted context.

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
- Delegation: use subagents with model variant by difficulty. See Delegation and Context Management
- Context: compact or clear and resume at 70 to 80 percent. See Delegation and Context Management

If you skip a skill load:
→ STOP. Go back and load it.
