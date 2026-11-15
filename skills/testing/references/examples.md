# Testing examples

Use this with the `testing` skill.

## Shared helpers

Good:
- `newTestServer` builds a test HTTP server with fixed config.
- `newTestUser` builds a valid user object.

Bad:
- Copy and paste of 20 lines of setup in each test.

## Go table-driven test

```go
// Each case has a name. The test name states the behavior.
cases := []struct {
  name    string
  input   string
  want    string
  wantErr bool
}{
  {name: "valid input returns value", input: "a", want: "a", wantErr: false},
  {name: "empty input returns error", input: "", want: "", wantErr: true},
}
for _, tc := range cases {
  t.Run(tc.name, func(t *testing.T) {
    t.Parallel()
    // call the code and assert
  })
}
```

## Real behavior

Good:
- Error is not nil when input is invalid.
- Returned value equals expected value.
- Storage has one new record after the call.

Bad:
- A test that calls the function and asserts `true == true`.
- A test that mocks the unit under test and checks the mock.
- A test with no assertion.

## Cleanup

Good:
- Create a temp dir per test and remove it in cleanup.
- `t.Cleanup(func() { os.Remove(tmpFile) })`

Bad:
- Write to a shared file in one test and read it in another without cleanup.

## Parallel

```go
func TestAdd(t *testing.T) {
  t.Parallel()
  // each isolated case also calls t.Parallel()
}
```

If a test needs shared state, document why. Keep it out of the parallel group.

## Portable

Good:
- `t.TempDir()` for temp files.
- `filepath.Join` for paths.

Bad:
- Hardcoded `/tmp/mytest` or `/Users/name` paths.
- A test that fails on Windows because it uses Unix sockets with no check.
