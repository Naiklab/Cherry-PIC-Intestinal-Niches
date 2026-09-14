#' ---
#' title: "Figure 3 — Visium HD spatial transcriptomics (8 µm)"
#' author: "Ikjot Sidhu"
#' date: "`r Sys.Date()`"
#' output:
#'   html_notebook:
#'     code_folding: hide
#'     toc: true
#'     toc_float: true
#'     toc_depth: 3
#' ---
#' 
#' ## Purpose
#' 
#' Spatial deconvolution maps and cell-type composition for the Visium HD 8 µm data —
#' Figure 3B, 3C and 3D. Reads the frozen 8 µm object and writes PDFs to `../outputs/`.
#' 
#' Panel 3A is a schematic and is not made here. Panel 3E (epithelial UMAP) lives in
#' `../../04_spatial_clusters_16um/scripts/Fig3E_16um_final.Rmd`, and panel 3F (enterocyte
#' dot plots) comes from the DR26001 scRNA project at
#' `DR26001-scRNA-project/.../04-merge-controls/scripts/Fig3F_DotPlots_final.Rmd`.
#' 
#' ## Outputs
#' 
#' A `fig3` prefix marks a published panel; `supporting_` marks everything else.
#' 
#' | File | Panel |
#' |---|---|
#' | `fig3B_deconv_dominant_Duodenum_3_008um.pdf` | 3B — duodenum |
#' | `fig3C_deconv_dominant_Ileum_3_008um.pdf` | 3C — ileum |
#' | `fig3D_composition_barplot.pdf` | 3D — composition, both regions pooled |
#' 
#' | Supporting file | What it is |
#' |---|---|
#' | `supporting_deconv_dominant_Duodenum_4_008um.pdf` | the second duodenum replicate |
#' | `supporting_deconv_dominant_Ileum_2_008um.pdf` | the second ileum replicate |
#' | `supporting_deconv_all_samples.pdf` | all four deconvolution maps on one sheet |
#' | `supporting_umap_all_clusters.pdf` | res-2 UMAP across all spatial clusters |
#' | `supporting_marker_heatmap_top10.pdf` | top-10 markers per spatial cluster |
#' 
#' **Published replicate.** Duodenum_3 and Ileum_3 are the printed panels, project-wide.
#' Duodenum_4 and Ileum_2 are real data from the second biological replicate but are not
#' printed, so they are written under `supporting_`. Fig 4A and Fig 6D/6E follow the same rule.
#' 
#' **Spatial cluster maps are not written here.** `FigS3_VisiumHD_QC_Clusters_final.Rmd` owns
#' them and produces identical files. The chunk at the end of this notebook is kept with
#' `eval = FALSE` so the provenance stays visible, but it does not run.
#' 
#' ## Inputs
#' 
#' | File | Contents |
#' |---|---|
#' | `../data/final_analysis_object_with_master_deconv_hires.RDS` | 8 µm object, hi-res images, RCTD results in `M_RCTD_*` — feeds panels 3B/3C only |
#' | `../data/8um-binned-updated-annotations(res2) Apr 21 with exclusion.csv` | res-2 cluster → annotation, compartment, colours |
#' | `../data/single cell seq combined datasets annotation res 1_2 With colors RCTD broad Aug12.xlsx` | RCTD cell type → broad category and palette, for panels 3B/3C |
#' | `../data/broad_deconv_composition_all_spots_tissue.csv` | mean RCTD weight per broad cell type per tissue, for panel 3D |
#' | `../data/single cell seq combined datasets annotation res 1_2 With colors RCTD broad July8.csv` | broad category → palette for the panel-3D composition table above |
#' 
#' All frozen. Deconvolution is not re-run — `M_RCTD_dominant_celltype` already exists in the
#' object; see `Preprocessing_VisiumHD_8um_final.Rmd` for how it was produced.
#' 
#' The mapping covers all 38 `M_RCTD_dominant_celltype` values present in the object and
#' resolves to the 27 broad categories in the published legend (11 Epithelia, 7 Stroma,
#' 8 Immune, plus Unknown). "Mix cluster remove" and "Unidentified" both collapse to
#' `Unknown`, which is a legend entry in the published figure rather than a dropped category.
#' 
#' **Panel 3D uses a separate deconvolution from 3B/3C.** `Master_RCTD_Deconvolution_Broad_8um.Rmd`
#' runs its own RCTD pass with `MB_RCTD_*` weight columns, against a reference built directly at
#' broad-category resolution (not collapsed post hoc from the 38-category fine reference that
#' `M_RCTD_*` uses), and — like the fine reference — excludes tissue-exclusive enterocyte
#' subtypes from the other tissue's reference (`Mid_villus_proximal_enterocytes` is not offered
#' to Ileum spots, `Mid_villus_distal_enterocytes` is not offered to Duodenum spots). Panel 3D's
#' composition table is `mean(MB_RCTD_<celltype>)` per tissue across all spots, all four samples
#' pooled — the pre-existing output of that notebook's own "All-spots Composition" section, not
#' recomputed here. Earlier this used `M_RCTD_broad` dominant-identity counting on the object
#' above, which a second independent review flagged as producing composition percentages that
#' didn't match the manuscript's stacked bars (e.g. Mid-villus proximal/Duodenum: 64% vs. a
#' published ~56%); the weight-based table here reproduces the manuscript within ~2-4 points
#' (58.4%/37.9% vs. ~56%/~34%), the closest of every calculation tried, and traces to genuinely
#' pre-existing code, so panel 3D was repointed at it. The remaining few points are consistent
#' with reading a stacked bar by eye, not a further code discrepancy — per-sample splits and a
#' same-object combined-subtype check were both tried and neither closes it further.
#' 
#' ## Running this
#' 
#' The 8 µm object needs more than 24 GB of RAM once loaded, so this runs on a compute node:
#' 
#' ```
#' OPENBLAS_NUM_THREADS=1 Rscript Fig3_VisiumHD_final.R
#' ```
#' 
#' Full build of the object loaded below — raw Space Ranger → `..._with_master_deconv_hires.RDS` — documented as code-of-record (not re-executed here; the figure runs from the frozen RDS).
#' 
## ----pipeline-provenance, child='Preprocessing_VisiumHD_8um_final.Rmd'--------

