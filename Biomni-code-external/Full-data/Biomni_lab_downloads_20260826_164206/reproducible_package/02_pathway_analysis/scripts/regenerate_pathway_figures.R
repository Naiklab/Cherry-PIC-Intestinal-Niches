suppressPackageStartupMessages({
  library(ggplot2)
  library(data.table)
  library(stringr)
  library(svglite)
  library(ComplexHeatmap)
  library(circlize)
  library(grid)
})
set.seed(42)

fontf <- "Liberation Sans"
theme_set(theme_classic(base_family = fontf) +
          theme(text = element_text(family = fontf)))

cat("=== Regenerating pathway figures (v4: module-level bars) ===\n\n")

# ── Load and filter data ──
dt <- fread("/mnt/results/pathway_table_cleaned.csv")
sig <- dt[!is.na(padj) & padj < 0.05]
cat("Total pathways in cleaned table:", nrow(dt), "\n")
cat("Significant (padj < 0.05):", nrow(sig), "\n")

# ── Remove Stem cells ──
sig <- sig[cell_type != "Stem cells"]
cat("After removing Stem cells:", nrow(sig), "pathways\n\n")

# ── Constants ──
region_colors <- c(
  "Duo"             = "#0279EE",
  "Shared-Duodenum" = "#5BA3F0",
  "Ile"             = "#E74C3C",
  "Shared-Ileum"    = "#F1948A"
)

# Fixed cell type order: epithelial → stromal → immune (Stem cells removed)
ct_order <- c("Bottom-villus EC", "Fibroblasts", "Endothelial",
              "Macrophages", "cDC1", "Plasmablasts")

# Clean cell type names for filenames
ct_filename <- function(ct) gsub("[^A-Za-z0-9]", "_", ct)

# Truncate pathway names
trunc_name <- function(x, n = 55) {
  sapply(x, function(s) {
    if (nchar(s) > n) paste0(substr(s, 1, n - 3), "...") else s
  }, USE.NAMES = FALSE)
}

# Clean pathway names: strip database prefixes, replace underscores with spaces
clean_pathway_name <- function(x) {
  sapply(x, function(s) {
    # Strip common prefixes
    s <- gsub("^(WP|REACTOME|KEGG|GOBP|GOCC|GOMF|HALLMARK|BIOCARTA|PID)_", "", s)
    # Replace underscores with spaces
    s <- gsub("_", " ", s)
    # Title case
    s <- tolower(s)
    s <- paste0(toupper(substr(s, 1, 1)), substr(s, 2, nchar(s)))
    s
  }, USE.NAMES = FALSE)
}

# Clean module names for filenames
mod_filename <- function(mod) {
  gsub("[^A-Za-z0-9]", "_", mod) |>
    gsub("_+", "_", x = _) |>
    gsub("^_|_$", "", x = _)
}

# ── Ensure output directories exist ──
fig_dir <- "/mnt/results/figures"
barplot_dir <- file.path(fig_dir, "pathways_ambient_removed")
hm_dir <- file.path(fig_dir, "module_heatmaps")
dir.create(barplot_dir, showWarnings = FALSE, recursive = TRUE)
dir.create(hm_dir, showWarnings = FALSE, recursive = TRUE)

# ── Delete old Stem cells bar plot files ──
old_stem <- list.files(barplot_dir, pattern = "^pathway_barplot_Stem_cells",
                       full.names = TRUE)
for (f in old_stem) {
  file.remove(f)
  cat("  Removed old file:", basename(f), "\n")
}

# ═══════════════════════════════════════════════════════════════
# BAR PLOTS — module-level, one bar per (module, region_class) pair
# Duodenum on top, Ileum on bottom, sorted by |NES| within region
# ═══════════════════════════════════════════════════════════════
cat("\n--- Generating module-level bar plots ---\n\n")

