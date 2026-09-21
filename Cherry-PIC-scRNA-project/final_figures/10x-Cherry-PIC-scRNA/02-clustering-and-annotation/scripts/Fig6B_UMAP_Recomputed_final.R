## ----setup, include=FALSE-----------------------------------------------------
if (nzchar(Sys.getenv("CHERRYPIC_R_LIB"))) .libPaths(c(Sys.getenv("CHERRYPIC_R_LIB"), .libPaths()))  # optional custom library

library(Seurat)
library(tidyverse)
library(speckle)
library(jsonlite)

knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)


## ----provenance-build, eval=FALSE---------------------------------------------
# library(harmony)
# 
# obj  <- readRDS("../data/DR26001_v2_annotated_seurat_singlets.rds")
# corr <- read.csv("../data/broad_cell_type_corrections.csv")
# 
# # Apply the 237 corrections, fold the relabelled cells into the Mid-villus group, drop it.
# obj$broad_cell_type[match(corr$cell, colnames(obj))] <- corr$broad_cell_type_corrected
# obj$broad_cell_type[obj$broad_cell_type == "Brunner gland-like epithelial cells"] <-
#   "Mid-villus enterocytes"
# obj_filt <- subset(obj, subset = broad_cell_type != "Mid-villus enterocytes")   # 10,068 cells
# saveRDS(obj_filt, "../data/obj_no_midvillus.rds")
# 
# # Recompute on the SCT assay, batch-correcting over sample of origin.
# DefaultAssay(obj_filt) <- "SCT"
# obj_filt <- FindVariableFeatures(obj_filt, assay = "SCT", nfeatures = 3000) |>
#   ScaleData(assay = "SCT") |>
#   RunPCA(assay = "SCT", npcs = 50)
# obj_filt <- RunHarmony(obj_filt, group.by.vars = "orig.ident", reduction.use = "pca")
# obj_filt <- RunUMAP(obj_filt, reduction = "harmony", dims = 1:30)
# saveRDS(obj_filt, "../data/obj_no_midvillus_recomputed.rds")


## ----config-------------------------------------------------------------------
data_dir <- "../data"
out_dir  <- "../outputs"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
op <- function(f) file.path(out_dir, f)

