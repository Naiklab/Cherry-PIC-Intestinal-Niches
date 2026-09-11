## ----setup, include=FALSE-----------------------------------------------------
if (nzchar(Sys.getenv("CHERRYPIC_R_LIB"))) .libPaths(c(Sys.getenv("CHERRYPIC_R_LIB"), .libPaths()))  # optional custom library
library(Seurat)
library(tidyverse)   # whole tidyverse, never individual sub-packages
library(patchwork)
library(viridis)
library(readxl)
library(png)          # readPNG() for the hi-res raster swap
knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)
set.seed(42)


## ----pipeline-provenance, child='Preprocessing_RCTD_StemNiche_final.Rmd'------

## ----stage1-niche-zones, eval=FALSE-------------------------------------------
# # Distance to the nearest stem-cell-dominant bin, then zone assignment. The niche is
# # the stem-cell bins plus their immediate periphery: within 3 bin widths (≤ 24 µm).
# # classify_niche_zone() is defined in Preprocessing_VisiumHD_8um_final.Rmd, Stage 7.
# # Per sample, verbatim from Preprocessing_VisiumHD_8um_final.Rmd, Stage 7.
# # Result levels: Stem_cell | Immediate_periphery | Outside_niche | No_tissue
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
# saveRDS(merged.object, "output_8um/RDS-files/final_analysis_object_8um_with_stem_niche.RDS")