#' <!--
#' Pre-processing Pipeline — Visium HD 8 µm object (FINAL, documentation).
#' Designed to be included via `{r child=...}` in the figure notebooks, so this file
#' has NO YAML header (a child's YAML would render as stray text in the parent).
#' To knit standalone: rmarkdown::render("Preprocessing_VisiumHD_8um_final.Rmd").
#' -->
#' 
#' # Pre-processing Pipeline — Visium HD 8 µm object
#' 
#' ## Purpose
#' 
#' **Reproducibility record** for the 8 µm Visium HD object that the figure notebooks
#' load. This notebook documents the *entire* build chain from raw Space Ranger output
#' to the frozen RDS objects. It is included at the top of `Fig3_VisiumHD_final.Rmd`,
#' `Fig4A_VisiumHD_final.Rmd` and `FigS3_VisiumHD_QC_Clusters_final.Rmd` via a
#' `{r child=...}` chunk so each figure notebook shows the full provenance.
#' 
#' **All chunks are `eval = FALSE`** — this is code-of-record, not re-run at figure time
#' (the figures read the frozen RDS). To rebuild from scratch, run these stages in order
#' on a compute node (submit through your scheduler; cap BLAS threads). The heavy steps (RCTD, integration) are
#' the canonical `.R` batch scripts, embedded here verbatim.
#' 
#' ### Object build DAG
#' 
#' ```
#' rawdata/<sample>/binned_outputs/square_008um/   (Space Ranger 4.0.1)
#'    │  General_VisiumHD_Analysis_Workflow.Rmd
#'    ▼
#' merged_object_clustered.RDS                      (QC→SCT→sketch→cluster res2→UMAP→project)
#'    │  Master_RCTD_Deconvolution_8um.R  (+ Master.Obj.rds reference)
#'    ▼
#' final_analysis_object_with_master_deconv.RDS     (M_RCTD_* deconvolution weights)
#'    │  swap_master_hires.R                         ├─► final_analysis_object_with_master_deconv_hires.RDS  ← Fig 3 / 4B / S3
#'    │  Stem_Cell_Niche_Analysis_8um.Rmd            └─► final_analysis_object_8um_with_stem_niche.RDS       (niche/violin analyses)
#' ```
#' 
#' The scRNA reference (`Master.Obj.rds`) used by RCTD is built in
#' `Preprocessing_scRNA_Reference_final.Rmd`.
#' 
## ----pp8-doc-setup, include=FALSE---------------------------------------------
# Documentation notebook — every pipeline chunk below is marked eval=FALSE
# individually (so this file is safe to include as a knitr child without
# disabling the parent figure notebook's chunks).

