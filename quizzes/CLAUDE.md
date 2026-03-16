# CLAUDE.md — Rules for the quizzes/ directory

This file defines rules specific to the quizzes directory.

These rules supplement the repository-wide rules defined in the root CLAUDE.md.

Claude must follow both.

------------------------------------------------------------------------

# Quizzes Directory Structure

The quizzes directory uses a two-stage workflow:

1.  Quizzes are authored in a **canonical plain-text format** stored in `canonical/`.
2.  The canonical files are converted to **Moodle XML** for import into KEATS (Moodle). The XML files are stored in `moodle-xml/`.

The conversion prompt used for generating Moodle XML is stored in:

quizzes/moodle_xml_conversion_prompt.txt

Claude must not modify the conversion prompt unless explicitly instructed.

------------------------------------------------------------------------

# File Naming Convention

All quiz files are named by week and topic:

canonical/W{nn}*{topic-slug}.txt moodle-xml/W{nn}*{topic-slug}.xml

Examples:

-   `W02_questions-theories-units-variables.txt`
-   `W05_correlations.txt`

The canonical `.txt` and Moodle `.xml` filenames must match exactly (same prefix and slug).

Claude must not add `_moodle` or other suffixes to filenames.

------------------------------------------------------------------------

# Canonical Text Format

Each canonical quiz file contains multiple-choice questions in this exact format:

```         
QUESTION: <question text, possibly spanning multiple lines>

A. <option text>
B. <option text>
C. <option text>
D. <option text>

ANSWER: <single capital letter>

---
```

Rules:

-   Question text may span multiple lines.
-   Option text may wrap onto the next line; wrapped lines belong to the preceding option.
-   Only lines beginning with `A.` `B.` `C.` `D.` define options.
-   Every question has exactly ONE correct answer.
-   Questions are separated by a line containing only `---`.
-   There is no `---` after the final question.
-   Most questions have four options (A through D).

------------------------------------------------------------------------

# Question Design Conventions

Based on existing quizzes:

-   Questions are multiple-choice with one correct answer.
-   Questions test conceptual understanding, not rote memorisation.
-   Distractors (incorrect options) should be plausible and address common misconceptions.
-   Questions often present a scenario or hypothesis and ask students to identify, classify, or interpret.
-   Quizzes cover concept video content only. Do not include questions about Stata syntax or Stata-specific content.
-   No feedback text is included in the canonical format.

------------------------------------------------------------------------

# Moodle XML Conversion

Moodle XML files are generated from canonical files using the rules in `moodle_xml_conversion_prompt.txt`.

Key conversion rules:

-   Question type: `multichoice`
-   `single = true` (one correct answer)
-   `shuffleanswers = true`
-   `answernumbering = abc`
-   Correct answer: `fraction="100"`; all others: `fraction="0"`
-   Question names follow the pattern `W{nn}_Q{nn}` (e.g. `W02_Q01`)
-   Question text uses `<p>` tags for paragraphs
-   No stray HTML, numbering, or option letters in the question stem

Claude may generate Moodle XML from canonical files when instructed, following these rules.

------------------------------------------------------------------------

# Week Coverage

Quizzes exist for Weeks 2-5, 7-10. There is no W01 (introductory week) or W06 (reading week).

Claude must not create quizzes for missing weeks unless explicitly instructed.

------------------------------------------------------------------------

# Allowed Tasks in quizzes/

Claude may:

-   Create new canonical quiz files when instructed
-   Add questions to existing canonical files
-   Generate Moodle XML from canonical files
-   Fix formatting issues in canonical files

Claude must not:

-   Modify `moodle_xml_conversion_prompt.txt` without instruction
-   Change the canonical text format
-   Rename existing files
-   Create quizzes for weeks without explicit instruction
