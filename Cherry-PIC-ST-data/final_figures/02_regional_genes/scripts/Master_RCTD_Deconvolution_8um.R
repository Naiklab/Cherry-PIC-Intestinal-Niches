#!/usr/bin/env Rscript
# =============================================================================
# Master RCTD Deconvolution — 8um Visium HD
# Author: Ikjot Sidhu
# Description: Runs RCTD cell-type deconvolution on 8um Visium HD data using
#              the annotated Master single-cell reference
# =============================================================================

# Print start time
cat("\n=============================================================================\n")
cat("MASTER RCTD DECONVOLUTION — 8UM VISIUM HD\n")
cat("=============================================================================\n")
cat("Start time:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

# =============================================================================
# 1. SETUP
# =============================================================================

cat("Setting up environment...\n")

# Library path
if (nzchar(Sys.getenv("CHERRYPIC_R_LIB"))) .libPaths(c(Sys.getenv("CHERRYPIC_R_LIB"), .libPaths()))  # optional custom library

# Load required libraries
suppressPackageStartupMessages({
  library(Seurat)
  library(spacexr)
  library(ggplot2)
  library(patchwork)
  library(dplyr)
  library(tidyr)
  library(pheatmap)
  library(RColorBrewer)
})

cat("Loaded libraries successfully\n")

# Cell type color palette
sc_annot_file <- "single cell seq combined datasets annotation res 1_2 With colors RCTD apr 2nd.csv"
if (!file.exists(sc_annot_file)) stop("Annotation CSV not found: ", sc_annot_file)
sc_annot <- read.csv(sc_annot_file, stringsAsFactors = FALSE)
sc_color_map <- setNames(trimws(sc_annot$Hex.Code), trimws(sc_annot$RCTD.cell.type.name))
sc_color_map <- sc_color_map[!duplicated(names(sc_color_map))]

# Helper: build a named colour vector for any set of cell type names,
# looking each up in sc_color_map and falling back to grey if absent.
ct_color_vec <- function(ct_names) {
  setNames(sapply(ct_names, function(ct) {
    h <- unname(sc_color_map[ct])
    if (!is.na(h) && nchar(trimws(h)) > 0 && trimws(h) != "NA") h else "#808080"
  }), ct_names)
}

# Parallel processing
future::plan("multicore", workers = future::availableCores())
options("future.globals.maxSize" = 2 * 10^12)

# Create output directories
dir.create("output_8um/plots", showWarnings = FALSE, recursive = TRUE)
dir.create("output_8um/tables", showWarnings = FALSE, recursive = TRUE)
dir.create("output_8um/RDS-files", showWarnings = FALSE, recursive = TRUE)

cat("Output directories created\n\n")

# =============================================================================
# 2. LOAD VISIUM HD SEURAT OBJECT
# =============================================================================

cat("Loading clustered Visium HD (8um) Seurat object...\n")

merged.object <- readRDS("output_8um/RDS-files/final_analysis_object.RDS")

cat("Object:", ncol(merged.object), "spots x", nrow(merged.object), "genes\n")
cat("Samples:", paste(unique(merged.object$orig.ident), collapse = ", "), "\n")
cat("Images:", paste(Images(merged.object), collapse = ", "), "\n")

# Identify spatial assay name
assay.name <- grep("^Spatial", names(merged.object@assays), value = TRUE)[1]
cat("Spatial assay:", assay.name, "\n\n")

# =============================================================================
# 3. LOAD MASTER SINGLE-CELL REFERENCE
# =============================================================================

master_path <- "output/master_integration/rds/Master.Obj.rds"
if (!file.exists(master_path)) {
  stop("Master object not found: ", master_path,
       "\nRun Master-dataset-integration.Rmd first.")
}

cat("Loading annotated Master single-cell reference...\n")
Master.Obj <- readRDS(master_path)
cat("Master object:", ncol(Master.Obj), "cells,", nrow(Master.Obj), "genes\n")

# Verify annotation column
if (!"cluster_annotation" %in% colnames(Master.Obj@meta.data)) {
  stop("cluster_annotation column not found in Master.Obj metadata.\n",
       "Run the annotation section in Master-dataset-integration.Rmd first.")
}

cat("\nCell type annotations (res 1.2):\n")
print(table(Master.Obj$cluster_annotation))
cat("\n")

# =============================================================================
# 4. BUILD RCTD REFERENCE
# =============================================================================

cat("Building RCTD reference from Master object...\n")

# ---------------------------------------------------------------------------
# Tissue-specific cell type exclusions
# ---------------------------------------------------------------------------
excl_ileum    <- c("Mid-villus proximal enterocytes", "Mid-villus proximal enterocytes 2")
excl_duodenum <- c("Mid-villus distal enterocytes")

# Use RNA assay raw counts
DefaultAssay(Master.Obj) <- "RNA"
Master.Obj <- JoinLayers(Master.Obj)

ref_counts <- GetAssayData(Master.Obj, assay = "RNA", layer = "counts")
ref_celltypes <- factor(Master.Obj$cluster_annotation)
names(ref_celltypes) <- colnames(Master.Obj)

# Remove cell types with too few cells and special labels
min_cells_per_type <- 25
remove_labels <- c("Unannotated", "Mix cluster remove", "Unidentified", "Unknown")

celltype_counts <- table(ref_celltypes)
valid_celltypes <- names(celltype_counts)[
  celltype_counts >= min_cells_per_type &
  !names(celltype_counts) %in% remove_labels
]

cat("Valid cell types (>=", min_cells_per_type, "cells, excluding special labels):",
    length(valid_celltypes), "\n")

removed <- setdiff(names(celltype_counts), valid_celltypes)
if (length(removed) > 0) {
  cat("Removed cell types:", paste(removed, collapse = ", "), "\n")
}

# Base filter
cells_to_keep <- names(ref_celltypes)[ref_celltypes %in% valid_celltypes]
ref_counts_filt <- ref_counts[, cells_to_keep]
ref_celltypes_filt <- droplevels(ref_celltypes[cells_to_keep])

# Ensure counts are integers
ref_counts_filt <- as(round(ref_counts_filt), "dgCMatrix")

# Sanitize cell type names — RCTD prohibits "/" in cell type labels
levels(ref_celltypes_filt) <- gsub("/", "-", levels(ref_celltypes_filt))

# Helper: build a tissue-specific RCTD Reference after removing extra cell types
build_tissue_ref <- function(rc, ct, extra_remove) {
  ct_keep <- droplevels(ct[!ct %in% extra_remove])
  rc_keep <- rc[, names(ct_keep), drop = FALSE]
  cat("  Excluded:", paste(extra_remove, collapse = ", "), "\n")
  cat("  Cell types remaining:", length(levels(ct_keep)), "\n")
  Reference(counts = rc_keep, cell_types = ct_keep, nUMI = colSums(rc_keep))
}

cat("\nBuilding Ileum reference...\n")
ref_rctd_ileum    <- build_tissue_ref(ref_counts_filt, ref_celltypes_filt, excl_ileum)

cat("Building Duodenum reference...\n")
ref_rctd_duodenum <- build_tissue_ref(ref_counts_filt, ref_celltypes_filt, excl_duodenum)

# Free Master.Obj to save memory
rm(Master.Obj, ref_counts, ref_counts_filt, ref_celltypes, ref_celltypes_filt)
gc()
cat("Memory cleared\n\n")

# =============================================================================
# 5. RUN RCTD PER SAMPLE
# =============================================================================

cat("Running RCTD per sample with Master reference...\n")

merged.object <- JoinLayers(merged.object)

sample_images <- Images(merged.object)
cat("Samples:", paste(sample_images, collapse = ", "), "\n\n")

master_rctd_results <- list()

for (img in sample_images) {
  cat("Processing:", img, "\n")

  # Check if pre-computed result exists — skip if already done
  out_file <- paste0("output_8um/RDS-files/master_rctd_result_", img, ".RDS")
  if (file.exists(out_file)) {
    cat("    Found pre-computed result, loading...\n")
    rctd <- readRDS(out_file)
    master_rctd_results[[img]] <- as.matrix(rctd@results[["weights"]])
    rm(rctd)
    next
  }

  # Get spatial coords and counts for this image
  coords <- GetTissueCoordinates(merged.object, image = img)
  if ("cell" %in% colnames(coords)) {
    rownames(coords) <- coords$cell
  }
  spot_barcodes <- rownames(coords)
  counts <- GetAssayData(merged.object, assay = assay.name,
                         layer = "counts")[, spot_barcodes, drop = FALSE]
  
  # Build coordinate data.frame
  numeric_cols <- colnames(coords)[sapply(coords, is.numeric)]
  coord_df <- data.frame(
    x = as.numeric(coords[[numeric_cols[1]]]),
    y = as.numeric(coords[[numeric_cols[2]]]),
    row.names = rownames(coords)
  )
  
  # Create SpatialRNA object
  spatial_rctd <- SpatialRNA(
    coords = coord_df,
    counts = counts,
    nUMI = colSums(counts)
  )
  
  cat("  Running RCTD for", img, "with", ncol(counts), "spots\n")
  tissue_ref <- if (grepl("Ileum", img, ignore.case = TRUE)) ref_rctd_ileum else ref_rctd_duodenum
  cat("  Reference:", if (grepl("Ileum", img, ignore.case = TRUE)) "Ileum" else "Duodenum", "\n")
  rctd <- create.RCTD(spatial_rctd, tissue_ref, max_cores = 1, UMI_min = 50)
  rctd <- run.RCTD(rctd, doublet_mode = "doublet")
  
  # Save result
  saveRDS(rctd, file = out_file)
  cat("  Saved RCTD result for", img, "\n")
  
  # Store weights
  master_rctd_results[[img]] <- as.matrix(rctd@results[["weights"]])
  
  rm(coords, counts, coord_df, spatial_rctd, rctd)
  gc()
  cat("\n")
}

cat("RCTD completed for all samples\n\n")

# =============================================================================
# 6. COMBINE RESULTS AND ADD TO SEURAT OBJECT
# =============================================================================

cat("Combining RCTD results and adding to Seurat object...\n")

# Align columns across tissue-specific references (fill absent cell types with 0)
all_cts <- unique(unlist(lapply(master_rctd_results, colnames)))
master_rctd_results_filled <- lapply(master_rctd_results, function(m) {
  missing_cts <- setdiff(all_cts, colnames(m))
  if (length(missing_cts) > 0) {
    z <- matrix(0, nrow(m), length(missing_cts),
                dimnames = list(rownames(m), missing_cts))
    m <- cbind(m, z)
  }
  m[, all_cts, drop = FALSE]
})
all_weights <- do.call(rbind, master_rctd_results_filled)
cat("Combined weights:", nrow(all_weights), "spots x", ncol(all_weights), "cell types\n")

# Normalize each spot's weights to sum to 1
weights_norm <- sweep(all_weights, 1, rowSums(all_weights), "/")
weights_norm[is.nan(weights_norm)] <- 0

# Build metadata data.frame with sanitized M_RCTD_ column names
deconv_df <- as.data.frame(weights_norm)
colnames(deconv_df) <- paste0("M_RCTD_", gsub("[^[:alnum:]]", "_", colnames(deconv_df)))

# Safe join: only add rows present in the Seurat object (RCTD may drop low-UMI spots)
common_cells <- intersect(rownames(deconv_df), colnames(merged.object))
cat("Matching spots:", length(common_cells), "of", ncol(merged.object), "total\n")
merged.object <- AddMetaData(merged.object, metadata = deconv_df[common_cells, , drop = FALSE])

# Find dominant cell type for matched spots
dominant_celltype <- apply(weights_norm[common_cells, ], 1, function(x) {
  if (all(is.na(x)) || sum(x, na.rm = TRUE) == 0) return("Unknown")
  gsub("[^[:alnum:]]", "_", colnames(weights_norm)[which.max(x)])
})
merged.object <- AddMetaData(merged.object,
                             metadata = data.frame(M_RCTD_dominant_celltype = dominant_celltype,
                                                   row.names = names(dominant_celltype)))
merged.object@meta.data$M_RCTD_dominant_celltype[
  is.na(merged.object@meta.data$M_RCTD_dominant_celltype)] <- "Unknown"

cat("Added", length(rctd_cols), "cell type proportions to metadata\n")
cat("Added dominant cell type assignments\n\n")

# =============================================================================
# 7. CREATE COLOR PALETTE FOR CELL TYPES
# =============================================================================

cat("Creating color palette for cell types...\n")

celltype_names <- gsub("M_RCTD_", "", rctd_cols)
dominant_celltypes <- unique(merged.object$M_RCTD_dominant_celltype)
dominant_celltypes <- dominant_celltypes[!is.na(dominant_celltypes)]
all_celltypes <- unique(c(celltype_names, dominant_celltypes))
all_celltypes <- all_celltypes[all_celltypes != "Unknown"]
all_celltypes <- sort(all_celltypes)

m_ct_colors <- ct_color_vec(all_celltypes)
m_ct_colors["Unknown"] <- "#D3D3D3"

unmatched <- names(m_ct_colors)[m_ct_colors == "#808080"]
if (length(unmatched) > 0)
  cat("Cell types without palette match (grey fallback):", paste(unmatched, collapse = ", "), "\n")

cat("Color palette created for", length(all_celltypes), "cell types\n\n")

# =============================================================================
# 8. SPATIAL PLOTS - DOMINANT CELL TYPE
# =============================================================================

cat("Generating spatial plots for dominant cell types...\n")

# Combined plot (all samples)
pdf("output_8um/plots/master_deconv_dominant_combined.pdf", width = 24, height = 12)
p_combined <- SpatialDimPlot(merged.object,
                             group.by = "M_RCTD_dominant_celltype",
                             label = FALSE,
                             pt.size.factor = 2.5,
                             cols = m_ct_colors) +
  ggtitle("Master RCTD — Dominant Cell Type (All Samples, 8um)") +
  theme(legend.position = "right", legend.text = element_text(size = 7))
print(p_combined)
dev.off()

# Per-sample plots
for (img in sample_images) {
  pdf(paste0("output_8um/plots/master_deconv_dominant_", gsub("[^[:alnum:]]", "_", img), ".pdf"),
      width = 12, height = 10)
  p <- SpatialDimPlot(merged.object,
                     images = img,
                     group.by = "M_RCTD_dominant_celltype",
                     label = FALSE,
                     pt.size.factor = 2.5,
                     cols = m_ct_colors) +
    ggtitle(paste("Master RCTD — Dominant Cell Type —", img, "(8um)")) +
    theme(legend.position = "right", legend.text = element_text(size = 7))
  print(p)
  dev.off()
}

cat("Spatial dominant cell type plots saved\n\n")

# =============================================================================
# 9. SPATIAL PLOTS - PROPORTION MAPS
# =============================================================================

cat("Generating spatial proportion maps for each cell type...\n")

m_rctd_cols <- grep("^M_RCTD_", colnames(merged.object@meta.data), value = TRUE)
m_rctd_cols <- m_rctd_cols[m_rctd_cols != "M_RCTD_dominant_celltype"]

for (celltype_col in m_rctd_cols) {
  celltype_name <- gsub("M_RCTD_", "", celltype_col)
  
  for (img in sample_images) {
    pdf(paste0("output_8um/plots/master_deconv_proportion_", 
               gsub("[^[:alnum:]]", "_", celltype_name), "_",
               gsub("[^[:alnum:]]", "_", img), ".pdf"),
        width = 10, height = 10)
    
    p <- SpatialFeaturePlot(merged.object,
                           images = img,
                           features = celltype_col,
                           pt.size.factor = 2.5) +
      ggtitle(paste("Master RCTD —", celltype_name, "Proportion —", img, "(8um)")) +
      scale_fill_gradientn(colors = c("lightgray", "yellow", "red", "darkred"),
                          limits = c(0, 1),
                          name = "Proportion")
    print(p)
    dev.off()
  }
}

cat("Spatial proportion maps saved\n\n")

# =============================================================================
# 10. HEATMAPS
# =============================================================================

cat("Generating heatmaps...\n")

# Cluster-level resolution (res = 2)
cluster_col <- "sketch_snn_res.2"

if (cluster_col %in% colnames(merged.object@meta.data)) {
  cluster_deconv <- merged.object@meta.data %>%
    filter(!is.na(.data[[cluster_col]])) %>%
    select(all_of(cluster_col), all_of(m_rctd_cols)) %>%
    group_by(.data[[cluster_col]]) %>%
    summarise(across(everything(), ~mean(.x, na.rm = TRUE)), .groups = "drop")
  
  numeric_rctd_cols <- m_rctd_cols[m_rctd_cols != "M_RCTD_spot_class"]
  cluster_mat <- cluster_deconv %>%
    select(all_of(numeric_rctd_cols)) %>%
    as.matrix()
  rownames(cluster_mat) <- cluster_deconv[[cluster_col]]
  colnames(cluster_mat) <- gsub("M_RCTD_", "", colnames(cluster_mat))
  cluster_mat[is.nan(cluster_mat)] <- NA
  cluster_mat <- cluster_mat[, colSums(!is.na(cluster_mat)) > 0, drop = FALSE]
  cluster_mat <- cluster_mat[rowSums(!is.na(cluster_mat)) > 0, , drop = FALSE]

  write.csv(cluster_deconv,
            "output_8um/tables/master_deconv_by_cluster.csv", row.names = FALSE)

  pdf("output_8um/plots/master_deconv_heatmap_cluster_res2.pdf", height = 12, width = 14)
  pheatmap(t(cluster_mat),
           na_col = "grey90",
           cluster_rows = TRUE, cluster_cols = TRUE,
           scale = "none",
           color = colorRampPalette(c("white", "mediumpurple", "purple4"))(100),
           main = "Master RCTD — Cell Type Proportions by Cluster (res 2, 8um)",
           fontsize_row = 9, fontsize_col = 10, border_color = NA)
  dev.off()
}

# Sample-level
sample_deconv <- merged.object@meta.data %>%
  select(orig.ident, all_of(m_rctd_cols)) %>%
  group_by(orig.ident) %>%
  summarise(across(everything(), ~mean(.x, na.rm = TRUE)), .groups = "drop")

sample_mat <- as.matrix(sample_deconv[, -1])
rownames(sample_mat) <- sample_deconv$orig.ident
colnames(sample_mat) <- gsub("M_RCTD_", "", colnames(sample_mat))
sample_mat[is.nan(sample_mat)] <- NA
sample_mat <- sample_mat[, colSums(!is.na(sample_mat)) > 0, drop = FALSE]
sample_mat <- sample_mat[rowSums(!is.na(sample_mat)) > 0, , drop = FALSE]

write.csv(sample_deconv,
          "output_8um/tables/master_deconv_by_sample.csv", row.names = FALSE)

pdf("output_8um/plots/master_deconv_heatmap_sample.pdf", height = 12, width = 14)
pheatmap(t(sample_mat),
         na_col = "grey90",
         cluster_rows = TRUE, cluster_cols = TRUE,
         scale = "none",
         color = colorRampPalette(c("white", "mediumpurple", "purple4"))(100),
         main = "Master RCTD — Cell Type Proportions by Sample (8um)",
         fontsize_row = 9, fontsize_col = 12, border_color = NA)
dev.off()

cat("Heatmaps saved\n\n")

# =============================================================================
# 11. BAR PLOTS
# =============================================================================

cat("Generating bar plots...\n")

# By sample
bar_sample <- merged.object@meta.data %>%
  select(orig.ident, all_of(m_rctd_cols)) %>%
  group_by(orig.ident) %>%
  summarise(across(everything(), ~mean(.x, na.rm = TRUE)), .groups = "drop") %>%
  pivot_longer(-orig.ident, names_to = "celltype", values_to = "proportion")
bar_sample$celltype <- gsub("M_RCTD_", "", bar_sample$celltype)

p_bar_sample <- ggplot(bar_sample,
                       aes(x = orig.ident, y = proportion, fill = celltype)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = m_ct_colors) +
  theme_classic() +
  labs(title = "Master RCTD — Mean Cell Type Proportions by Sample (8um)",
       x = "Sample", y = "Proportion", fill = "Cell Type") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "right", legend.text = element_text(size = 7))

