#!/usr/bin/env Rscript
# =============================================================================
# Handoff B — receiver populations for the ligand-receptor analysis
# (Figures 6F, 6G, S8)
# =============================================================================
#
# RECONSTRUCTED. The original export ran interactively and was not saved.
#
# This project supplies BOTH receivers. In the scored LIANA tables they appear
# as "Stem cells" and "TA cells" — renamed from the SC and TA labels here, and
# distinct from the Cherry-PIC niche object's own "TA cells/early progenitors"
# (199 cells), which the sender-count figure merges with TA but which is a
# separate population. CLU+ reserve stem cells are NOT stem cells for this
# analysis and appear nowhere in the scored tables; the "_noclu" suffix on those
# files records their exclusion.
#
# Counts in the source object:
#
#   label            all      Duodenum   Ileum
#   SC              2907        1583      1324
#   TA              5036        3326      1710
#
# Both populations are derived from the source object by label, so this script
# reproduces them rather than depending on any exported file. The three stem
# exports that are available were checked and match exactly
# (EP_CTRL_Stem_cells_all/Duodenum/Ileum.rds = 2907/1583/1324, SC only).
#
# Input:  ../../04-merge-controls/outputs/epithelia_EP.CTRL_data.processed(no-immune).RDS
# Output: ../outputs/EP_CTRL_{Stem_cells,TA}_{all,Duodenum,Ileum}.rds
# =============================================================================

if (nzchar(Sys.getenv("CHERRYPIC_R_LIB"))) .libPaths(c(Sys.getenv("CHERRYPIC_R_LIB"), .libPaths()))  # optional custom library
suppressPackageStartupMessages(library(Seurat))

in_path <- file.path("..", "..", "04-merge-controls", "outputs",
                     "epithelia_EP.CTRL_data.processed(no-immune).RDS")
out     <- function(f) file.path("..", "outputs", f)
dir.create(file.path("..", "outputs"), showWarnings = FALSE, recursive = TRUE)

seu <- readRDS(in_path)

# cell_type_labels is set at stage 04 on RNA_snn_res.0.8: SC is clusters 0 and 9,
# TA is clusters 3, 5, 6 and 7. Stage 05 re-annotates the same clusters more
# finely but leaves both assignments unchanged.
receivers <- c(Stem_cells = "SC", TA = "TA")
expected  <- c(Stem_cells = 2907L, TA = 5036L)

for (nm in names(receivers)) {
  pop <- subset(seu, subset = cell_type_labels == receivers[[nm]])
  if (ncol(pop) != expected[[nm]])
    warning(sprintf("%s: expected %d cells, got %d", nm, expected[[nm]], ncol(pop)))

  saveRDS(pop, out(sprintf("EP_CTRL_%s_all.rds", nm)))
  for (loc in c("Duodenum", "Ileum")) {
    part <- subset(pop, subset = Location == loc)
    message(sprintf("%-11s %-9s %5d cells", nm, loc, ncol(part)))
    saveRDS(part, out(sprintf("EP_CTRL_%s_%s.rds", nm, loc)))
  }
}
