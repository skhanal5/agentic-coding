# Review checklist

Use this with the `code-review` skill. Read it when you need detail beyond the standards.

## Contents

- Questions to ask
- What to flag
- Preferred remedies
- Phrases to use

## Questions to ask

For every meaningful change:

- Is there a code judo move that makes this much simpler?
- Can the change be reframed so fewer concepts, branches, or helper layers are needed?
- Does it improve or worsen the local architecture?
- Did the diff add branching where a better abstraction should exist?
- Did a cohesive module become more coupled, more stateful, or harder to scan?
- Does the logic live in the right file and layer?
- Did the change grow a file past a healthy size?
- Do repeated conditionals signal a missing model or helper?
- Is the code direct and legible, or does it rely on special cases and incidental control flow?
- Does each abstraction earn its keep, or is it a wrapper?
- Did the diff add casts, optionality, or ad-hoc object shapes that hide the real invariant?
- Did the diff leak details across a boundary?
- Is the orchestration more sequential or less atomic than needed?

## What to flag

- A complex implementation where a reframing could delete whole categories of complexity
- Refactors that move code but do not reduce the concepts a reader must hold
- A file that crosses 1000 lines because of the PR
- New conditionals bolted onto unrelated paths
- One-off booleans, nullable modes, or flags that complicate control flow
- Feature logic in general-purpose modules
- Generic magic handling that hides simple structure
- Thin wrappers and identity abstractions
- Needless casts, `any`, `unknown`, or optional params
- Copy-pasted logic instead of a helper
- Narrow edge-case handling inside an already busy function
- "Temporary" branching that will become permanent debt
- Bespoke helpers when a canonical utility exists
- Logic in the wrong layer or package
- Serial async flow for independent work
- Partial-update logic that is less atomic than needed

## Preferred remedies

- Delete a layer of indirection instead of polishing it.
- Reframe the state model so conditionals disappear.
- Change the ownership boundary so the feature extends an existing abstraction.
- Turn special-case logic into a simpler default flow.
- Extract a helper or pure function.
- Split a large file into focused modules.
- Move feature logic behind a dedicated abstraction.
- Replace condition chains with a typed model or explicit dispatcher.
- Separate orchestration from business logic.
- Collapse duplicate branches.
- Reuse the canonical helper.
- Make type boundaries explicit.
- Move logic to the module that owns the concept.
- Parallelize independent work when it also simplifies the flow.
- Make related updates atomic.

Do not accept "maybe rename this" when the real problem is structural. Do not accept a cleaner version of a messy idea when a much simpler idea is plausible.

## Phrases to use

- `this pushes the file past 1k lines. can we decompose this first?`
- `this adds another special-case branch into an already busy flow. can we move this behind its own abstraction?`
- `this works, but it makes the surrounding code more spaghetti. let's keep the behavior and restructure the implementation.`
- `this feels like feature logic leaking into a shared path. can we isolate it?`
- `this abstraction seems unnecessary. can we just keep the direct flow?`
- `why does this need a cast / optional here? can we make the boundary more explicit instead?`
- `this looks like a bespoke helper for something we already have elsewhere. can we reuse the canonical one?`
- `i think there's a code-judo move here that makes this much simpler. can we reframe this so these branches disappear?`
- `this refactor moves complexity around, but doesn't really delete it. is there a way to make the model itself simpler?`
