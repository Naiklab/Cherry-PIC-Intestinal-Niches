# ─────────────────────────────────────────────────────────────────────────────
# Rebuild the Cherry-PIC analysis environment.
#
#   Rscript .checks/install_environment.R            install
#   Rscript .checks/install_environment.R --dry-run  report only, change nothing
#
# Installs the packages the analysis loads directly, pinned to the versions used
# on the analysis cluster. Transitive dependencies resolve to whatever the
# pinned versions require; the complete 575-package closure as it stood is
# recorded in .checks/r_library_manifest.tsv for exact comparison.
#
# Base R:        4.4.1 (2024-06-14)
# Bioconductor:  3.20
# ─────────────────────────────────────────────────────────────────────────────

DRY <- "--dry-run" %in% commandArgs(TRUE)

R_TARGET    <- "4.4.1"
BIOC_TARGET <- "3.20"

msg <- function(...) cat(sprintf(...), "\n")
do_install <- function(expr) if (DRY) invisible(NULL) else try(expr, silent = TRUE)

# packageVersion() normalises CRAN's "1.1-3" to "1.1.3", so compare parsed versions,
# not strings, or identical releases look like mismatches.
same_ver <- function(a, b) {
  if (is.na(a) || is.na(b)) return(FALSE)
  isTRUE(tryCatch(package_version(a) == package_version(b), error = function(e) FALSE))
}
have_ver <- function(p) tryCatch(as.character(packageVersion(p)), error = function(e) NA_character_)
# GitHub packages have no CRAN-style release cadence, so two different commits can
# legitimately share the same declared Version string -- a version match alone doesn't
# prove the installed package is the exact commit this analysis used. remotes records
# the actual installed commit in the package's own DESCRIPTION; compare that too.
have_sha <- function(p) tryCatch(utils::packageDescription(p, fields = "RemoteSha"),
                                 error = function(e) NA_character_)
want_sha <- function(spec) sub("^.*@", "", spec)  # "owner/repo@sha" -> "sha"
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
# SingleR and celldex are loaded by Cell_type-reAnnotation.Rmd but were absent from the
# cluster library, so no version is pinned for them.
bioc <- c(ComplexHeatmap = "2.22.0", EnhancedVolcano = "1.24.0", UCell = "2.10.1",
          fgsea = "1.32.4", scDblFinder = "1.20.2", speckle = "1.6.0",
          SingleR = NA, celldex = NA)

# ── GitHub ───────────────────────────────────────────────────────────────────
# Pinned to the exact commit each declared version resolves to (matching renv.lock),
# not the default branch tip — these packages have no CRAN-style release cadence, so
# "current main" silently drifts to whatever the upstream repo happens to contain today.
github <- c(spacexr    = "dmcable/spacexr@9f5dc33c8060f946c6072a138b70e189636e1435",
            presto     = "immunogenomics/presto@7636b3d0465c468c35853f82f1717d3a64b3c8f6",
            nichenetr  = "saeyslab/nichenetr@66f90d5eeafef280b2b2f339b3fd70ffec1781dd",
            liana      = "saezlab/liana@6cab46c54234f861ea176c3de77c4b8aa45ecb3d")
github_versions <- c(spacexr = "2.2.1", presto = "1.0.0", nichenetr = "2.2.1.1", liana = "0.1.14")

if (DRY) msg("\nDRY RUN - reporting what would change; nothing will be installed.")
if (!DRY) {
  if (!requireNamespace("remotes", quietly = TRUE))     install.packages("remotes", repos = "https://cloud.r-project.org")
  if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager", repos = "https://cloud.r-project.org")
}

cran_failed <- character(0); bioc_failed <- character(0)

msg("\n== CRAN (%d packages, version-pinned) ==", length(cran))
for (p in names(cran)) {
  have <- have_ver(p)
  if (same_ver(have, cran[[p]])) { msg("  ok      %-14s %s", p, have); next }
  msg("  install %-14s %s%s", p, cran[[p]], if (is.na(have)) "" else sprintf("  (have %s)", have))
  result <- do_install(remotes::install_version(p, version = cran[[p]],
                                                repos = "https://cloud.r-project.org", upgrade = "never"))
  if (inherits(result, "try-error")) { msg("    ERROR installing %s: %s", p, conditionMessage(attr(result, "condition"))); cran_failed <- c(cran_failed, p) }
}

