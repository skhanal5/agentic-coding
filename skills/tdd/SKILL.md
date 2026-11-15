---
name: tdd
description: Use this skill whenever the user wants to build or fix behavior test-first. Examples are "do TDD", "write the failing test first", "red green refactor", "where do I start with tests for this feature", and any new function, endpoint, or bug fix where tests should drive the code. It sets the loop of one failing test, the smallest code to pass, then a refactor. Use it before you write code for a change that needs tests. Skip it for reviewing or repairing existing tests. Use `testing` for that.
---

# TDD

Write tests first. Each test drives one small piece of behavior. This keeps the change small and proves each step works.

For rules on what makes a good test, load `testing`. This skill covers the order of work.

## The loop

Repeat for each behavior in the plan:

1. **Pick one behavior.** Choose the smallest next behavior. Write it as one plain sentence.
2. **Red.** Write one test for it. Run the test. It must fail, and it must fail for the right reason. A test that passes at once proves nothing. Fix the test.
3. **Green.** Write the smallest code that makes the test pass. Do not add behavior the test does not need.
4. **Refactor.** Clean up the code and the test. Run all tests after each change. They stay green.
5. **Commit** per `make-a-commit`.

## Order of behaviors

- Start with the happy path.
- Then add the unhappy paths: invalid input, errors, failure modes.
- Then add edge cases: empty values, limits, off-by-one, retries, timeouts.

## Bug fixes

- Write a test that reproduces the bug first. Run it and watch it fail.
- Fix the code. Watch the test pass.
- Keep the test. It guards against the bug returning.

## Rules

- Never write code before a failing test, except to make the test compile.
- Never write more than one failing test at a time.
- Never change a test only to make it pass. Change it only if the expected behavior was wrong.
- If a step feels too big, split it into smaller behaviors.
- If you cannot test a behavior, stop and ask. Do not skip the test.

## Stop conditions

- Requirements for the next behavior are unclear.
- The test fails for a reason you do not understand.
- The code needs files outside the approved plan.

## Checklist

- [ ] Each behavior has a test that failed first
- [ ] Each test failed for the right reason
- [ ] Each step used the smallest code to pass
- [ ] All tests pass after every refactor
- [ ] Happy, unhappy, and edge cases are covered
- [ ] Each step is its own small commit
