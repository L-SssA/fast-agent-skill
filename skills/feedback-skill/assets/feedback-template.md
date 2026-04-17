# Skill Feedback Report

**Generated**: [Date]  
**Skill Name**: [skill-name]  
**Analysis Period**: [Start Date] - [End Date]

---

## Executive Summary

[Brief overview of the feedback extraction results, including:

- Number of corrections identified
- Main categories of issues found
- Priority distribution
- Overall skill health assessment]

---

## Context Analysis Results

### Skill Usage Instances

| Instance | Timestamp | Task Description    | Outcome                   |
| -------- | --------- | ------------------- | ------------------------- |
| #1       | [time]    | [brief description] | [success/partial/failure] |
| #2       | [time]    | [brief description] | [success/partial/failure] |

### Corrections Detected

**Total Corrections Found**: [N]

#### Correction #1

- **Timestamp**: [when it occurred]
- **Type**: [Explicit/Implicit]
- **Severity**: [Low/Medium/High]
- **User Statement**: "[quote from user]"
- **Context**: [what was happening when correction occurred]

#### Correction #2

[Same format as above]

---

## Root Cause Analysis

### Issue Categories

| Category             | Count | Percentage | Avg Severity |
| -------------------- | ----- | ---------- | ------------ |
| Description Issues   | N     | X%         | [L/M/H]      |
| Missing Instructions | N     | X%         | [L/M/H]      |
| Edge Cases           | N     | X%         | [L/M/H]      |
| Example Issues       | N     | X%         | [L/M/H]      |
| Other                | N     | X%         | [L/M/H]      |

### Detailed Analysis

#### Issue #1: [Brief Title]

**Category**: [Description/Instruction/Edge Case/Example/Other]  
**Priority**: [P0/P1/P2/P3]  
**Frequency**: [Every time/Often/Sometimes/Rarely]

**Problem Description**:
[Clear explanation of what went wrong]

**Root Cause**:
[Why this happened - link to specific gap in skill]

**Impact**:
[How this affects users and task completion]

**Evidence**:

- User correction: "[quote]"
- Agent response: "[what agent did wrong]"
- Expected behavior: "[what should have happened]"

---

## Improvement Recommendations

### High Priority (P0-P1)

#### Recommendation #1

**Type**: [Description Optimization / Instruction Addition / Edge Case Handling / Example Enhancement]

**Current State**:

```
[Current relevant content from skill, if any]
```

**Proposed Change**:

```markdown
[Exact text to add or modify]
```

**Location**:

- File: `SKILL.md` or `references/[filename].md`
- Section: [specific section name]
- Position: [where to insert]

**Rationale**:
[Why this change is needed and how it solves the problem]

**Expected Impact**:

- [Specific improvement 1]
- [Specific improvement 2]

**Testing Suggestion**:
[How to verify this fix works]

---

#### Recommendation #2

[Same format as above]

### Medium Priority (P2)

#### Recommendation #3

[Same format as high priority recommendations]

### Low Priority (P3)

#### Recommendation #4

[Same format as high priority recommendations]

---

## Implementation Plan

### Phase 1: Critical Fixes (P0)

**Estimated Effort**: [time estimate]

