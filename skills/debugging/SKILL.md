---
name: debugging
description: Use this skill whenever the user reports a bug, crash, wrong output, flaky behavior, or regression and the cause is not yet known. Examples are "this throws a null error sometimes", "the total is wrong", "it worked yesterday", "why does this hang", and "find out why". It sets the order of work: reproduce, narrow down, find the root cause, then fix. Use it before you edit any code for the fix. Skip it when the cause is already known and the user only wants the fix built. Use `workflow` or `tdd` for that.
---

# Debugging

Find the cause of a bug before you change code. A fix without a known cause often hides the bug and does not remove it.

## Steps

1. **State the problem.** Write what happens, what should happen, and how to trigger it. Ask the user if any of these is missing.
2. **Reproduce.** Make the bug happen on demand with a command, a test, or a script. If you cannot reproduce it, stop. Say what you tried and ask for more detail. Do not guess a fix.
3. **Narrow down.** Cut the problem in half again and again. Use one method at a time:
   - Check the input and output at each step.
   - Use `git bisect` or compare against the last good commit.
   - Remove parts of the code or data until the bug goes away.
4. **Find the root cause.** Write one hypothesis in a sentence. Run one check that could prove it wrong. Repeat until a check confirms the cause. Read the code that runs, not the code you expect to run.
5. **Fix the cause.** Make the smallest change that removes the cause. Do not patch the symptom.
6. **Prove the fix.** Load `tdd`. Write a test that fails because of the bug, then see it pass with the fix. Run the full test suite.
7. **Report.** State the cause, the fix, and the evidence in bullets.

## Rules

- Change one thing at a time. Undo changes that did not help.
- Do not leave debug prints or temporary code in the fix.
- Keep notes of what you checked and what you learned. This prevents repeat work.
- Do not trust a fix you cannot reproduce failing first.

## Stop conditions

- You cannot reproduce the bug.
- Two hypotheses in a row fail and you have no new evidence. Report what you know and ask.
- The root cause is in code outside the approved scope. State it and ask.

## Checklist

- [ ] The bug is reproduced on demand
- [ ] The root cause is named and confirmed by a check
- [ ] The fix changes the cause, not only the symptom
- [ ] A test fails without the fix and passes with it
- [ ] No debug code remains
