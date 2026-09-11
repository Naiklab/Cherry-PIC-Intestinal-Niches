## ----setup, include=FALSE-----------------------------------------------------
if (nzchar(Sys.getenv("CHERRYPIC_R_LIB"))) .libPaths(c(Sys.getenv("CHERRYPIC_R_LIB"), .libPaths()))  # optional custom library
library(Seurat)             # Read10X_h5, spatial plotting
library(tidyverse)
library(patchwork)
library(RColorBrewer)
knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)


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


## ----pp8-annotate, eval=FALSE-------------------------------------------------
# annotation.file <- "8um-binned-updated-annotations(res2) Apr 21 with exclusion.csv"
# annotations <- read.csv(annotation.file, stringsAsFactors = FALSE)
# annotations <- annotations[!is.na(annotations$Cluster) & annotations$Cluster != "", ]
# 
# fill_na <- function(x, fill = "Unknown") { x[is.na(x) | x == "" | x == "NA"] <- fill; x }
# cid <- as.character(annotations$Cluster)
# cell.clusters <- as.character(merged.object$sketch_snn_res.2)
# 
# merged.object <- AddMetaData(merged.object, metadata = data.frame(
#   cluster_annotation     = fill_na(setNames(annotations$Annotation,                cid)[cell.clusters]),
#   region_annotation      = fill_na(setNames(annotations$Spatial.region.annotation, cid)[cell.clusters]),
#   location_annotation    = fill_na(setNames(annotations$Region.Annotation,         cid)[cell.clusters]),
#   compartment_annotation = fill_na(setNames(annotations$Compartment,               cid)[cell.clusters]),
#   granular_annotation    = fill_na(setNames(annotations$Granular.annotation,       cid)[cell.clusters]),
#   row.names = colnames(merged.object)))
# 
# saveRDS(merged.object, "output_8um/RDS-files/final_analysis_object.RDS")


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
# # Categories excluded from periphery counting. Recovered from the original interactive
# # script (Stem_Cell_Niche_Analysis_8um.Rmd) — an earlier pass through this reconstruction
# # defaulted all three to character(0) and passed none at the call site, silently applying
# # no exclusions at all. EXCL_CLUSTER_* is region-specific: Duodenum and Ileum images use
# # different cluster lists, keyed on cluster_annotation.
# EXCL_DOMINANT <- c("Unknown")
# EXCL_REGION   <- c("Tip_villus_distal_enterocytes", "Tip_villus_proximal_enterocytes")
# EXCL_CLUSTER_DUODENUM <- c("Mid-villus distal enterocytes-1", "Mid-villus distal enterocytes-2",
#                            "Mid-villus distal enterocytes-3",
#                            "Bottom-villus distal enterocytes",
#                            "Tip-villus distal enterocytes",
#                            "Tip-villus proximal enterocytes-2",
#                            "Tip-villus activated proximal enterocytes",
#                            "Brunner's gland", "Peyer's patch")
# EXCL_CLUSTER_ILEUM <- c("Mid-villus proximal enterocytes-1", "Mid-villus proximal enterocytes-2",
#                         "Mid-villus proximal enterocytes-3", "Mid-villus proximal enterocytes-4",
#                         "Bottom-villus proximal enterocytes",
#                         "Tip-villus distal enterocytes",
#                         "Tip-villus proximal enterocytes-1", "Tip-villus proximal enterocytes-2",
#                         "Tip-villus activated proximal enterocytes",
#                         "Brunner's gland", "Peyer's patch")
# 
# # Zone by distance; Stem_cell overrides; excluded dominant/region/cluster → Outside_niche.
# classify_niche_zone <- function(dist_bins, is_stem, celltype_vec, region_ann_vec,
#                                 cluster_ann_vec = NULL, immed_max = IMMED_PERI_MAX_BINS,
#                                 excl_dominant = EXCL_DOMINANT,
#                                 excl_region = EXCL_REGION, excl_cluster = character(0)) {
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
#   excl_cluster <- if (grepl("Duodenum", img, ignore.case = TRUE)) EXCL_CLUSTER_DUODENUM else EXCL_CLUSTER_ILEUM
#   zone <- classify_niche_zone(dist_bins, coords$barcode %in% stem_bc,
#                               meta$M_RCTD_dominant_celltype, meta$region_annotation, meta$cluster_annotation,
#                               excl_cluster = excl_cluster)
#   niche_results[[img]] <- data.frame(barcode = coords$barcode, dist_bins = dist_bins,
#                                      dist_um = dist_bins * 8, stem_niche_zone = zone,
#                                      row.names = coords$barcode)
# }
# all_results <- do.call(rbind, niche_results)
# # rbind on a NAMED list can rename rows to avoid duplicates when raw per-image barcodes
# # collide across samples (Visium barcodes are drawn from a shared whitelist and are not
# # globally unique) — restoring rownames from the barcode column, as the original
# # interactive script does, guarantees the lookup below matches on barcode, not on
# # whatever rbind decided to call the row.
# rownames(all_results) <- all_results$barcode
# merged.object <- AddMetaData(merged.object,
#   all_results[colnames(merged.object), c("dist_bins", "dist_um", "stem_niche_zone")])
# merged.object$tissue_type <- ifelse(grepl("Duodenum", merged.object$orig.ident, ignore.case = TRUE),
#                                     "Duodenum", "Ileum")
# saveRDS(merged.object, "output_8um/RDS-files/final_analysis_object_8um_with_stem_niche.RDS")


