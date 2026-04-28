#!/usr/bin/env Rscript
# Generate YouTube thumbnail cards for video pages, imitating the rendered
# RevealJS title-slide style of the existing JPGs in cards/.
#
# Reads titles from reference/videos_metadata.csv, draws a 1920x1080 JPG per
# video with a left-aligned blue title, a hamburger menu icon at the bottom
# left, and a "1 / N" slide counter at the bottom right. Skips files that
# already exist in cards/ so re-running is idempotent.

if (!requireNamespace("magick", quietly = TRUE)) {
  install.packages("magick", repos = "https://cloud.r-project.org")
}
library(magick)

PROJECT_ROOTS <- c(
  "C:/Users/leona/OneDrive - King's College London/methods-education",
  "C:/Users/k2588471/OneDrive - King's College London/methods-education"
)
PROJECT_ROOT <- PROJECT_ROOTS[file.exists(PROJECT_ROOTS)][1]
stopifnot("project root not found" = !is.na(PROJECT_ROOT))

CARDS_DIR <- file.path(PROJECT_ROOT, "cards")
META_CSV  <- file.path(PROJECT_ROOT, "reference", "videos_metadata.csv")
SLIDES_C  <- file.path(PROJECT_ROOT, "slides", "videos-concepts")
SLIDES_S  <- file.path(PROJECT_ROOT, "slides", "videos-stata")

WIDTH        <- 1920
HEIGHT       <- 1080
BG           <- "#f2f2f2"
BLUE         <- "#2871f2"
GREY         <- "#9a9a9a"
TITLE_SIZE   <- 130
COUNTER_SIZE <- 32
MARGIN_X     <- 80
MARGIN_Y     <- 40

count_slides <- function(qmd_path) {
  if (is.na(qmd_path) || !file.exists(qmd_path)) return(10L)
  lines <- readLines(qmd_path, warn = FALSE)
  n_seps <- sum(grepl("^-{6,}\\s*$", lines))
  if (n_seps > 0) n_seps + 1L else 10L
}

find_qmd <- function(file_name) {
  for (dir in c(SLIDES_C, SLIDES_S)) {
    p <- file.path(dir, paste0(file_name, ".qmd"))
    if (file.exists(p)) return(p)
  }
  NA_character_
}

wrap_title <- function(title, width = 22) {
  paste(strwrap(title, width = width), collapse = "\n")
}

draw_card <- function(title, n_slides, out_path) {
  img <- image_blank(WIDTH, HEIGHT, color = BG)

  # Title: left-aligned, vertically centered. Pad ~200px from the left edge to
  # match the existing screenshots.
  wrapped <- wrap_title(title, width = 22)
  img <- image_annotate(
    img, wrapped,
    size = TITLE_SIZE, color = BLUE, weight = 700,
    font = "sans", gravity = "West",
    location = sprintf("+%d+0", 200)
  )

  # Slide counter (bottom-right)
  img <- image_annotate(
    img, paste0("1 / ", n_slides),
    size = COUNTER_SIZE, color = GREY,
    font = "sans", gravity = "SouthEast",
    location = sprintf("+%d+%d", MARGIN_X, MARGIN_Y)
  )

  # Hamburger menu icon: three short horizontal bars, bottom-left.
  bar_w <- 36; bar_h <- 5; gap <- 9
  total_h <- 3 * bar_h + 2 * gap
  x0 <- MARGIN_X
  y0 <- HEIGHT - MARGIN_Y - total_h
  canvas <- image_draw(img)
    for (i in 0:2) {
      rect(
        x0,
        y0 + i * (bar_h + gap),
        x0 + bar_w,
        y0 + i * (bar_h + gap) + bar_h,
        col = GREY, border = NA
      )
    }
  dev.off()
  img <- canvas

  image_write(img, out_path, format = "jpg", quality = 92)
}

main <- function() {
  meta <- read.csv(META_CSV, stringsAsFactors = FALSE, check.names = FALSE)
  generated <- 0L
  skipped   <- 0L
  for (i in seq_len(nrow(meta))) {
    row <- meta[i, ]
    file_name <- row[["File name"]]
    title     <- row[["Final Title"]]
    if (is.na(file_name) || file_name == "") next
    out_path  <- file.path(CARDS_DIR, paste0(file_name, ".jpg"))
    if (file.exists(out_path)) {
      skipped <- skipped + 1L
      next
    }
    qmd <- find_qmd(file_name)
    n_slides <- count_slides(qmd)
    cat(sprintf("Generating: %s (slides=%d)\n", file_name, n_slides))
    draw_card(title, n_slides, out_path)
    generated <- generated + 1L
  }
  cat(sprintf("\nDone. Generated %d, skipped %d (already existed).\n",
              generated, skipped))
}

main()