#' 
#' ---
#' 
#' # Stage 1 — Environment & parameters
#' *(source: `General_VisiumHD_Analysis_Workflow.Rmd`)*
#' 
## ----pp8-params, eval=FALSE---------------------------------------------------
# if (nzchar(Sys.getenv("CHERRYPIC_R_LIB"))) .libPaths(c(Sys.getenv("CHERRYPIC_R_LIB"), .libPaths()))  # optional custom library
# library(Seurat); library(tidyverse); library(patchwork); library(RColorBrewer)
# future::plan("multicore", workers = future::availableCores())
# options(future.globals.maxSize = 2 * 10^12)
# 
# # Samples & raw data location (Space Ranger 4.0.1, Visium Mouse Transcriptome Probe v2.0)
# sample.names <- c("SHNA03_D3-7um_0_v1","SHNA03_D4-7um_0_v1","SHNA03_I2-7um_0_v1","SHNA03_I3-7um_0_v1")
# data.dir     <- Sys.getenv("CHERRYPIC_RAWDATA", "rawdata")
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

#' 
#' # Stage 2 — Load Visium HD data (per sample, with image)
#' 
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

#' 
#' # Stage 3 — QC metrics & filter (UMI ≥ 25)
#' 
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

#' 
#' # Stage 4 — Normalize, merge, sketch
#' 
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

#' 
#' # Stage 5 — Cluster (res 2) & UMAP on the sketch, then project to full data
#' 
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

#' 
#' ---
#' 
#' # Stage 5b — Attach cluster annotations → `final_analysis_object.RDS`
#' 
#' An earlier version of this record said cluster annotations were mapped "downstream" —
#' meaning at figure-plotting time — and left this stage out entirely. That was wrong: Stage
#' 6's own batch script (`Master_RCTD_Deconvolution_8um.R`) reads `final_analysis_object.RDS`,
#' a file nothing upstream of it wrote. Checked the original interactive script on Minerva
#' (`General_VisiumHD_Analysis_Workflow.Rmd`) and found this exact gap — a cluster-annotation
#' CSV crosswalk attached between clustering and RCTD, identical in structure to Stage 5 of
#' the 16 µm pipeline, just not carried into this notebook. Figure notebooks (e.g. Fig 3)
#' separately re-derive the same columns from the same crosswalk at figure time; that
#' redundancy is harmless since both read the same `sketch_snn_res.2` cluster IDs, but it
#' means this stage's real purpose is producing the exact file Stage 6 expects, not the
#' figures' own annotation.
#' 
#' BANKSY spatial-domain clustering also runs in this interval in the original script but
#' feeds no published panel — omitted here on the same basis as the 16 µm pipeline's excluded
#' exploratory analyses.
#' 
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

#' 
#' ---
#' 
#' # Stage 6 — RCTD deconvolution → `final_analysis_object_with_master_deconv.RDS`
#' *(canonical batch script embedded verbatim; uses the master scRNA reference `Master.Obj.rds`,
#' run with `UMI_min = 50`; produces the `M_RCTD_*` weight columns and `M_RCTD_dominant_celltype`)*
#' 
## ----pp8-rctd, eval=FALSE, code=readLines("Master_RCTD_Deconvolution_8um.R")----
# NA

#' 
#' # Stage 7 — Stem cell niche zones → `final_analysis_object_8um_with_stem_niche.RDS`
#' *(source: `Stem_Cell_Niche_Analysis_8um.Rmd`; parallel branch — consumed by the
#' Figure 6 niche deconvolution, not by Fig 3/4B/S3. Distances are nearest-stem-spot Euclidean in pixel
#' space, converted to 8 µm bins.)*
#' 
## ----pp8-niche-params, eval=FALSE---------------------------------------------
# STEM_CELL_TYPE      <- "Stem_cells"
# IMMED_PERI_MAX_BINS <- 3     # immediate periphery = within 3 bin widths (≤ 24 µm)
# # The stem-cell niche is the stem-cell bins plus that immediate periphery.
# # Everything further out is outside the niche and is not carried forward.
# zone_levels <- c("Stem_cell", "Immediate_periphery", "Outside_niche", "No_tissue")

#' 
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
# EXCL_REGION   <- c("Tip-villus distal enterocytes", "Tip-villus proximal enterocytes")
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

#' 
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

