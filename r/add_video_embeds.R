#!/usr/bin/env Rscript
# Insert a YouTube iframe embed into each video page that does not already
# have one. Reads the YouTube ID for each video from videos_metadata.csv and
# inserts the iframe immediately after the page's H1 title line, matching
# the convention already used in S01-doing-reproducible-research.qmd.

PROJECT_ROOTS <- c(
  "C:/Users/leona/OneDrive - King's College London/methods-education",
  "C:/Users/k2588471/OneDrive - King's College London/methods-education"
)
PROJECT_ROOT <- PROJECT_ROOTS[file.exists(PROJECT_ROOTS)][1]
stopifnot("project root not found" = !is.na(PROJECT_ROOT))

META_CSV <- file.path(PROJECT_ROOT, "reference", "videos_metadata.csv")
SLIDES_C <- file.path(PROJECT_ROOT, "slides", "videos-concepts")
SLIDES_S <- file.path(PROJECT_ROOT, "slides", "videos-stata")

iframe_for <- function(video_id) {
  sprintf(
    '<iframe width="560" height="315" src="https://www.youtube.com/embed/%s" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>',
    video_id
  )
}

find_qmd <- function(file_name) {
  for (dir in c(SLIDES_C, SLIDES_S)) {
    p <- file.path(dir, paste0(file_name, ".qmd"))
    if (file.exists(p)) return(p)
  }
  NA_character_
}

insert_embed <- function(qmd_path, video_id) {
  lines <- readLines(qmd_path, warn = FALSE)

  if (any(grepl("youtube\\.com/embed", lines, fixed = FALSE))) {
    return("skipped (already embedded)")
  }

  # Find the first H1 title line, e.g. "# Foo {.title-left}". Use the first
  # line that begins with "# " followed by anything (not "## ").
  title_idx <- which(grepl("^# [^#]", lines))
  if (length(title_idx) == 0) {
    return("skipped (no H1 title found)")
  }
  i <- title_idx[1]

  # Decide insertion: after the title line, then a blank line, then iframe,
  # then a blank line, then the rest. If the file already has a blank line
  # right after the title, reuse it.
  iframe_line <- iframe_for(video_id)
  before <- lines[seq_len(i)]
  after  <- if (i < length(lines)) lines[(i + 1):length(lines)] else character(0)

  # Trim any leading blank lines from `after` so we control spacing precisely.
  while (length(after) > 0 && !nzchar(after[1])) {
    after <- after[-1]
  }

  new_lines <- c(before, "", iframe_line, "", after)
  writeLines(new_lines, qmd_path, useBytes = TRUE)
  "inserted"
}

main <- function() {
  meta <- read.csv(META_CSV, stringsAsFactors = FALSE, check.names = FALSE)
  inserted <- 0L
  skipped  <- 0L
  missing  <- 0L

  for (i in seq_len(nrow(meta))) {
    row <- meta[i, ]
    file_name  <- row[["File name"]]
    video_id   <- row[["YouTube ID"]]
    if (is.na(file_name) || file_name == "") next
    if (is.na(video_id)  || video_id  == "") {
      cat(sprintf("- %-36s no YouTube ID, skip\n", file_name))
      missing <- missing + 1L
      next
    }
    qmd <- find_qmd(file_name)
    if (is.na(qmd)) {
      cat(sprintf("- %-36s no matching .qmd, skip\n", file_name))
      missing <- missing + 1L
      next
    }
    result <- insert_embed(qmd, video_id)
    if (result == "inserted") {
      inserted <- inserted + 1L
    } else {
      skipped <- skipped + 1L
    }
    cat(sprintf("- %-36s %s\n", file_name, result))
  }

  cat(sprintf("\nDone. Inserted %d, skipped %d, missing %d.\n",
              inserted, skipped, missing))
}

main()