1. [ ] [Recommendation #1 title]
   - File: [filename]
   - Changes: [brief summary]
2. [ ] [Recommendation #2 title]
   - File: [filename]
   - Changes: [brief summary]

### Phase 2: Important Improvements (P1)

**Estimated Effort**: [time estimate]

[Similar format]

### Phase 3: Enhancements (P2-P3)

**Estimated Effort**: [time estimate]

[Similar format]

---

## New Files to Create

| File Path              | Purpose       | Priority | Estimated Lines |
| ---------------------- | ------------- | -------- | --------------- |
| `references/[name].md` | [description] | P0/P1/P2 | ~N lines        |
| `references/[name].md` | [description] | P0/P1/P2 | ~N lines        |

### File Outlines

#### File: `references/[name].md`

```markdown
# [Title]

## Overview

[Brief description]

## When This Applies

[Usage scenarios]

## Detailed Guide

[Main content structure]

## Examples

[Example structure]

## Common Issues

[Troubleshooting structure]
```

---

## Files to Modify

| File Path              | Change Type                         | Lines Added | Lines Removed |
| ---------------------- | ----------------------------------- | ----------- | ------------- |
| `SKILL.md`             | [Description/Workflow/Examples/etc] | +N          | -N            |
| `references/[name].md` | [Update/Add section]                | +N          | -N            |

---

## Reference Updates Required

### New References to Add in SKILL.md

```markdown
## Related Resources

- [New Guide Title](references/new-file.md)
- [Another Guide](references/another-file.md)
```

### Existing References to Update

- `[Old Link Text](references/file.md)` → `[New Link Text](references/file.md)`

---

## Quality Checks

### Pre-Implementation Checklist

- [ ] All improvements reviewed and approved by user
- [ ] No duplicate content identified
- [ ] Progressive disclosure principle maintained
- [ ] SKILL.md will remain under 500 lines
- [ ] All new files have clear purpose
- [ ] Terminology is consistent
- [ ] Style matches existing content

### Post-Implementation Checklist

- [ ] SKILL.md line count: [N] (< 500)
- [ ] All links validated
- [ ] Markdown syntax checked
- [ ] No broken references
- [ ] Content reviewed for clarity
- [ ] Examples tested (if applicable)
- [ ] Ready for testing with optimize-skill

---

## Testing Recommendations

### Trigger Rate Testing

**Suggested Test Queries (Should Trigger)**:

1. "[query that should activate skill]"
2. "[another relevant query]"
3. "[edge case query]"

**Suggested Test Queries (Should NOT Trigger)**:

1. "[unrelated query]"
2. "[query for different skill]"

### Output Quality Testing

**Test Cases**:

1. **Scenario**: [description]
   - **Input**: [test input]
   - **Expected Output**: [what should happen]
   - **Success Criteria**: [how to measure]

2. **Scenario**: [description]
   - **Input**: [test input]
   - **Expected Output**: [what should happen]
   - **Success Criteria**: [how to measure]

### Edge Case Testing

**Boundary Conditions to Test**:

- [ ] Empty input
- [ ] Maximum size input
- [ ] Invalid format input
- [ ] Special characters
- [ ] [other relevant edge cases]

---

## Metrics and KPIs

### Current State (Before Improvements)

- **Trigger Accuracy**: [estimated %]
- **Correction Frequency**: [N corrections per use]
- **User Satisfaction**: [qualitative assessment]
- **Task Success Rate**: [estimated %]

### Target State (After Improvements)

- **Trigger Accuracy**: [target %]
- **Correction Frequency**: [target: < N corrections per use]
- **User Satisfaction**: [target level]
- **Task Success Rate**: [target %]

### Measurement Plan

[How to track these metrics after implementation]

---

## Risks and Mitigations

### Risk #1: [Description]

**Probability**: [Low/Medium/High]  
**Impact**: [Low/Medium/High]

**Mitigation**:
[How to reduce or handle this risk]

### Risk #2: [Description]

[Same format]

---

## Next Steps

1. **Immediate Actions**:
   - [ ] Review this report
   - [ ] Approve/reject recommendations
   - [ ] Prioritize implementation phases

2. **Implementation**:
   - [ ] Apply Phase 1 changes
   - [ ] Validate changes
   - [ ] Collect initial feedback

3. **Testing**:
   - [ ] Use optimize-skill for systematic testing
   - [ ] Run trigger rate tests
   - [ ] Test output quality
   - [ ] Verify edge cases

4. **Iteration**:
   - [ ] Monitor usage patterns
   - [ ] Collect new feedback
   - [ ] Schedule next review

---

## Appendix

### A. Full Conversation Excerpts

**Excerpt #1**: [Relevant dialogue showing correction]

**Excerpt #2**: [Another relevant dialogue]

### B. Technical Details

[Any technical analysis, code snippets, or detailed explanations]

### C. Related Skills

[List of skills that might be affected or related]

### D. Change History

| Date   | Version | Changes        | Author |
| ------ | ------- | -------------- | ------ |
| [date] | 1.0     | Initial report | [name] |

---

**Report Generated By**: skill-extract-feedback  
**Version**: 1.0  
**For Questions or Clarifications**: [contact info or process]
