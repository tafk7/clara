---
description: Validate comment accuracy and appropriateness
---

# /comments

<instructions>
Analyze comments to ensure accuracy, then aggressively identify redundant comments that restate what self-documenting code already expresses.
</instructions>

<approach>
Phase 1 - Understand: Read implementation to comprehend actual behavior.
Phase 2 - Validate: Check comments against actual code behavior for accuracy.
Phase 3 - Assess Necessity: Identify comments describing self-evident code.
Phase 4 - Report: Document inaccurate comments (fix) and redundant comments (delete).

Philosophy: Self-documenting code is superior to commented code. Only complex algorithms, non-obvious decisions, or "why" explanations justify comments.

Exception: Public function/class docstrings serve automated documentation and IDE tooling - maintain these even when simple, ensuring accuracy and convention compliance (JSDoc, Python docstrings, etc.).

Output: Create analysis in _artifacts/analyses/YYMMDD_HHMM_description.md
</approach>

<context>
Target: $ARGUMENTS
</context>