# Colours and row order as drawn in the published Figure 6. The label "Plamsablasts" is
# spelled as it is in the object's metadata.
ct_colors <- c(
  "CLU+ reserve stem cells"          = "#B12121",
  "TA cells/early progenitors"       = "#1C5E8E",
  "Bottom-Villus enterocytes"        = "#9E9AC7",
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
ct_order <- names(ct_colors)

epithelial_cts    <- ct_order[1:6]
immune_stroma_cts <- ct_order[7:13]


## ----load---------------------------------------------------------------------
obj_re   <- readRDS(file.path(data_dir, "obj_no_midvillus_recomputed.rds"))
obj_filt <- readRDS(file.path(data_dir, "obj_no_midvillus.rds"))
stopifnot(identical(colnames(obj_re), colnames(obj_filt)))

obj_re$broad_cell_type   <- factor(obj_re$broad_cell_type,   levels = ct_order)
obj_filt$broad_cell_type <- factor(obj_filt$broad_cell_type, levels = ct_order)
stopifnot(!anyNA(obj_re$broad_cell_type))

cat("Cells:", ncol(obj_re), "| Reductions:", paste(Reductions(obj_re), collapse = ", "), "\n")
print(table(obj_re$broad_cell_type))


## ----panel_6b, fig.width=6, fig.height=3.75-----------------------------------
umap_df <- data.frame(
  UMAP_1 = Embeddings(obj_re, "umap")[, 1],
  UMAP_2 = Embeddings(obj_re, "umap")[, 2],
  broad_cell_type = obj_re$broad_cell_type
)

p_umap <- ggplot(umap_df, aes(UMAP_1, UMAP_2, color = broad_cell_type)) +
  geom_point(size = 0.6) +
  scale_color_manual(values = ct_colors, name = NULL) +
  guides(color = guide_legend(override.aes = list(size = 3))) +
  theme_classic(base_size = 8) +
  theme(axis.text = element_text(size = 6), legend.text = element_text(size = 6),
        legend.key = element_blank(), plot.margin = margin(6, 6, 6, 6)) +
  labs(x = "UMAP-1", y = "UMAP-2")

ggsave(op("fig6B_umap_celltype_broad.pdf"), p_umap, width = 6, height = 3.75)
p_umap


## ----composition, fig.width=4.54, fig.height=3.75-----------------------------
comp_df <- obj_re@meta.data |>
  mutate(region = recode(orig.ident, MouseDuo = "Duodenum", Mouseileum = "Ileum")) |>
  count(region, broad_cell_type, name = "n") |>
  group_by(region) |>
  mutate(pct = 100 * n / sum(n)) |>
  ungroup() |>
  mutate(region = factor(region, levels = c("Duodenum", "Ileum")))

p_comp <- ggplot(comp_df, aes(region, pct, fill = broad_cell_type)) +
  geom_col(width = 0.7) +
  scale_fill_manual(values = ct_colors, name = NULL, drop = FALSE) +
  theme_classic(base_size = 8) +
  theme(axis.text = element_text(size = 6), legend.text = element_text(size = 6),
        plot.margin = margin(6, 6, 6, 6)) +
  labs(x = NULL, y = "% Composition")

ggsave(op("supporting_composition_stacked_broad_corrected.pdf"), p_comp, width = 4.54, height = 3.75)
p_comp


## ----dotplots, fig.width=12, fig.height=3.75----------------------------------
inferno_rev <- c("#FCFFA4", "#F7D13D", "#FB9A06", "#ED6925", "#CF4446",
                 "#A52C60", "#781C6D", "#4A0C6B", "#1B0C42", "#000004")

panel <- read.csv(file.path(data_dir, "annotation_marker_genes_reduced.csv"), stringsAsFactors = FALSE)
panel <- panel[panel$broad_cell_type != "Mid-villus enterocytes", ]

DefaultAssay(obj_filt) <- "RNA"
obj_filt <- NormalizeData(obj_filt, assay = "RNA", verbose = FALSE)

compute_dotdata <- function(panel_sub, ct_order) {
  gene_order <- panel_sub$gene
  expr <- GetAssayData(obj_filt, assay = "RNA", layer = "data")[unique(gene_order), , drop = FALSE]
  cells_by_ct <- split(colnames(obj_filt), as.character(obj_filt$broad_cell_type))

  rows <- list()
  for (i in seq_along(gene_order)) {
    g <- gene_order[i]
    if (!(g %in% rownames(expr))) next
    for (j in seq_along(ct_order)) {
      cells <- cells_by_ct[[ct_order[j]]]
      if (length(cells) == 0) next
      vals <- expr[g, cells]
      rows[[length(rows) + 1]] <- data.frame(slot = i, gene = g, ct_pos = j,
        cell_type = ct_order[j], pct_exp = mean(vals > 0), avg_exp = mean(vals))
    }
  }
  dd <- do.call(rbind, rows)
  # z-score per gene across cell types, before zero-expression dots are dropped
  dd$z_score <- ave(dd$avg_exp, dd$gene, FUN = function(x) {
    s <- sd(x); if (s == 0) 0 else (x - mean(x)) / s
  })
  dd[dd$avg_exp > 0, ]
}

make_dotplot <- function(dd, ct_order, title, fill_var, fill_limits, fill_name) {
  gene_breaks <- sort(unique(dd$slot))
  gene_labels <- vapply(gene_breaks, function(s) dd$gene[dd$slot == s][1], character(1))
  ggplot(dd, aes(x = slot, y = ct_pos)) +
    geom_point(aes(fill = .data[[fill_var]], size = pct_exp), shape = 21, color = "black", stroke = 0.25) +
    scale_fill_gradientn(name = fill_name, colors = inferno_rev, limits = fill_limits) +
    scale_size_continuous(name = "% Expressing", range = c(0.8, 5), limits = c(0, 1)) +
    scale_x_continuous(breaks = gene_breaks, labels = gene_labels, expand = c(0.02, 0.02)) +
    scale_y_continuous(breaks = seq_along(ct_order), labels = gsub("_", " ", ct_order),
                       expand = expansion(mult = c(0.08, 0.04), add = c(0.2, 0.1))) +
    ggtitle(title) +
    theme_classic(base_size = 8) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, size = 6),
          axis.text.y = element_text(size = 6), plot.title = element_text(size = 10, face = "bold"),
          legend.text = element_text(size = 6), legend.title = element_text(size = 7),
          plot.margin = margin(6, 6, 6, 6))
}

