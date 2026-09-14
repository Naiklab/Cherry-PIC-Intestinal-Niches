#!/usr/bin/env Rscript
# =============================================================================
# Region-unique ligand-receptor pairs by module, stem-cell receiver -> Figure S8A/B
# =============================================================================
#
# An independent audit found no tracked entry point produces these panels: the
# frozen inputs (region_unique_combined_byreceiver_{duodenum,ileum}_stem_noclu.csv)
# and the published outputs (figS8A/figS8B) were both already in this repo, but
# nothing in scripts/ read one to produce the other. The Biomni session that made
# them wrote its plotting script directly to the sandbox filesystem; that source
# was never captured in the delivered execution trace, so it cannot be recovered
# verbatim.
#
# This is a new implementation, not a recovered original. The encoding below was
# read directly off the shipped figS8A PNG (axis labels, legend, point positions)
# rather than guessed:
#   - a dot plot, one row per pair, grouped and colour-coded by curated module
#   - x = nn_activity (NicheNet Pearson correlation; the shipped x-axis label is
#     literally "NicheNet activity (stem Pearson)")
#   - point size = -log10(aggregate_rank) (shipped legend: "-log10(RRA FDR)")
#   - point fill = dual (TRUE = solid, FALSE = pale/hollow; shipped legend
#     "Dual-supported: no / yes")
#   - rows and modules ordered by combined_rank, ascending (best first) -- this was
#     originally read off the shipped PNG as descending nn_activity, but a second
#     independent review found that doesn't reproduce the manuscript's module order;
#     combined_rank does (verified against both regions' CSVs)
#   - "top N" is the first N rows of the CSV, which is already combined_rank-
#     ascending (32/32 for duodenum, 50/117 for ileum) - confirmed against the
#     shipped files' own row/point counts
#
# Verify visually against the shipped figS8A/figS8B before treating this as the
# panel of record -- this reproduces the encoding, not necessarily every exact
# layout choice (point jitter, legend placement, panel sizing).

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(tidyverse)   # read_csv()
})

.here <- local({a <- commandArgs(FALSE); f <- sub("^--file=", "", a[grep("^--file=", a)])
          if (length(f)) dirname(normalizePath(f)) else getwd()})
DATA <- normalizePath(file.path(.here, "..", "outputs", "region_unique_combined_byreceiver"), mustWork = FALSE)

# Module -> (short label, hex color), recovered from the shipped SVGs' own <text> elements.
module_map <- list(
  "FGF signaling"                             = c("FGF",             "#999933"),
  "Growth factors (EGF/HGF/VEGF/Nrg)"         = c("Growth factors",  "#009E73"),
  "ECM–Integrin / Matrix"                = c("ECM–Integrin","#E69F00"),
  "Axon guidance (Ephrin/Sema/Netrin/Slit)"   = c("Axon guidance",   "#56B4E9"),
  "Other"                                     = c("Other",           "#0072B2"),
  "R-spondin / Lgr5 (Wnt amplifier)"          = c("R-spondin/Lgr5",  "#AA4499"),
  "Immune / antigen & integrin-Itgam"         = c("Immune",          "#D55E00"),
  "Lipid / lipoprotein & iron transport"      = c("Lipid/iron",      "#CC79A7"),
  "WNT signaling"                             = c("WNT",             "#44AA99"),
  "Wnt modulators (Sfrp/Sostdc1)"             = c("Wnt modulators",  "#DDCC77"),
  "ECM-remodeling / proteases & inhibitors"   = c("ECM-remodeling",  "#F0E442"),
  "Complement / coagulation"                  = c("Complement",      "#117733"),
  "BMP / TGFβ family"                    = c("BMP/TGFβ",   "#882255"),
  "Notch signaling"                           = c("Notch",           "#332288")
)
FALLBACK_COLOR <- "#999999"

short_label   <- function(m) vapply(m, function(x) if (x %in% names(module_map)) module_map[[x]][1] else x, character(1))
# Keyed by SHORT label, not raw module_curated -- cols is built from already-shortened
# labels (levels(df$short_module)), so the lookup must match on those, not the raw strings.
short_to_color <- setNames(vapply(module_map, `[`, character(1), 2),
                           vapply(module_map, `[`, character(1), 1))
color_for_short <- function(m) vapply(m, function(x) if (x %in% names(short_to_color)) short_to_color[[x]] else FALLBACK_COLOR, character(1))

