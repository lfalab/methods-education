# CLAUDE.md — Rules for the attention-checks/ directory

This file defines rules specific to the attention-checks directory.

These rules supplement the repository-wide rules defined in the root CLAUDE.md.

Claude must follow both.

------------------------------------------------------------------------

# Purpose

Attention checks are short quiz questions embedded in the H5P interactive videos on KEATS (Moodle).

Each video should have at least one attention check. The questions appear during playback to verify that students are engaging with the material.

------------------------------------------------------------------------

# File Naming Convention

Files use the same prefix and slug as the corresponding slide page:

{prefix}{nn}-{topic-slug}.txt

Where the prefix matches the slide family:

- `C` for concept videos (matching `slides/videos-concepts/`)
- `S` for Stata videos (matching `slides/videos-stata/`)

Examples:

- `C01-empirical-vs-normative.txt` corresponds to `slides/videos-concepts/C01-empirical-vs-normative.qmd`
- `S01-doing-reproducible-research.txt` corresponds to `slides/videos-stata/S01-doing-reproducible-research.qmd`

------------------------------------------------------------------------

# File Format

Attention check files are plain `.txt` files with a simple structure.

Each file contains one or more questions. Each question consists of:

1. A question stem (one or more lines of text)
2. A blank line
3. Answer options, each on its own line, prefixed with `- `
4. The **first option listed is always the correct answer**

Questions within the same file are separated by a blank line after the last option of the preceding question.

Example:

```
What is reproducible research?

- Being able to obtain the same results using the same data and code
- Being able to prove that your hypothesis is correct
- Being able to formulate a good theory for a research question
```

------------------------------------------------------------------------

# Question Design Conventions

- Questions are short and test a single concept from the video.
- Most questions have **three options**; some have four. Two options is the minimum.
- The correct answer is always listed first in the file. H5P shuffles the options when displaying them to students.
- Distractors should be plausible but clearly wrong to a student who watched the video.
- Some questions include a quoted scenario or hypothesis before the question stem.
- The tone is informal and accessible. Occasional humour in distractors is acceptable.
- A file may contain one question or several, depending on the length of the video.

------------------------------------------------------------------------

# Coverage

Attention checks exist for:

- All 28 concept videos (C01–C28)
- Stata videos S01–S04, S09–S11

Stata videos S05–S08 do not yet have attention checks.

There are no attention checks for lecture slides (the W-series), since lectures are not delivered as H5P interactive videos.

Claude must not create attention checks for missing videos unless explicitly instructed.

------------------------------------------------------------------------

# Allowed Tasks in attention-checks/

Claude may:

- Create new attention check files when instructed
- Add questions to existing files
- Improve question clarity
- Fix formatting issues

Claude must not:

- Change the file format (plain `.txt`, first option = correct answer)
- Rename or move existing files
- Create attention checks for videos that do not exist