compartments <- list(epithelia = epithelial_cts, immune_stroma = immune_stroma_cts)
for (nm in names(compartments)) {
  cts <- compartments[[nm]]
  panel_sub <- panel[panel$broad_cell_type %in% cts, ]
  panel_sub <- panel_sub[order(factor(panel_sub$broad_cell_type, levels = cts), panel_sub$gene_order), ]
  dd <- compute_dotdata(panel_sub, cts)
  cat(nm, "| genes:", nrow(panel_sub), "| cell types:", length(cts), "| dots:", nrow(dd), "\n")

  z_max <- max(abs(dd$z_score))
  p_z <- make_dotplot(dd, cts, nm, "z_score", c(-z_max, z_max), "Z-score")
  ggsave(op(paste0("supporting_dotplot_", nm, "_zscore.pdf")), p_z, width = 12, height = 3.75)
  print(p_z)

  p_l <- make_dotplot(dd, cts, nm, "avg_exp", c(0, max(dd$avg_exp)), "Log1p expression")
  ggsave(op(paste0("supporting_dotplot_", nm, "_log1p.pdf")), p_l, width = 12, height = 3.75)
}


## ----propeller_corrected------------------------------------------------------
tags <- fromJSON(file.path(data_dir, "cells_per_tag.json"))
bc2rep <- stack(tags)
names(bc2rep) <- c("raw_barcode", "replicate")
bc2rep$replicate <- as.character(bc2rep$replicate)
tissue_map <- c(OB1 = "Ileum", OB2 = "Ileum", OB3 = "Duodenum", OB4 = "Duodenum")

# Cell names carry a "{sample}_" prefix that the tag table does not.
raw_bc <- sub("^[^_]+_", "", colnames(obj_filt))
obj_filt$replicate <- unname(setNames(bc2rep$replicate, bc2rep$raw_barcode)[raw_bc])
obj_filt$region    <- unname(tissue_map[obj_filt$replicate])
stopifnot(!anyNA(obj_filt$replicate))

prop_corrected <- propeller(clusters = as.character(obj_filt$broad_cell_type),
                            sample = obj_filt$replicate, group = obj_filt$region,
                            transform = "logit")
prop_corrected <- prop_corrected[order(prop_corrected$FDR), ]
write.csv(prop_corrected, op("supporting_propeller_results_broad_corrected.csv"), row.names = TRUE)

ref_path <- op("supporting_propeller_results_broad.csv")
if (file.exists(ref_path)) {
  prop_original <- read.csv(ref_path, row.names = 1, check.names = FALSE)
  cmp <- data.frame(
    FDR_original  = prop_original[rownames(prop_corrected), "FDR"],
    FDR_corrected = prop_corrected$FDR,
    row.names = rownames(prop_corrected)
  ) |> mutate(across(everything(), ~ signif(.x, 3)))
  print(cmp)
  cat("\nSignificant at FDR < 0.05, original :",
      paste(rownames(prop_original)[prop_original$FDR < 0.05], collapse = "; "), "\n")
} else {
  print(signif(prop_corrected[, c("PropMean.Duodenum", "PropMean.Ileum", "FDR")], 3))
}
cat("Significant at FDR < 0.05, corrected:",
    paste(rownames(prop_corrected)[prop_corrected$FDR < 0.05], collapse = "; "), "\n")


## ----session_info-------------------------------------------------------------
sessionInfo()

