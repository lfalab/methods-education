# CLAUDE.md — Rules for the slides/ directory

This file defines rules specific to the slides directory.

These rules supplement the repository-wide rules defined in the root CLAUDE.md.

Claude must follow both.

---

# Slides Directory Structure

The slides directory contains three content families:

lectures/
Lecture slide decks.

videos-concepts/
Short concept explanation videos.

videos-stata/
Stata tutorial videos.

Claude must not modify this directory structure.

New pages must be placed in the correct folder.

---

# Slide Templates

Canonical templates are stored in:

slides/templates/lecture-template.qmd  
slides/templates/video-concept-template.qmd  
slides/templates/video-stata-template.qmd

When creating a new slide page Claude must start from the appropriate template.

Claude must not invent a new slide structure.

---

# Family-Specific Rules

lectures/

Lecture slides:

- use the lecture template
- use class: lecture
- include title, subtitle, and author
- do not use presenter-space

videos-concepts/

Concept video slides:

- use the video-concept template
- use class: video
- use a manual title slide
- use presenter-space blocks
- **must be software-agnostic**: no references to Stata, R, or any specific software. Software-specific content belongs exclusively in S-indexed videos. This ensures concept videos remain usable if the module switches to a different statistical package.

The presenter-space environment is required for this slide family.

videos-stata/

Stata video slides:

- use the video-stata template
- use class: lecture
- do not use presenter-space
- often include code examples

---

# Slide Deck Preparation Guidelines

These rules apply whenever Claude is asked to draft or revise a slide deck.

## Slide Density Constraints

**These are absolute rules. There are no exceptions, no mitigating circumstances, and no excuses.**

- **NEVER more than 3 bullet points per slide.** Adding a fourth bullet point is embarrassing and will always be wrong. If content does not fit in 3 bullets, split it into two slides.
- Maximum 10–12 words per bullet.
- No paragraph-style prose.
- No multi-sentence bullets.
- Slides are scaffolding for spoken narration, not self-contained explanations.

## Punctuation Rules

**These are absolute rules. There are no exceptions.**

- **NEVER use em dashes (—) in slide text.** Use a comma, semicolon, colon, or full stop instead. Em dashes are banned from all slide content without exception.

## C-prefix (Concept Video) Structure and Approach

The standard slide sequence for concept videos is:

1. Title slide
2. "You will learn to…" slide
3. Concept development slides
4. Recap slide
5. "Why This Matters" slide

Pedagogical approach:

- Emphasise intuition first, formalism second.
- Avoid symbolic overload early in the deck.
- Keep derivations minimal unless explicitly required.
- Do not over-explain or anticipate every student confusion in slide text.
- Err on the side of brevity rather than completeness.
- Maintain continuity with previous weeks.

## S-prefix (Stata Video) Approach

- Procedural, step-by-step walkthrough.
- Code blocks should be concise.
- Interpretation delivered in short prompts, not paragraphs.
- No statistical theory exposition; save that for C-videos.

## Source Hierarchy for Drafting

When preparing any slide deck:

1. `.qmd` template files determine structure and formatting.
2. Learning goals (from Excel metadata or explicit instructions) determine scope.
3. Transcripts and prior slides are content references only; do not copy structure from them.

## Language Notes

- Do not describe randomised experiments as the "gold standard".
- Empirical examples should remain consistent across related videos in a sequence.

---

# Video Embedding

Lecture videos are embedded directly in slide pages using the full YouTube embed code copied from YouTube.

Embeds normally appear near the top of the page before the first heading.

Not every slide page currently contains a video embed.

Claude must not attempt to add missing embeds unless explicitly instructed.

---

# Video Metadata Reference

The file

reference/videos_metadata.csv

contains metadata about lecture videos and slide pages.

Claude may read this file for reference but must never modify it unless explicitly instructed.

---

# RevealJS Theme Safety

RevealJS themes are defined in the theme directory.

Claude must not modify theme files or RevealJS configuration unless explicitly instructed.

---

# Path Safety

Slides rely heavily on relative paths.

Claude must not change relative paths unless explicitly instructed.

---

# Allowed Tasks in slides/

Claude may:

- create new slide pages
- improve text explanations
- add headings or sections
- embed YouTube videos when instructed
- fix formatting issues within a slide page

Claude must not:

- modify _quarto.yml
- modify navigation structure
- alter site-wide styling
- reorganize slide directories
