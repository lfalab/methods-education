# CLAUDE.md — Rules for the activities/ directory

This file defines rules specific to the activities directory.

These rules supplement the repository-wide rules defined in the root CLAUDE.md.

Claude must follow both.

------------------------------------------------------------------------

# Activities Directory Structure

This directory contains seminar and workshop activities written as `.qmd` pages.

Activities are designed for in-class use during weekly seminars.

There are no subdirectories. All activity files live directly in `activities/`.

------------------------------------------------------------------------

# File Naming Convention

Files are named using the pattern:

A{nn}-{topic-slug}.qmd

Where `{nn}` is a two-digit week number matching the lecture week.

When a week has more than one activity, a lowercase letter suffix is added:

A{nn}a-{topic-slug}.qmd
A{nn}b-{topic-slug}.qmd

Examples:

- `A04-distributions-activity.qmd` — single activity for Week 4
- `A07a-sampling-activity.qmd` — first activity for Week 7
- `A07b-htests-weights.qmd` — second activity for Week 7

------------------------------------------------------------------------

# Activity Types

Activities fall into several types, but all share the same YAML structure:

- **Seminar activities** — structured exercises for in-class group work (e.g. A05, A07a)
- **Mock exam activities** — practice questions in exam format (e.g. A04)
- **Catch-up activities** — self-guided review for students who fell behind (e.g. A06)
- **PS2 workshops** — structured work sessions for Problem Set 2 (e.g. A08b)

------------------------------------------------------------------------

# YAML Header Format

All activity files use this YAML structure:

```yaml
---
title: "Activity Title"
subtitle: "Statistics for Political Science — Week N"
author: "Leonardo Falabella"
format:
  html:
    toc: true
    toc-depth: 2
    number-sections: false
    theme: default
---
```

Key conventions:

- Activities use `title:` (not `pagetitle:`).
- The `subtitle:` always includes the week identifier.
- Activities render as HTML only — there is no RevealJS format.
- There is no `class:` field.

------------------------------------------------------------------------

# Content Conventions

Activities typically follow this structure:

1. Introduction section explaining the activity's purpose
2. Numbered parts or scenario-based tasks
3. Interpretation or reflection questions
4. Summary section listing skills practised

Additional conventions:

- Sections are separated by horizontal rules (`------------------------------------------------------------------------`).
- Questions are **bolded** using the format `**Q1.**` or `**Question A:**`.
- Hints to students are placed in blockquotes (`>`).
- Instructor-only hints are placed in HTML comments (`<!-- ... -->`).
- Links to the Shared Project Folder and video pages are used where relevant.
- One activity (A04) contains R code chunks for generating plots. Most activities do not contain executable code.

------------------------------------------------------------------------

# Week Coverage

Activities currently exist for Weeks 4-8. Earlier weeks and later weeks will be added over time.

Some weeks have two activities; some have one. This is intentional and varies by week.

Claude must not create activities for missing weeks unless explicitly instructed.

------------------------------------------------------------------------

# Allowed Tasks in activities/

Claude may:

- Create new activity files when instructed
- Improve text clarity within existing activities
- Add questions or sections to existing activities
- Fix formatting issues

Claude must not:

- Change the YAML header format
- Rename or move existing files
- Convert activities to RevealJS slide format
- Modify links to external resources (Shared Project Folder, KEATS) without instruction
