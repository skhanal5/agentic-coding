---
name: testing
description: This skill should be used when the user asks to write tests, add unit tests, review tests, or needs TDD guidance. Use when the user asks to cover happy, unhappy, and edge cases with table-driven and behavioral tests.
---

# Testing

Guidelines for testing code

---

## 1. PR Test Requirement

- Every PR must include unit tests for the code it changes
- Tests live in the same PR as the code they cover. No follow up PR for tests.
- If a PR has no functional change, explain why tests are not needed. Otherwise add tests.
- Tests must match the change. Do not add unrelated tests to meet the rule.

If tests are missing:
→ STOP. Add tests before PR creation.

---

## 2. TDD Style

- Prefer test driven development
- Write the test with the code change, not at the end of implementation
- Steps:
  - Write a failing test for the next small behavior
  - Write the smallest code to make it pass
  - Refactor while keeping tests green
- If you did not follow TDD, still write tests before you mark the PR ready. Do not defer tests.

---

## 3. What To Test

Test three groups for each behavior:

- Happy path: expected input and expected output. Shows the feature works.
- Unhappy path: invalid input, errors, or failure modes. Shows error handling works.
- Edge cases: empty values, limits, off by one, timeouts, retries, concurrent use.

Keep each test focused on one behavior. Use clear names that state the case.

**Example:**
- `returns user when id is valid` (happy path)
- `returns error when id is missing` (unhappy path)
- `returns error when id is zero` (edge case)

---

## 4. Shared Helpers

- Do not reinvent the wheel in tests
- If many tests repeat the same setup, refactor to a shared helper
- Keep helpers small and focused. One helper does one job.
- Put helpers near the tests that use them or in a common test helper package if the language allows it
- Name helpers clearly. A new reader must understand what the helper does.

**Good:**
- `newTestServer` that builds a test HTTP server with fixed config
- `newTestUser` that builds a valid user object

**Bad:**
- Copy and paste of 20 lines of setup in each test

If a helper grows too large or hides the test intent:
→ Simplify the helper or inline the setup.

---

## 5. Language Standards

- Follow the idiom of the language you use
- Go: use table driven tests. One table per behavior. Each row is a case with name, input, and expected result.
- Other languages: use their standard pattern for parameterized tests where it exists
- Keep test structure consistent across the codebase. Match existing style if one exists.

**Go example:**

```
// Test cases use table driven style. Each case has a name.
// Test name states the behavior.
cases := []struct {
  name string
  input string
  want string
  wantErr bool
}{
  {name: "valid input returns value", input: "a", want: "a", wantErr: false},
  {name: "empty input returns error", input: "", want: "", wantErr: true},
}
for _, tc := range cases {
  t.Run(tc.name, func(t *testing.T) {
    // parallel where possible, see section 8
  })
}
```

---

## 6. Behavior Not Hacks

- Tests must verify meaningful behavior. They must not pass for the sake of passing.
- Assert on observable results. Check return values, errors, state changes, or calls that matter.
- Do not write tests that only check that code runs without error but do not check what it does
- Do not mock everything so the test cannot fail. Mock only what you must.

**Good:**
- `got error is not nil when input is invalid`
- `got value equals expected value`
- `storage has one new record after call`

**Bad:**
- Test that calls the function and asserts true is true
- Test that mocks the unit under test and then checks the mock
- Test with no assertion at all

If a test does not verify useful behavior:
→ Rewrite the test or delete it.

---

## 7. Stateless and Cleanup

- Prefer stateless tests. Stateless tests avoid race conditions and are easy to run in any order.
- Each test must set up its own data. Do not depend on order or on shared mutable state.
- If state is needed, clean it up:
  - Use `t.Cleanup` in Go or `afterEach` or `defer` or the language equivalent
  - Reset files, DB rows, env vars, and global state after the test
  - Use temp directories or isolated test instances where possible
- Do not leave test data behind that affects the next test

**Good:**
- Create temp dir per test, remove it in cleanup
- Use `t.Cleanup(func() { os.Remove(tmpFile) })`

**Bad:**
- Write to a shared file in one test and read it in another without cleanup

---

## 8. Parallel Execution

- Tests must be able to run in parallel for speed
- Mark tests as parallel where safe. In Go use `t.Parallel()` at top level and inside `t.Run` when the case is isolated.
- Do not share mutable state between parallel tests
- If a test cannot run in parallel because it needs shared state, document why and keep it out of the parallel group

**Good:**
```
func TestAdd(t *testing.T) {
  t.Parallel()
  // test cases each call t.Parallel() if isolated
}
```

---

## 9. Portable Execution

- Tests must run on CI and on any developer device
- Do not use OS or arch specific logic. Avoid hardcoded paths like `/Users/name` or `C:\temp`.
- Use temp directories, relative paths, or test helpers that work on all platforms
- Do not depend on local env vars, local DB, or network unless the test sets them up or skips cleanly when missing
- If a test needs an external tool, check for it and skip with a clear message when it is not present

**Good:**
- `t.TempDir()` for temp files. Works on all platforms.
- `filepath.Join` for paths. Works on all OS.

**Bad:**
- `/tmp/mytest` hardcoded for Linux only
- Test that fails on Windows because it uses Unix sockets without check

---

## 10. Checklist Before PR

- [ ] Every functional change has unit tests in the same PR
- [ ] Tests were written with the code change in TDD style or at least before PR ready
- [ ] Happy path, unhappy path, and edge cases are covered
- [ ] No repeated setup. Shared helpers used where helpful.
- [ ] Tests follow language idiom such as table driven tests in Go
- [ ] Tests verify meaningful behavior. No hack tests.
- [ ] Tests are stateless or clean up state correctly
- [ ] Tests can run in parallel where possible
- [ ] Tests run on CI and on any device with no OS or arch specific logic
- [ ] Tests are concise and plain. Names state the behavior.

If any item fails:
→ Fix before creating PR. No deferred test work.
