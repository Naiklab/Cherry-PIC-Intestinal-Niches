## ----setup, include=FALSE-----------------------------------------------------
if (nzchar(Sys.getenv("CHERRYPIC_R_LIB"))) .libPaths(c(Sys.getenv("CHERRYPIC_R_LIB"), .libPaths()))  # optional custom library
library(Seurat)
library(speckle)
library(tidyverse)      # whole tidyverse, never individual sub-packages
library(jsonlite)
library(patchwork)
library(readxl)
library(ggrepel)

set.seed(42)
theme_set(theme_classic())
knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)


## ----pipeline-provenance, child='Preprocessing_scRNA_Annotation_final.Rmd'----

## ----stage1-merge-cluster, eval=FALSE-----------------------------------------
# # Two HTO-demultiplexed samples from CellRanger multi (per_sample_outs already
# # separate cells by sample — no additional HTO demux needed in Seurat).
# seu_ileum <- Read10X(ileum_filtered_matrix_dir)
# seu_duo   <- Read10X(duo_filtered_matrix_dir)
# 
# seu <- merge(CreateSeuratObject(seu_ileum, project = "Mouseileum"),
#              CreateSeuratObject(seu_duo,   project = "MouseDuo"),
#              add.cell.ids = c("Mouseileum", "MouseDuo"))
# 
# # SCTransform fit PER SAMPLE at merge time (median_umi baked in per-sample —
# # this is why 03's Section 6 refit is required after any cell-count-changing filter).
# seu <- SCTransform(seu, vst.flavor = "v2")
# # Harmony's k-means initialisation is stochastic and carries no default seed,
# # unlike RunUMAP (seed.use = 42) and FindClusters (random.seed = 0).
# set.seed(42)
# seu <- RunPCA(seu) |> RunHarmony(group.by.vars = "orig.ident") |>
#   RunUMAP(reduction = "harmony", dims = 1:30) |>
#   FindNeighbors(reduction = "harmony", dims = 1:30) |>
#   FindClusters(resolution = 1.0)
# 
# saveRDS(seu, "DR26001_v2_seurat.rds")


## ----stage2-annotate-filter, eval=FALSE---------------------------------------
# # Single source of truth for both colors AND exclusion: the biologist-curated
# # annotation xlsx. No second hand-maintained exclusion list anywhere else.
# ann_df <- readxl::read_excel(
#   "../data/New qc resolution 1 annotation  broad annotation and colors July07.xlsx")
# REMOVE_CLUSTERS <- ann_df$Cluster[ann_df$`Hex color` == "Remove"]
# 
# seu$cell_type       <- unname(setNames(ann_df$Annotation, ann_df$Cluster)[cluster_ids])
# seu$broad_cell_type <- unname(setNames(ann_df[["Broad annotation"]], ann_df$Cluster)[cluster_ids])
# 
# # Doublet detection (scDblFinder) on the PRE-filter object (QC diagnostics need
# # pre-filter data — you can't plot "where the doublets are" after removing them).
# sce <- as.SingleCellExperiment(seu)
# sce <- scDblFinder::scDblFinder(sce, samples = "orig.ident")
# seu$doublet_call <- sce$scDblFinder.class
# 
# # Filter: low-quality clusters (Hex color == "Remove") + doublets, together —
# # doublet filtering + low-quality-cluster removal both happen BEFORE any plot
# # other than the doublet-detection QC diagnostics themselves.
# seu_final <- seu[, !(cluster_ids %in% REMOVE_CLUSTERS) & seu$doublet_call != "doublet"]
# 
# # Refit SCTransform on the filtered population — filtering doesn't recompute
# # the per-sample median_umi baked into the original SCT model, and doesn't
# # drop the same fraction of cells from each sample, so the inherited SCT
# # models would silently no longer match the filtered population.
# seu_final <- SCTransform(seu_final, vst.flavor = "v2")
# set.seed(42)
# seu_final <- RunPCA(seu_final) |> RunHarmony(group.by.vars = "orig.ident") |>
#   RunUMAP(reduction = "harmony", dims = 1:30)
# 
# saveRDS(seu_final, "DR26001_v2_annotated_seurat_singlets.rds")



