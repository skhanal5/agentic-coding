---
description: Coding style preferences for consistent code contributions
---

# Coding style preferences

## Commits

Prefer small commits with independent changes over one large commit with many changes. Each commit should cover a single logical change and leave the codebase in a valid state.

Examples of good commit boundaries:
- One bug fix per commit
- One feature per commit
- One refactor per commit
- Deleting dead code is a separate commit from fixing live code
- Tooling/config changes are separate from logic changes

Avoid:
- Mixing formatting changes with logic changes
- Combining unrelated fixes in one commit
- Giant commits that touch many files for different reasons
