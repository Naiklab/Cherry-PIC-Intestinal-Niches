## ----pipeline-provenance, child='Preprocessing_VisiumHD_8um_final.Rmd'--------

## ----pp8-doc-setup, include=FALSE---------------------------------------------
# Documentation notebook — every pipeline chunk below is marked eval=FALSE
# individually (so this file is safe to include as a knitr child without
# disabling the parent figure notebook's chunks).


## ----pp8-params, eval=FALSE---------------------------------------------------
# if (nzchar(Sys.getenv("CHERRYPIC_R_LIB"))) .libPaths(c(Sys.getenv("CHERRYPIC_R_LIB"), .libPaths()))  # optional custom library
# library(Seurat); library(tidyverse); library(patchwork); library(RColorBrewer)
# future::plan("multicore", workers = future::availableCores())
# options(future.globals.maxSize = 2 * 10^12)
# 
# # Samples & raw data location (Space Ranger 4.0.1, Visium Mouse Transcriptome Probe v2.0)
# sample.names <- c("SHNA03_D3-7um_0_v1","SHNA03_D4-7um_0_v1","SHNA03_I2-7um_0_v1","SHNA03_I3-7um_0_v1")
# data.dir     <- "rawdata/"
# bin.size     <- c(8)
# image.names  <- list("SHNA03_D3-7um_0_v1" = "Duodenum-3", "SHNA03_D4-7um_0_v1" = "Duodenum-4",
#                      "SHNA03_I2-7um_0_v1" = "Ileum-2",    "SHNA03_I3-7um_0_v1" = "Ileum-3")
# 
# # QC thresholds (min.counts APPLIED; max.mt.percent a guideline, NOT applied as a filter)
# min.counts <- 25
# max.mt.percent <- 20
# 
# # Clustering: sketch-based; res 2 is the FINAL resolution used downstream
# sketch.ncells       <- 5000
# cluster.resolutions <- c(0.2, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4)


## ----pp8-load, eval=FALSE-----------------------------------------------------
# load_visium_hd_data <- function(sample.name, data.dir, bin.size) {
#   spatial.dir <- file.path(data.dir, sample.name)
#   object <- Load10X_Spatial(data.dir = spatial.dir, bin.size = bin.size,
#                             slice = image.names[[sample.name]])
#   cat("Loaded sample:", sample.name, "with", ncol(object), "spots\n")
#   object
# }
# object.list <- lapply(sample.names, load_visium_hd_data, data.dir = data.dir, bin.size = bin.size[1])
# names(object.list) <- sample.names
# 
# # Tag each object with its image / sample identity (one image per sample here)
# split.object.list <- lapply(sample.names, function(sn) {
#   obj <- object.list[[sn]]; obj$orig.ident <- image.names[[sn]]; obj$sample <- sn; obj
# })
# names(split.object.list) <- sample.names


## ----pp8-qc, eval=FALSE-------------------------------------------------------
# # Mitochondrial % per spot (mouse "mt-" / human "MT-")
# split.object.list <- lapply(split.object.list, function(obj)
#   PercentageFeatureSet(obj, pattern = "^mt-|^MT-", col.name = "percent.mt"))
# 
# assay.name  <- names(split.object.list[[1]]@assays)[1]   # "Spatial.008um"
# count.col   <- paste0("nCount_", assay.name)
# 
# # APPLIED filter: nCount >= min.counts (25). No MT-based subset is applied.
# filtered.object.list <- lapply(split.object.list, function(obj)
#   subset(obj, subset = nCount_Spatial.008um >= min.counts))


## ----pp8-norm-sketch, eval=FALSE----------------------------------------------
# normalized.object.list <- lapply(filtered.object.list, NormalizeData, assay = assay.name)
# merged.object <- merge(normalized.object.list[[1]], normalized.object.list[2:length(normalized.object.list)])
# 
# DefaultAssay(merged.object) <- assay.name
# merged.object <- FindVariableFeatures(merged.object)
# merged.object <- ScaleData(merged.object)
# # Sketch (uniform 5,000 cells) for scalable clustering
# merged.object <- SketchData(object = merged.object, ncells = 5000L,
#                             method = "Uniform", sketched.assay = "sketch")


