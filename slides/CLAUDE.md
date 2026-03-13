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

The presenter-space environment is required for this slide family.

videos-stata/

Stata video slides:

- use the video-stata template
- use class: lecture
- do not use presenter-space
- often include code examples

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
