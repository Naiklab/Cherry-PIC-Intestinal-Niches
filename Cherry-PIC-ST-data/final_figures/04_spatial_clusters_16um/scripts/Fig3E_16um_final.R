## ----pipeline-provenance, child='upstream/Preprocessing_VisiumHD_16um_final.Rmd'----

## ----pp16-doc-setup, include=FALSE--------------------------------------------
# Documentation notebook — every pipeline chunk below is marked eval=FALSE
# individually (so this file is safe to include as a knitr child without
# disabling the parent figure notebook's chunks).


## ----pp16-params, eval=FALSE--------------------------------------------------
# if (nzchar(Sys.getenv("CHERRYPIC_R_LIB"))) .libPaths(c(Sys.getenv("CHERRYPIC_R_LIB"), .libPaths()))  # optional custom library
# library(Seurat); library(tidyverse); library(patchwork); library(RColorBrewer)
# future::plan("multicore", workers = future::availableCores())
# options(future.globals.maxSize = 2 * 10^12)
# 
# # Samples & raw data location (Space Ranger 4.0.1, Visium Mouse Transcriptome Probe v2.0)
# sample.names <- c("SHNA03_D3-7um_0_v1","SHNA03_D4-7um_0_v1","SHNA03_I2-7um_0_v1","SHNA03_I3-7um_0_v1")
# data.dir     <- Sys.getenv("CHERRYPIC_RAWDATA", "rawdata")
# bin.size     <- c(16)
# image.names  <- list("SHNA03_D3-7um_0_v1" = "Duodenum-3", "SHNA03_D4-7um_0_v1" = "Duodenum-4",
#                      "SHNA03_I2-7um_0_v1" = "Ileum-2",    "SHNA03_I3-7um_0_v1" = "Ileum-3")
# 
# # QC thresholds (min.counts APPLIED; max.mt.percent a guideline, NOT applied as a filter)
# min.counts     <- 50   # 16 µm bins collect ~4x the transcripts of 8 µm bins (25)
# max.mt.percent <- 20
# 
# # Clustering: sketch-based; res 2 is the FINAL resolution used downstream
# sketch.ncells       <- 5000
# cluster.resolutions <- c(0.2, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4)


## ----pp16-load, eval=FALSE----------------------------------------------------
# load_visium_hd_data <- function(sample.name, data.dir, bin.size) {
#   spatial.dir <- file.path(data.dir, sample.name)
#   if (!dir.exists(spatial.dir)) { warning("Spatial directory not found: ", spatial.dir); return(NULL) }
#   object <- Load10X_Spatial(data.dir = spatial.dir, bin.size = bin.size,
#                             slice = image.names[[sample.name]])
#   cat("Loaded sample:", sample.name, "with", ncol(object), "spots\n")
#   object
# }
# 
# object.list <- lapply(sample.names, function(s) load_visium_hd_data(s, data.dir, bin.size[1]))
# names(object.list) <- sample.names
# object.list <- object.list[!sapply(object.list, is.null)]


## ----pp16-split, eval=FALSE---------------------------------------------------
# split_multi_image_samples <- function(object.list, image.names) {
#   split.object.list <- list()
#   for (sample.name in names(object.list)) {
#     obj <- object.list[[sample.name]]
#     images <- image.names[[sample.name]]
#     if (length(images) > 1) {
#       csv.dir <- file.path(dirname(obj@images[[1]]@image), "cloupe_csvs")
#       if (dir.exists(csv.dir)) {
#         csv.files <- list.files(csv.dir, pattern = "\\.csv$", full.names = TRUE)
#         for (i in seq_along(images)) {
#           image.name <- images[i]
#           csv.file <- csv.files[grep(image.name, csv.files)][1]
#           if (!is.na(csv.file) && file.exists(csv.file)) {
#             cells.to.keep <- read.csv(csv.file)$Barcode
#             sub.obj <- subset(obj, cells = cells.to.keep)
#             sub.obj$orig.ident <- image.name
#             sub.obj$sample <- sample.name
#             split.object.list[[paste(sample.name, image.name, sep = "_")]] <- sub.obj
#           }
#         }
#       } else {
#         obj$orig.ident <- sample.name
#         obj$sample <- sample.name
#         split.object.list[[sample.name]] <- obj
#       }
#     } else {
#       obj$orig.ident <- images[1]
#       obj$sample <- sample.name
#       split.object.list[[sample.name]] <- obj
#     }
#   }
#   split.object.list
# }
# 
# split.object.list <- split_multi_image_samples(object.list, image.names)
# cat("After splitting:", length(split.object.list), "objects\n")


