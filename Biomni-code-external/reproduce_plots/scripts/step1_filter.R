#!/usr/bin/env Rscript
# Step 1: Filter object — remove Mid-villus enterocytes, save subset
# Input:  Original Seurat object + corrected broad_cell_type labels
# Output: objects/obj_no_midvillus.rds (filtered, Harmony-only embeddings preserved)

suppressMessages(library(Seurat))

# ---- Configuration ----
base_dir   <- "."  # Path to the reproduce_plots/ directory
input_obj  <- "/path/to/DR26001_v2_annotated_seurat_singlets_with_replicates.rds"  # Original Seurat object

# Derived paths (do not edit below)
data_dir <- file.path(base_dir, "data")
obj_dir  <- file.path(base_dir, "objects")
dir.create(obj_dir, showWarnings = FALSE, recursive = TRUE)

cat("Loading Seurat object...\n")
obj <- readRDS(input_obj)

# Apply corrected annotations
corrected_bct <- readRDS(file.path(data_dir, "corrected_broad_cell_type.rds"))
corrected_bct[corrected_bct == "Brunner gland-like epithelial cells"] <- "Mid-villus enterocytes"
obj@meta.data$broad_cell_type <- corrected_bct

cat("Before removal:", ncol(obj), "cells\n")
cat("Mid-villus enterocytes:", sum(obj@meta.data$broad_cell_type == "Mid-villus enterocytes"), "\n")

# Subset: remove Mid-villus enterocytes
obj_filt <- subset(obj, subset = broad_cell_type != "Mid-villus enterocytes")
cat("After removal:", ncol(obj_filt), "cells\n")
cat("Cell types remaining:", length(unique(obj_filt@meta.data$broad_cell_type)), "\n")
print(table(obj_filt@meta.data$broad_cell_type))

# Save filtered object
out_path <- file.path(obj_dir, "obj_no_midvillus.rds")
saveRDS(obj_filt, out_path)
cat("Saved:", out_path, "\n")