for (ct in ct_order) {
  pw_dt <- copy(sig[cell_type == ct])
  if (nrow(pw_dt) == 0) {
    cat(sprintf("  %s: 0 significant pathways (skipped)\n", ct))
    next
  }

  # Aggregate to (module, region_class) pairs
  mod_agg <- pw_dt[, .(
    mean_NES = mean(NES),
    n_pathways = .N
  ), by = .(module, region_class)]

  n_bars <- nrow(mod_agg)
  n_mod <- uniqueN(mod_agg$module)

  # Create display label: module name + [region] tag for shared modules
  mod_agg[, label := ifelse(
    grepl("^Shared", region_class),
    paste0(module, " [", region_class, "]"),
    module
  )]

  # Direction: Duodenum (negative NES) or Ileum (positive NES)
  mod_agg[, direction := ifelse(mean_NES < 0, "Duodenum", "Ileum")]

  # Order: Duodenum on top (sorted by |NES| desc), then Ileum (sorted by |NES| desc)
  mod_agg <- mod_agg[order(direction == "Ileum", -abs(mean_NES))]
  mod_agg[, row_idx := seq_len(.N)]
  N <- nrow(mod_agg)

  # Factor with reversed levels so first bar (largest |NES| Duodenum) at TOP
  mod_agg[, row_f := factor(row_idx, levels = rev(row_idx))]

  # Label map
  label_map <- setNames(mod_agg$label, as.character(mod_agg$row_idx))

  # Region group boundaries for annotations
  n_duo <- sum(mod_agg$direction == "Duodenum")
  n_ile <- sum(mod_agg$direction == "Ileum")

  # Y positions in ggplot2 discrete coords (reversed factor: row_idx=i → y = N-i+1)
  # Duodenum group: row_idx 1..n_duo → y = N..N-n_duo+1
  # Ileum group: row_idx n_duo+1..N → y = N-n_duo..1
  duo_center_y <- if (n_duo > 0) N - n_duo / 2 + 0.5 else NA
  ile_center_y <- if (n_ile > 0) (N - n_duo + 1) / 2 else NA

  # X position for region annotations (right side, outside plot area)
  x_max <- max(abs(mod_agg$mean_NES)) * 1.05
  x_annot <- x_max * 1.12

  # Build plot
  p <- ggplot(mod_agg, aes(x = mean_NES, y = row_f, fill = region_class)) +
    geom_col(width = 0.7) +
    geom_vline(xintercept = 0, color = "grey40", linewidth = 0.4) +
    scale_y_discrete(labels = label_map) +
    scale_fill_manual(
      values = region_colors,
      name = "Region class",
      breaks = c("Duo", "Shared-Duodenum", "Ile", "Shared-Ileum"),
      labels = c("Duodenum-specific", "Shared (Duodenum-dir)",
                 "Ileum-specific", "Shared (Ileum-dir)")
    ) +
    scale_x_continuous(breaks = scales::pretty_breaks(n = 5)) +
    coord_cartesian(clip = "off") +
    labs(
      x = "NES (Ileum vs Duodenum)",
      y = NULL,
      title = paste0(ct, " — Module-level pathway enrichment"),
      subtitle = paste0(
        "Bars grouped by region (Duodenum on top, Ileum on bottom) | ",
        "sorted by |NES| within region | ",
        n_bars, " module-region bars from ", n_mod, " modules"
      )
    ) +
    theme(
      axis.text.y = element_text(size = 8, family = fontf, hjust = 1),
      axis.text.x = element_text(size = 8, family = fontf),
      legend.position = "bottom",
      legend.text = element_text(size = 8, family = fontf),
      legend.title = element_text(size = 9, family = fontf),
      plot.title = element_text(size = 12, face = "bold", family = fontf),
      plot.subtitle = element_text(size = 8, color = "grey40", family = fontf),
      plot.margin = margin(5.5, 60, 5.5, 5.5, "pt")
    )

  # Add region annotations on the right side
  if (!is.na(duo_center_y)) {
    p <- p + annotate("text", x = x_annot, y = duo_center_y,
                      label = "Duodenum", angle = 270, size = 3.5,
                      fontface = "bold", color = "#0279EE", family = fontf)
  }
  if (!is.na(ile_center_y)) {
    p <- p + annotate("text", x = x_annot, y = ile_center_y,
                      label = "Ileum", angle = 270, size = 3.5,
                      fontface = "bold", color = "#E74C3C", family = fontf)
  }

  # Figure dimensions: fixed width, height scales with bar count
  fig_w <- 10
  fig_h <- max(4, n_bars * 0.35 + 2.5)

  # Clean filename
  fn <- ct_filename(ct)
  png_path <- file.path(barplot_dir, paste0("pathway_barplot_", fn, ".png"))
  svg_path <- file.path(barplot_dir, paste0("pathway_barplot_", fn, ".svg"))

  # Delete old files (S3 FUSE overwrite issue)
  if (file.exists(png_path)) file.remove(png_path)
  if (file.exists(svg_path)) file.remove(svg_path)

  ggsave(png_path, p, width = fig_w, height = fig_h, dpi = 200, limitsize = FALSE)
  svglite::svglite(svg_path, width = fig_w, height = fig_h)
  print(p)
  dev.off()

  cat(sprintf("  %s: %d bars (%d modules) — saved (%.0f x %.0f in)\n",
              ct, n_bars, n_mod, fig_w, fig_h))
}