## ----pp8-hires-swap, eval=FALSE, code=readLines("scripts_hires_master/swap_master_hires.R")----
# NA



## ----config-------------------------------------------------------------------
rds_hires <- "../data/final_analysis_object_with_master_deconv_hires.RDS"
ann_csv   <- "../data/8um-binned-updated-annotations(res2) Apr 21 with exclusion.csv"
out_dir   <- "../outputs"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
op   <- function(f) file.path(out_dir, f)
ubar <- function(x) gsub("\\.", "_", x)
cluster_col <- "sketch_snn_res.2"

# ---- res-2 cluster -> annotation maps (all three levels) ----
ann <- read.csv(ann_csv, stringsAsFactors = FALSE, check.names = TRUE)
ann$Cluster  <- as.character(ann$Cluster)
cluster_map  <- setNames(trimws(ann$Annotation),                ann$Cluster)
region_map   <- setNames(trimws(ann$Spatial.region.annotation), ann$Cluster)
location_map <- setNames(trimws(ann$Region.Annotation),         ann$Cluster)
cluster_levels  <- unique(trimws(ann$Annotation))
region_levels   <- unique(trimws(ann$Spatial.region.annotation))
location_levels <- unique(trimws(ann$Region.Annotation))

cluster_colors  <- setNames(trimws(ann$Granular.color), trimws(ann$Annotation))
cluster_colors  <- cluster_colors[!duplicated(names(cluster_colors))][cluster_levels]
gen_pal <- function(labels, base = "Paired")
  setNames(colorRampPalette(brewer.pal(12, base))(length(labels)), labels)
region_colors   <- gen_pal(region_levels, "Paired")
location_colors <- setNames(c("#4292C6", "#ef8a62", "#7B4F24"), location_levels)

# ---- QC parameters (from General_VisiumHD_Analysis_Workflow.Rmd) ----
MIN_COUNTS <- 25          # applied UMI cutoff
MT_PATTERN <- "^mt-|^MT-"
samples <- tibble::tribble(
  ~sample,      ~region,    ~folder,
  "Duodenum-3", "Duodenum", "SHNA03_D3-7um_0_v1",
  "Duodenum-4", "Duodenum", "SHNA03_D4-7um_0_v1",
  "Ileum-2",    "Ileum",    "SHNA03_I2-7um_0_v1",
  "Ileum-3",    "Ileum",    "SHNA03_I3-7um_0_v1"
)
sample_levels <- samples$sample
samp_cols <- setNames(c("#6A51A3", "#9E7BC8", "#08519C", "#4292C6"), sample_levels)


## ----load_spatial-------------------------------------------------------------
merged.object <- readRDS(rds_hires)
sample_images <- Images(merged.object)
cl <- as.character(merged.object@meta.data[[cluster_col]])
merged.object$cluster_annotation  <- factor(unname(cluster_map[cl]),  levels = cluster_levels)
merged.object$region_annotation   <- factor(unname(region_map[cl]),   levels = region_levels)
merged.object$location_annotation <- factor(unname(location_map[cl]), levels = location_levels)


