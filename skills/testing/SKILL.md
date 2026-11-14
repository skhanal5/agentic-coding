---
name: testing
description: This skill should be used when the user asks to write tests, add unit tests, review tests, or needs TDD guidance. Use when the user asks to cover happy, unhappy, and edge cases with table-driven and behavioral tests.
---

# Testing

Guidelines for testing code.

## 1. PR test requirement

- Every PR includes unit tests for the code it changes.
- Tests live in the same PR as the code. No follow-up PR for tests.
- If a PR has no functional change, explain why tests are not needed.
- Tests must match the change. Do not add unrelated tests to meet the rule.

If tests are missing, stop. Add tests before PR creation.

## 2. TDD style

- Write the test with the code change, not at the end.
- Steps:
  - Write a failing test for the next small behavior.
  - Write the smallest code to make it pass.
  - Refactor while tests stay green.
- If you skipped TDD, still write tests before you mark the PR ready.

## 3. What to test

Test three groups for each behavior:

- Happy path: expected input gives expected output.
- Unhappy path: invalid input, errors, and failure modes.
- Edge cases: empty values, limits, off-by-one, timeouts, retries, concurrent use.

Keep each test on one behavior. Name each test for the case.

- `returns user when id is valid` (happy)
- `returns error when id is missing` (unhappy)
- `returns error when id is zero` (edge)

## 4. Test real behavior

- Assert on observable results: return values, errors, state changes, or calls that matter.
- Mock only what you must. Never mock the unit under test.
- Do not write tests with no assertion, or tests that only check the code runs.

If a test does not verify useful behavior, rewrite it or delete it.

## 5. Structure

- Use the idiom of the language. In Go, use table-driven tests with one table per behavior. Each row has a name, input, and expected result.
- Match the existing style of the codebase.
- Move repeated setup into small shared helpers. If a helper hides the test intent, inline it.

## 6. Isolation

- Each test sets up its own data. No shared mutable state and no order dependence.
- Clean up files, DB rows, env vars, and globals. Use `t.Cleanup`, `afterEach`, or `defer`.
- Mark tests parallel where safe, for example `t.Parallel()` in Go.
- Tests must run on CI and on any device. Use temp directories and relative paths. Skip with a clear message when a needed tool or service is missing.

For examples of each point, read `references/examples.md`.

## 7. Checklist before PR

- [ ] Every functional change has unit tests in the same PR
- [ ] Tests were written with the code or before the PR was ready
- [ ] Happy, unhappy, and edge cases are covered
- [ ] Shared helpers replace repeated setup
- [ ] Tests follow the language idiom
- [ ] Tests verify real behavior
- [ ] Tests are stateless or clean up
- [ ] Tests run in parallel where possible
- [ ] Tests have no OS or arch specific logic
- [ ] Test names state the behavior

If any item fails, fix it before creating the PR.
