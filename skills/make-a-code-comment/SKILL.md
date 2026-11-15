---
name: make-a-code-comment
description: This skill should be used when the user asks to write, add, or review code comments. Use when the user asks to document why code exists, label hacks, or reference bugs in concise plain STE100 English.
---

# Make a code comment

Guidelines for writing comments in code.

## 1. General rule

- Keep comments short by default.
- Explain why the code exists. Do not repeat what clear code already says.
- Write for a reader with zero knowledge of the codebase.
- Add more detail only if the code is unusually complex.

If the code is clear without a comment, add no comment.

## 2. Language

- Follow the Language rules in `CLAUDE.md`. Make the text easy to translate.

Good: `Retry three times before failure. Wait longer between each retry.`

Bad: `Leverage exponential backoff strat to amortize tail latency` (jargon)

## 3. Longer comments

Use a longer comment only for unusually complex code. State the reason, the tradeoff, or the expected result in simple steps.

```
// Retry with increasing delay. Start at 1 second. Double each time.
// Stop at 30 seconds. This prevents many clients from retrying at once.
```

## 4. Bug, incident, or issue references

- If code exists because of a bug or incident, reference it. Use an issue ID, ticket link, or incident date.
- State what happened in one short, factual line.
- Do not paste long logs. Skip the reference if it does not help the reader.

```
// Fix for login failure on retry. See issue 482. Server returned 429 without Retry-After.
// Added fallback wait of 2 seconds. Prevents tight retry loop.
```

## 5. Hack or temporary fix

- Start the comment with `HACK:` or `TEMP FIX:`.
- Say why it is a hack and what the proper fix is. Link a follow-up ticket if one exists.
- Do not hide a hack. Make it easy to find and remove.

```
// HACK: Use fixed wait of 5 seconds. Proper fix is to read Retry-After header. See ticket 891.
// TEMP FIX: Skip validation for old records. Old data has no owner field. See issue 523.
```

## 6. Checklist before adding a comment

- [ ] The comment is needed. The code alone is not clear enough.
- [ ] It is short. Extra detail only for complex code.
- [ ] The language follows `CLAUDE.md`
- [ ] A reader with zero context can understand it.
- [ ] A bug or incident reference is included if relevant.
- [ ] A hack or temporary fix is labeled with the next step.

If any item fails, rewrite the comment before committing.