## ----stage2-rctd, eval=FALSE--------------------------------------------------
# merged.object <- readRDS("output_8um/RDS-files/final_analysis_object_8um_with_stem_niche.RDS")
# niche_object  <- merged.object[, !is.na(merged.object$stem_niche_zone) &
#                                   merged.object$stem_niche_zone %in%
#                                   c("Stem_cell", "Immediate_periphery")]
# assay.name <- grep("^Spatial", names(niche_object@assays), value = TRUE)[1]
# 
# sc_ref <- readRDS("outputs/DR26001_v2_annotated_seurat_singlets.rds")
# 
# REMOVE_LABELS <- c("Unknown", "Unassigned", "Doublet",
#                    "High-mitochondrial/low-quality cells",
#                    "Low-confidence sparse-marker myeloid-like cells",
#                    "Transcriptionally diffuse low-confidence cells",
#                    "Mid-villus enterocytes", "Mid villus enterocyte-2",
#                    "Regenerative Brunners gland-like epithelial cells")
# MIN_CELLS_PER_CT <- 25
# 
# ref_counts    <- GetAssayData(sc_ref, layer = "counts")
# ref_celltypes <- factor(sc_ref$cell_type)
# ct_table  <- table(ref_celltypes)
# valid_cts <- names(ct_table)[ct_table >= MIN_CELLS_PER_CT & !names(ct_table) %in% REMOVE_LABELS]
# 
# # Subset counts and cell_types to the SAME cells — Reference() requires both to have
# # the same number of columns; the counts matrix must not be left at full size.
# cells_keep         <- names(ref_celltypes)[ref_celltypes %in% valid_cts]
# ref_counts_filt    <- as(round(ref_counts[, cells_keep]), "dgCMatrix")   # SCT counts can be non-integer
# ref_celltypes_filt <- droplevels(ref_celltypes[cells_keep])
# levels(ref_celltypes_filt) <- gsub("/", "-", levels(ref_celltypes_filt))  # RCTD prohibits "/"
# 
# ref_rctd <- Reference(counts = ref_counts_filt, cell_types = ref_celltypes_filt,
#                       nUMI = colSums(ref_counts_filt))
# 
# # Per sample: build SpatialRNA from that image's own coordinates and counts, run RCTD,
# # and keep the weights matrix and spot_class vector for the merge step below.
# rctd_results <- list(); rctd_spotclass <- list()
# for (img in Images(niche_object)) {
#   coords <- GetTissueCoordinates(niche_object, image = img)
#   if ("cell" %in% colnames(coords)) rownames(coords) <- coords$cell
#   spot_barcodes <- rownames(coords)
#   counts <- GetAssayData(niche_object, assay = assay.name, layer = "counts")[, spot_barcodes, drop = FALSE]
#   numeric_cols <- colnames(coords)[sapply(coords, is.numeric)]
#   coord_df <- data.frame(x = as.numeric(coords[[numeric_cols[1]]]),
#                          y = as.numeric(coords[[numeric_cols[2]]]),
#                          row.names = rownames(coords))
# 
#   spatial_rctd <- SpatialRNA(coords = coord_df, counts = counts, nUMI = colSums(counts))
#   rctd <- create.RCTD(spatial_rctd, ref_rctd, max_cores = 1, UMI_min = 50)
#   rctd <- run.RCTD(rctd, doublet_mode = "doublet")
#   saveRDS(rctd, paste0("rctd_niche_result_", img, ".RDS"))
# 
#   rctd_results[[img]]   <- as.matrix(rctd@results[["weights"]])
#   rctd_spotclass[[img]] <- setNames(as.character(rctd@results[["results_df"]][["spot_class"]]),
#                                     rownames(rctd@results[["results_df"]]))
#   rm(rctd); gc()
# }
# 
# # Merge per-sample weights: align columns across samples (absent cell types filled 0),
# # rbind, row-normalise, and write DR_RCTD_<celltype> proportion columns plus
# # DR_RCTD_dominant_celltype and DR_RCTD_spot_class.
# all_cts <- unique(unlist(lapply(rctd_results, colnames)))
# rctd_results_filled <- lapply(rctd_results, function(m) {
#   missing <- setdiff(all_cts, colnames(m))
#   if (length(missing) > 0) {
#     z <- matrix(0, nrow(m), length(missing), dimnames = list(rownames(m), missing))
#     m <- cbind(m, z)
#   }
#   m[, all_cts, drop = FALSE]
# })
# combined_weights <- do.call(rbind, rctd_results_filled)
# weights_norm <- sweep(combined_weights, 1, rowSums(combined_weights), "/")
# weights_norm[is.nan(weights_norm)] <- 0
# 
# deconv_df <- as.data.frame(weights_norm)
# colnames(deconv_df) <- paste0("DR_RCTD_", gsub("[^[:alnum:]]", "_", colnames(deconv_df)))
# common_cells <- intersect(rownames(deconv_df), colnames(niche_object))
# niche_object <- AddMetaData(niche_object, metadata = deconv_df[common_cells, , drop = FALSE])
# 
# dominant_ct <- apply(weights_norm[common_cells, ], 1, function(x) {
#   if (all(is.na(x)) || sum(x) == 0) return("Unknown")
#   gsub("[^[:alnum:]]", "_", gsub("/", "-", colnames(weights_norm)[which.max(x)]))
# })
# niche_object <- AddMetaData(niche_object,
#   metadata = data.frame(DR_RCTD_dominant_celltype = dominant_ct, row.names = names(dominant_ct)))
# niche_object@meta.data$DR_RCTD_dominant_celltype[
#   is.na(niche_object@meta.data$DR_RCTD_dominant_celltype)] <- "Unknown"
# 
# sc_names <- unlist(lapply(unname(rctd_spotclass), names))
# sc_vals  <- unlist(lapply(unname(rctd_spotclass), as.character), use.names = FALSE)
# sc_matched <- setNames(sc_vals, sc_names)[match(common_cells, sc_names)]
# names(sc_matched) <- common_cells
# niche_object <- AddMetaData(niche_object,
#   metadata = data.frame(DR_RCTD_spot_class = sc_matched, row.names = common_cells))
# 
# saveRDS(niche_object, "outputs/RCTD/8um_stem_niche/RDS-files/niche_object_8um_with_DR_RCTD.RDS")


## ----stage3-hires-swap, eval=FALSE--------------------------------------------
# # For each image slot (e.g. "Duodenum.3.008um"), replace the low-res raster with
# # Space Ranger's tissue_hires_image.png and point scale.factors$lowres at the
# # hi-res value, so pt.size.factor-based plotting calls need no changes.
# img <- niche_object@images[[slot_name]]
# img@image <- png::readPNG(hires_png_path)
# img@scale.factors$lowres <- img@scale.factors$hires
# niche_object@images[[slot_name]] <- img



