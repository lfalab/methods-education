library(ggplot2)
library(grid)
library(gridExtra)

make_table <- function(highlight = "none") {

  p <- ggplot() +
    xlim(0, 10) + ylim(1.8, 11.6) +
    theme_void() +
    theme(plot.background = element_rect(fill = "white", colour = NA),
          plot.margin = margin(5, 5, 5, 5))

  black <- "black"
  grey  <- "grey50"
  hcol  <- "#FFD700"

  # Whether to render stars in yellow bold
  star_hl <- (highlight == "stars")
  star_col <- if (star_hl) hcol else black
  star_face <- if (star_hl) "bold" else "plain"
  # For the no-stars case (Model 3 immigration)
  nostar_col <- if (star_hl) hcol else black
  nostar_face <- if (star_hl) "bold" else "plain"

  # ── Highlight boxes (drawn first so they sit behind text) ──
  if (highlight == "columns") {
    p <- p +
      annotate("rect", xmin = 2.8, xmax = 9.2, ymin = 2.0, ymax = 11.2,
               fill = hcol, alpha = 0.25, colour = hcol, linewidth = 1.2)
  }
  if (highlight == "depvar") {
    p <- p +
      annotate("rect", xmin = 2.8, xmax = 9.2, ymin = 10.4, ymax = 11.2,
               fill = hcol, alpha = 0.25, colour = hcol, linewidth = 1.2)
  }
  if (highlight == "rows") {
    p <- p +
      annotate("rect", xmin = 0.3, xmax = 2.8, ymin = 5.2, ymax = 9.4,
               fill = hcol, alpha = 0.25, colour = hcol, linewidth = 1.2)
  }
  if (highlight == "bottom") {
    p <- p +
      annotate("rect", xmin = 0.3, xmax = 9.7, ymin = 2.8, ymax = 4.8,
               fill = hcol, alpha = 0.18, colour = hcol, linewidth = 1.2)
  }
  if (highlight == "blanks") {
    p <- p +
      annotate("rect", xmin = 3.3, xmax = 5.1, ymin = 7.0, ymax = 8.0,
               fill = hcol, alpha = 0.3, colour = hcol, linewidth = 1.2) +
      annotate("rect", xmin = 5.5, xmax = 7.3, ymin = 8.5, ymax = 9.5,
               fill = hcol, alpha = 0.3, colour = hcol, linewidth = 1.2)
  }
  if (highlight == "se") {
    p <- p +
      annotate("rect", xmin = 3.35, xmax = 4.85, ymin = 8.35, ymax = 8.65,
               fill = hcol, alpha = 0.3, colour = hcol, linewidth = 1) +
      annotate("rect", xmin = 5.45, xmax = 6.95, ymin = 6.85, ymax = 7.15,
               fill = hcol, alpha = 0.3, colour = hcol, linewidth = 1) +
      annotate("rect", xmin = 7.45, xmax = 8.95, ymin = 8.35, ymax = 8.65,
               fill = hcol, alpha = 0.3, colour = hcol, linewidth = 1) +
      annotate("rect", xmin = 7.45, xmax = 8.95, ymin = 6.85, ymax = 7.15,
               fill = hcol, alpha = 0.3, colour = hcol, linewidth = 1)
  }

  # ── Horizontal rules ──
  p <- p +
    geom_segment(aes(x = 0.5, xend = 9.5, y = 11.3, yend = 11.3), linewidth = 0.5) +
    geom_segment(aes(x = 3.2, xend = 9.5, y = 10.35, yend = 10.35), linewidth = 0.3) +
    geom_segment(aes(x = 0.5, xend = 9.5, y = 4.8, yend = 4.8), linewidth = 0.3) +
    geom_segment(aes(x = 0.5, xend = 9.5, y = 2.8, yend = 2.8), linewidth = 0.5)

  # ── Header ──
  sz_title <- 3.2
  sz_body  <- 3.0
  sz_small <- 2.6

  p <- p +
    annotate("text", x = 6.3, y = 11.0, label = "Dependent variable:", fontface = "italic",
             size = sz_title, colour = black) +
    annotate("text", x = 6.3, y = 10.65, label = "Leave Vote Share (%)",
             size = sz_title, colour = black) +
    annotate("text", x = 4.2, y = 10.05, label = "(1)", size = sz_body, colour = black) +
    annotate("text", x = 6.3, y = 10.05, label = "(2)", size = sz_body, colour = black) +
    annotate("text", x = 8.3, y = 10.05, label = "(3)", size = sz_body, colour = black)

  # ── Variable row labels ──
  lx <- 1.5
  p <- p +
    annotate("text", x = lx, y = 9.0, label = "Higher Education (%)", size = sz_body,
             colour = black, hjust = 0.5) +
    annotate("text", x = lx, y = 7.5, label = "Immigrant Share (%)", size = sz_body,
             colour = black, hjust = 0.5) +
    annotate("text", x = lx, y = 6.0, label = "Constant", size = sz_body,
             colour = black, hjust = 0.5)

  # ── Coefficients: split number and stars into separate text layers ──
  # This lets us colour/bold the stars independently

  # Offset between number and stars
  soff <- 0.03
  # SE offset: shift SEs left to align with the number portion (not centred on number+stars)
  se_off <- 0.15

  # Model 1: Education -1.130***
  p <- p +
    annotate("text", x = 4.2 - soff, y = 9.0, label = "-1.130", size = sz_body,
             colour = black, hjust = 1) +
    annotate("text", x = 4.2 + soff, y = 9.0, label = "***", size = sz_body,
             colour = star_col, fontface = star_face, hjust = 0) +
    annotate("text", x = 4.2 - se_off, y = 8.5, label = "(0.147)", size = sz_small, colour = grey)

  # Model 1: Constant 83.918***
  p <- p +
    annotate("text", x = 4.2 - soff, y = 6.0, label = "83.918", size = sz_body,
             colour = black, hjust = 1) +
    annotate("text", x = 4.2 + soff, y = 6.0, label = "***", size = sz_body,
             colour = star_col, fontface = star_face, hjust = 0) +
    annotate("text", x = 4.2 - se_off, y = 5.5, label = "(3.995)", size = sz_small, colour = grey)

  # Model 2: Immigration -0.414***
  p <- p +
    annotate("text", x = 6.3 - soff, y = 7.5, label = "-0.414", size = sz_body,
             colour = black, hjust = 1) +
    annotate("text", x = 6.3 + soff, y = 7.5, label = "***", size = sz_body,
             colour = star_col, fontface = star_face, hjust = 0) +
    annotate("text", x = 6.3 - se_off, y = 7.0, label = "(0.066)", size = sz_small, colour = grey)

  # Model 2: Constant 56.807***
  p <- p +
    annotate("text", x = 6.3 - soff, y = 6.0, label = "56.807", size = sz_body,
             colour = black, hjust = 1) +
    annotate("text", x = 6.3 + soff, y = 6.0, label = "***", size = sz_body,
             colour = star_col, fontface = star_face, hjust = 0) +
    annotate("text", x = 6.3 - se_off, y = 5.5, label = "(1.110)", size = sz_small, colour = grey)

  # Model 3: Education -1.143***
  p <- p +
    annotate("text", x = 8.3 - soff, y = 9.0, label = "-1.143", size = sz_body,
             colour = black, hjust = 1) +
    annotate("text", x = 8.3 + soff, y = 9.0, label = "***", size = sz_body,
             colour = star_col, fontface = star_face, hjust = 0) +
    annotate("text", x = 8.3 - se_off, y = 8.5, label = "(0.148)", size = sz_small, colour = grey)

  # Model 3: Immigration 0.085 (no stars)
  p <- p +
    annotate("text", x = 8.3, y = 7.5, label = "0.085", size = sz_body, colour = black) +
    annotate("text", x = 8.3 - se_off, y = 7.0, label = "(0.112)", size = sz_small, colour = grey)

  # Model 3: Constant 83.493***
  p <- p +
    annotate("text", x = 8.3 - soff, y = 6.0, label = "83.493", size = sz_body,
             colour = black, hjust = 1) +
    annotate("text", x = 8.3 + soff, y = 6.0, label = "***", size = sz_body,
             colour = star_col, fontface = star_face, hjust = 0) +
    annotate("text", x = 8.3 - se_off, y = 5.5, label = "(4.040)", size = sz_small, colour = grey)

  # ── Bottom panel ──
  p <- p +
    annotate("text", x = lx, y = 4.4, label = "Observations", size = sz_small, colour = black, hjust = 0.5) +
    annotate("text", x = 4.2, y = 4.4, label = "139", size = sz_small, colour = black) +
    annotate("text", x = 6.3, y = 4.4, label = "167", size = sz_small, colour = black) +
    annotate("text", x = 8.3, y = 4.4, label = "139", size = sz_small, colour = black) +

    annotate("text", x = lx, y = 3.8, label = expression(R^2), size = sz_small, colour = black, hjust = 0.5) +
    annotate("text", x = 4.2, y = 3.8, label = "0.301", size = sz_small, colour = black) +
    annotate("text", x = 6.3, y = 3.8, label = "0.193", size = sz_small, colour = black) +
    annotate("text", x = 8.3, y = 3.8, label = "0.304", size = sz_small, colour = black) +

    annotate("text", x = lx, y = 3.2, label = expression(paste("Adjusted ", R^2)), size = sz_small,
             colour = black, hjust = 0.5) +
    annotate("text", x = 4.2, y = 3.2, label = "0.296", size = sz_small, colour = black) +
    annotate("text", x = 6.3, y = 3.2, label = "0.188", size = sz_small, colour = black) +
    annotate("text", x = 8.3, y = 3.2, label = "0.294", size = sz_small, colour = black)

  # ── Note ──
  p <- p +
    annotate("text", x = 5, y = 2.4,
             label = expression(paste(italic("Note: "), "*p<0.1; **p<0.05; ***p<0.01")),
             size = sz_small, colour = grey)

  return(p)
}

# ── Generate all versions ──
outdir <- "C:/Users/leona/OneDrive - King's College London/methods-education/assets"

versions <- c("none", "columns", "depvar", "rows", "bottom", "blanks", "stars", "se")
filenames <- c("reg-table-brexit.png",
               "reg-table-brexit-columns.png",
               "reg-table-brexit-depvar.png",
               "reg-table-brexit-rows.png",
               "reg-table-brexit-bottom.png",
               "reg-table-brexit-blanks.png",
               "reg-table-brexit-stars.png",
               "reg-table-brexit-se.png")

for (i in seq_along(versions)) {
  p <- make_table(highlight = versions[i])
  ggsave(file.path(outdir, filenames[i]), plot = p,
         width = 7, height = 4, dpi = 200, bg = "white")
  cat("Saved:", filenames[i], "\n")
}