## ----annotated_umap, fig.width=11, fig.height=9-------------------------------
umap_red <- intersect(c("umap.sketch", "full.umap.sketch", "umap"), Reductions(merged.object))[1]
p_umap <- DimPlot(merged.object, reduction = umap_red, group.by = "cluster_annotation",
                  cols = cluster_colors, raster = TRUE, raster.dpi = c(600, 600),
                  pt.size = 1.2, label = FALSE) +
  ggtitle("Spatial clusters (res 2) — annotated, 8 µm") +
  theme_classic(base_size = 13) + theme(legend.text = element_text(size = 8))
ggsave(op("figS3_cluster_umap_annotated.pdf"), p_umap, width = 11, height = 9)
p_umap


## ----spatial_annotation_levels, fig.show='hide'-------------------------------
# Hi-res SpatialDimPlots for all three annotation levels (per sample + combined).
plot_level <- function(group_by, cols, title, file_prefix) {
  for (img in sample_images) {
    p <- SpatialDimPlot(merged.object, images = img, group.by = group_by,
                        label = FALSE, pt.size.factor = 1.25, cols = cols) +
      scale_fill_manual(values = cols, na.value = "grey90", drop = FALSE) +
      ggtitle(paste0(title, " - ", img, " (8 µm, hi-res)")) +
      theme(legend.position = "right", legend.text = element_text(size = 8),
            plot.title = element_text(size = 11))
    ggsave(op(paste0(file_prefix, "_", ubar(img), ".pdf")), plot = p, height = 10, width = 13)
  }
  plots <- lapply(sample_images, function(img)
    SpatialDimPlot(merged.object, images = img, group.by = group_by,
                   label = FALSE, pt.size.factor = 1.25, cols = cols) +
      scale_fill_manual(values = cols, na.value = "grey90", drop = FALSE) +
      ggtitle(img) + theme(plot.title = element_text(size = 9)))
  ggsave(op(paste0(file_prefix, "_all_samples.pdf")), height = 18, width = 17,
         plot = wrap_plots(plots, ncol = 2, guides = "collect") +
           plot_annotation(title = paste0(title, " - All Samples (8 µm, hi-res)")) &
           theme(plot.title = element_text(size = 12), legend.position = "bottom",
                 legend.text = element_text(size = 8)))
}
plot_level("cluster_annotation",  cluster_colors,  "Spatial Cluster Annotation (res 2)", "figS3_spatial_cluster")
plot_level("region_annotation",   region_colors,   "Spatial Region Annotation (res 2)",  "figS3_spatial_region")
plot_level("location_annotation", location_colors, "Location (Proximal/Distal)",         "figS3_spatial_location")


## ----qc_compute---------------------------------------------------------------
# Per-spot QC from each raw on-tissue matrix (no log normalisation, linear axes).
qc_one <- function(folder) {
  h5 <- file.path("../data/rawdata", folder, "binned_outputs", "square_008um", "filtered_feature_bc_matrix.h5")
  m <- Read10X_h5(h5)
  if (is.list(m)) m <- m[["Gene Expression"]]
  total   <- Matrix::colSums(m)
  nfeat   <- Matrix::colSums(m > 0)
  mt_rows <- grep(MT_PATTERN, rownames(m))
  mt_pct  <- if (length(mt_rows) > 0) 100 * Matrix::colSums(m[mt_rows, , drop = FALSE]) / total else rep(0, ncol(m))
  mt_pct[!is.finite(mt_pct)] <- 0
  tibble(nCount = as.numeric(total), nFeature = as.numeric(nfeat), percent.mt = as.numeric(mt_pct))
}
qc <- samples %>% rowwise() %>% mutate(data = list(qc_one(folder))) %>% ungroup() %>%
  select(sample, region, data) %>% unnest(data) %>%
  mutate(sample = factor(sample, levels = sample_levels))