## ----config-------------------------------------------------------------------
# ---- Frozen inputs (relative paths — this folder is self-contained) --------
rds_singlets <- "../data/DR26001_v2_annotated_seurat_singlets.rds"
ann_xlsx     <- "../data/New qc resolution 1 annotation  broad annotation and colors July07.xlsx"
cells_json   <- "../data/cells_per_tag.json"
out_dir      <- "../outputs"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
op <- function(f) file.path(out_dir, f)

save_pdf <- function(plot, path, width = 10, height = 7) {
  pdf(path, width = width, height = height)
  print(plot)
  dev.off()
  invisible(plot)
}

# ---- Official cell-type colors (same source as every other plot in this project) ----
ann_df <- read_excel(ann_xlsx)

ct_color_df <- ann_df[!duplicated(ann_df$Annotation), ]
cell_type_colors <- setNames(
  ifelse(ct_color_df$`Hex color` == "Remove" | is.na(ct_color_df$`Hex color`),
         "#BEBEBE", paste0("#", ct_color_df$`Hex color`)),
  ct_color_df$Annotation
)

broad_color_df <- ann_df[!duplicated(ann_df[["Broad annotation"]]), ]
broad_color_df <- broad_color_df[!is.na(broad_color_df[["Broad annotation"]]), ]
broad_cell_type_colors <- setNames(
  ifelse(broad_color_df$`Hex color` == "Remove" | is.na(broad_color_df$`Hex color`),
         "#BEBEBE", paste0("#", broad_color_df$`Hex color`)),
  broad_color_df[["Broad annotation"]]
)

cat("Fine cell-type colors:", length(cell_type_colors), "\n")
cat("Broad cell-type colors:", length(broad_cell_type_colors), "\n")


## ----load---------------------------------------------------------------------
seu <- readRDS(rds_singlets)
cat("Cells:", ncol(seu), "| Genes:", nrow(seu), "\n")
cat("Reductions:", paste(Reductions(seu), collapse = ", "), "\n")
cat("\nCell-type counts (fine-grained):\n")
print(sort(table(seu$cell_type), decreasing = TRUE))
cat("\nCell-type counts (broad):\n")
print(sort(table(seu$broad_cell_type, useNA = "ifany"), decreasing = TRUE))


## ----assign-replicate---------------------------------------------------------
tag_barcodes <- fromJSON(cells_json)

bc2rep <- stack(tag_barcodes)
names(bc2rep) <- c("raw_barcode", "replicate")
bc2rep$replicate <- as.character(bc2rep$replicate)

tissue_map <- c(OB1 = "Ileum", OB2 = "Ileum",
                OB3 = "Duodenum", OB4 = "Duodenum")
bc2rep$tissue <- tissue_map[bc2rep$replicate]

raw_bc        <- sub("^[^_]+_", "", colnames(seu))
rep_lookup    <- setNames(bc2rep$replicate, bc2rep$raw_barcode)
tissue_lookup <- setNames(bc2rep$tissue,    bc2rep$raw_barcode)

seu$replicate <- unname(rep_lookup[raw_bc])
seu$region    <- unname(tissue_lookup[raw_bc])

n_before <- ncol(seu)
seu <- subset(seu, cells = colnames(seu)[!is.na(seu$replicate)])
cat("Dropped", n_before - ncol(seu), "unmatched cells; retained", ncol(seu), "\n")
cat("\nCells per replicate:\n"); print(table(seu$replicate))
cat("\nCells per region:\n");    print(table(seu$region))


## ----exclude_midvillus--------------------------------------------------------
n_before <- ncol(seu)
seu <- seu[, is.na(seu$broad_cell_type) | seu$broad_cell_type != "Mid-villus enterocytes"]
cat("Excluded", n_before - ncol(seu), "Mid-villus enterocytes cells; retained", ncol(seu), "\n")


## ----umap_fine, fig.width=14, fig.height=7------------------------------------
p_umap_fine <- DimPlot(seu,
                       reduction  = "umap",
                       group.by   = "cell_type",
                       label      = TRUE,
                       repel      = TRUE,
                       label.size = 3.5,
                       pt.size    = 1.5,
                       cols       = cell_type_colors) +
  ggtitle("Cherry-PIC sorted niches — cell-type annotation (fine)") +
  theme(legend.text = element_text(size = 9))

save_pdf(p_umap_fine, op("supporting_umap_celltype_fine.pdf"), width = 14, height = 7)
p_umap_fine