msg("\n== Bioconductor %s (%d packages) ==", BIOC_TARGET, length(bioc))
if (!DRY) BiocManager::install(version = BIOC_TARGET, ask = FALSE, update = FALSE)
for (p in names(bioc)) {
  have <- have_ver(p); want <- bioc[[p]]
  if (is.na(have)) {
    msg("  install %-14s %s", p, if (is.na(want)) "" else want)
    result <- do_install(BiocManager::install(p, ask = FALSE, update = FALSE))
    if (inherits(result, "try-error")) { msg("    ERROR installing %s: %s", p, conditionMessage(attr(result, "condition"))); bioc_failed <- c(bioc_failed, p) }
  }
  else if (is.na(want))          msg("  ok      %-14s %s  (not pinned)", p, have)
  else if (same_ver(have, want)) msg("  ok      %-14s %s", p, have)
  else                           msg("  DIFFERS %-14s have %s, analysis used %s", p, have, want)
}

msg("\n== GitHub (%d packages, pinned to commit) ==", length(github))
github_failed <- character(0)
for (p in names(github)) {
  have <- have_ver(p); want <- github_versions[[p]]
  sha_have <- have_sha(p); sha_want <- want_sha(github[[p]])
  # A version-string match is not sufficient on its own -- see the have_sha() comment.
  sha_ok <- !is.na(sha_have) && identical(sha_have, sha_want)
  if (is.na(have) || !same_ver(have, want) || !sha_ok) {
    reason <- if (is.na(have)) "missing" else if (!same_ver(have, want)) "version differs" else "commit differs"
    msg("  install %-10s %s from %s  (%s)", p, want, github[[p]], reason)
    result <- do_install(remotes::install_github(github[[p]], upgrade = "never", force = !is.na(have)))
    if (inherits(result, "try-error")) { msg("    ERROR installing %s: %s", p, conditionMessage(attr(result, "condition"))); github_failed <- c(github_failed, p) }
  } else msg("  ok      %-14s %s  (commit %s)", p, have, substr(sha_have, 1, 10))
}

# ── report ───────────────────────────────────────────────────────────────────
msg("\n== Result ==")
pins <- c(cran, bioc, github_versions)   # GitHub packages are now version-checked like the rest
bad <- 0; diff <- 0
for (p in c(names(cran), names(bioc), names(github))) {
  have <- have_ver(p)
  want <- if (p %in% names(pins)) pins[[p]] else NA
  if (is.na(have)) { msg("  MISSING  %s", p); bad <- bad + 1 }
  else if (!is.na(want) && !same_ver(have, want)) {
    msg("  DIFFERS  %-14s have %s, analysis used %s", p, have, want); diff <- diff + 1
  }
  else if (p %in% names(github)) {
    # Version alone does not prove the exact commit for a GitHub package -- also check
    # the installed RemoteSha against the one this analysis actually used.
    sha_have <- have_sha(p); sha_want <- want_sha(github[[p]])
    if (is.na(sha_have) || !identical(sha_have, sha_want)) {
      msg("  DIFFERS  %-14s version matches (%s) but commit does not (have %s, analysis used %s)",
          p, have, if (is.na(sha_have)) "unknown" else substr(sha_have, 1, 10), substr(sha_want, 1, 10))
      diff <- diff + 1
    }
  }
}
failed <- c(cran_failed, bioc_failed, github_failed)
if (length(failed) > 0) msg("  %d package install(s) errored: %s", length(failed), paste(failed, collapse = ", "))
if (bad == 0 && diff == 0 && length(failed) == 0) {
  msg("  every package present at the analysis version.")
} else {
  msg("  %d missing, %d at a different version, %d errored.", bad, diff, length(failed))
}
msg("\nCompare your full library against the analysis library with:")
msg("  .checks/r_library_manifest.tsv   (575 packages, name / version / source)")

# Dry runs and pure reporting never fail the process; a real install run that leaves
# packages missing, mismatched, or errored exits nonzero so a scripted caller notices
# rather than silently treating a failed install as success.
if (!DRY && (bad > 0 || diff > 0 || length(failed) > 0)) quit(status = 1, save = "no")
