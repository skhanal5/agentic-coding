---
name: code-review
description: Use this skill whenever the user asks to review code quality on a branch or PR. Examples are a maintainability review, a thermo-nuclear review, a code judo check, too many wrapper helpers or abstractions, a file that grew too big, special-case branches that make code messy, or a change that feels more complicated than it should be. It runs a strict structural review and ends with a verdict line that the `shipping` gate checks. Use it even if the user does not say "code review". Skip it for PR text, tests, and merge conflicts.
---

# Thermo-Nuclear Code Quality Review

Use this skill for a strict review of implementation quality, maintainability, abstraction quality, and codebase health.

Be **ambitious** about structure. Do not stop at local cleanups. Look for "code judo" moves. A code judo move is a restructuring that keeps behavior and makes the code much simpler, smaller, and more direct.

## Baseline prompt

> Perform a deep code quality audit of the current branch's changes.
> Rethink how to structure and implement the changes to improve code quality without changing behavior.
> Improve abstractions and modularity. Reduce spaghetti code. Improve succinctness and legibility.
> Be ambitious. If a clear path needs restructuring part of the codebase, take it.
> Be thorough and rigorous. Measure twice, cut once.

## Standards

0. **Simplify structurally.** Look for a reframing that makes whole branches, helpers, modes, or layers disappear. Prefer deleting complexity over rearranging it.
1. **Watch file size.** A PR must not push a file from under 1000 lines to over 1000 lines without a strong reason. Ask if the code should be split first.
2. **Stop spaghetti growth.** Treat new ad-hoc conditionals, scattered special cases, and one-off branches in unrelated flows as design problems. Move the logic behind its own abstraction.
3. **Fix the design, not only the behavior.** Do not approve "it works" code that leaves the codebase messier.
4. **Prefer direct, boring code.** Flag magic behavior, thin wrappers, identity helpers, and pass-through layers.
5. **Keep types and boundaries clean.** Question needless optionality, `any`, `unknown`, and casts. Prefer explicit typed models.
6. **Use the canonical layer.** Reuse existing helpers. Flag logic in the wrong package or leaking across a boundary.
7. **Flag avoidable orchestration complexity.** Examples are serial work that could run in parallel, and updates that can leave state half-applied.

For the full question list, flag list, remedies, and phrasing examples, read `references/review-checklist.md`.

## Output order

1. Structural regressions
2. Missed code judo simplifications
3. Spaghetti and branching growth
4. Boundary, abstraction, and type problems
5. File size and decomposition
6. Modularity and abstraction
7. Legibility

Do not flood the review with nits when larger structural issues exist. Give fewer comments with high conviction. Be direct and serious. Do not be rude. Do not soften major issues.

## Review record

Every review starts and ends with a fixed line. Together they prove the review happened. The `shipping` gate checks them.

Start with this line. The SHA is the head commit under review. Get it with `git rev-parse --short HEAD`.

```
Reviewed <branch> at <SHA> against <base>.
```

End with exactly one of these lines. The Approval bar decides which.

```
Verdict: Approved
Verdict: Changes needed. <one-line reason>
```

Review the committed diff. Read all of `git diff <base>...HEAD`. Do not rely on memory. Uncommitted changes are not in that diff, so commit them first. A new commit after the review needs a new review.

## Approval bar

Do not approve only because behavior seems correct. Approve only when none of these is true:

- A clear structural regression
- A visible code judo move that would remove a lot of incidental complexity
- An unjustified file-size jump, including crossing 1000 lines
- Ad-hoc branching that tangles an existing flow
- Feature checks scattered across shared code
- A hacky or magic abstraction, an unneeded wrapper, or cast-heavy contracts
- A boundary leak, a duplicated canonical helper, or logic in the wrong layer
- An obvious decomposition that would help maintainability and was skipped

Treat each item as a blocker unless the author justifies it clearly. If none applies, still leave explicit, actionable feedback.
