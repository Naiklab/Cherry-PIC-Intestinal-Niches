#!/usr/bin/env Rscript
# Final dot plots: 2 compartments (Epithelial, Immune+Stroma)
# Two color scales per compartment: z-score and log1p
# Genes on x-axis, cell types on y-axis
# Reversed inferno palette, shape=21 dots, theme_classic
#
# Input:  data/annotation_marker_genes_reduced.csv + objects/obj_no_midvillus.rds
# Output: figures/dotplot_epithelial_zscore.png/.svg
#         figures/dotplot_epithelial_log1p.png/.svg
#         figures/dotplot_immune_stroma_zscore.png/.svg
#         figures/dotplot_immune_stroma_log1p.png/.svg
#         data/annotation_marker_genes_no_midvillus.csv (intermediate)

suppressMessages({
  library(Seurat)
  library(ggplot2)
  library(svglite)
})

# ---- Configuration ----
base_dir <- "."  # Path to the reproduce_plots/ directory

# Derived paths (do not edit below)
data_dir <- file.path(base_dir, "data")
obj_dir  <- file.path(base_dir, "objects")
fig_dir  <- file.path(base_dir, "figures")
dir.create(fig_dir, showWarnings = FALSE, recursive = TRUE)

# ---- Parameters ----
inferno_rev <- c("#FCFFA4", "#F7D13D", "#FB9A06", "#ED6925", "#CF4446",
                  "#A52C60", "#781C6D", "#4A0C6B", "#1B0C42", "#000004")

# ---- Compartment cell types (Mid-villus removed, PDF-matched order) ----
epithelial_cts <- c(
  "CLU+ reserve stem cells", "TA cells/early progenitors",
  "Bottom-Villus enterocytes",
  "Paneth cells", "Enteroendocrine cells", "Goblet cells"
)
immune_stroma_cts <- c(
  "Blood vascular endothelial cells", "Fibroblasts", "Macrophages",
  "Plamsablasts", "T_helper cells", "Cd8aa IEL", "cDC1"
)

# ---- Load panel (remove Mid-villus genes) ----
panel <- read.csv(file.path(data_dir, "annotation_marker_genes_reduced.csv"), stringsAsFactors = FALSE)
panel <- panel[panel$broad_cell_type != "Mid-villus enterocytes", ]
# Save updated panel
write.csv(panel, file.path(data_dir, "annotation_marker_genes_no_midvillus.csv"), row.names = FALSE)

# ---- Load filtered Seurat object (Mid-villus already removed) ----
cat("Loading filtered Seurat object...\n")
obj <- readRDS(file.path(obj_dir, "obj_no_midvillus.rds"))
DefaultAssay(obj) <- "RNA"
obj <- NormalizeData(obj, assay = "RNA", verbose = FALSE)

# ---- Compute dot data ----
compute_dotdata <- function(panel_sub, ct_order) {
  gene_order <- panel_sub$gene
  n_slots    <- nrow(panel_sub)

  unique_genes <- unique(gene_order)
  expr <- GetAssayData(obj, assay = "RNA", layer = "data")[unique_genes, , drop = FALSE]
  ct_vec <- as.character(obj@meta.data$broad_cell_type)
  cells_by_ct <- split(colnames(obj), ct_vec)

  rows <- list()
  for (i in seq_len(n_slots)) {
    g <- gene_order[i]
    if (!(g %in% rownames(expr))) next
    for (j in seq_along(ct_order)) {
      ct <- ct_order[j]
      cells <- cells_by_ct[[ct]]
      if (length(cells) == 0) next
      vals <- expr[g, cells]
      rows[[length(rows)+1]] <- data.frame(
        slot = i, gene = g,
        ct_pos = j, cell_type = ct,
        pct_exp = mean(vals > 0),   # 0-1 scale
        avg_exp = mean(vals),        # log1p-normalized
        stringsAsFactors = FALSE
      )
    }
  }
  dd <- do.call(rbind, rows)

  # Z-score per gene across cell types (computed BEFORE filtering)
  dd$z_score <- ave(dd$avg_exp, dd$gene, FUN = function(x) {
    sd_x <- sd(x); if (sd_x == 0) 0 else (x - mean(x)) / sd_x
  })

  # Filter out zero-expression rows (no dot drawn)
  dd <- dd[dd$avg_exp > 0, ]
  dd
}

