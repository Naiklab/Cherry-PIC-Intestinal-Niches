#!/usr/bin/env Rscript
# Master script: runs the full pipeline to reproduce all plots
#
# Usage:
#   1. Edit base_dir and input_obj below
#   2. Run: Rscript run_all.R
#
# You can also run individual scripts from the scripts/ directory.
# Each script is self-contained and can be run independently.

# ---- Configuration ----
base_dir   <- "."  # Path to the reproduce_plots/ directory
input_obj  <- "/path/to/DR26001_v2_annotated_seurat_singlets_with_replicates.rds"  # Original Seurat object

# Derived paths
data_dir <- file.path(base_dir, "data")
obj_dir  <- file.path(base_dir, "objects")
fig_dir  <- file.path(base_dir, "figures")
scripts  <- file.path(base_dir, "scripts")
dir.create(fig_dir, showWarnings = FALSE, recursive = TRUE)
dir.create(obj_dir, showWarnings = FALSE, recursive = TRUE)

# ---- Helper: source a script with base_dir and input_obj pre-set ----
run_step <- function(script_name) {
  cat("\n", paste(rep("=", 60), collapse = ""), "\n", sep = "")
  cat("Running:", script_name, "\n")
  cat(paste(rep("=", 60), collapse = ""), "\n")
  source(file.path(scripts, script_name), chdir = FALSE)
}

# ---- Step 1: Filter Mid-villus enterocytes ----
# Skip if filtered object already exists
if (file.exists(file.path(obj_dir, "obj_no_midvillus.rds"))) {
  cat("Skipping step1 (obj_no_midvillus.rds already exists)\n")
} else {
  run_step("step1_filter.R")
}

# ---- Step 2: Harmony-only UMAP + composition ----
# Always runs (regenerates plots from existing embeddings)
run_step("step2_umap_composition.R")

# ---- Step 3: Recompute PCA -> Harmony -> UMAP ----
# Skip if recomputed object already exists
if (file.exists(file.path(obj_dir, "obj_no_midvillus_recomputed.rds"))) {
  cat("Skipping step3 (obj_no_midvillus_recomputed.rds already exists)\n")
} else {
  run_step("step3_recompute.R")
}

# ---- Step 4: Recomputed UMAP + composition ----
# Always runs (regenerates plots from recomputed embeddings)
run_step("step4_umap_comp_recomputed.R")

# ---- Step 5: Build marker panels ----
# Skip if panel CSVs already exist
if (file.exists(file.path(data_dir, "annotation_marker_genes.csv"))) {
  cat("Skipping rebuild_panel_stringent.R (annotation_marker_genes.csv already exists)\n")
} else {
  run_step("rebuild_panel_stringent.R")
}

if (file.exists(file.path(data_dir, "annotation_marker_genes_reduced.csv"))) {
  cat("Skipping build_reduced_panel.R (annotation_marker_genes_reduced.csv already exists)\n")
} else {
  run_step("build_reduced_panel.R")
}

# ---- Step 6: Dot plots ----
run_step("dotplot_final.R")

cat("\n", paste(rep("=", 60), collapse = ""), "\n", sep = "")
cat("All done! Check the figures/ directory for outputs.\n")
cat(paste(rep("=", 60), collapse = ""), "\n")