#' 
#' # Stage 8 — Hi-res image swap → `*_hires.RDS`
#' *(canonical script embedded verbatim; replaces the low-res Space Ranger image with the
#' hi-res PNG and sets `scale.factors$lowres <- scale.factors$hires` so default plotting is
#' unchanged. This produces `final_analysis_object_with_master_deconv_hires.RDS`, the object
#' Fig 3/4B/S3 load.)*
#' 
## ----pp8-hires-swap, eval=FALSE, code=readLines("scripts_hires_master/swap_master_hires.R")----
# NA


#' 
## ----setup, include=FALSE-----------------------------------------------------
# Only prepend the HPC library when it actually exists, so the notebook still opens locally.
if (nzchar(Sys.getenv("CHERRYPIC_R_LIB"))) .libPaths(c(Sys.getenv("CHERRYPIC_R_LIB"), .libPaths()))  # optional custom library

library(Seurat)
library(tidyverse)
library(patchwork)
library(RColorBrewer)
library(readxl)

knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)

#' 
#' # Setup
#' 
#' ## Paths and annotation maps
#' 
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

#' 
#' ## Load the object
#' 
## ----load---------------------------------------------------------------------
merged.object <- readRDS(rds_hires)
sample_images <- Images(merged.object)
cat("Spots:", ncol(merged.object), "| Images:", paste(sample_images, collapse = ", "), "\n")

cl <- as.character(merged.object@meta.data[[cluster_col]])
merged.object$cluster_annotation <- factor(unname(cluster_map[cl]), levels = cluster_levels)

#' 
#' ---
#' 
#' # PART 1 — Manuscript panels
#' 
#' ## Panels 3B and 3C — RCTD dominant cell type, per sample
#' 
#' Each spot is coloured by whichever cell type RCTD assigned the most weight. The
#' manuscript splits the four samples across two panels: **duodenum → 3B, ileum → 3C**.
#' 
#' The published legend groups cell types into 27 **broad** categories under Epithelia /
#' Stroma / Immune. The object stores the finer 38-category RCTD labels, so the first step
#' is collapsing those to broad.
#' 
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

#' 
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

#' 
#' ## Panel 3D — composition of deconvolved cell identities
#' 
#' Mean RCTD weight per broad cell type, per tissue, pooling all four samples' spots —
#' not the `M_RCTD_broad` dominant-identity counts panels 3B/3C use. This is a separate,
#' pre-existing RCTD deconvolution (`Master_RCTD_Deconvolution_Broad_8um.Rmd`, `MB_RCTD_*`
#' columns) run directly at broad-category resolution; its own "All-spots Composition"
#' section already computed and saved this table, so it is read here rather than
#' recomputed. See the Inputs section above for why: dominant-identity counting gave
#' composition percentages that didn't reproduce the manuscript's bars, and this
#' weight-based table is the closest match found, from genuinely pre-existing code.
#' 
## ----panel_3d_composition, fig.width=6, fig.height=8--------------------------
comp_tissue_csv   <- "../data/broad_deconv_composition_all_spots_tissue.csv"
broad_palette_csv <- "../data/single cell seq combined datasets annotation res 1_2 With colors RCTD broad July8.csv"

comp_raw <- read.csv(comp_tissue_csv, stringsAsFactors = FALSE)

broad_pal_sheet <- read.csv(broad_palette_csv, stringsAsFactors = FALSE, check.names = FALSE)
broad_cols_3d <- setNames(trimws(broad_pal_sheet$`Broad Hex code`), trimws(broad_pal_sheet$Broad))
broad_cols_3d <- broad_cols_3d[nzchar(names(broad_cols_3d)) & nzchar(broad_cols_3d) & broad_cols_3d != "NA"]
broad_cols_3d <- broad_cols_3d[!duplicated(names(broad_cols_3d))]

comp_of_3d <- setNames(trimws(broad_pal_sheet$Compartment), trimws(broad_pal_sheet$Broad))
comp_of_3d <- comp_of_3d[!duplicated(names(comp_of_3d))]

comp_df <- comp_raw |>
  dplyr::transmute(region = ifelse(tissue_type == "Duodenum", "Duo", "Ile"),
                   celltype = celltype,
                   pct = 100 * mean_prop)

present_3d <- sort(unique(comp_df$celltype))
present_3d <- present_3d[order(match(comp_of_3d[present_3d], c("Epithelia", "Stroma", "Immune"),
                                     nomatch = 4L), present_3d)]

comp_df <- comp_df |>
  dplyr::mutate(region = factor(region, levels = c("Duo", "Ile")),
               celltype = factor(celltype, levels = present_3d))

