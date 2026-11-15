# Stacked PRs

Use this with the `shipping` skill when a PR is split into stacked PRs.

## Tool

GitHub supports stacked PRs through `gh stack`. Install it with `gh extension install github/gh-stack`. See https://gh.io/stacks.

Use `gh stack` instead of manual base-branch handling.

## Commands

- `gh stack init`: start or adopt a stack.
- `gh stack add <branch>`: add a layer.
- `gh stack submit`: push branches and create or update PRs with the correct bases.
- `gh stack sync`: fetch, cascade-rebase, and push.
- `gh stack rebase`: resolve conflicts.
- `gh stack view`: inspect the stack.

## Rules

- Base a stacked PR on the parent PR's branch, not on `main`. `gh stack submit` sets the base.
- Make the first Background bullet name the parent PR. Example: `Stacks on #48.`
- Review and test each PR at its own head commit. The `code-review` gate applies to each PR.
- Measure a stacked PR against the parent's branch, not `main`. That branch is the `<base>` for the review diff and the size count.
- When the parent gets new commits, run `gh stack sync` (or `gh stack rebase`, then push). Run the gates again.
- After the parent merges, run `gh stack sync --prune`. It rebases the child onto `main`, sets its base to `main`, and prunes the merged branch. Run the gates again.
- If you rebase by hand and the parent was squash-merged, use `git rebase --onto main <parent-branch>`. A plain `git rebase main` replays the parent's commits on top of their squashed copy. `gh stack sync` handles this case for you.
