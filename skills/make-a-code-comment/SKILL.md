---
name: make-a-code-comment
description: This skill should be used when the user asks to write, add, or review code comments. Use when the user asks to document why code exists, label hacks, or reference bugs in concise plain STE100 English.
---

# Make a code comment

Guidelines for writing comments in code

---

## 1. General Rule

- Keep comments concise by default
- Add more detail only if the code is unusually complex and hard to understand from the code alone
- Explain why the code exists, not what the code does when the code is already clear
- Write for a reader with zero knowledge of the codebase

If the code is clear without a comment:
→ Do not add a comment

---

## 2. Language Standard

- Use plain English that is easy to translate and easy to understand
- Prefer ASD-STE100 Simplified Technical English
  - Use short sentences with one idea per sentence
  - Use simple verbs and common words
  - Use active voice
  - Use the same word for the same idea everywhere
  - Avoid jargon, idioms, and complex terms
  - Define a term if you must use it, then use it consistently
- Assume the reader is new to the project and to the domain

**Good:**
- `Retry three times before failure. Wait longer between each retry.`
- `Use cache here to avoid extra network calls`

**Bad:**
- `Leverage exponential backoff strat to amortize tail latency` (jargon heavy)
- `Utilize memoization paradigm for idempotent hydration` (not plain English)

---

## 3. Style Rules

- No em dashes
- No semi-colons
- Use short sentences
- Use periods to separate ideas, not semi-colons or em dashes
- Keep line length readable, break into two sentences if needed

**Good:**
- `Retry on 429. Wait for Retry-After header. Cap wait at 30 seconds.`

**Bad:**
- `Retry on 429 wait for Retry-After header` with em dash between clauses (do not use em dash)
- `Retry on 429 cap wait at 30s` with semi-colon between clauses (do not use semi-colon)

---

## 4. When To Add More Detail

- Add a longer comment only if the code is unusually complex
- Keep the long comment structured and still plain
- Explain the reason, the tradeoff, or the expected result in simple steps

**Example for complex code:**
```
// Retry with increasing delay. Start at 1 second. Double each time.
// Stop at 30 seconds. This prevents many clients from retrying at once.
// See design doc for retry limits.
```

For simple code, keep it to one short line or no comment at all.

---

## 5. Bug, Incident, or Issue References

- If code was added because of a bug or an incident, reference it
- Include a short note on what happened and where to find the full report
- Use an issue ID, ticket link, or incident date if available
- Keep the reference short and factual

**Examples:**
```
// Fix for login failure on retry. See issue 482. Server returned 429 without Retry-After.
// Added fallback wait of 2 seconds. Prevents tight retry loop.

// Workaround for outage on 2026-02-14. Cache was empty after deploy. This check rebuilds cache.
```

Do not add a reference if it does not help the reader. Do not paste long logs.

---

## 6. Hack or Temporary Fix

- If the code is a hack or temporary fix, say so clearly
- Use the label HACK or TEMP FIX at the start of the comment
- Explain why it is a hack and what the proper fix should be
- Link to a follow up ticket if one exists

**Examples:**
```
// HACK: Use fixed wait of 5 seconds. Proper fix is to read Retry-After header. See ticket 891.
// Remove this after API update.

// TEMP FIX: Skip validation for old records. Old data has no owner field. See issue 523.
// Plan to backfill owner field next sprint.
```

Do not hide a hack. Make it visible so it can be removed later.

---

## 7. Checklist Before Adding a Comment

- [ ] Comment is needed. Code alone is not clear enough
- [ ] Comment is concise. Extra detail only if code is unusually complex
- [ ] Language is plain English, no jargon, follows STE100 style
- [ ] No em dashes, no semi-colons
- [ ] Reader with zero context can understand it
- [ ] If due to bug or incident, reference is included
- [ ] If hack or temporary fix, it is labeled as HACK or TEMP FIX with next step

If any item fails:
→ Rewrite the comment before committing