## ----pp8-cluster-project, eval=FALSE------------------------------------------
# DefaultAssay(merged.object) <- "sketch"
# merged.object <- FindVariableFeatures(merged.object)
# merged.object <- ScaleData(merged.object)
# merged.object <- RunPCA(merged.object, assay = "sketch", reduction.name = "pca.sketch")
# merged.object <- FindNeighbors(merged.object, assay = "sketch", reduction = "pca.sketch", dims = 1:50)
# merged.object <- FindClusters(merged.object, resolution = cluster.resolutions)   # sketch_snn_res.2 is FINAL
# merged.object <- RunUMAP(merged.object, reduction = "pca.sketch", reduction.name = "umap.sketch",
#                          return.model = TRUE, dims = 1:50)
# 
# # Project sketch clustering + UMAP back onto all spots
# merged.object <- ProjectData(
#   object = merged.object, assay = assay.name,
#   full.reduction = "full.pca.sketch", sketched.assay = "sketch",
#   sketched.reduction = "pca.sketch", umap.model = "umap.sketch", dims = 1:50,
#   refdata = setNames(lapply(cluster.resolutions, function(res) paste0("sketch_snn_res.", res)),
#                      paste0("sketch_snn_res.", cluster.resolutions)))
# 
# saveRDS(merged.object, "output_8um/RDS-files/merged_object_clustered.RDS")
# # (Cluster annotations at res 2 are mapped from
# #  "8um-binned-updated-annotations(res2) Apr 21 with exclusion.csv" downstream.)


## ----pp8-rctd, eval=FALSE, code=readLines("Master_RCTD_Deconvolution_8um.R")----
# NA


## ----pp8-niche-params, eval=FALSE---------------------------------------------
# STEM_CELL_TYPE      <- "Stem_cells"
# IMMED_PERI_MAX_BINS <- 3     # immediate periphery = within 3 bin widths (≤ 24 µm)
# # The stem-cell niche is the stem-cell bins plus that immediate periphery.
# # Everything further out is outside the niche and is not carried forward.
# zone_levels <- c("Stem_cell", "Immediate_periphery", "Outside_niche", "No_tissue")


## ----pp8-niche-helpers, eval=FALSE--------------------------------------------
# # Bin distance uses the Space Ranger spot diameter (px) from scalefactors_json.json.
# get_spot_diameter_px <- function(sample_path, bin_size = "008um") {
#   json_path <- file.path(sample_path, "binned_outputs", paste0("square_", bin_size),
#                          "spatial", "scalefactors_json.json")
#   rjson::fromJSON(file = json_path)$spot_diameter_fullres
# }
# compute_min_dist_bins <- function(all_coords, stem_coords, spot_diam_px) {
#   if (nrow(stem_coords) == 0) return(rep(NA_real_, nrow(all_coords)))
#   nn <- RANN::nn2(data = stem_coords, query = all_coords, k = 1)   # nearest stem spot
#   as.numeric(nn$nn.dists[, 1]) / spot_diam_px
# }
# # Zone by distance; Stem_cell overrides; excluded dominant/region/cluster → Outside_niche.
# classify_niche_zone <- function(dist_bins, is_stem, celltype_vec, region_ann_vec,
#                                 cluster_ann_vec = NULL, immed_max = IMMED_PERI_MAX_BINS,
#                                 excl_dominant = character(0),
#                                 excl_region = character(0), excl_cluster = character(0)) {
#   zone <- character(length(dist_bins))
#   zone[is.na(dist_bins)] <- "No_tissue"
#   zone[!is.na(dist_bins)] <- "Outside_niche"
#   zone[!is.na(dist_bins) & dist_bins > 0 & dist_bins <= immed_max & !is_stem] <- "Immediate_periphery"
#   zone[is_stem] <- "Stem_cell"
#   excl <- (!is.na(celltype_vec)   & celltype_vec   %in% excl_dominant) |
#           (!is.na(region_ann_vec) & region_ann_vec %in% excl_region)
#   if (!is.null(cluster_ann_vec)) excl <- excl | (!is.na(cluster_ann_vec) & cluster_ann_vec %in% excl_cluster)
#   zone[excl & !zone %in% c("Stem_cell", "No_tissue")] <- "Outside_niche"
#   factor(zone, levels = zone_levels)
# }