ggsave("output_8um/plots/master_deconv_barplot_by_sample.pdf",
       plot = p_bar_sample, height = 10, width = 14)

# By cluster
if (cluster_col %in% colnames(merged.object@meta.data)) {
  bar_cluster <- merged.object@meta.data %>%
    filter(!is.na(.data[[cluster_col]])) %>%
    select(all_of(cluster_col), all_of(m_rctd_cols)) %>%
    group_by(.data[[cluster_col]]) %>%
    summarise(across(everything(), ~mean(.x, na.rm = TRUE)), .groups = "drop") %>%
    pivot_longer(-all_of(cluster_col), names_to = "celltype", values_to = "proportion")
  bar_cluster$celltype <- gsub("M_RCTD_", "", bar_cluster$celltype)
  
  p_bar_cluster <- ggplot(bar_cluster,
                          aes(x = factor(.data[[cluster_col]]),
                              y = proportion, fill = celltype)) +
    geom_bar(stat = "identity", position = "stack") +
    scale_fill_manual(values = m_ct_colors) +
    theme_classic() +
    labs(title = "Master RCTD — Mean Cell Type Proportions by Cluster (res 2, 8um)",
         x = "Cluster", y = "Proportion", fill = "Cell Type") +
    theme(axis.text.x = element_text(size = 9),
          legend.position = "right", legend.text = element_text(size = 7))
  
  ggsave("output_8um/plots/master_deconv_barplot_by_cluster.pdf",
         plot = p_bar_cluster, height = 10, width = 16)
}

