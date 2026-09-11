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



## ----setup, include=FALSE-----------------------------------------------------
if (nzchar(Sys.getenv("CHERRYPIC_R_LIB"))) .libPaths(c(Sys.getenv("CHERRYPIC_R_LIB"), .libPaths()))  # optional custom library

library(Seurat)
library(tidyverse)
library(patchwork)
library(RColorBrewer)

knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)


## ----config-------------------------------------------------------------------
rds_hires <- "../data/final_analysis_object_with_master_deconv_hires.RDS"
out_dir   <- "../outputs"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

op   <- function(f) file.path(out_dir, f)     # path helper for outputs
ubar <- function(x) gsub("\\.", "_", x)       # "Ileum.2.008um" -> "Ileum_2_008um"

FIG4A_GENES <- c("Fabp1", "Reg1", "Fabp6", "Slc10a2")


## ----load---------------------------------------------------------------------
merged.object <- readRDS(rds_hires)
sample_images <- Images(merged.object)

genes_present <- intersect(FIG4A_GENES, rownames(merged.object))
missing <- setdiff(FIG4A_GENES, genes_present)
if (length(missing) > 0) warning("Genes not in data: ", paste(missing, collapse = ", "))
cat("Genes plotted:", paste(genes_present, collapse = ", "), "\n")


## ----panel_4a_plots, fig.width=6, fig.height=6--------------------------------
PUBLISHED_REPLICATE <- c("Duodenum.3.008um", "Ileum.3.008um")

for (gene in genes_present) {
  gene_range <- range(FetchData(merged.object, vars = gene)[[gene]], na.rm = TRUE)

  plots <- lapply(sample_images, function(img) {
    p <- SpatialFeaturePlot(merged.object, features = gene, images = img,
                            pt.size.factor = 1.25, crop = TRUE)
    p[[1]] +
      scale_fill_gradientn(colours = rev(brewer.pal(11, "Spectral")),
                           limits = gene_range, name = "Expr") +
      labs(title = paste0(gene, " — ", img)) +
      theme(plot.title = element_text(size = 10, hjust = 0.5),
            legend.key.size = unit(0.4, "cm"))
  })
  names(plots) <- sample_images

  for (img in sample_images) {
    prefix <- if (img %in% PUBLISHED_REPLICATE) "fig4A_spatial_" else "supporting_spatial_"
    ggsave(op(paste0(prefix, gene, "_", ubar(img), ".pdf")),
           plots[[img]], width = 6, height = 6)
  }
  cat("Saved 4A panels:", gene, "\n")
}


## ----supporting_all_samples, fig.width=22, fig.height=6-----------------------
for (gene in genes_present) {
  gene_range <- range(FetchData(merged.object, vars = gene)[[gene]], na.rm = TRUE)

  plots <- lapply(sample_images, function(img) {
    p <- SpatialFeaturePlot(merged.object, features = gene, images = img,
                            pt.size.factor = 1.25, crop = TRUE)
    p[[1]] +
      scale_fill_gradientn(colours = rev(brewer.pal(11, "Spectral")),
                           limits = gene_range, name = "Expr") +
      labs(title = paste0(gene, " — ", img)) +
      theme(plot.title = element_text(size = 10, hjust = 0.5),
            legend.key.size = unit(0.4, "cm"))
  })

  p_row <- wrap_plots(plots, nrow = 1, guides = "collect")
  ggsave(op(paste0("supporting_spatial_", gene, "_all_samples.pdf")), p_row, width = 22, height = 6)
  cat("Saved supporting row:", gene, "\n")
}


## ----session_info-------------------------------------------------------------
sessionInfo()