## ----pp16-qc, eval=FALSE------------------------------------------------------
# split.object.list <- lapply(split.object.list, function(obj)
#   PercentageFeatureSet(obj, pattern = "^mt-|^MT-", col.name = "percent.mt"))
# 
# assay.name  <- names(split.object.list[[1]]@assays)[1]   # Spatial.016um
# count.col   <- paste0("nCount_",   assay.name)
# feature.col <- paste0("nFeature_", assay.name)
# 
# # The ONLY filter applied: UMI floor. percent.mt is recorded, never used to subset.
# filtered.object.list <- lapply(split.object.list, function(obj) {
#   count.col.local <- grep('^nCount_Spatial', colnames(obj@meta.data), value = TRUE)[1]
#   if (is.na(count.col.local)) stop('No nCount_Spatial column found in metadata!')
#   cells.keep <- obj@meta.data[[count.col.local]] >= min.counts
#   obj[, cells.keep]
# })


## ----pp16-cluster, eval=FALSE-------------------------------------------------
# normalized.object.list <- lapply(filtered.object.list, function(obj)
#   NormalizeData(obj, assay = assay.name))
# 
# merged.object <- merge(normalized.object.list[[1]],
#                        normalized.object.list[2:length(normalized.object.list)])
# 
# DefaultAssay(merged.object) <- assay.name
# merged.object <- FindVariableFeatures(merged.object)
# merged.object <- ScaleData(merged.object)
# merged.object <- SketchData(merged.object, ncells = 5000L, method = "Uniform",
#                             sketched.assay = "sketch")
# 
# # Cluster on the sketch
# DefaultAssay(merged.object) <- "sketch"
# merged.object <- FindVariableFeatures(merged.object)
# merged.object <- ScaleData(merged.object)
# merged.object <- RunPCA(merged.object, assay = "sketch", reduction.name = "pca.sketch")
# merged.object <- FindNeighbors(merged.object, assay = "sketch",
#                                reduction = "pca.sketch", dims = 1:50)
# merged.object <- FindClusters(merged.object, resolution = cluster.resolutions)
# merged.object <- RunUMAP(merged.object, reduction = "pca.sketch",
#                          reduction.name = "umap.sketch", return.model = TRUE, dims = 1:50)
# 
# # Project every resolution back onto all bins
# merged.object <- ProjectData(
#   object = merged.object, assay = assay.name,
#   full.reduction = "full.pca.sketch", sketched.assay = "sketch",
#   sketched.reduction = "pca.sketch", umap.model = "umap.sketch", dims = 1:50,
#   refdata = setNames(lapply(cluster.resolutions, function(res) paste0("sketch_snn_res.", res)),
#                      paste0("sketch_snn_res.", cluster.resolutions)))
# 
# saveRDS(merged.object, file = "output_16um/RDS-files/merged_object_clustered_16um.RDS")


## ----pp16-annotate, eval=FALSE------------------------------------------------
# annotations <- read.csv("16um-binned-updated-annotations(res2).csv", stringsAsFactors = FALSE)
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
# saveRDS(merged.object, file = "output_16um/RDS-files/final_analysis_object_16um.RDS")


## ----pp16-epi, eval=FALSE-----------------------------------------------------
# epi.object <- subset(merged.object, subset = compartment_annotation == "Epithelia")
# cat("Epithelia subset:", ncol(epi.object), "spots\n")   # 229,070
# 
# DefaultAssay(epi.object) <- "Spatial.016um"             # full assay, NOT the sketch
# epi.object <- NormalizeData(epi.object, assay = "Spatial.016um")
# epi.object <- FindVariableFeatures(epi.object, assay = "Spatial.016um", nfeatures = 3000)
# epi.object <- ScaleData(epi.object)
# epi.object <- RunPCA(epi.object, npcs = 30, reduction.name = "pca.epi")
# epi.object <- RunUMAP(epi.object, reduction = "pca.epi", dims = 1:30,
#                       reduction.name = "umap.epi")
# 
# saveRDS(epi.object, file = "output_16um/RDS-files/epi.subset_object_16um.RDS")



## ----setup, include=FALSE-----------------------------------------------------
if (nzchar(Sys.getenv("CHERRYPIC_R_LIB"))) .libPaths(c(Sys.getenv("CHERRYPIC_R_LIB"), .libPaths()))  # optional custom library

library(Seurat)
library(tidyverse)
library(patchwork)
library(RColorBrewer)

knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)