cat("\n--- Bar plots done ---\n\n")

# ═══════════════════════════════════════════════════════════════
# MODULE HEATMAPS — one per module
# Style matched to example: raw names, wrapped labels, blue-white-red, gray NA
# ═══════════════════════════════════════════════════════════════
cat("--- Generating module heatmaps (example style) ---\n\n")

# Get modules with significant pathways, ordered by count
mod_summary <- sig[, .N, by = module][order(-N)]
cat("Modules with significant pathways:", nrow(mod_summary), "\n\n")

# NES color scale (symmetric around 0) — example colors
nes_range <- max(abs(sig$NES), na.rm = TRUE)
nes_breaks <- c(-ceiling(nes_range), 0, ceiling(nes_range))
col_fun <- colorRamp2(nes_breaks, c("#247CEF", "#FFFFFF", "#E74C3C"))

# Wrap pathway names at ~35 chars, breaking at underscores
wrap_pathway_name <- function(x, width = 35) {
  sapply(x, function(s) {
    if (nchar(s) <= width) return(s)
    # Find the last underscore before position width
    breaks <- gregexpr("_", s)[[1]]
    breaks <- breaks[breaks <= width & breaks > 0]
    if (length(breaks) == 0) {
      # No underscore before width, just break at width
      return(paste0(substr(s, 1, width), "\n", substr(s, width + 1, nchar(s))))
    }
    # Break at the last underscore
    pos <- max(breaks)
    paste0(substr(s, 1, pos - 1), "\n", substr(s, pos + 1, nchar(s)))
  }, USE.NAMES = FALSE)
}

