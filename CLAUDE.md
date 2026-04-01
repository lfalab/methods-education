# CLAUDE.md — Operating Rules for the Methods Education Website

This repository contains a **Quarto website** used to host teaching materials for a university module.

The site includes lecture slides, activities, quizzes, reference pages, and embedded videos.

Claude Code may assist with **content creation and small improvements**, but must avoid modifying the structural architecture of the site.

All changes should be **conservative, minimal, and easy to review**.

---

# Core Principles

1. Make the **smallest possible change** required to complete the task.
2. Prefer **creating new content pages** over modifying shared configuration.
3. **Do not refactor or reorganize the repository.**
4. **Do not rename, move, or delete files** unless explicitly instructed.
5. If a task requires editing multiple files, **explain why before making changes**.
6. When multiple approaches are possible, prefer the one that modifies fewer files.

---

# Session Initialization

At the start of each session Claude must:

1. Read `MEMORY.md` to understand the architecture and conventions of the project.
2. Check the `logs/` directory and read the most recent log entry if it exists.
3. Use this information to maintain consistency with previous changes.

Claude should never ignore information contained in `MEMORY.md`.

---

# Repository Structure

The repository follows a stable Quarto website structure.

### Content directories

These contain teaching material and are safe to edit.

- `slides/` — lecture slide decks written in `.qmd`
- `activities/` — interactive learning activities
- `quizzes/` — quiz materials
- `attention-checks/` — classroom attention checks

- `reference/` — reference material and project metadata

Important files:

- `reference/videos_metadata.csv`
- `reference/activities_metadata.csv`

These files are the **master metadata tables** for lecture videos/slide decks and class activities respectively.

Claude may **read these files** to retrieve titles or ordering information.

Claude should **update `activities_metadata.csv`** when creating, modifying, or deleting activity files in `activities/`, to keep the metadata in sync with the content. Claude must **not modify `videos_metadata.csv`** unless explicitly instructed.

Claude may create or edit `.qmd` files inside content directories.

However, **the directory structure must not be modified**.

---

# Shared Project Folder

`shared-project-folder/` is a student-facing teaching resource located at the root of the repository.

It is shared with students via an OneDrive link. **Students have view-only access** — they cannot modify files.

The folder uses a **nested `.gitignore`** pattern: do-files (`shared-project-folder/do/*.do`) are git-tracked, while data files, output, and other binary content are ignored. This ensures do-files are referenceable with `@` in VSCode's Claude Code extension.

There is **no `CLAUDE.md` inside this folder** — this is intentional, since students can read all files in it.

### Subdirectories

| Directory | Purpose | Claude may edit? |
|---|---|---|
| `data-raw/` | Original datasets (`.dta`) and codebooks (`.pdf`, `.docx`) | No |
| `data-clean/` | Cleaned/processed datasets saved by do-files | No |
| `do/` | Stata do-files used in teaching | Yes |
| `output/` | Generated graphs (`.jpg`) saved by do-files | No |

### Do-file conventions

All do-files set the working directory with `cd` as the first command, then use **relative paths** for everything else (e.g., `"data-raw/British_Election_Study_2024.dta"`).

The canonical working directory path is:

```
cd "C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder"
```

When creating or editing do-files that will be committed to the repository, always use this path. It is the path on the primary development machine.