## ----config-------------------------------------------------------------------
rds_all_clusters <- "../data/final_analysis_object_16um.RDS"
rds_epi          <- "../outputs/epi_subset_16um.RDS"
ann_csv          <- "../data/16um-epithelial-annotations-Aug29-FINAL.csv"
out_dir          <- "../outputs"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

op <- function(f) file.path(out_dir, f)

cluster_col <- "sketch_snn_res.2"   # res-2 cluster IDs, same field in both objects

ann <- read.csv(ann_csv, stringsAsFactors = FALSE)
ann$Cluster <- as.character(ann$Cluster)

region_map    <- setNames(trimws(ann$Spatial.region.annotation), ann$Cluster)
granular_map  <- setNames(trimws(ann$Annotation),                ann$Cluster)
region_colors <- setNames(trimws(ann$Color), trimws(ann$Spatial.region.annotation))
region_colors <- region_colors[!duplicated(names(region_colors))]

cat("Regions in crosswalk:", length(unique(region_map)), "— published Figure 3E has 9\n")


## ----panel_3d_load------------------------------------------------------------
epi.object <- readRDS(rds_epi)
cat("Epithelia subset:", ncol(epi.object), "spots | Reductions:",
    paste(Reductions(epi.object), collapse = ", "), "\n")

cl <- as.character(epi.object@meta.data[[cluster_col]])
epi.object$region_epi_annotation <- unname(region_map[cl])

n_na <- sum(is.na(epi.object$region_epi_annotation))
if (n_na > 0) warning(n_na, " spots have no region mapping — check crosswalk coverage.")

broad_present <- levels(factor(as.character(epi.object$region_epi_annotation)))
cat("Distinct region categories present:", length(broad_present), "— published Figure 3E has 9\n")
print(broad_present)

cols_broad <- if (all(broad_present %in% names(region_colors))) {
  region_colors[broad_present]
} else NULL


## ----panel_3d_plot, fig.width=16, fig.height=12-------------------------------
p_epi_broad <- DimPlot(epi.object, reduction = "umap.epi", group.by = "region_epi_annotation",
                       cols = cols_broad, label = TRUE, label.size = 3, repel = TRUE,
                       raster = TRUE, raster.dpi = c(600, 600), pt.size = 1.5) +
  ggtitle("Figure 3E — epithelial subset (16 µm, res 2)") +
  theme(legend.position = "right", legend.text = element_text(size = 8))

ggsave(op("fig3E_epithelia_umap.pdf"), p_epi_broad, width = 16, height = 12)
p_epi_broad


## ----supporting_epi_granular, fig.width=16, fig.height=12---------------------
epi.object$granular_epi_annotation <- unname(granular_map[cl])

gran_present <- levels(factor(as.character(epi.object$granular_epi_annotation)))
cat("Granular categories present:", length(gran_present), "\n")

p_epi_gran <- DimPlot(epi.object, reduction = "umap.epi", group.by = "granular_epi_annotation",
                      label = TRUE, label.size = 3, repel = TRUE,
                      raster = TRUE, raster.dpi = c(600, 600), pt.size = 1.5) +
  ggtitle("Figure 3E — epithelial subset, granular annotation (16 µm, res 2)") +
  theme(legend.position = "right", legend.text = element_text(size = 7))

ggsave(op("supporting_epithelia_umap_granular.pdf"), p_epi_gran, width = 16, height = 12)
p_epi_gran


## ----supporting_all_clusters, fig.width=11, fig.height=9----------------------
merged.object <- readRDS(rds_all_clusters)
cat("Spots:", ncol(merged.object), "| Reductions:",
    paste(Reductions(merged.object), collapse = ", "), "\n")

cl_all <- as.character(merged.object@meta.data[[cluster_col]])
merged.object$granular_annotation <- unname(granular_map[cl_all])

umap_red <- intersect(c("umap.sketch", "full.umap.sketch", "umap"), Reductions(merged.object))[1]
if (is.na(umap_red)) stop("No UMAP reduction found in the 16 µm object.")

p_umap_all <- DimPlot(merged.object, reduction = umap_red, group.by = "granular_annotation",
                      raster = TRUE, raster.dpi = c(600, 600), pt.size = 1.2, label = FALSE) +
  ggtitle("Spatial clusters (res 2) — 16 µm, all compartments") +
  theme_classic(base_size = 13) +
  theme(legend.text = element_text(size = 7))

ggsave(op("supporting_umap_all_clusters_16um.pdf"), p_umap_all, width = 11, height = 9)
p_umap_all


## ----session_info-------------------------------------------------------------
sessionInfo()