## ----umap_broad, fig.width=14, fig.height=7-----------------------------------
p_umap_broad <- DimPlot(seu,
                        reduction  = "umap",
                        group.by   = "broad_cell_type",
                        label      = TRUE,
                        repel      = TRUE,
                        label.size = 3.5,
                        pt.size    = 1.5,
                        cols       = broad_cell_type_colors) +
  ggtitle("Cherry-PIC sorted niches — cell-type annotation (broad)") +
  theme(legend.text = element_text(size = 9))

save_pdf(p_umap_broad, op("fig6B_umap_celltype_broad.pdf"), width = 14, height = 7)
p_umap_broad


## ----propeller_fine-----------------------------------------------------------
prop_df <- as.data.frame(seu@meta.data) %>%
  dplyr::count(region, replicate, cell_type, name = "n_cells") %>%
  group_by(replicate) %>%
  mutate(pct = n_cells / sum(n_cells) * 100) %>%
  ungroup()

prop_results <- propeller(clusters = seu$cell_type, sample = seu$replicate, group = seu$region, transform = "logit")
cat("propeller() results (sorted by FDR):\n")
print(prop_results[order(prop_results$FDR), ])
write.csv(prop_results, op("supporting_propeller_results_fine.csv"), row.names = TRUE)


## ----stacked_bar_fine, fig.width=9, fig.height=6------------------------------
ct_order <- prop_df %>%
  group_by(cell_type) %>% summarise(tot = sum(n_cells)) %>%
  arrange(desc(tot)) %>% pull(cell_type)

prop_df2 <- prop_df %>%
  mutate(cell_type = factor(cell_type, levels = rev(ct_order)),
         rep_label = paste0(replicate, "\n(", region, ")"))

p_stack_fine <- ggplot(prop_df2, aes(x = rep_label, y = pct, fill = cell_type)) +
  geom_col(width = 0.7) +
  scale_fill_manual(values = cell_type_colors) +
  labs(title = "Cell-type composition per replicate (fine)",
       x = NULL, y = "% of cells", fill = "Cell type") +
  theme(legend.text = element_text(size = 8), legend.key.size = unit(0.4, "cm"))

save_pdf(p_stack_fine, op("supporting_composition_stacked_fine.pdf"), width = 9, height = 6)
p_stack_fine


## ----volcano_fine, fig.width=10, fig.height=6---------------------------------
grp_cols <- grep("^PropMean\\.", colnames(prop_results), value = TRUE)
stopifnot(length(grp_cols) == 2)

vol_df <- prop_results %>%
  rownames_to_column("cell_type") %>%
  mutate(log2FC     = log2(.data[[grp_cols[2]]] + 1e-4) - log2(.data[[grp_cols[1]]] + 1e-4),
         neg_logFDR = -log10(FDR + 1e-10),
         sig        = FDR < 0.05)

p_vol_fine <- ggplot(vol_df, aes(x = log2FC, y = neg_logFDR, colour = sig, label = cell_type)) +
  geom_point(size = 3) +
  ggrepel::geom_text_repel(size = 3, max.overlaps = 20) +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", colour = "grey50") +
  geom_vline(xintercept = 0, linetype = "dotted") +
  scale_colour_manual(values = c("FALSE" = "grey60", "TRUE" = "#D6604D"),
                      labels = c("ns", "FDR < 0.05")) +
  labs(title = "Proportion change: Duodenum vs Ileum (fine)",
       x = paste0("log2(PropMean.", grp_cols[2], " / PropMean.", grp_cols[1], ")"),
       y = "-log10(FDR)", colour = NULL) +
  theme(legend.position = "top")

save_pdf(p_vol_fine, op("supporting_composition_volcano_fine.pdf"), width = 10, height = 6)
p_vol_fine


## ----propeller_broad----------------------------------------------------------
seu_broad <- seu[, !is.na(seu$broad_cell_type)]
cat("Cells excluded (NA broad_cell_type):", ncol(seu) - ncol(seu_broad), "\n")

prop_df_broad <- as.data.frame(seu_broad@meta.data) %>%
  dplyr::count(region, replicate, broad_cell_type, name = "n_cells") %>%
  group_by(replicate) %>%
  mutate(pct = n_cells / sum(n_cells) * 100) %>%
  ungroup()