## ----qc_violins, fig.width=16, fig.height=6-----------------------------------
mk_violin <- function(yvar, ylab, cutoff = NA, cutoff_lab = NULL) {
  p <- ggplot(qc, aes(x = sample, y = .data[[yvar]], fill = sample)) +
    geom_violin(scale = "width", trim = TRUE, alpha = 0.85, colour = "grey30") +
    geom_boxplot(width = 0.12, outlier.shape = NA, fill = "white", alpha = 0.6) +
    scale_fill_manual(values = samp_cols) + labs(x = NULL, y = ylab) +
    theme_classic(base_size = 13) +
    theme(legend.position = "none", axis.text.x = element_text(angle = 30, hjust = 1))
  if (!is.na(cutoff)) {
    p <- p + geom_hline(yintercept = cutoff, linetype = "solid", colour = "red", linewidth = 0.7)
    if (!is.null(cutoff_lab))
      p <- p + annotate("text", x = 0.6, y = cutoff, label = cutoff_lab, colour = "red",
                        hjust = 0, vjust = -0.4, size = 3)
  }
  p
}
v_umi  <- mk_violin("nCount",   "UMI counts (raw)",     MIN_COUNTS, paste0("min UMI = ", MIN_COUNTS)) + ggtitle("UMI counts per spot")
v_feat <- mk_violin("nFeature", "Feature counts (raw)", NA) + ggtitle("Features per spot")
v_mt   <- mk_violin("percent.mt","Mitochondrial %",     NA) + ggtitle("Mitochondrial percent")  # no cutoff applied
ggsave(op("figS3_qc_violin_umi.pdf"),      v_umi,  height = 6, width = 6)
ggsave(op("figS3_qc_violin_features.pdf"), v_feat, height = 6, width = 6)
ggsave(op("figS3_qc_violin_mito.pdf"),     v_mt,   height = 6, width = 6)
ggsave(op("figS3_qc_violins_combined.pdf"),
       (v_umi | v_feat | v_mt) + plot_annotation(title = "QC metrics per sample (8 µm, raw counts)"),
       height = 6, width = 16)
(v_umi | v_feat | v_mt)


## ----qc_scatter, fig.width=18, fig.height=5-----------------------------------
x_max <- max(qc$nCount); y_max <- max(qc$nFeature)
p_scatter <- ggplot(qc, aes(x = nCount, y = nFeature)) +
  geom_point(size = 0.25, alpha = 0.4, colour = "#3B4A6B") +
  geom_vline(xintercept = MIN_COUNTS, linetype = "solid", colour = "red", linewidth = 0.6) +
  scale_x_continuous(limits = c(0, x_max)) + scale_y_continuous(limits = c(0, y_max)) +
  facet_wrap(~ sample, nrow = 1) +
  labs(x = "UMI counts (raw)", y = "Feature counts (raw)",
       title = "Features vs UMI counts per replicate (8 µm, raw counts)",
       subtitle = paste0("Red line = applied UMI cutoff (>= ", MIN_COUNTS, "); shared axes across replicates")) +
  theme_bw(base_size = 12) + theme(panel.grid.minor = element_blank())
ggsave(op("figS3_qc_scatter_features_vs_umi.pdf"), p_scatter, height = 5, width = 18)
p_scatter


## ----qc_scatter_individual, fig.width=6, fig.height=5-------------------------
for (s in sample_levels) {
  p_s <- ggplot(filter(qc, sample == s), aes(x = nCount, y = nFeature)) +
    geom_point(size = 0.25, alpha = 0.4, colour = "#3B4A6B") +
    geom_vline(xintercept = MIN_COUNTS, linetype = "solid", colour = "red", linewidth = 0.6) +
    scale_x_continuous(limits = c(0, x_max)) + scale_y_continuous(limits = c(0, y_max)) +
    labs(x = "UMI counts (raw)", y = "Feature counts (raw)",
         title = paste0("Features vs UMI counts — ", s, " (8 µm, raw counts)"),
         subtitle = paste0("Red line = applied UMI cutoff (>= ", MIN_COUNTS, ")")) +
    theme_bw(base_size = 12) + theme(panel.grid.minor = element_blank())
  ggsave(op(paste0("figS3_qc_scatter_features_vs_umi_", ubar(s), ".pdf")), p_s, height = 5, width = 6)
  cat("Saved:", s, "\n")
}

