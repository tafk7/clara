---
description: Validate comment accuracy and appropriateness
---

# /comments

<instructions>
Analyze comments and docstrings to ensure they are accurate, appropriately detailed for the code's complexity, and not redundantly describing self-evident code.
</instructions>

<approach>
Phase 1 - Inspect: Review files systematically, checking each comment against actual code behavior.
Phase 2 - Diagnose: Categorize issues - inaccurate/outdated comments, redundant descriptions of obvious code, inappropriate detail level for complexity.
Phase 3 - Report: Document problematic comments with specific examples and recommended fixes.
Priority: Only report problematic comments, not comprehensive surveys
Output: Create analysis in _artifacts/analyses/
</approach>

<context>
Target: $ARGUMENTS
</context>
