# PR examples

Use this with the `create-a-pr` skill.

## Concise PR

```
feat: add retry logic

## Background
- App failed on 429 responses. No retry existed.
- Users saw errors during busy periods.

## Changes
- Add retry with increasing delay. Start at 1 second. Cap at 30 seconds.
- Respect Retry-After header when present.
- Add unit tests for retry logic.

## Testing
- Ran unit tests. All pass.
- Tested manually with mock 429 responses. Verified delay and cap.
```

## PR with risk

```
fix: add rate limiting

## Background
- Login endpoint had no rate limit. Risk of brute force attacks.
- Need to limit requests per user.

## Changes
- Add rate limit of 5 requests per minute on login.
- Return 429 when limit is reached. Include Retry-After header.

## Risks
- Valid users may hit limit during retry. Impact is low. Mitigation is clear error message.

## Testing
- Added integ tests for limit and 429 response.
- Verified Retry-After header in tests.
- Manual test with 6 rapid logins. Sixth request returned 429.
```

If a PR is unusually complex, add more bullets or a short note under a section. Keep the language plain.