## ----config-------------------------------------------------------------------
# ---- Frozen inputs (relative paths — this folder is self-contained) --------
niche_obj    <- "../data/niche_object_8um_with_DR_RCTD.RDS"
ann_xlsx     <- "../data/New qc resolution 1 annotation  broad annotation and colors July07.xlsx"
ct_order_xlsx <- "../data/Cluster order for bar plot 061726.xlsx"
raw_data_dir <- "../data/rawdata"   # local copy of the 4 hi-res tissue PNGs
out_dir      <- "../outputs"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Map each SAMPLE FOLDER to its slice/image name (same as
# Swap_LowRes_to_HiRes_Images.Rmd / 14_RCTD_HiRes_Plots_StemNiche_8um.Rmd).
image.names <- list(
  "SHNA03_D3-7um_0_v1" = "Duodenum-3",
  "SHNA03_D4-7um_0_v1" = "Duodenum-4",
  "SHNA03_I2-7um_0_v1" = "Ileum-2",
  "SHNA03_I3-7um_0_v1" = "Ileum-3"
)
slot_to_folder <- setNames(names(image.names), make.names(unlist(image.names)))
print(slot_to_folder)

hires.image.name <- "tissue_hires_image.png"
bin_um <- 8L

# RCTD/Seurat metadata column names cannot contain spaces, "/", "+", etc., so
# the same sanitization used when notebook 04 built DR_RCTD_* columns must be
# applied to the raw annotation strings before they can be used as lookup keys.
sanitize <- function(x) gsub("[^[:alnum:]]", "_", gsub("/", "-", x))

# ---- Published-replicate routing -------------------------------------------
# Duodenum_3 and Ileum_3 are the published Fig 6D/6E replicates, project-wide.
# Duodenum_4 and Ileum_2 are the second biological replicate: real data, not a
# printed panel, so they are written as supporting_ rather than fig6D_/fig6E_.
image_prefix <- c(
  "Duodenum.3.008um" = "fig6D_",
  "Duodenum.4.008um" = "supporting_",
  "Ileum.2.008um"    = "supporting_",
  "Ileum.3.008um"    = "fig6E_"
)

cat("Output directory:", out_dir, "\n")


## ----load_colors--------------------------------------------------------------
ann_df <- read_excel(ann_xlsx)

# Fine-grained (`cell_type`) palette — notebook 04 built its RCTD reference
# from cell_type, so DR_RCTD_* names must be matched against this.
ct_color_df <- ann_df[!duplicated(ann_df$Annotation), ]
cell_type_colors_san <- setNames(
  ifelse(ct_color_df$`Hex color` == "Remove" | is.na(ct_color_df$`Hex color`),
         "#BEBEBE", paste0("#", ct_color_df$`Hex color`)),
  sanitize(ct_color_df$Annotation)
)

ct_order_df  <- read_excel(ct_order_xlsx)
ct_order_raw <- unique(ct_order_df$Annotation[!is.na(ct_order_df$Annotation)])

cat("Fine cell-type colors loaded:", length(cell_type_colors_san), "\n")


## ----load_rctd----------------------------------------------------------------
cat("Loading frozen niche RCTD result (fine cell_type reference)...\n")
niche_object <- readRDS(niche_obj)
cat("Object:", ncol(niche_object), "spots x", nrow(niche_object), "genes\n")
sample_images <- Images(niche_object)
cat("Images:", paste(sample_images, collapse = ", "), "\n")


## ----hires_swap---------------------------------------------------------------
read_hires_raster <- function(folder, bin_um, data.dir, image.name) {
  spatial.dir <- file.path(data.dir, folder, "binned_outputs",
                           sprintf("square_%03dum", bin_um), "spatial")
  png.path <- file.path(spatial.dir, image.name)
  if (!file.exists(png.path)) stop("Hi-res image not found: ", png.path)
  message("    reading ", png.path)
  readPNG(png.path)
}

for (nm in sample_images) {
  message("processing image slot: ", nm)
  key <- sub("\\.0[0-9]+um$", "", nm)   # "Duodenum.3.008um" -> "Duodenum.3"
  if (!key %in% names(slot_to_folder)) stop("No folder mapping for image slot '", nm, "'.")
  folder <- slot_to_folder[[key]]

  img <- niche_object@images[[nm]]
  stopifnot("image" %in% slotNames(img), "scale.factors" %in% slotNames(img))
  old_dim <- dim(img@image)

  img@image <- read_hires_raster(folder, bin_um, raw_data_dir, hires.image.name)

  sf <- img@scale.factors
  sf$lowres <- sf$hires   # default SpatialPlot(image.scale="lowres") now renders hi-res
  img@scale.factors <- sf

  niche_object@images[[nm]] <- img
  message("  raster ", paste(old_dim[1:2], collapse = "x"),
          " -> ", paste(dim(img@image)[1:2], collapse = "x"))
}
cat("Hi-res image swap complete.\n")


## ----color_setup--------------------------------------------------------------
dr_rctd_cols <- grep("^DR_RCTD_", colnames(niche_object@meta.data), value = TRUE)
dr_rctd_cols <- dr_rctd_cols[!dr_rctd_cols %in%
                               c("DR_RCTD_dominant_celltype", "DR_RCTD_spot_class")]

PLOT_EXCLUDE <- paste0("DR_RCTD_", c(
  "Transcriptionally_diffuse_low_confidence_cells",
  "High_mitochondrial_low_quality_cells",
  "Low_confidence_sparse_marker_myeloid_like_cells"
))
dr_rctd_cols <- dr_rctd_cols[!dr_rctd_cols %in% PLOT_EXCLUDE]

ct_order_cols <- paste0("DR_RCTD_", sanitize(ct_order_raw))
dr_rctd_cols  <- c(intersect(ct_order_cols, dr_rctd_cols),
                   setdiff(dr_rctd_cols, ct_order_cols))

ct_names     <- gsub("^DR_RCTD_", "", dr_rctd_cols)
dom_cts      <- unique(na.omit(niche_object$DR_RCTD_dominant_celltype))
all_cts_plot <- unique(c(ct_names, dom_cts))
all_cts_plot <- all_cts_plot[all_cts_plot != "Unknown"]

ct_colors <- ifelse(all_cts_plot %in% names(cell_type_colors_san),
                     cell_type_colors_san[all_cts_plot], "#808080")
names(ct_colors) <- all_cts_plot
ct_colors["Unknown"] <- "#D3D3D3"

cat("Colors assigned:", length(ct_colors), "\n")
cat("Proportion columns:", length(dr_rctd_cols), "\n")


## ----spatial_dominant, fig.show='hide'----------------------------------------
for (img in sample_images) {
  p <- SpatialDimPlot(niche_object, images = img, group.by = "DR_RCTD_dominant_celltype",
                      label = FALSE, pt.size.factor = 1.25, cols = ct_colors) +
    ggtitle(paste0("Cherry-PIC sorted niches — Dominant Cell Type (", img, ")")) +
    theme(legend.position = "right", legend.text = element_text(size = 7))

  prefix <- image_prefix[[img]]
  ggsave(file.path(out_dir, paste0(prefix, "dominant_celltype_", gsub("\\.", "_", img), ".pdf")),
         plot = p, height = 12, width = 14)
  cat("  Saved (", prefix, "):", img, "\n")
}


## ----spatial_proportions, fig.show='hide'-------------------------------------
for (col in dr_rctd_cols) {
  ct_name <- gsub("^DR_RCTD_", "", col)
  cmax <- max(niche_object@meta.data[[col]], na.rm = TRUE)
  for (img in sample_images) {
    p <- SpatialFeaturePlot(niche_object, features = col, images = img, pt.size.factor = 1.25) +
      scale_fill_gradientn(colors = viridis::viridis(100),
                           limits = c(0, cmax), na.value = "grey90") +
      ggtitle(paste0(ct_name, " — ", img)) +
      theme(legend.position = "right")

    ggsave(file.path(out_dir, paste0("supporting_proportion_",
                                     gsub("[^[:alnum:]]", "_", ct_name), "_",
                                     gsub("\\.", "_", img), ".pdf")),
           plot = p, height = 10, width = 12)
  }
  cat("  Saved:", ct_name, "\n")
}
cat("All hi-res deconvolution plots written to", out_dir, "\n")


## ----session_info-------------------------------------------------------------
sessionInfo()