# ---- Build plot ----
make_plot <- function(dd, ct_order, title, fill_var, fill_limits, fill_name) {
  gene_breaks <- sort(unique(dd$slot))
  gene_labels <- sapply(gene_breaks, function(s) dd$gene[dd$slot == s][1])
  ct_labels   <- gsub("_", " ", ct_order)

  p <- ggplot(dd, aes(x = slot, y = ct_pos)) +
    geom_point(aes(fill = .data[[fill_var]], size = pct_exp),
               shape = 21, color = "black", stroke = 0.25) +
    scale_fill_gradientn(name = fill_name, colors = inferno_rev,
                         limits = fill_limits) +
    scale_size_continuous(name = "% Expressing",
                          range = c(0.8, 5), limits = c(0, 1)) +
    scale_x_continuous(breaks = gene_breaks, labels = gene_labels,
                       expand = c(0.02, 0.02)) +
    scale_y_continuous(breaks = seq_along(ct_order), labels = ct_labels,
                       expand = expansion(mult = c(0.08, 0.04), add = c(0.2, 0.1))) +
    ggtitle(title) +
    theme_classic(base_size = 8) +
    theme(
      text = element_text(family = "Liberation Sans"),
      axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, size = 6),
      axis.text.y = element_text(size = 6),
      plot.title  = element_text(size = 10, face = "bold"),
      legend.text  = element_text(size = 6),
      legend.title = element_text(size = 7),
      legend.position = "right",
      plot.margin = margin(6, 6, 6, 6)
    )
  p
}

# ---- Save plot ----
save_plot <- function(p, name, plot_width = 12, plot_height = 3.75) {
  png_path <- file.path(fig_dir, paste0("dotplot_", name, ".png"))
  svg_path <- file.path(fig_dir, paste0("dotplot_", name, ".svg"))
  ggsave(png_path, p, width = plot_width, height = plot_height, dpi = 300, limitsize = FALSE)
  svglite::svglite(svg_path, width = plot_width, height = plot_height)
  print(p)
  dev.off()
  cat("PNG:", png_path, "\n")
  cat("SVG:", svg_path, "\n")
}

# ---- Generate all plots ----
compartments <- list(
  Epithelial     = epithelial_cts,
  Immune_Stroma  = immune_stroma_cts
)

for (comp_name in names(compartments)) {
  ct_order <- compartments[[comp_name]]
  panel_sub <- panel[panel$broad_cell_type %in% ct_order, ]
  panel_sub$ct_factor <- factor(panel_sub$broad_cell_type, levels = ct_order)
  panel_sub <- panel_sub[order(panel_sub$ct_factor, panel_sub$gene_order), ]

  dd <- compute_dotdata(panel_sub, ct_order)
  cat("\n===", comp_name, "===\n")
  cat("Genes:", nrow(panel_sub), "| Cell types:", length(ct_order),
      "| Dot data rows:", nrow(dd), "\n")

  pw <- 12

  # Z-score plot (symmetric limits)
  z_max <- max(abs(dd$z_score), na.rm = TRUE)
  p_z <- make_plot(dd, ct_order, comp_name, "z_score",
                   c(-z_max, z_max), "Z-score")
  save_plot(p_z, paste0(tolower(comp_name), "_zscore"), pw)

  # Log1p plot
  log_max <- max(dd$avg_exp, na.rm = TRUE)
  p_log <- make_plot(dd, ct_order, comp_name, "avg_exp",
                     c(0, log_max), "Log1p expression")
  save_plot(p_log, paste0(tolower(comp_name), "_log1p"), pw)
}

cat("\nDone.\n")