When writing **wrapper do-files** (temporary files in `C:\temp\` used to run Stata from Claude Code), use the `cd` path that matches the current machine. See the multi-machine reference table below.

---

# Running Stata from Claude Code

Claude Code can execute Stata do-files and read the output directly from the terminal. This enables Claude to verify statistical examples, debug do-files, create new analyses, and report regression results — all without the user switching to the Stata GUI.

The teaching materials on the website (slides, activities) are tightly coupled to the Stata do-files and datasets in `shared-project-folder/`. Being able to run these do-files is essential for maintaining and developing the course.

### Multi-machine reference

The user works on two PCs. At the start of a session, Claude should detect which machine it is on by checking which Stata executable exists.

| | Home PC (`leona`) | Office PC (`k2588471`) |
|---|---|---|
| Stata executable | `C:\Program Files\Stata19\StataSE-64.exe` | `C:\Program Files\StataNow19\StataMP-64.exe` |
| OneDrive `cd` path | `C:\Users\leona\OneDrive - King's College London\methods-education\shared-project-folder` | `C:\Users\k2588471\OneDrive - King's College London\methods-education\shared-project-folder` |

### How it works

Running Stata from the Claude Code terminal requires working around three Windows issues:

1. **MSYS2 path mangling** — Git Bash converts `/e` to `E:/`. Set `MSYS_NO_PATHCONV=1` to disable this.
2. **GUI executable** — The Stata executable is a GUI app; `cmd` doesn't wait for it. Use PowerShell `Start-Process -Wait` instead.
3. **Output capture** — Stata's `/e` batch mode log is unreliable. Use Stata's `log using` command inside the do-file for explicit output capture.

### Step 1: Write a wrapper do-file to `C:\temp\`

```stata
log using "C:\temp\stata-output.log", text replace

cd "<OneDrive cd path for this machine>"
use "data-raw/Brexit_Regional.dta", clear
regress leave_share share_high_skill

log close
exit, clear
```

The wrapper always follows this pattern:
- `log using "C:\temp\stata-output.log", text replace` — open a text log at a known path
- `cd` using the OneDrive path for the current machine (see multi-machine reference table above)
- The actual Stata commands (loading data, analysis, etc.)
- `log close` — flush the log
- `exit, clear` — close Stata cleanly

To run an existing do-file, the wrapper can call it with `do "do/filename.do"` after setting `cd`.

### Step 2: Execute from the terminal

```bash
MSYS_NO_PATHCONV=1 powershell -Command '$p = Start-Process -FilePath "<Stata executable for this machine>" -ArgumentList "/e","do","C:\temp\<wrapper>.do" -Wait -PassThru; Write-Output "ExitCode: $($p.ExitCode)"'
```

Replace `<Stata executable for this machine>` with the path from the multi-machine reference table. Replace `<wrapper>` with the name of the wrapper do-file.

An exit code of `0` means success.

### Step 3: Read the log

Read `C:\temp\stata-output.log` to retrieve the Stata output (regression tables, summary statistics, etc.).

### Conventions

- Wrapper do-files and logs go in `C:\temp\` (outside the repository).
- Never commit wrapper do-files or log files to the repository.
- Always include `exit, clear` at the end of wrapper do-files so Stata closes after running.
- When running an existing do-file from `shared-project-folder/do/`, wrap it rather than modifying it.

---

# Running R from Claude Code

Claude Code can execute R scripts from the terminal. This is useful for generating plots, running analyses with R-based datasets, and verifying R code in legacy materials.

### How it works

R is **not** on the system PATH. Always use the full path to `Rscript.exe`.

The R version differs by machine. At the start of a session, detect the installed version:

| | Home PC (`leona`) | Office PC (`k2588471`) |
|---|---|---|
| Rscript path | `C:\Program Files\R\R-4.2.0\bin\Rscript.exe` | `C:\Program Files\R\R-4.5.3\bin\Rscript.exe` |

### Running a script

```bash
"<Rscript path for this machine>" "path/to/script.R"
```

### Running inline R

```bash
"<Rscript path for this machine>" -e 'library(readxl); d <- read_excel("file.xlsx"); str(d)'
```

Note: single quotes around the `-e` expression work in Git Bash. Escape internal single quotes with `'"'"'` if needed.

### Available packages

The following packages are confirmed available: `tidyverse`, `readxl`, `ggplot2`, `dplyr`, `tidyr`.

### Saving plot output

R scripts run from the terminal have no display device. To produce plots, use `ggsave()` or `pdf()`/`png()` to write to a file:

```r
ggsave("C:/temp/plot.png", width = 8, height = 5)
```

### Conventions

- R is used for content generation (regression tables, plots), not for the main teaching materials (which use Stata).
- Temporary R output files go in `C:\temp\` (outside the repository).
- Never commit R output files to the repository.

---

# R Content Generation Directory

`r/` contains R scripts and datasets used to generate content for the website (plots, regression table images, statistical output).

### Structure

| Path | Purpose | Claude may edit? |
|------|---------|------------------|
| `r/*.R` | R scripts that produce assets | Yes |
| `r/data/` | Datasets used by R scripts | No (source data) |

### Conventions

- R scripts save output images to `assets/` (tracked in git).
- Source data files (`.xlsx`, `.dta`) in `r/data/` should not be modified.
- Generated/intermediate data files (`.csv`) in `r/data/` are gitignored.
- When creating new R scripts, follow the pattern of existing scripts: set paths relative to the project root or use absolute OneDrive paths consistent with the project.

---

# Legacy Materials Directory

`legacy/` contains teaching materials from a previous version of this course taught at UCSD. These are **read-only reference sources** used as starting points when creating new slide decks and videos for the KCL course.

The directory is gitignored (contents are not tracked, except `legacy/CLAUDE.md` and `legacy/.gitignore`).

See `legacy/CLAUDE.md` for the full directory structure, file inventory, and mapping between legacy sources and current pages.

### Content creation workflow

New slide decks and videos are created iteratively with Claude using legacy materials as springboards:

1. Read relevant legacy slides, transcripts, and reference pages on the topic
2. Adapt the pedagogical structure and explanations for the KCL context
3. Replace canonical examples (UCSD used California/Trump data; KCL uses Brexit, BES, QoG, NSS datasets)
4. Produce new `.qmd` slide decks for the Quarto website

### Rules

- Claude may **read** files in `legacy/` for reference
- Claude must **not modify** files in `legacy/` (except `legacy/CLAUDE.md` if instructed)
- Legacy materials inform structure and pedagogy, not specific examples or data
- When asked to create new content, check `legacy/` for relevant source material

---

# Shared Resource Directories

These directories contain reusable assets.

- `assets/` — images and static media
- `cards/` — thumbnail images used for YouTube video uploads
- `theme/` — SCSS theme files controlling slide styling

Claude may read these files but **must not modify them unless explicitly instructed**.

---

# Quarto Build Directories (Do Not Modify)

These directories are automatically generated by Quarto and must never be edited.

- `.quarto/`
- `_freeze/`
- `_site/`

---

# Protected Configuration Files

Claude may read these files but must not modify them unless explicitly instructed.

- `styles.css`
- files inside `theme/`
- `index.qmd`
- `about.qmd`
- `methods-education.Rproj`
- `reference/videos_metadata.csv`

Note: `reference/activities_metadata.csv` is **not** a protected file. Claude should update it when creating or modifying activity files to keep metadata in sync.

---

# Video Embedding Convention

Lecture videos are embedded **directly inside slide pages** using the full YouTube embed code copied from YouTube.

Embeds should typically appear **at the top of the page before the first heading**.

There is currently **no reusable include template for video embeds**.

When creating or editing pages, Claude should follow the embed pattern used in existing `.qmd` files.

---

# Current State of Video Embedding

The video integration is **in progress**.

- Some lecture videos have been uploaded to YouTube.
- Only a subset of those videos are currently embedded in the slide pages.
- Many slide pages still do not contain embedded videos.

Claude should **not attempt to automatically embed missing videos unless explicitly asked to perform that task**.

---

# Safe Editing Areas

Claude may freely:

- create new `.qmd` pages
- improve clarity of text
- add teaching material
- embed YouTube videos when instructed
- make small layout improvements within individual pages
- create and edit Stata do-files in `shared-project-folder/do/`
- run Stata do-files from the terminal and read the output (see "Running Stata from Claude Code")
- report and interpret Stata output (regression tables, summary statistics, etc.)
- create and edit R scripts in `r/`

When creating new content pages, Claude **must update `_quarto.yml`** to add the page to the sidebar so it appears on the site. Keeping the sidebar in sync with new content is part of the task, not a separate step requiring explicit instruction.

---

# Path and Link Safety

This repository relies heavily on **relative paths**.

Claude must not change relative paths unless explicitly instructed.

Breaking paths can break the site.

---

# Gitignore Convention for Non-Tracked Directories

When a directory contains files that should not be committed (e.g., large datasets, binary output) but also contains files that Claude needs to reference or edit, **never add the directory name to the root `.gitignore`**.

A root-level directory ignore (e.g., `my-folder/`) prevents git from descending into the directory entirely. This means files inside it **cannot be referenced with `@`** in VSCode's Claude Code extension.

Instead, use a **nested `.gitignore`** inside the directory:

```
# Ignore all contents by default
*

# Track this gitignore
!.gitignore

# Selectively un-ignore files that should be tracked
!do/
!do/*.do
```

This pattern is used by `legacy/.gitignore` and `shared-project-folder/.gitignore`. Any new directories added to the project that need selective tracking must follow the same convention.

---

# Editing Workflow

Before making changes:

1. Identify which files will be edited.
2. Explain why each file must change.
3. Confirm that no protected files are being modified.

---

# Change Logging

When Claude performs structural or multi-file changes it should create a short session log.

Logs are stored in:

logs/YYYY-MM-DD-session.md

Each log should contain:

- session date
- tasks completed
- files modified
- important notes

Logs should remain concise.

---

# Session Handoff for Cross-Machine Work

The user works across two PCs. Claude Code conversations and plans are stored locally and do not sync between machines.

When a session involves substantial design work or multi-step content creation, Claude should **proactively offer to write a handoff document** to `logs/` before the session ends.

Handoff documents are stored as:

logs/YYYY-MM-DD-handoff.md

A handoff should contain:

- what was built and why (pedagogical or design rationale)
- key decisions made during the conversation
- any data or output that informed the work (e.g. regression coefficients)
- what remains to be done
- source materials referenced

Handoff documents are more detailed than session logs. A session log records *what changed*; a handoff captures *the reasoning and context* needed to resume work in a new conversation on a different machine.

Claude should also save a recommended resume prompt to `prompts/` so the user can copy-paste it to start the next session. The prompt should reference the handoff document and any key files using `@` syntax.

---

# Rendering Validation

A full site render is slow (71+ pages). **Do not render after every change.** Render only when explicitly asked by the user or at the very end of a multi-file task before committing.

When rendering:

- Prefer `quarto render path/to/specific-file.qmd` for single-file checks (this only works after a full render has been run at least once in the session).
- Use a full `quarto render` only when structural files (`_quarto.yml`, theme, templates) have been edited or when the user requests it.
- Do not render speculatively to "check if it works." Trust the `.qmd` syntax; render to verify only when there is a specific reason to doubt correctness.

If rendering fails, stop and report the issue.

---

# Deployment Rules

Claude may publish the website **when explicitly asked** by the user using:

```bash
quarto publish gh-pages --no-browser
```

Claude must **never** publish without explicit instruction. Each publish pushes to the `gh-pages` branch and updates the live site.

Claude must not:

- push commits to the main branch (deployment is separate from committing)
- modify GitHub Pages configuration

---

# Project Memory File

`MEMORY.md` contains stable project knowledge.

Claude must treat it as authoritative documentation of project architecture and conventions.

Claude must not modify it unless instructed.

---

# Forbidden Tasks Without Explicit Instruction

Claude must not:

- refactor the repository
- rename directories
- move files between folders
- delete files
- modify global configuration
- alter theme styling
- restructure navigation (beyond adding new pages to the sidebar)