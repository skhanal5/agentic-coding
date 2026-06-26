# Branching Policy

Read this before creating any branch or commit.

---

## Hard Rule

- Never commit or push directly to `main`
- All changes must be made on a feature branch
- Every change requires a Pull Request (no exceptions)

If a branch or PR workflow is not possible in the current environment:
→ STOP and ask for guidance.

---

## Branch Naming Convention

- Format: `skhanal/<feature-name>`
- Must be:
  - single-purpose
  - ≤4 words
  - derived from intent, not implementation details

**Examples (valid):**
- `skhanal/login-ui`
- `skhanal/fix-auth-bug`

**Invalid:**
- `skhanal/refactor-auth-system-and-login-state-fix`

If a branch cannot be created or named properly per this convention:
→ STOP and ask.