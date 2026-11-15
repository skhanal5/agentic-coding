# agentic-coding

A small repository of **shared skills and policy** for Claude Code. The files here are never run by the agent directly. `setup.sh` copies them into `~/.claude`.

## Quick setup

```bash
git clone <url> ~/agentic-coding
~/agentic-coding/setup.sh
```

The script copies:
- `skills/` to `~/.claude/skills/` (without `evals/`)
- `templates/CLAUDE.md` to `~/.claude/CLAUDE.md`

The script warns before it overwrites an existing skills folder.

## Structure

```
templates/CLAUDE.md         Global policy: language rules, hard constraint, execution rule
skills/<name>/SKILL.md      One skill. Loaded when its description matches the task.
skills/<name>/references/   Long detail that SKILL.md links to. Loaded only when needed.
skills/<name>/evals/        Trigger evals for the skill. Not installed by setup.sh.
scripts/check_skills.py     Checks that every skill follows the rules below.
```

Skills:
- `workflow`: understand, plan, implement, verify, and PR discipline
- `make-a-branch`: branch naming and the single-purpose rule
- `make-a-commit`: small, valid commits with plain messages
- `make-a-code-comment`: plain comments, bug references, and HACK labels
- `debugging`: reproduce, find the root cause, then fix
- `writing-skills`: repo rules for adding and tuning skills
- `tdd`: test-first loop of red, green, refactor
- `testing`: what good tests look like and the PR test rule
- `code-review`: strict maintainability review with a review record
- `deslop`: remove AI-generated slop from a diff
- `shipping`: the pre-PR gate, PR size, and the preflight checklist
- `create-a-pr`: PR title and description format
- `fix-merge-conflicts`: resolve conflicts and confirm the build
- `verify-this`: prove a claim with baseline and treatment evidence

`CLAUDE.md` is short. It holds only rules that must apply in every session. Everything else lives in skills.

## Skill rules

- The folder name and the `name` field are the same.
- The `description` says when to use the skill. It names the requests that should load it.
- `SKILL.md` is at most 150 lines. Move long detail to `references/` and link to it.
- Each skill has `evals/triggers.json` with at least 5 prompts that should trigger it and 5 that should not.

Run the check and its tests before you open a PR:

```bash
python3 scripts/check_skills.py
python3 -m unittest discover -s tests
```

## Adding a skill

1. Create `skills/<name>/SKILL.md` with `name` and `description` frontmatter.
2. Write `skills/<name>/evals/triggers.json`. Use realistic prompts. Make the should-not-trigger prompts near misses.
3. Run the trigger evals and tune the description. See below.
4. Run `python3 scripts/check_skills.py`.
5. Run `./setup.sh` to install.

## Evals

Each `triggers.json` is a list of `{"query": "...", "should_trigger": true|false}`. It tests one thing. The skill description must make Claude load the skill for the right prompts and ignore the wrong ones.

Run the evals with the `skill-creator` scripts. Run them from a folder that has a `.claude/` directory. The runner writes a temporary command file there.

```bash
SC=<path to the skill-creator skill>
PYTHONPATH=$SC python3 $SC/scripts/run_eval.py \
  --eval-set skills/<name>/evals/triggers.json \
  --skill-path skills/<name> \
  --runs-per-query 3 --verbose
```

To tune the description, use `$SC/scripts/run_loop.py` with the same arguments plus `--model <model-id>`. It splits the prompts into train and test sets and proposes better descriptions. Apply the best description by hand and run the check again.

The skill you test is usually also installed in `~/.claude/skills`. The installed copy can load instead of the test copy, and the stock runner then reports 0 triggers. Count a trigger on the real skill name to avoid this. See `skills/writing-skills/SKILL.md` for cost rules and tips.

These runs are real model runs and cost tokens.

## Updating configuration

After you change a skill, run `~/agentic-coding/setup.sh` again.

---

*This repository holds configuration, docs, and one check script. It has no application code.*
