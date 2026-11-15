---
name: writing-skills
description: Use this skill whenever the user asks to add, change, shorten, split, or tune a skill in this repo, or to write or fix a skill description or its trigger evals. Examples are "add a skill for X", "this skill never triggers", "make this skill shorter", and "write evals for the skill". It sets the repo rules for SKILL.md, references, trigger evals, and cheap eval runs. Use it before you edit anything under `skills/`. Skip it for using a skill.
---

# Writing skills

Rules for the skills in this repo. Run `python3 scripts/check_skills.py` before you open a PR.

## Layout

```
skills/<name>/SKILL.md      Instructions. 150 lines at most.
skills/<name>/references/   Long detail. Linked from SKILL.md.
skills/<name>/evals/triggers.json
```

- The folder name and the `name` field are the same.
- Move detail that is not needed on every use into `references/`. Say in `SKILL.md` when to read each file.
- One skill has one job. Split a skill that has two.

## Description

The description decides when the skill loads. It is the most important text in the skill.

- Name the real requests that should load it. Use words a user would type. Opening with "Use this skill whenever" works well.
- Say "Use it even if the user does not say <name>". Models under-trigger skills.
- End with what to skip and which skill to use instead. This prevents overlap.
- Keep it under 1024 characters. Use plain English with no em dashes and no semi-colons.

## Body

- Write steps, rules, and stop conditions. Do not write essays.
- Give the reason for a rule in a few words. Avoid shouting.
- Use `CLAUDE.md` for language rules. Do not copy them.
- Link other skills by name. Do not copy their rules.

## Trigger evals

- `evals/triggers.json` is a list of `{"query": "...", "should_trigger": true|false}`.
- Write at least 5 prompts that should trigger and 5 that should not.
- Write prompts like a real user. Use file names, context, and casual wording.
- Make the should-not prompts near misses. Use requests that touch a neighboring skill. Do not use obvious unrelated requests.
- Ask the user to approve new prompts.

## Running evals

Evals run real model sessions. They cost usage. Run them only when the user agrees.

- Use a cheap model, for example Haiku, for quick checks. Use the main model for a final check.
- Use 1 run per prompt and 1 worker first. Raise them only if results are noisy.
- Run one skill at a time. Do not run all skills at once.
- The runner is the `skill-creator` script `run_eval.py`. See the README for the command.
- A copy of the skill in `~/.claude/skills` competes with the test copy. Count a trigger on the real skill name, or the results read 0.
- Read the missed prompts. Rewrite the description to name those requests. Run again.

## Checklist

- [ ] Folder name and `name` match
- [ ] Description names real requests, says "even if", and says what to skip
- [ ] `SKILL.md` is 150 lines or less
- [ ] Trigger evals have 5 and 5 prompts and the user approved them
- [ ] `python3 scripts/check_skills.py` passes
- [ ] README lists the skill