cat("Bar plots saved\n\n")

# =============================================================================
# 12. BAR PLOTS BY ANNOTATIONS
# =============================================================================

cat("Generating bar plots by annotations...\n")

annotation_cols <- c("cluster_annotation", "region_annotation",
                     "location_annotation", "celltype_annotation")
available_annots <- annotation_cols[annotation_cols %in% colnames(merged.object@meta.data)]

for (annot_col in available_annots) {
  annot_values <- merged.object@meta.data[[annot_col]]
  if (all(is.na(annot_values))) next

  title_annot <- gsub("_", " ",
                       tools::toTitleCase(gsub("_annotation", "", annot_col)))

  # Mean proportions
  mean_df <- merged.object@meta.data %>%
    filter(!is.na(.data[[annot_col]])) %>%
    select(all_of(annot_col), all_of(m_rctd_cols)) %>%
    group_by(.data[[annot_col]]) %>%
    summarise(across(everything(), ~mean(.x, na.rm = TRUE)), .groups = "drop") %>%
    pivot_longer(-all_of(annot_col), names_to = "celltype", values_to = "proportion")
  mean_df$celltype <- gsub("M_RCTD_", "", mean_df$celltype)

  p_mean <- ggplot(mean_df,
                   aes(x = .data[[annot_col]], y = proportion, fill = celltype)) +
    geom_bar(stat = "identity", position = "stack") +
    scale_fill_manual(values = m_ct_colors) +
    theme_classic() +
    labs(title = paste("Master RCTD — Proportions by", title_annot, "(8um)"),
         x = title_annot, y = "Mean Proportion", fill = "Cell Type") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1),
          legend.text = element_text(size = 7))

  # Normalized bar plot
  p_norm <- ggplot(mean_df,
                   aes(x = .data[[annot_col]], y = proportion, fill = celltype)) +
    geom_bar(stat = "identity", position = "fill") +
    scale_fill_manual(values = m_ct_colors) +
    scale_y_continuous(labels = scales::percent) +
    theme_classic() +
    labs(title = paste("Master RCTD — Composition by", title_annot, "(%, 8um)"),
         x = title_annot, y = "Percentage", fill = "Cell Type") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1),
          legend.text = element_text(size = 7))

  # Dominant cell type
  dom_df <- merged.object@meta.data %>%
    filter(!is.na(.data[[annot_col]]) & !is.na(M_RCTD_dominant_celltype)) %>%
    count(.data[[annot_col]], M_RCTD_dominant_celltype) %>%
    group_by(.data[[annot_col]]) %>%
    mutate(pct = n / sum(n) * 100)

  p_dom <- ggplot(dom_df,
                  aes(x = .data[[annot_col]], y = pct,
                      fill = M_RCTD_dominant_celltype)) +
    geom_bar(stat = "identity", position = "stack") +
    scale_fill_manual(values = m_ct_colors) +
    theme_classic() +
    labs(title = paste("Master RCTD — Dominant Cell Type by", title_annot, "(8um)"),
         x = title_annot, y = "%", fill = "Dominant") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1),
          legend.text = element_text(size = 7))

  combined <- (p_mean | p_norm) / p_dom +
    plot_layout(heights = c(1, 1)) +
    plot_annotation(title = paste("Master RCTD Deconvolution by",
                                  title_annot, "(8um)"))

  ggsave(paste0("output_8um/plots/master_deconv_barplot_by_", annot_col, ".pdf"),
         plot = combined, height = 14, width = 18)

  # Save summary table
  mean_wide <- mean_df %>%
    pivot_wider(names_from = celltype, values_from = proportion)
  write.csv(mean_wide,
            paste0("output_8um/tables/master_deconv_proportions_by_",
                   annot_col, ".csv"),
            row.names = FALSE)

  cat("  Saved:", annot_col, "\n")
}

