---
description: Generate professional PR description
---

# /git:pr

<instructions>
Generate a professional pull request description for the current branch against its parent branch.
</instructions>

<approach>
Phase 1 - Analyze: Review all commits and changes since branch divergence from base branch
Phase 2 - Synthesize: Identify the core purpose, key changes, and user-facing impact
Phase 3 - Write: Create professional description focusing on what and why, avoiding hyperbole and line-level details
Priority: Clarity and accuracy over marketing language
Visual aids: Use ASCII diagrams only when they clarify architecture or data flow better than prose
Output: Save PR description ready to md file in _artifacts/
</approach>

<context>
Target: $ARGUMENTS
Base branch: Infer from git or use $ARGUMENTS if specified (e.g., "main", "develop")
</context>
