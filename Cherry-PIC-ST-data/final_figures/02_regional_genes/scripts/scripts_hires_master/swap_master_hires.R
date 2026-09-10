#!/usr/bin/env Rscript
# =============================================================================
# Swap low-res -> hi-res Space Ranger images in the two OLD (master/granular)
# 8um objects, writing NEW *_hires.RDS files. Mirrors Swap_LowRes_to_HiRes_Images.Rmd.
# =============================================================================

if (nzchar(Sys.getenv("CHERRYPIC_R_LIB"))) .libPaths(c(Sys.getenv("CHERRYPIC_R_LIB"), .libPaths()))  # optional custom library
library(tidyverse)                                  # whole tidyverse only
library(Seurat)                                     # spatial object handling (v5)
library(png)                                        # readPNG() — same reader Seurat uses

# ---- Configuration ----------------------------------------------------------
# Space Ranger output root, one folder per sample.
data.dir <- Sys.getenv("CHERRYPIC_RAWDATA", "rawdata")

# Sample folder -> slice/image name (make.names() dotting matches merged slots)
image.names <- list(
  "SHNA03_D3-7um_0_v1" = "Duodenum-3",
  "SHNA03_D4-7um_0_v1" = "Duodenum-4",
  "SHNA03_I2-7um_0_v1" = "Ileum-2",
  "SHNA03_I3-7um_0_v1" = "Ileum-3"
)
slot_to_folder <- setNames(names(image.names), make.names(unlist(image.names)))

hires.image.name <- "tissue_hires_image.png"

# Only the two master/granular 8um objects (bin = 8um).
jobs <- tibble::tribble(
  ~label,                    ~rds_in,                                                              ~rds_out,                                                                     ~bin_um,
  "8um master deconv",       "output_8um/RDS-files/final_analysis_object_with_master_deconv.RDS",  "output_8um/RDS-files/final_analysis_object_with_master_deconv_hires.RDS",     8L,
  "8um master stem niche",   "output_8um/RDS-files/final_analysis_object_8um_with_stem_niche.RDS", "output_8um/RDS-files/final_analysis_object_8um_with_stem_niche_hires.RDS",    8L
)

# ---- Helpers (identical logic to the notebook) ------------------------------
read_hires_raster <- function(folder, bin_um, data.dir, image.name) {
  spatial.dir <- file.path(data.dir, folder, "binned_outputs",
                           sprintf("square_%03dum", bin_um), "spatial")
  png.path <- file.path(spatial.dir, image.name)
  if (!file.exists(png.path)) stop("Hi-res image not found: ", png.path)
  message("    reading ", png.path)
  readPNG(png.path)
}

swap_object_to_hires <- function(object, slot_to_folder, bin_um, data.dir, image.name) {
  for (nm in Images(object)) {
    message("  processing image slot: ", nm)
    key <- sub("\\.0[0-9]+um$", "", nm)                 # strip ".008um" bin suffix
    if (!key %in% names(slot_to_folder))
      stop("No folder mapping for image slot '", nm, "' (key '", key, "').")
    folder <- slot_to_folder[[key]]

    img <- object@images[[nm]]
    old_dim <- dim(img@image)
    img@image <- read_hires_raster(folder, bin_um, data.dir, image.name)
    sf <- img@scale.factors
    sf$lowres <- sf$hires                                # default image.scale="lowres" -> hires raster
    img@scale.factors <- sf
    object@images[[nm]] <- img
    message("    raster ", paste(old_dim[1:2], collapse = "x"),
            " -> ", paste(dim(img@image)[1:2], collapse = "x"))
  }
  object
}

# ---- Run --------------------------------------------------------------------
for (i in seq_len(nrow(jobs))) {
  job <- jobs[i, ]
  message("=== ", job$label, " ===")
  if (!file.exists(job$rds_in)) { warning("Input missing, skipping: ", job$rds_in); next }
  obj <- readRDS(job$rds_in)
  obj <- swap_object_to_hires(obj, slot_to_folder, job$bin_um, data.dir, hires.image.name)
  dir.create(dirname(job$rds_out), showWarnings = FALSE, recursive = TRUE)
  saveRDS(obj, job$rds_out)
  message("  saved -> ", job$rds_out)
  rm(obj); gc()
}
message("ALL SWAPS DONE")
