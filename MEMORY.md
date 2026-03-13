# MEMORY.md — Methods Education Website

## Project Overview

This repository contains a Quarto website used to host teaching materials for a university module on research methods and statistics.

The site publishes lecture slides, concept explanations, activities, quizzes, and reference pages.

All materials are written in Quarto (`.qmd`) and rendered as a static website hosted on GitHub Pages.

The goal of the project is to provide students with structured teaching materials combining slide explanations and lecture videos.

---

## Core Design Decisions

The site uses **HTML pages as the primary navigation format**.

Each slide deck has two formats:

- HTML page view (default navigation format)
- RevealJS slide presentation

Students normally read the HTML page view.

RevealJS is available through the **"Other Formats → RevealJS"** link and is mainly used for presenting slides in class.

---

## Slide Page Structure

Most slide pages follow this structure:

1. YouTube lecture video embed (when available)
2. Structured headings explaining concepts
3. Optional link to the RevealJS slide format

Videos are embedded **directly inside the `.qmd` page using the full YouTube embed code**.

There is currently **no reusable embed template**.

---

## Current State of Video Integration

Video integration is still in progress.

- Some lecture videos have been uploaded to YouTube.
- Only some of those videos are currently embedded on the site.
- Many pages still do not contain embedded videos.

At a later stage the embedding process may be completed programmatically using Claude Code.

---

## Site Architecture

Content directories:

slides/ — lecture and concept slide decks  
activities/ — interactive exercises  
quizzes/ — quiz material  
cards/ — flashcard-style learning material  
attention-checks/ — classroom attention checks  
reference/ — project reference material

Shared resources:

assets/ — images and media  
theme/ — SCSS theme files controlling slide styling

---

## Key Reference File

`reference/videos_metadata.csv`

This file contains structured metadata about lecture videos.

It may be used to guide the creation or updating of slide pages.

The file is **read-only for Claude** unless explicitly instructed.

---

## Quarto Build Directories

These directories are generated automatically by Quarto and must not be edited.

.quarto/  
_freeze/  
_site/

---

## Configuration Files

_quarto.yml — defines site navigation and rendering  
styles.css — site-level styling  
theme/ — RevealJS styling

---

## Navigation Model

The site uses a **left sidebar navigation panel**.

Sidebar items link to HTML page versions of slide decks and activities.

RevealJS slides are accessed through the **"Other Formats"** menu.

---

## Deployment

The site is rendered locally with Quarto and deployed to GitHub Pages.

Typical workflow:

1. edit `.qmd` files
2. preview locally with `quarto preview`
3. render the site
4. publish changes

Claude Code must **never perform deployment actions**.