cat("\n")

# =============================================================================
# 13. DOMINANT CELL TYPE SUMMARY
# =============================================================================

cat("Generating dominant cell type summary...\n")

# Overall summary
dom_summary <- merged.object@meta.data %>%
  count(M_RCTD_dominant_celltype) %>%
  mutate(pct = n / sum(n) * 100) %>%
  arrange(desc(n))

print(dom_summary)
write.csv(dom_summary,
          "output_8um/tables/master_deconv_dominant_summary.csv", row.names = FALSE)

# Dominant by sample
dom_by_sample <- merged.object@meta.data %>%
  count(orig.ident, M_RCTD_dominant_celltype) %>%
  group_by(orig.ident) %>%
  mutate(pct = n / sum(n) * 100)

p_dom_sample <- ggplot(dom_by_sample,
                       aes(x = orig.ident, y = pct,
                           fill = M_RCTD_dominant_celltype)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = m_ct_colors) +
  theme_classic() +
  labs(title = "Master RCTD — Dominant Cell Type Distribution by Sample (8um)",
       x = "Sample", y = "%", fill = "Dominant Cell Type") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.text = element_text(size = 7))

ggsave("output_8um/plots/master_deconv_dominant_by_sample.pdf",
       plot = p_dom_sample, height = 10, width = 14)

cat("Dominant cell type summary saved\n\n")

# =============================================================================
# 14. SAVE FINAL OBJECT
# =============================================================================

cat("Saving final Seurat object with deconvolution results...\n")

saveRDS(merged.object,
        file = "output_8um/RDS-files/final_analysis_object_with_master_deconv.RDS")

cat("Saved to: output_8um/RDS-files/final_analysis_object_with_master_deconv.RDS\n\n")

# =============================================================================
# COMPLETION
# =============================================================================

cat("=============================================================================\n")
cat("MASTER RCTD DECONVOLUTION COMPLETE (8UM)\n")
cat("=============================================================================\n")
cat("End time:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
cat("\nOutputs:\n")
cat("  Plots:  output_8um/plots/master_deconv_*.pdf\n")
cat("  Tables: output_8um/tables/master_deconv_*.csv\n")
cat("  Object: output_8um/RDS-files/final_analysis_object_with_master_deconv.RDS\n")
cat("=============================================================================\n")