prop_results_broad <- propeller(clusters = seu_broad$broad_cell_type,
                                sample = seu_broad$replicate, group = seu_broad$region, transform = "logit")
cat("propeller() results, broad cell types (sorted by FDR):\n")
print(prop_results_broad[order(prop_results_broad$FDR), ])
write.csv(prop_results_broad, op("supporting_propeller_results_broad.csv"), row.names = TRUE)


## ----stacked_bar_broad, fig.width=9, fig.height=6-----------------------------
ct_order_broad <- prop_df_broad %>%
  group_by(broad_cell_type) %>% summarise(tot = sum(n_cells)) %>%
  arrange(desc(tot)) %>% pull(broad_cell_type)

# Pool the two replicates per region into one bar each (region-level %, not
# per-replicate) — matches the published panel structure.
prop_df_region <- as.data.frame(seu_broad@meta.data) %>%
  dplyr::count(region, broad_cell_type, name = "n_cells") %>%
  group_by(region) %>%
  mutate(pct = n_cells / sum(n_cells) * 100) %>%
  ungroup() %>%
  mutate(broad_cell_type = factor(broad_cell_type, levels = rev(ct_order_broad)))

# Stats-only reference, not plotted: which categories are significant, and in
# which region the proportion is higher — read straight off prop_results_broad.
grp_cols_broad_sig <- grep("^PropMean\\.", colnames(prop_results_broad), value = TRUE)
stopifnot(length(grp_cols_broad_sig) == 2)
region_names_sig <- sub("^PropMean\\.", "", grp_cols_broad_sig)

sig_broad <- prop_results_broad %>%
  rownames_to_column("broad_cell_type") %>%
  filter(FDR < 0.05) %>%
  mutate(region = region_names_sig[max.col(cbind(.data[[grp_cols_broad_sig[1]]],
                                                  .data[[grp_cols_broad_sig[2]]]))]) %>%
  select(broad_cell_type, region)

cat("Cell types significant at FDR < 0.05 (broad), with the higher-proportion region:\n")
print(sig_broad)

p_stack_broad <- ggplot(prop_df_region, aes(x = region, y = pct, fill = broad_cell_type)) +
  geom_col(width = 0.5) +
  scale_fill_manual(values = broad_cell_type_colors) +
  labs(title = "Cell-type composition by region (broad)",
       x = NULL, y = "% of cells", fill = "Cell type") +
  theme(legend.text = element_text(size = 8), legend.key.size = unit(0.4, "cm"))

save_pdf(p_stack_broad, op("fig6C_composition_stacked_broad.pdf"), width = 9, height = 6)
p_stack_broad


## ----volcano_broad, fig.width=10, fig.height=6--------------------------------
grp_cols_broad <- grep("^PropMean\\.", colnames(prop_results_broad), value = TRUE)
stopifnot(length(grp_cols_broad) == 2)

vol_df_broad <- prop_results_broad %>%
  rownames_to_column("broad_cell_type") %>%
  mutate(log2FC     = log2(.data[[grp_cols_broad[2]]] + 1e-4) - log2(.data[[grp_cols_broad[1]]] + 1e-4),
         neg_logFDR = -log10(FDR + 1e-10),
         sig        = FDR < 0.05)

p_vol_broad <- ggplot(vol_df_broad, aes(x = log2FC, y = neg_logFDR, colour = sig, label = broad_cell_type)) +
  geom_point(size = 3) +
  ggrepel::geom_text_repel(size = 3, max.overlaps = 20) +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", colour = "grey50") +
  geom_vline(xintercept = 0, linetype = "dotted") +
  scale_colour_manual(values = c("FALSE" = "grey60", "TRUE" = "#D6604D"),
                      labels = c("ns", "FDR < 0.05")) +
  labs(title = "Proportion change: Duodenum vs Ileum (broad)",
       x = paste0("log2(PropMean.", grp_cols_broad[2], " / PropMean.", grp_cols_broad[1], ")"),
       y = "-log10(FDR)", colour = NULL) +
  theme(legend.position = "top")

save_pdf(p_vol_broad, op("supporting_composition_volcano_broad.pdf"), width = 10, height = 6)
p_vol_broad


## ----session_info-------------------------------------------------------------
sessionInfo()

