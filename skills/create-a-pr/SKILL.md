---
name: create-a-pr
description: This skill should be used when the user asks to create a PR, write a PR title or description, or check PR format. Use when the user asks to create operation colon summary titles and Background, Changes, Testing, Risks descriptions.
---

# Create a PR

Guidelines for PR titles and descriptions

---

## 1. PR Title

- Format: `<Operation>: <summary>`
  - `Operation` must match branch operation from `make-a-branch` skill: `feat`, `fix`, `chore`, `test`, `docs`, `refactor`, `perf`, `ci`, `build`
  - Use lowercase operation
  - `summary`: 2 to 4 words that describe the change. Use plain words. Keep it short.
  - Title mirrors branch name. Branch `feat/add-retry-logic` becomes title `feat: add retry logic`
- Keep title to one short line. No period at end.

**Examples (valid):**
- `feat: add retry logic`
- `fix: add rate limiting`
- `chore: update readme`
- `test: add integ tests`

**Invalid:**
- `Add retry logic` (missing operation)
- `feat/add-retry-logic` (branch format, not PR title format)
- `feat: leverage exponential backoff strat to amortize tail latency` (jargon heavy)
- `Feat: Add Retry Logic` (wrong case)

If title cannot follow this format:
→ STOP and ask.

---

## 2. PR Description

Description must be concise and easily understandable by a reader with zero knowledge of the codebase. Prefer bullets over paragraphs. Keep it short unless the PR has unusual complexity that needs more detail.

Description has 3 to 4 sections. Use this order and these headings:

### Background
- What is the change and why is it needed
- Use 2 to 4 bullets
- Explain the problem or goal in plain terms

### Changes
- What was changed at a high level
- Use bullets, one bullet per key change
- Do not list every file. Group related changes.

### Testing
- How was the change validated
- How were risks checked if risks exist
- Use bullets. Include commands or test types when helpful.

### Risks (optional)
- Include only if the PR introduces risk
- If no risk, omit this section. Do not add a placeholder.
- Use bullets to state each risk and its impact or mitigation.

---

## 3. Language Standard

- Use plain English that a new reader can understand with no prior context
- Prefer ASD-STE100 Simplified Technical English:
  - Use short sentences with one idea per sentence
  - Use simple verbs and common words
  - Use active voice
  - Use the same word for the same idea everywhere
  - Avoid jargon, idioms, and complex terms
  - Define a term if you must use it, then use it consistently
- No em dashes
- No semi-colons. Use periods to separate ideas.
- Bullets over paragraphs. Each bullet is one idea.

**Good:**
- `Fix login retry. Server returned 429 without Retry-After. Added fallback wait.`

**Bad:**
- `Leverage holistic synergy to ameliorate retry storm via exponential backoff strat` (jargon heavy, not plain English)

---

## 4. Template

Use this template for every PR:

```
## Background
- Why this change exists
- What problem it fixes or what goal it meets

## Changes
- High level change 1
- High level change 2
- High level change 3

## Risks
- Risk 1 and how it is handled (omit section if no risk)

## Testing
- How you tested the change
- How you checked risks
```

**Example (concise PR):**

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

**Example with risk:**

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

If PR is unusually complex, you may add more bullets or a short note under a section, but keep language plain and concise.

---

## 5. Checklist Before Creating PR

- [ ] Title follows `<Operation>: <summary>` and matches branch operation
- [ ] Title is concise and plain English with no jargon
- [ ] Description has Background, Changes, Testing, and Risks only if needed
- [ ] Description uses bullets, not long paragraphs
- [ ] Description is concise. Longer only if PR has unusual complexity
- [ ] Language is plain English, follows STE100, no jargon
- [ ] No em dashes, no semi-colons
- [ ] Reader with zero context can understand it

If any item fails:
→ Fix before creating PR.
