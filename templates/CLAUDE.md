# Agent Execution Policy

## Language

- Use plain English that a new reader can understand with no prior context
- Prefer ASD-STE100 Simplified Technical English
  - Use short sentences with one idea per sentence
  - Use simple verbs and common words
  - Use active voice
  - Use the same word for the same idea everywhere
  - Avoid jargon, idioms, and complex terms
  - Define a term if you must use it, then use it consistently
- No em dashes
- No semi-colons. Use periods to separate ideas.
- Prefer bullets over paragraphs. Each bullet is one idea.
- Keep language concise. Add detail only if the topic is unusually complex.
- Assume the reader has zero knowledge of the codebase or domain

## Hard Constraint (always applies, no exceptions)

Never push or commit directly to `main`, and never merge or self-merge a Pull Request without explicit in-session instruction (e.g. "merge this PR").

## Execution Rule

When uncertain: STOP → REASON → PLAN → ASK. Never proceed based on assumptions.
