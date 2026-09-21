#!/usr/bin/env Rscript
# Step 3: Recompute full pipeline on filtered object (Mid-villus removed)
# FindVariableFeatures -> ScaleData -> PCA -> Harmony -> UMAP
# Input:  objects/obj_no_midvillus.rds
# Output: objects/obj_no_midvillus_recomputed.rds

suppressMessages({
  library(Seurat)
  library(harmony)
})

# ---- Configuration ----
base_dir <- "."  # Path to the reproduce_plots/ directory

# Derived paths (do not edit below)
obj_dir <- file.path(base_dir, "objects")

cat("Loading filtered object...\n")
obj <- readRDS(file.path(obj_dir, "obj_no_midvillus.rds"))

# Check existing SCT status
cat("Assays:", paste(names(obj@assays), collapse=", "), "\n")
cat("Cells:", ncol(obj), "\n")
cat("VariableFeatures:", length(VariableFeatures(obj)), "\n")

# Use SCT assay for the pipeline (matching original workflow)
DefaultAssay(obj) <- "SCT"

# Step 1: FindVariableFeatures on SCT
cat("\n--- FindVariableFeatures ---\n")
obj <- FindVariableFeatures(obj, assay = "SCT", nfeatures = 3000, verbose = FALSE)
cat("VariableFeatures:", length(VariableFeatures(obj)), "\n")

# Step 2: ScaleData on SCT
cat("\n--- ScaleData ---\n")
obj <- ScaleData(obj, assay = "SCT", verbose = FALSE)
cat("Done.\n")

# Step 3: PCA on SCT
cat("\n--- PCA ---\n")
obj <- RunPCA(obj, assay = "SCT", npcs = 50, verbose = FALSE)
cat("PCA dims:", dim(Embeddings(obj, "pca")), "\n")

# Step 4: Harmony integration (using orig.ident as batch variable)
cat("\n--- Harmony ---\n")
obj <- RunHarmony(obj, group.by.vars = "orig.ident", reduction.use = "pca", verbose = FALSE)
cat("Harmony dims:", dim(Embeddings(obj, "harmony")), "\n")

# Step 5: UMAP on Harmony
cat("\n--- UMAP ---\n")
obj <- RunUMAP(obj, reduction = "harmony", dims = 1:30, verbose = FALSE)
cat("UMAP dims:", dim(Embeddings(obj, "umap")), "\n")

# Save recomputed object
out_path <- file.path(obj_dir, "obj_no_midvillus_recomputed.rds")
saveRDS(obj, out_path)
cat("\nSaved:", out_path, "\n")
cat("Done.\n")