plot_region <- function(region_label, csv_path, top_n, out_svg, out_png) {
  df <- read_csv(csv_path, show_col_types = FALSE)
  cat(sprintf("%s: %d rows in CSV, plotting top %d\n", region_label, nrow(df), min(top_n, nrow(df))))

  df <- head(df, top_n)   # already combined_rank-ascending -> first N is "top N"
  df$short_module <- short_label(df$module_curated)
  df$dual_supported <- toupper(as.character(df$dual)) == "TRUE"
  df$neglog10_fdr <- -log10(pmax(df$aggregate_rank, 1e-300))
  # Blank combined_rank sorts last (worst), matching how the CSV was already ranked.
  df$rank_for_order <- ifelse(is.na(df$combined_rank), Inf, df$combined_rank)

  # LIANA-only pairs carry no nn_activity value at all (blank, not just low) -- these
  # are exactly what the shipped figure's "no NicheNet activity" label marks. A second
  # independent review found the first version of this script placed them at the same
  # x-position as the most negative *real* measured value, which reads as a genuine
  # (if weak) activity rather than "no activity at all" and put the label in a spot that
  # could overlap real points. Give them their own position with a visible gap outside
  # the measured range instead.
  no_nn <- is.na(df$nn_activity)
  x_range <- range(df$nn_activity, na.rm = TRUE)
  x_gap <- diff(x_range) * 0.12
  x_no_nn <- x_range[1] - x_gap
  df$nn_activity[no_nn] <- x_no_nn

  # Order modules and pairs by combined_rank, ascending (best first) -- a second
  # independent review found the previous version ordered by nn_activity instead, which
  # does not reproduce the manuscript's order (verified here against the actual
  # duodenum/ileum CSVs: sorting each module by its single best combined_rank
  # reproduces the manuscript's exact module sequence, e.g. duodenum's
  # FGF -> Growth factors -> ECM-Integrin -> Axon guidance -> Other -> ...).
  mod_order <- df %>% group_by(short_module) %>% summarise(best = min(rank_for_order)) %>%
    arrange(best) %>% pull(short_module)
  df$short_module <- factor(df$short_module, levels = mod_order)
  df <- df %>% arrange(short_module, rank_for_order)
  df$pair <- factor(df$pair, levels = rev(df$pair))

  cols <- setNames(color_for_short(levels(df$short_module)), levels(df$short_module))

  # Module label positions: one per module, placed just past the plot's right edge,
  # vertically centred on that module's rows -- matching the shipped figure's layout.
  y_idx <- setNames(seq_along(levels(df$pair)), levels(df$pair))
  mod_labels <- df %>% mutate(yi = y_idx[as.character(pair)]) %>%
    group_by(short_module) %>% summarise(y = mean(yi)) %>%
    mutate(x = max(df$nn_activity, na.rm = TRUE) * 1.18)

  p <- ggplot(df, aes(x = nn_activity, y = pair, size = neglog10_fdr,
                      color = short_module, alpha = dual_supported)) +
    geom_point() +
    geom_text(data = mod_labels, aes(x = x, y = y, label = short_module, color = short_module),
             inherit.aes = FALSE, hjust = 0, fontface = "bold", size = 3) +
    { if (any(no_nn)) list(
        geom_vline(xintercept = x_range[1] - x_gap / 2, linetype = "dashed", color = "grey70", linewidth = 0.3),
        # A third independent review found this label at a fixed y = 0.3 (below row 1,
        # the lowest real data row) was clipped out of the rendered PNG/SVG entirely --
        # present in the vector geometry but invisible. Anchored to the midpoint of the
        # actual no-activity rows' y-positions instead, which is always in-range.
        annotate("text", x = x_no_nn, y = mean(y_idx[as.character(df$pair[no_nn])]),
                label = "no NicheNet\nactivity",
                angle = 90, hjust = 0.5, size = 2.3, color = "grey40", lineheight = 0.8)
      ) } +
    scale_color_manual(values = cols, guide = "none") +
    scale_alpha_manual(values = c(`TRUE` = 1, `FALSE` = 0.35), name = "Dual-supported",
                       labels = c(`FALSE` = "no", `TRUE` = "yes")) +
    scale_size_continuous(name = "-log10(RRA FDR)") +
    scale_x_continuous(expand = expansion(mult = c(0.1, 0.35))) +
    labs(title = sprintf("%s → Stem cells — top %d combined LIANA+NicheNet, by module",
                         region_label, min(top_n, nrow(df))),
        x = "NicheNet activity (stem Pearson)", y = NULL) +
    theme_minimal(base_size = 9) +
    theme(panel.grid.minor = element_blank(), legend.position = "bottom",
          plot.margin = margin(5.5, 30, 5.5, 5.5))

  h <- max(4, nrow(df) * 0.19)
  ggsave(out_svg, p, width = 9, height = h, limitsize = FALSE)
  ggsave(out_png, p, width = 9, height = h, dpi = 200, limitsize = FALSE)
  cat("  wrote", out_svg, "and", out_png, "\n")
}

plot_region("Duodenum", file.path(DATA, "region_unique_combined_byreceiver_duodenum_stem_noclu.csv"),
           top_n = 32,
           out_svg = file.path(DATA, "figS8A_region_unique_duodenum_stem_top32_rebuilt.svg"),
           out_png = file.path(DATA, "figS8A_region_unique_duodenum_stem_top32_rebuilt.png"))

plot_region("Ileum", file.path(DATA, "region_unique_combined_byreceiver_ileum_stem_noclu.csv"),
           top_n = 50,
           out_svg = file.path(DATA, "figS8B_region_unique_ileum_stem_top50_rebuilt.svg"),
           out_png = file.path(DATA, "figS8B_region_unique_ileum_stem_top50_rebuilt.png"))

cat("\nDone. These are written with a _rebuilt suffix -- compare against the shipped\n")
cat("figS8A/figS8B before replacing them as the panel of record.\n")
