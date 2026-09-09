## ----setup, include=FALSE-----------------------------------------------------
for (.p in c("/sc/arion/projects/naiklab/ikjot/R")) if (dir.exists(.p)) .libPaths(c(.p, .libPaths()))

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

