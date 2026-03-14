# reference/CLAUDE.md — Reference Directory Guide

This directory contains metadata files that document the teaching materials in this repository.

These files are used as authoritative references when creating or updating content pages.

---

## Files in This Directory

### `videos_metadata.csv`

Master metadata table for lecture videos and slide decks.

**Columns:**

| Column | Description |
|---|---|
| Week | Teaching week in which the material is covered |
| File name | Base filename of the corresponding `.qmd` slide page (no extension) |
| Final Title | Display title of the video / slide deck |
| YouTube ID | YouTube video ID (used to construct the embed URL) |
| Badge | Content type: `Concept` (conceptual lecture) or `Lab` (Stata lab session) |
| Key Learning Goal | One-sentence description of what students should be able to do after engaging with the material |

**Usage rules:**

- Claude may **read** this file to retrieve titles or ordering information.
- Claude must **not modify** this file unless explicitly instructed.

---

### `activities_metadata.csv`

Metadata table for seminar and workshop activities in the `activities/` directory.

**Columns:**

| Column | Description |
|---|---|
| Week | Teaching week in which the activity is used (or `Reading Week`) |
| File name | Base filename of the corresponding `.qmd` activity page (no extension) |
| Title | Display title of the activity (from the YAML front matter) |
| Activity Type | Type of activity: `Seminar Activity`, `Catch-Up Activity`, or `PS2 Workshop` |
| Dataset | Dataset(s) used in the activity, if any |
| Key Learning Goal | One-sentence description of what students should be able to do after completing the activity |

**Activity types:**

- **Seminar Activity** — a structured group exercise run in the seminar session
- **Catch-Up Activity** — a self-directed activity for students who missed or need to consolidate earlier material
- **PS2 Workshop** — a structured work session supporting the Problem Set 2 submission

**Usage rules:**

- Claude may **read** this file to retrieve activity titles, types, or ordering information.
- Claude should **update** this file when creating, modifying, or deleting activity files in `activities/`, to keep the metadata in sync with the content.

---

## Adding New Reference Files

If a new metadata file is added to this directory, update this `CLAUDE.md` to document its columns and usage rules.