## ----pp8-niche-assign, eval=FALSE---------------------------------------------
# # Per sample: nearest-stem-spot distance → zone; then add columns + save.
# merged.object <- readRDS("output_8um/RDS-files/final_analysis_object_with_master_deconv.RDS")
# niche_results <- list()
# for (img in Images(merged.object)) {
#   coords <- GetTissueCoordinates(merged.object, image = img); coords$barcode <- rownames(coords)
#   spot_diam_px <- get_spot_diameter_px(sample_paths[[img]])
#   meta <- merged.object@meta.data[coords$barcode, , drop = FALSE]
#   stem_bc <- rownames(meta)[!is.na(meta$M_RCTD_dominant_celltype) &
#                               meta$M_RCTD_dominant_celltype == STEM_CELL_TYPE]
#   all_mat  <- as.matrix(coords[, c("imagerow", "imagecol")]); rownames(all_mat) <- coords$barcode
#   stem_mat <- all_mat[rownames(all_mat) %in% stem_bc, , drop = FALSE]
#   dist_bins <- compute_min_dist_bins(all_mat, stem_mat, spot_diam_px)
#   zone <- classify_niche_zone(dist_bins, coords$barcode %in% stem_bc,
#                               meta$M_RCTD_dominant_celltype, meta$region_annotation, meta$cluster_annotation)
#   niche_results[[img]] <- data.frame(barcode = coords$barcode, dist_bins = dist_bins,
#                                      dist_um = dist_bins * 8, stem_niche_zone = zone,
#                                      row.names = coords$barcode)
# }
# all_results <- do.call(rbind, niche_results)
# merged.object <- AddMetaData(merged.object,
#   all_results[colnames(merged.object), c("dist_bins", "dist_um", "stem_niche_zone")])
# merged.object$tissue_type <- ifelse(grepl("Duodenum", merged.object$orig.ident, ignore.case = TRUE),
#                                     "Duodenum", "Ileum")
# saveRDS(merged.object, "output_8um/RDS-files/final_analysis_object_8um_with_stem_niche.RDS")


## ----pp8-hires-swap, eval=FALSE, code=readLines("scripts_hires_master/swap_master_hires.R")----
# NA



## ----setup, include=FALSE-----------------------------------------------------
# Only prepend the HPC library when it actually exists, so the notebook still opens locally.
if (nzchar(Sys.getenv("CHERRYPIC_R_LIB"))) .libPaths(c(Sys.getenv("CHERRYPIC_R_LIB"), .libPaths()))  # optional custom library

library(Seurat)
library(tidyverse)
library(patchwork)
library(RColorBrewer)
library(readxl)

knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)


## ----config-------------------------------------------------------------------
rds_hires <- "../data/final_analysis_object_with_master_deconv_hires.RDS"
ann_csv   <- "../data/8um-binned-updated-annotations(res2) Apr 21 with exclusion.csv"
out_dir   <- "../outputs"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

op   <- function(f) file.path(out_dir, f)          # path helper for outputs
ubar <- function(x) gsub("\\.", "_", x)            # "Ileum.2.008um" -> "Ileum_2_008um"

cluster_col <- "sketch_snn_res.2"                  # res-2 cluster IDs, already in the object

# res-2 cluster number -> annotation label, and label -> colour.
ann            <- read.csv(ann_csv, stringsAsFactors = FALSE, check.names = TRUE)
ann$Cluster    <- as.character(ann$Cluster)
cluster_map    <- setNames(trimws(ann$Annotation), ann$Cluster)
cluster_levels <- unique(trimws(ann$Annotation))
cluster_colors <- setNames(trimws(ann$Granular.color), trimws(ann$Annotation))
cluster_colors <- cluster_colors[!duplicated(names(cluster_colors))][cluster_levels]


## ----load---------------------------------------------------------------------
merged.object <- readRDS(rds_hires)
sample_images <- Images(merged.object)
cat("Spots:", ncol(merged.object), "| Images:", paste(sample_images, collapse = ", "), "\n")

cl <- as.character(merged.object@meta.data[[cluster_col]])
merged.object$cluster_annotation <- factor(unname(cluster_map[cl]), levels = cluster_levels)


## ----panel_3bc_palette--------------------------------------------------------
# Broad categories and their palette come from the Aug-12 annotation sheet.
# The older "August 10th" CSV stays on disk for provenance but is not read here.
deconv_color_xlsx <- "../data/single cell seq combined datasets annotation res 1_2 With colors RCTD broad Aug12.xlsx"
sc_annot_col <- readxl::read_excel(deconv_color_xlsx)
# The granular `Hex Code` column is empty in this sheet; only `Broad` and
# `Broad Hex code` are used.

# Seurat sanitised cell-type names when M_RCTD_dominant_celltype was written; match it.
sani <- function(x) gsub("[^[:alnum:]]", "_", gsub("/", "-", trimws(x)))

# The sheet holds both "Cd8aa _IEL" and "Cd8aa_IEL" for the same category. Collapsing
# repeated underscores merges them; left alone the legend shows 28 entries, not 27.
norm_broad <- function(x) gsub("_+", "_", gsub("[^[:alnum:]]", "_", trimws(x)))

