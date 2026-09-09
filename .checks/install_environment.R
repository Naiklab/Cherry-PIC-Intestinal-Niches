# ─────────────────────────────────────────────────────────────────────────────
# Rebuild the Cherry-PIC analysis environment.
#
#   Rscript .checks/install_environment.R
#
# Installs the packages the analysis loads directly, pinned to the versions used
# on the Minerva HPC cluster. Transitive dependencies resolve to whatever the
# pinned versions require; the complete 575-package closure as it stood is
# recorded in .checks/r_library_manifest.tsv for exact comparison.
#
# Base R:        4.4.1 (2024-06-14)
# Bioconductor:  3.20
# ─────────────────────────────────────────────────────────────────────────────

R_TARGET    <- "4.4.1"
BIOC_TARGET <- "3.20"

msg <- function(...) cat(sprintf(...), "\n")
cur <- paste(R.version$major, R.version$minor, sep = ".")
if (cur != R_TARGET)
  msg("NOTE: running R %s; the analysis used %s. Package versions below still apply,\n      but a different R minor version can change numerical output.", cur, R_TARGET)

# ── CRAN, pinned ─────────────────────────────────────────────────────────────
cran <- c(
  Matrix = "1.7-5",  RColorBrewer = "1.1-3", Seurat = "5.5.0",  SeuratObject = "5.4.0",
  sp = "2.2-1",      circlize = "0.4.18",    clustree = "0.5.1", data.table = "1.18.4",
  dplyr = "1.2.1",   ggplot2 = "4.0.3",      ggpubr = "0.6.3",   ggrepel = "0.9.8",
  ggsci = "5.0.0",   glue = "1.8.1",         harmony = "2.0.3",  jsonlite = "2.0.0",
  msigdbr = "26.1.0", patchwork = "1.3.2",   pheatmap = "1.0.13", png = "0.1-9",
  readxl = "1.5.0",  stringr = "1.6.0",      svglite = "2.2.2",  tibble = "3.3.1",
  tidyr = "1.3.2",   tidyverse = "2.0.0",    viridis = "0.6.5",  sctransform = "0.4.3",
  knitr = "1.51",    openxlsx = "4.2.8.1"
)

# ── Bioconductor 3.20 ────────────────────────────────────────────────────────
bioc <- c("ComplexHeatmap", "EnhancedVolcano", "UCell", "fgsea", "scDblFinder",
          "speckle", "SingleR", "celldex")

# ── GitHub ───────────────────────────────────────────────────────────────────
github <- c(spacexr    = "dmcable/spacexr",
            presto     = "immunogenomics/presto",
            nichenetr  = "saeyslab/nichenetr",
            liana      = "saezlab/liana")

if (!requireNamespace("remotes", quietly = TRUE))     install.packages("remotes", repos = "https://cloud.r-project.org")
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager", repos = "https://cloud.r-project.org")

msg("\n== CRAN (%d packages, version-pinned) ==", length(cran))
for (p in names(cran)) {
  have <- tryCatch(as.character(packageVersion(p)), error = function(e) NA)
  if (!is.na(have) && have == cran[[p]]) { msg("  ok      %-14s %s", p, have); next }
  msg("  install %-14s %s%s", p, cran[[p]], if (is.na(have)) "" else sprintf("  (have %s)", have))
  try(remotes::install_version(p, version = cran[[p]],
                               repos = "https://cloud.r-project.org", upgrade = "never"), silent = TRUE)
}

msg("\n== Bioconductor %s (%d packages) ==", BIOC_TARGET, length(bioc))
BiocManager::install(version = BIOC_TARGET, ask = FALSE, update = FALSE)
for (p in bioc) {
  have <- tryCatch(as.character(packageVersion(p)), error = function(e) NA)
  if (is.na(have)) { msg("  install %s", p); try(BiocManager::install(p, ask = FALSE, update = FALSE), silent = TRUE) }
  else msg("  ok      %-14s %s", p, have)
}

msg("\n== GitHub (%d packages) ==", length(github))
for (p in names(github)) {
  have <- tryCatch(as.character(packageVersion(p)), error = function(e) NA)
  if (is.na(have)) { msg("  install %-10s from %s", p, github[[p]]); try(remotes::install_github(github[[p]], upgrade = "never"), silent = TRUE) }
  else msg("  ok      %-14s %s", p, have)
}

# ── report ───────────────────────────────────────────────────────────────────
msg("\n== Result ==")
all_p <- c(names(cran), bioc, names(github))
bad <- 0
for (p in all_p) {
  have <- tryCatch(as.character(packageVersion(p)), error = function(e) NA)
  want <- if (p %in% names(cran)) cran[[p]] else NA
  if (is.na(have)) { msg("  MISSING  %s", p); bad <- bad + 1 }
  else if (!is.na(want) && have != want) msg("  DIFFERS  %-14s have %s, analysis used %s", p, have, want)
}
if (bad == 0) msg("  every package installed.")
msg("\nCompare your full library against the analysis library with:")
msg("  .checks/r_library_manifest.tsv   (575 packages, name / version / source)")
