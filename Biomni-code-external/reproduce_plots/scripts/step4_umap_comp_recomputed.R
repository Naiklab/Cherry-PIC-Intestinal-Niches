#!/usr/bin/env Rscript
# Step 4: UMAP + composition plots with recomputed embeddings
# PDF-matched colors, cell type order, and dimensions
# Input:  objects/obj_no_midvillus_recomputed.rds
# Output: figures/umap_no_midvillus_recomputed.png/.svg (narrow, 5.38 x 3.75 in)
#         figures/umap_no_midvillus_recomputed_wide_{6,7,8}in.png/.svg (wide variants)
#         figures/composition_by_region_reordered.png/.svg (4.54 x 3.75 in)

suppressMessages({
  library(Seurat)
  library(ggplot2)
  library(svglite)
})

# ---- Configuration ----
base_dir <- "."  # Path to the reproduce_plots/ directory

# Derived paths (do not edit below)
obj_dir <- file.path(base_dir, "objects")
fig_dir <- file.path(base_dir, "figures")
dir.create(fig_dir, showWarnings = FALSE, recursive = TRUE)

# ---- Color scheme from Figure 6v12.pdf ----
ct_colors <- c(
  "CLU+ reserve stem cells"          = "#B12121",
  "TA cells/early progenitors"       = "#1C5E8E",
  "Bottom-Villus enterocytes"        = "#9E9AC7",
  "Mid-villus enterocytes"           = "#614B71",
  "Paneth cells"                     = "#006C2C",
  "Enteroendocrine cells"            = "#74C476",
  "Goblet cells"                     = "#11A44B",
  "Blood vascular endothelial cells" = "#495800",
  "Fibroblasts"                      = "#DEB89A",
  "Macrophages"                      = "#A04F57",
  "Plamsablasts"                     = "#F8BAD0",
  "T_helper cells"                   = "#088A91",
  "Cd8aa IEL"                        = "#004D5E",
  "cDC1"                             = "#7D1C28"
)

# PDF-matched order (top to bottom, minus Mid-villus)
ct_order <- c(
  "CLU+ reserve stem cells", "TA cells/early progenitors",
  "Bottom-Villus enterocytes",
  "Paneth cells", "Enteroendocrine cells", "Goblet cells",
  "Blood vascular endothelial cells", "Fibroblasts", "Macrophages",
  "Plamsablasts", "T_helper cells", "Cd8aa IEL", "cDC1"
)

# ---- Load recomputed object ----
cat("Loading recomputed object...\n")
obj <- readRDS(file.path(obj_dir, "obj_no_midvillus_recomputed.rds"))
obj@meta.data$broad_cell_type <- factor(obj@meta.data$broad_cell_type, levels = ct_order)

# ---- UMAP ----
cat("Building UMAP...\n")
umap_df <- data.frame(
  UMAP_1 = Embeddings(obj, "umap")[, 1],
  UMAP_2 = Embeddings(obj, "umap")[, 2],
  broad_cell_type = obj@meta.data$broad_cell_type
)

p_umap <- ggplot(umap_df, aes(UMAP_1, UMAP_2, color = broad_cell_type)) +
  geom_point(size = 0.6, alpha = 1) +
  scale_color_manual(values = ct_colors, name = NULL) +
  guides(color = guide_legend(override.aes = list(size = 3))) +
  theme_classic(base_size = 8) +
  theme(
    text = element_text(family = "Liberation Sans"),
    axis.text = element_text(size = 6),
    legend.text = element_text(size = 6),
    legend.title = element_text(size = 7),
    legend.position = "right",
    legend.key = element_blank(),
    plot.margin = margin(6, 6, 6, 6)
  ) +
  labs(x = "UMAP-1", y = "UMAP-2")

# Save narrow version (5.38 x 3.75)
png_path <- file.path(fig_dir, "umap_no_midvillus_recomputed.png")
svg_path <- file.path(fig_dir, "umap_no_midvillus_recomputed.svg")
ggsave(png_path, p_umap, width = 5.38, height = 3.75, dpi = 300, limitsize = FALSE)
svglite::svglite(svg_path, width = 5.38, height = 3.75); print(p_umap); dev.off()
cat("UMAP (narrow) PNG:", png_path, "\n")
cat("UMAP (narrow) SVG:", svg_path, "\n")

# Save wide versions at three widths for user to pick
for (w in c(6, 7, 8)) {
  png_w <- file.path(fig_dir, paste0("umap_no_midvillus_recomputed_wide_", w, "in.png"))
  svg_w <- file.path(fig_dir, paste0("umap_no_midvillus_recomputed_wide_", w, "in.svg"))
  ggsave(png_w, p_umap, width = w, height = 3.75, dpi = 300, limitsize = FALSE)
  svglite::svglite(svg_w, width = w, height = 3.75); print(p_umap); dev.off()
  cat("UMAP (wide ", w, "in) PNG:", png_w, "\n", sep="")
  cat("UMAP (wide ", w, "in) SVG:", svg_w, "\n", sep="")
}

# ---- Composition plot by region ----
cat("\nBuilding composition plot...\n")
comp_df <- as.data.frame(table(obj@meta.data$broad_cell_type, obj@meta.data$orig.ident))
colnames(comp_df) <- c("cell_type", "region", "count")
comp_df$region <- gsub("MouseDuo", "Duodenum", comp_df$region)
comp_df$region <- gsub("Mouseileum", "Ileum", comp_df$region)
comp_df$region <- factor(comp_df$region, levels = c("Duodenum", "Ileum"))
comp_df$cell_type <- factor(comp_df$cell_type, levels = ct_order)

# Proportions per region (sum to 100%)
comp_df <- do.call(rbind, lapply(split(comp_df, comp_df$region), function(d) {
  d$prop <- d$count / sum(d$count) * 100
  d
}))

p_comp <- ggplot(comp_df, aes(x = region, y = prop, fill = cell_type)) +
  geom_bar(stat = "identity", width = 0.7) +
  scale_fill_manual(values = ct_colors, name = NULL) +
  theme_classic(base_size = 8) +
  theme(
    text = element_text(family = "Liberation Sans"),
    axis.text.x = element_text(size = 6),
    axis.text.y = element_text(size = 6),
    legend.text = element_text(size = 6),
    legend.title = element_text(size = 7),
    legend.position = "right",
    plot.margin = margin(6, 6, 6, 6)
  ) +
  labs(x = NULL, y = "% Composition")

png_path <- file.path(fig_dir, "composition_by_region_reordered.png")
svg_path <- file.path(fig_dir, "composition_by_region_reordered.svg")
ggsave(png_path, p_comp, width = 4.54, height = 3.75, dpi = 300, limitsize = FALSE)
svglite::svglite(svg_path, width = 4.54, height = 3.75); print(p_comp); dev.off()
cat("Composition PNG:", png_path, "\n")
cat("Composition SVG:", svg_path, "\n")

cat("\nDone.\n")