# Granular RCTD label -> broad category. `RCTD cell type name` covers all 38 values
# the object uses; `Population` is a fallback in case that column is ever edited.
broad_map <- c(
  setNames(norm_broad(sc_annot_col$Broad), sani(sc_annot_col$Population)),
  setNames(norm_broad(sc_annot_col$Broad), sani(sc_annot_col$`RCTD cell type name`))
)
broad_map <- broad_map[nzchar(names(broad_map)) & nzchar(broad_map) & broad_map != "NA"]
broad_map <- broad_map[!duplicated(names(broad_map))]

broad_cols <- setNames(trimws(sc_annot_col$`Broad Hex code`), norm_broad(sc_annot_col$Broad))
broad_cols <- broad_cols[nzchar(names(broad_cols)) & names(broad_cols) != "NA"]
broad_cols <- broad_cols[!duplicated(names(broad_cols))]

gran  <- ifelse(merged.object$M_RCTD_dominant_celltype == "Unknown", "Unknown",
                sani(merged.object$M_RCTD_dominant_celltype))
broad <- unname(broad_map[gran])
broad[is.na(broad) | gran == "Unknown"] <- "Unknown"
merged.object$M_RCTD_broad <- broad

unmapped <- setdiff(unique(gran[is.na(broad_map[gran])]), "Unknown")
if (length(unmapped)) warning("No broad mapping for: ", paste(unmapped, collapse = ", "))

# Legend order follows the published figure: Epithelia, Stroma, Immune.
comp_of <- setNames(trimws(sc_annot_col$Compartment), norm_broad(sc_annot_col$Broad))
comp_of <- comp_of[!duplicated(names(comp_of))]
present <- sort(unique(merged.object$M_RCTD_broad))
present <- present[order(match(comp_of[present], c("Epithelia", "Stroma", "Immune"),
                               nomatch = 4L), present)]
merged.object$M_RCTD_broad <- factor(merged.object$M_RCTD_broad, levels = present)

deconv_colors <- vapply(present, function(b) {
  hex <- unname(broad_cols[b])
  if (!is.na(hex) && nzchar(hex) && hex != "NA") hex else "#D3D3D3"
}, character(1))
names(deconv_colors) <- present

cat("Broad categories in legend:", length(present), "— published Figure 3 has 27\n")


## ----panel_3bc_plots, fig.show='hide'-----------------------------------------
# Duodenum samples make panel 3B, ileum samples 3C. Only the published replicate keeps
# the fig3B_/fig3C_ prefix; the other replicate is real data but not a printed panel, so
# it is written as supporting_ — the same convention as Fig 4A and Fig 6D/6E.
PUBLISHED_REPLICATE <- c("Duodenum.3.008um", "Ileum.3.008um")

for (img in sample_images) {
  region <- if (grepl("Duodenum", img, ignore.case = TRUE)) "3B" else "3C"
  prefix <- if (img %in% PUBLISHED_REPLICATE) paste0("fig", region) else "supporting"

  p <- SpatialDimPlot(merged.object, images = img, group.by = "M_RCTD_broad",
                      label = FALSE, pt.size.factor = 1.25, cols = deconv_colors) +
    scale_fill_manual(values = deconv_colors, na.value = "grey90", drop = FALSE) +
    ggtitle(paste0("RCTD dominant cell type — ", img, " (8 µm, hi-res)")) +
    theme(legend.position = "right", legend.text = element_text(size = 7),
          plot.title = element_text(size = 11))

  ggsave(op(paste0(prefix, "_deconv_dominant_", ubar(img), ".pdf")),
         plot = p, height = 12, width = 14)
  cat(prefix, "<-", img, "\n")
}


## ----panel_3d_composition, fig.width=6, fig.height=8--------------------------
merged.object$region <- ifelse(grepl("Duodenum", merged.object$orig.ident, ignore.case = TRUE),
                               "Duo", "Ile")

comp_df <- merged.object@meta.data |>
  dplyr::count(region, M_RCTD_broad, name = "n") |>
  dplyr::group_by(region) |>
  dplyr::mutate(pct = 100 * n / sum(n)) |>
  dplyr::ungroup() |>
  dplyr::mutate(region = factor(region, levels = c("Duo", "Ile")),
               M_RCTD_broad = factor(M_RCTD_broad, levels = present))

p_composition <- ggplot(comp_df, aes(x = region, y = pct, fill = M_RCTD_broad)) +
  geom_col(width = 0.6) +
  scale_fill_manual(values = deconv_colors, drop = FALSE, name = "Annotation") +
  labs(x = NULL, y = "% Composition") +
  theme_classic(base_size = 12) +
  theme(legend.text = element_text(size = 7), legend.key.size = unit(0.35, "cm"))

ggsave(op("fig3D_composition_barplot.pdf"), p_composition, width = 6, height = 8)
p_composition


