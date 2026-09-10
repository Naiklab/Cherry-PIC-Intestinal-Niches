#!/usr/bin/env Rscript
# =============================================================================
# Handoff B — stem-cell receiver population for the ligand-receptor analysis
# (Figures 6F, 6G, S8)
# =============================================================================
#
# RECONSTRUCTED. The original export was run interactively and was not saved.
# This script was written by reading the three exported objects back and
# reproducing the subset that yields them exactly:
#
#   EP_CTRL_Stem_cells_all.rds        2907 cells   Duodenum + Ileum
#   EP_CTRL_Stem_cells_Duodenum.rds   1583 cells   Duodenum
#   EP_CTRL_Stem_cells_Ileum.rds      1324 cells   Ileum
#
# All three contain only cell_type_labels == "SC".
#
# NOTE ON SCOPE. This project supplies the *stem cell* receiver only. The TA
# receiver, and every sender population, come from the Cherry-PIC sorted-niche
# object, not from here — in the merged LIANA input the 199 TA cells and all
# macrophage, fibroblast, enterocyte and lymphoid senders carry a broad_cell_type
# value, which the cells exported here do not. The 73 CLU+ reserve stem cells
# that join these 2907 as "Stem_cells" also come from that object, and are
# excluded before scoring.
#
# Input:  ../../04-merge-controls/outputs/epithelia_EP.CTRL_data.processed(no-immune).RDS
# Output: ../outputs/EP_CTRL_Stem_cells_{all,Duodenum,Ileum}.rds
# =============================================================================

if (nzchar(Sys.getenv("CHERRYPIC_R_LIB"))) .libPaths(c(Sys.getenv("CHERRYPIC_R_LIB"), .libPaths()))  # optional custom library
suppressPackageStartupMessages(library(Seurat))

in_path  <- file.path("..", "..", "04-merge-controls", "outputs",
                      "epithelia_EP.CTRL_data.processed(no-immune).RDS")
out      <- function(f) file.path("..", "outputs", f)
dir.create(file.path("..", "outputs"), showWarnings = FALSE, recursive = TRUE)

seu <- readRDS(in_path)

# cell_type_labels comes from stage 04, annotated on RNA_snn_res.0.8.
# "SC" is clusters 0 and 9; stage 05 re-annotates the same clusters more finely
# but leaves the SC assignment unchanged.
stem <- subset(seu, subset = cell_type_labels == "SC")

stopifnot(ncol(stem) == 2907L)

saveRDS(stem, out("EP_CTRL_Stem_cells_all.rds"))

for (loc in c("Duodenum", "Ileum")) {
  part <- subset(stem, subset = Location == loc)
  message(sprintf("%-9s %5d cells", loc, ncol(part)))
  saveRDS(part, out(sprintf("EP_CTRL_Stem_cells_%s.rds", loc)))
}