deconv_colors_3d <- vapply(present_3d, function(b) {
  hex <- unname(broad_cols_3d[b])
  if (!is.na(hex) && nzchar(hex) && hex != "NA") hex else "#D3D3D3"
}, character(1))
names(deconv_colors_3d) <- present_3d

p_composition <- ggplot(comp_df, aes(x = region, y = pct, fill = celltype)) +
  geom_col(width = 0.6) +
  scale_fill_manual(values = deconv_colors_3d, drop = FALSE, name = "Annotation") +
  labs(x = NULL, y = "% Composition") +
  theme_classic(base_size = 12) +
  theme(legend.text = element_text(size = 7), legend.key.size = unit(0.35, "cm"))

ggsave(op("fig3D_composition_barplot.pdf"), p_composition, width = 6, height = 8)
p_composition

#' 
#' ## Panel 3E — moved
#' 
#' **Figure 3E (epithelial UMAP) does not live in this notebook.** It used to be produced
#' here by reusing this object's 8 µm resolution-2 clustering (`sketch_snn_res.2`),
#' remapped through the 8 µm annotation CSV — but that clustering never distinguishes
#' Enteroendocrine cells as their own cluster, so the panel only ever reached 8 of the
#' published 9 categories.
#' 
#' The real panel comes from the 16 µm object's own whole-object clustering, which does
#' resolve EEC as its own cluster (cluster 33) — coarser binning, not a clustering run
#' confined to the epithelial subset; the subset itself is only re-embedded (PCA/UMAP),
#' inheriting those cluster identities rather than being re-clustered. See
#' `../../04_spatial_clusters_16um/scripts/Fig3E_16um_final.Rmd`, which resolves all 9
#' categories in the published legend. `fig3E_epithelia_umap.pdf` and its supporting outputs
#' are written there, not here.
#' 
#' ---
#' 
#' # PART 2 — Supporting figures
#' 
#' Not part of Figure 3. Kept because they are useful for review and QC.
#' 
#' ## All spatial clusters, UMAP
#' 
#' Panel 3E (in the 16 µm notebook) shows only the epithelial compartment. This is the
#' full res-2 UMAP, all compartments, from this notebook's 8 µm object.
#' 
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

#' 
#' ## All four deconvolution maps on one sheet
#' 
#' The same data as panels 3B and 3C, laid out together for side-by-side comparison.
#' Large file (~240 MB) — it is a review aid, not a panel source.
#' 
## ----supporting_deconv_combined, fig.show='hide'------------------------------
p_list <- SpatialDimPlot(merged.object, group.by = "M_RCTD_broad", label = FALSE,
                         pt.size.factor = 1.25, cols = deconv_colors, combine = FALSE)

ggsave(op("supporting_deconv_all_samples.pdf"), height = 14, width = 20,
       plot = wrap_plots(p_list, ncol = 2) +
         plot_annotation(title = "RCTD dominant cell type — all samples (8 µm, hi-res)") &
         theme(legend.position = "right", legend.text = element_text(size = 7)))

#' 
#' ## Top-10 markers per spatial cluster
#' 
#' Wilcoxon markers per res-2 cluster, cached to `../data/markers_cluster_annotation.csv`
#' so this only computes once. Cells are downsampled to 150 per cluster to keep the heatmap
#' renderable.
#' 
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

#' 
#' ## Not run here — spatial cluster maps
#' 
#' These are pixel-identical to the `figS3_spatial_cluster_*.pdf` files produced by
#' `FigS3_VisiumHD_QC_Clusters_final.Rmd`, which owns them. Kept for provenance, disabled
#' so this notebook does not write 487 MB of duplicates.
#' 
## ----superseded_spatial_clusters, eval=FALSE----------------------------------
# for (img in sample_images) {
#   p <- SpatialDimPlot(merged.object, images = img, group.by = "cluster_annotation",
#                       label = FALSE, pt.size.factor = 1.25, cols = cluster_colors) +
#     scale_fill_manual(values = cluster_colors, na.value = "grey90", drop = FALSE) +
#     ggtitle(paste0("Spatial cluster annotation (res 2) — ", img)) +
#     theme(legend.position = "right", legend.text = element_text(size = 8))
#   ggsave(op(paste0("fig3_spatial_clusters_", ubar(img), ".pdf")), p, height = 10, width = 13)
# }

#' 
## ----session_info-------------------------------------------------------------
sessionInfo()