for (i in seq_len(nrow(mod_summary))) {
  mod <- mod_summary$module[i]
  n_sig <- mod_summary$N[i]

  # Get all rows for this module (significant only)
  mod_dt <- sig[module == mod]

  # Get unique pathways in this module
  mod_pathways <- unique(mod_dt$pathway)

  # Determine which cell types have at least one significant pathway in this module
  ct_present <- ct_order[sapply(ct_order, function(ct) nrow(mod_dt[cell_type == ct]) > 0)]

  # Build NES matrix: pathways (rows) x present cell types (cols)
  nes_mat <- matrix(NA_real_, nrow = length(mod_pathways),
                    ncol = length(ct_present),
                    dimnames = list(wrap_pathway_name(mod_pathways), ct_present))

  for (j in seq_along(mod_pathways)) {
    pw <- mod_pathways[j]
    for (k in seq_along(ct_present)) {
      ct <- ct_present[k]
      r <- mod_dt[pathway == pw & cell_type == ct]
      if (nrow(r) > 0) {
        nes_mat[j, k] <- r$NES
      }
    }
  }

  # Order pathways by row-mean NES (NA as 0), ascending — Duodenum-dominant at top
  row_means <- rowMeans(nes_mat, na.rm = FALSE)
  row_means[is.na(row_means)] <- 0
  row_order <- order(row_means)
  nes_mat <- nes_mat[row_order, , drop = FALSE]

  # Figure dimensions — account for wrapped labels (up to 2 lines per label)
  n_rows <- nrow(nes_mat)
  n_cols <- ncol(nes_mat)
  # Estimate label width: use the longest single-line segment after wrapping
  max_name_len <- max(sapply(rownames(nes_mat), function(s) max(nchar(strsplit(s, "\n")[[1]]))))
  label_w <- max_name_len * 0.075  # generous: ~0.075 in per char at fontsize 8
  # Height: each row may have 2 lines, so use 0.45 in per row
  fig_h <- max(3, n_rows * 0.45 + 2.5)
  fig_w <- max(6, n_cols * 1.2 + label_w + 3)

  # Clean filename
  fn <- mod_filename(mod)
  png_path <- file.path(hm_dir, paste0("module_heatmap_", fn, ".png"))
  svg_path <- file.path(hm_dir, paste0("module_heatmap_", fn, ".svg"))

  # Delete old files
  if (file.exists(png_path)) file.remove(png_path)
  if (file.exists(svg_path)) file.remove(svg_path)

  # Build heatmap — example style
  png(png_path, width = fig_w, height = fig_h, units = "in", res = 200,
      family = fontf, type = "cairo")

  hm <- Heatmap(
    nes_mat,
    name = "NES",
    col = col_fun,
    cluster_rows = FALSE,
    cluster_columns = FALSE,
    show_row_dend = FALSE,
    row_names_side = "left",
    row_names_gp = gpar(fontsize = 8, fontfamily = fontf, col = "#4D4D4D"),
    column_names_gp = gpar(fontsize = 9, fontfamily = fontf, col = "#4D4D4D"),
    column_names_rot = 35,
    column_title = paste0(mod, " — pathway enrichment across cell types\n",
                          "Blue = Duodenum-up (NES<0) | Red = Ileum-up (NES>0) | Gray = not present"),
    column_title_gp = gpar(fontsize = 10, fontfamily = fontf, fontface = "bold"),
    heatmap_legend_param = list(
      title = "NES\n(Ile vs Duo)",
      title_gp = gpar(fontsize = 9, fontfamily = fontf),
      labels_gp = gpar(fontsize = 8, fontfamily = fontf),
      legend_height = unit(3, "cm"),
      at = seq(-ceiling(nes_range), ceiling(nes_range), 1)
    ),
    na_col = "#ECE9E2",
    border = FALSE,
    rect_gp = gpar(col = "white", lwd = 1.28),
    width = unit(n_cols * 1.2, "in"),
    use_raster = FALSE
  )

  draw(hm, padding = unit(c(2, 2, 2, 10), "mm"))
  dev.off()

  # SVG version
  svglite::svglite(svg_path, width = fig_w, height = fig_h)
  draw(hm, padding = unit(c(2, 2, 2, 10), "mm"))
  dev.off()

  cat(sprintf("  %s: %d pathways x %d cell types — saved\n", mod, n_rows, n_cols))
}

cat("\n--- Module heatmaps done ---\n\n")

# ═══════════════════════════════════════════════════════════════
# SUMMARY
# ═══════════════════════════════════════════════════════════════
cat("=== SUMMARY ===\n")
cat("Bar plots generated:\n")
bar_files <- list.files(barplot_dir, pattern = "^pathway_barplot_.*\\.png$", full.names = TRUE)
for (f in sort(bar_files)) cat("  ", basename(f), "\n")
cat("\nModule heatmaps generated:\n")
hm_files <- list.files(hm_dir, pattern = "^module_heatmap_.*\\.png$", full.names = TRUE)
for (f in sort(hm_files)) cat("  ", basename(f), "\n")
cat("\nTotal: ", length(bar_files), " bar plots + ", length(hm_files), " heatmaps\n", sep = "")
cat("\n=== DONE ===\n")