## ----supporting_umap_all, fig.width=11, fig.height=9--------------------------
umap_red <- intersect(c("umap.sketch", "full.umap.sketch", "umap"), Reductions(merged.object))[1]
if (is.na(umap_red)) stop("No UMAP reduction found in object.")

p_umap <- DimPlot(merged.object, reduction = umap_red, group.by = "cluster_annotation",
                  cols = cluster_colors, raster = TRUE, raster.dpi = c(600, 600),
                  pt.size = 1.2, label = FALSE) +
  ggtitle("All spatial clusters (res 2, 8 µm)") +
  theme_classic(base_size = 13) +
  theme(legend.text = element_text(size = 8))

ggsave(op("supporting_umap_all_clusters.pdf"), p_umap, width = 11, height = 9)
p_umap


## ----supporting_deconv_combined, fig.show='hide'------------------------------
p_list <- SpatialDimPlot(merged.object, group.by = "M_RCTD_broad", label = FALSE,
                         pt.size.factor = 1.25, cols = deconv_colors, combine = FALSE)

ggsave(op("supporting_deconv_all_samples.pdf"), height = 14, width = 20,
       plot = wrap_plots(p_list, ncol = 2) +
         plot_annotation(title = "RCTD dominant cell type — all samples (8 µm, hi-res)") &
         theme(legend.position = "right", legend.text = element_text(size = 7)))


## ----supporting_marker_heatmap, fig.width=24, fig.height=14-------------------
Idents(merged.object) <- merged.object$cluster_annotation

markers_cache <- "../data/markers_cluster_annotation.csv"
if (file.exists(markers_cache)) {
  markers <- read.csv(markers_cache, stringsAsFactors = FALSE)
} else {
  markers <- FindAllMarkers(merged.object, only.pos = TRUE, min.pct = 0.25,
                            logfc.threshold = 0.25, test.use = "wilcox", verbose = FALSE)
  write.csv(markers, markers_cache, row.names = FALSE)
}

top10 <- markers |>
  group_by(cluster) |>
  slice_max(order_by = avg_log2FC, n = 10, with_ties = FALSE) |>
  ungroup()

# Order clusters by annotation-CSV row order, keeping only labels actually present.
present_cl     <- levels(droplevels(merged.object$cluster_annotation))
ordered_levels <- c(cluster_levels[cluster_levels %in% present_cl],
                    setdiff(present_cl, cluster_levels))
merged.object$cluster_annotation <- factor(merged.object$cluster_annotation,
                                           levels = ordered_levels)
Idents(merged.object) <- merged.object$cluster_annotation

gene_order <- top10 |>
  arrange(factor(cluster, levels = ordered_levels)) |>
  pull(gene) |> unique()
gene_order <- intersect(gene_order, rownames(merged.object))

set.seed(42)
cells_use <- unlist(lapply(ordered_levels, function(x) {
  cells <- colnames(merged.object)[merged.object$cluster_annotation == x]
  cells <- cells[!is.na(cells)]
  if (length(cells) > 150) sample(cells, 150) else cells
}))

obj_hm <- merged.object[, cells_use]
obj_hm <- ScaleData(obj_hm, features = gene_order, verbose = FALSE)

p_hm <- DoHeatmap(obj_hm, features = gene_order, group.by = "cluster_annotation",
                  group.colors = cluster_colors[ordered_levels], label = TRUE,
                  size = 3, draw.lines = TRUE) +
  scale_fill_gradient2(low = "#2C7BB6", mid = "white", high = "#D7191C",
                       midpoint = 0, na.value = "grey85", name = "Scaled\nexpression") +
  ggtitle("Top-10 marker genes per spatial cluster (8 µm)") +
  theme(axis.text.y = element_text(size = 6))

ggsave(op("supporting_marker_heatmap_top10.pdf"), p_hm, width = 24, height = 14,
       limitsize = FALSE)
p_hm


## ----superseded_spatial_clusters, eval=FALSE----------------------------------
# for (img in sample_images) {
#   p <- SpatialDimPlot(merged.object, images = img, group.by = "cluster_annotation",
#                       label = FALSE, pt.size.factor = 1.25, cols = cluster_colors) +
#     scale_fill_manual(values = cluster_colors, na.value = "grey90", drop = FALSE) +
#     ggtitle(paste0("Spatial cluster annotation (res 2) — ", img)) +
#     theme(legend.position = "right", legend.text = element_text(size = 8))
#   ggsave(op(paste0("fig3_spatial_clusters_", ubar(img), ".pdf")), p, height = 10, width = 13)
# }


## ----session_info-------------------------------------------------------------
sessionInfo()

