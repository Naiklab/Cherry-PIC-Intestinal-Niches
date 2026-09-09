suppressPackageStartupMessages({
  library(data.table)
})

cat("=== Loading pre-computed expression metrics ===\n")
expr_dt <- fread("/mnt/results/cell_level_expression_validation.csv")
cat("Loaded:", nrow(expr_dt), "rows\n")

# Deduplicate: some genes appear in multiple categories (e.g. Tyrobp in both
# doublet_annotation and myeloid_marker), creating duplicate gene+cell_type rows.
# Keep the full table for reference, use a deduplicated version for all lookups.
expr_lu <- expr_dt[!duplicated(paste(gene, cell_type))]
cat("After dedup:", nrow(expr_lu), "rows\n")

# --- Define gene sets (same as original) ---
ambient_paneth <- c("Defa3","Defa5","Defa17","Defa21","Defa22","Defa23","Defa24",
                    "Defa26","Defa29","Defa30","Defa36","Reg3b","Reg3g","Itln1")
ambient_enterocyte <- c("Fabp1","Fabp2","Fabp6","Apoa1","Apoa4","Rbp2","Mttp","Apob")
ambient_bile_acid <- c("Slc10a2","Slc51a","Slc51b")
ambient_xenobiotic <- c("Cyp3a11","Cyp3a13","Cyp3a25","Cyp2c65","Cyp2c66",
                        "Cyp2b10","Ugt2a3","Ugt2b34","Ugt2b35")
preserve_genes <- c("Aldh1a2","Aldh1a3","Rbp1","Lrat","Dhrs9","Cyp27a1","Rxra",
                    "Abca1","Abcg1","Apoe","Lpl","Cd36","Fabp5","Stard5","Abcc3")
doublet_genes <- c("Cd14","C5ar1","C3ar1","Clec4d","Clec4n","Itgam","Itgax",
                   "Ptprc","Tyrobp","Inpp5d","Cd74","Gzmb","Il7r")
plasmablast_markers <- c("Igha","Igkc","Jchain","Iglv1","Iglc1")
myeloid_markers <- c("Csf1r","Cx3cr1","Trem2","Mrc1","Msr1","Clec10a","Mgl2",
                     "Fcer1g","Tyrobp","Itgam","Itgax","Stab1","Gpnmb","Cd68",
                     "C5ar1","C3ar1","Dab2")

non_epithelial <- c("Fibroblasts","Endothelial","Macrophages","Plasmablasts","cDC1")
epithelial_sources <- c("Paneth cells","Bottom-Villus enterocytes",
                        "Mid-villus enterocytes","Upper-villus enterocytes","Goblet cells")
all_types <- c(non_epithelial, epithelial_sources)

gene_categories <- list(
  ambient_paneth = ambient_paneth,
  ambient_enterocyte = ambient_enterocyte,
  ambient_bile_acid = ambient_bile_acid,
  ambient_xenobiotic = ambient_xenobiotic,
  preserve = preserve_genes,
  doublet_annotation = doublet_genes,
  plasmablast_marker = plasmablast_markers,
  myeloid_marker = myeloid_markers
)

# --- Helper: get metrics string for a gene in a cell type (uses deduplicated table) ---
getm <- function(g, ct) {
  r <- expr_lu[gene == g & cell_type == ct]
  if (nrow(r) == 0) return("NA")
  if (is.na(r$pct_expr)) return("NA")
  sprintf("%.0f%%/m%.1f/x%d", r$pct_expr, r$mean_all, r$max_expr)
}

# --- Helper: get numeric metric ---
getn <- function(g, ct, col) {
  r <- expr_lu[gene == g & cell_type == ct]
  if (nrow(r) == 0) return(NA)
  r[[col]]
}

# ============================================================
# ANALYSIS 1: Ambient genes — NE vs epithelial source
# ============================================================
cat("\n", strrep("=", 70), "\n", sep="")
cat("ANALYSIS 1: Ambient genes in non-epithelial vs epithelial source\n")
cat(strrep("=", 70), "\n\n")

epi_src <- list(
  ambient_paneth = "Paneth cells",
  ambient_enterocyte = "Bottom-Villus enterocytes",
  ambient_bile_acid = "Bottom-Villus enterocytes",
  ambient_xenobiotic = "Bottom-Villus enterocytes"
)

ambient_verdicts <- list()

for (cat_name in names(epi_src)) {
  genes_cat <- gene_categories[[cat_name]]
  es <- epi_src[[cat_name]]
  cat("--- ", cat_name, " (source: ", es, ") ---\n", sep="")

  for (g in genes_cat) {
    ne_pcts <- sapply(non_epithelial, function(ct) getn(g, ct, "pct_expr"))
    ne_maxs <- sapply(non_epithelial, function(ct) getn(g, ct, "max_expr"))
    epi_pct <- getn(g, es, "pct_expr")
    epi_max <- getn(g, es, "max_expr")

    ne_max_pct <- max(ne_pcts, na.rm=TRUE)
    ne_max_max <- max(ne_maxs, na.rm=TRUE)

    if (is.na(epi_pct)) { verdict <- "UNKNOWN"
    } else if (ne_max_pct < 5 && epi_pct > 50) { verdict <- "AMBIENT"
    } else if (ne_max_pct < 15 && ne_max_max <= 3 && epi_pct > 50) { verdict <- "AMBIENT"
    } else if (ne_max_pct > 30 && ne_max_max > 5) { verdict <- "POSSIBLE_GENUINE"
    } else if (ne_max_pct > 10 && ne_max_max > 10) { verdict <- "POSSIBLE_DOUBLET"
    } else { verdict <- "LIKELY_AMBIENT"
    }

    ambient_verdicts[[g]] <- verdict

    ne_str <- paste(sprintf("%s:%s", non_epithelial, sapply(non_epithelial, getm, g=g)), collapse=" ")
    cat(sprintf("  %-10s | %s | %s:%s | %s\n", g, ne_str, es, getm(g, es), verdict))
  }
  cat("\n")
}

# ============================================================
# ANALYSIS 2: Preserve genes
# ============================================================
cat(strrep("=", 70), "\n")
cat("ANALYSIS 2: Preserve genes (should be genuinely expressed)\n")
cat(strrep("=", 70), "\n\n")

preserve_verdicts <- list()

for (g in preserve_genes) {
  pcts <- sapply(non_epithelial, function(ct) getn(g, ct, "pct_expr"))
  means <- sapply(non_epithelial, function(ct) getn(g, ct, "mean_all"))
  ne_str <- paste(sprintf("%s:%.0f%%/m%.1f", non_epithelial, pcts, means), collapse=" ")
  mx_pct <- max(pcts, na.rm=TRUE)
  mx_mean <- max(means, na.rm=TRUE)
  verdict <- if (mx_pct > 20 && mx_mean > 0.5) "GENUINE" else if (mx_pct > 5) "MODERATE" else "LOW"
  preserve_verdicts[[g]] <- verdict
  cat(sprintf("  %-10s | %s | %s\n", g, ne_str, verdict))
}

# ============================================================
# ANALYSIS 3: Doublet/annotation genes
# ============================================================
cat("\n", strrep("=", 70), "\n", sep="")
cat("ANALYSIS 3: Doublet/annotation genes\n")
cat(strrep("=", 70), "\n\n")

doublet_verdicts <- list()

for (g in doublet_genes) {
  endo <- getm(g, "Endothelial")
  fibro <- getm(g, "Fibroblasts")
  macro <- getm(g, "Macrophages")
  cdc1 <- getm(g, "cDC1")
  pb <- getm(g, "Plasmablasts")

  # Classify: is this gene expressed in a coherent immune population?
  endo_pct <- getn(g, "Endothelial", "pct_expr")
  endo_max <- getn(g, "Endothelial", "max_expr")
  fibro_pct <- getn(g, "Fibroblasts", "pct_expr")
  fibro_max <- getn(g, "Fibroblasts", "max_expr")
  macro_pct <- getn(g, "Macrophages", "pct_expr")
  macro_max <- getn(g, "Macrophages", "max_expr")

  # Determine verdict
  if (!is.na(macro_pct) && macro_pct > 30) {
    verdict <- "MYEOID_GENUINE"
  } else if (!is.na(endo_pct) && endo_pct > 15 && !is.na(endo_max) && endo_max > 50) {
    verdict <- "POSSIBLE_DOUBLET"
  } else if (!is.na(fibro_pct) && fibro_pct > 15 && !is.na(fibro_max) && fibro_max > 50) {
    verdict <- "POSSIBLE_DOUBLET"
  } else if ((!is.na(endo_pct) && endo_pct < 5) && (!is.na(fibro_pct) && fibro_pct < 5)) {
    verdict <- "AMBIENT"
  } else {
    verdict <- "LOW_LEVEL"
  }

  doublet_verdicts[[g]] <- verdict
  cat(sprintf("  %-10s | Endo:%-16s | Fibro:%-16s | Macro:%-16s | cDC1:%-16s | PB:%-16s | %s\n",
              g, endo, fibro, macro, cdc1, pb, verdict))
}

# ============================================================
# ANALYSIS 4: Plasmablasts population inspection
# ============================================================
cat("\n", strrep("=", 70), "\n", sep="")
cat("ANALYSIS 4: Plasmablasts population inspection\n")
cat(strrep("=", 70), "\n\n")

cat("Plasmablast markers:\n")
for (g in plasmablast_markers) {
  r <- expr_lu[gene == g & cell_type == "Plasmablasts"]
  if (nrow(r) > 0 && !is.na(r$pct_expr))
    cat(sprintf("  %-10s: %.1f%% expr, mean=%.2f, mean_expr=%.2f, max=%d\n",
                g, r$pct_expr, r$mean_all, r$mean_expr, r$max_expr))
  else
    cat(sprintf("  %-10s: not in counts matrix\n", g))
}

cat("\nMyeloid markers (from pathway LEs) in Plasmablasts vs Macrophages:\n")
for (g in myeloid_markers) {
  r <- expr_lu[gene == g & cell_type == "Plasmablasts"]
  mr <- expr_lu[gene == g & cell_type == "Macrophages"]
  if (nrow(r) > 0 && !is.na(r$pct_expr)) {
    m_str <- if (nrow(mr) > 0 && !is.na(mr$pct_expr)) sprintf("%.1f%%/m%.1f", mr$pct_expr, mr$mean_all) else "NA"
    cat(sprintf("  %-10s: PB %.1f%% (mean=%.2f, max=%d) | Macro %s\n",
                g, r$pct_expr, r$mean_all, r$max_expr, m_str))
  } else {
    cat(sprintf("  %-10s: PB not in matrix | Macro %s\n",
                g, if (nrow(mr) > 0 && !is.na(mr$pct_expr)) sprintf("%.1f%%", mr$pct_expr) else "NA"))
  }
}

# Verdict
pb_pct <- sapply(plasmablast_markers, function(g) getn(g, "Plasmablasts", "pct_expr"))
mye_pct <- sapply(myeloid_markers, function(g) getn(g, "Plasmablasts", "pct_expr"))

cat("\n--- Verdict ---\n")
cat(sprintf("  Mean plasmablast marker %%expr: %.1f%%\n", mean(pb_pct, na.rm=TRUE)))
cat(sprintf("  Mean myeloid marker %%expr: %.1f%%\n", mean(mye_pct, na.rm=TRUE)))
cat(sprintf("  Plasmablast markers >50%%: %d/%d\n", sum(pb_pct > 50, na.rm=TRUE), length(pb_pct)))
cat(sprintf("  Myeloid markers >30%%: %d/%d\n", sum(mye_pct > 30, na.rm=TRUE), length(mye_pct)))

if (mean(pb_pct, na.rm=TRUE) > 50 && mean(mye_pct, na.rm=TRUE) < 20) {
  cat("  VERDICT: GENUINE PLASMABLASTS\n")
} else if (mean(mye_pct, na.rm=TRUE) > 30 && mean(pb_pct, na.rm=TRUE) < 30) {
  cat("  VERDICT: LIKELY MISANNOTATED MYELOID\n")
} else if (mean(pb_pct, na.rm=TRUE) > 40 && mean(mye_pct, na.rm=TRUE) > 30) {
  cat("  VERDICT: POSSIBLE DOUBLETS OR MIXED\n")
} else {
  cat("  VERDICT: AMBIGUOUS\n")
}

# ============================================================
# ANALYSIS 5: Borderline pathway genes — detailed inspection
# ============================================================
cat("\n", strrep("=", 70), "\n", sep="")
cat("ANALYSIS 5: Borderline pathway gene inspection\n")
cat(strrep("=", 70), "\n\n")

# Fibroblasts REACTOME_BILE_ACID_AND_BILE_SALT_METABOLISM (1/3 = 33%)
cat("--- Fibroblasts REACTOME_BILE_ACID_AND_BILE_SALT_METABOLISM (33% ambient) ---\n")
bile_acid_fibro <- c("Slc10a2","Slc51a","Slc51b","Aldh1a2","Cyp27a1","Abcc3")
for (g in bile_acid_fibro) {
  cat(sprintf("  %-10s | Fibro:%s | Macro:%s | Endo:%s\n",
              g, getm(g,"Fibroblasts"), getm(g,"Macrophages"), getm(g,"Endothelial")))
}

# Macrophages REACTOME_RECYCLING_OF_BILE_ACIDS_AND_SALTS (4/9 = 44%)
cat("\n--- Macrophages REACTOME_RECYCLING_OF_BILE_ACIDS_AND_SALTS (44% ambient) ---\n")
recycling_genes <- c("Slc10a2","Slc51a","Slc51b","Apoa1","Apoa4","Abca1","Abcg1","Apoe","Abcc3")
for (g in recycling_genes) {
  cat(sprintf("  %-10s | Macro:%s | Fibro:%s | Endo:%s\n",
              g, getm(g,"Macrophages"), getm(g,"Fibroblasts"), getm(g,"Endothelial")))
}

# Macrophages REACTOME_BILE_ACID_AND_BILE_SALT_METABOLISM (4/9 = 44%)
cat("\n--- Macrophages REACTOME_BILE_ACID_AND_BILE_SALT_METABOLISM (44% ambient) ---\n")
bile_macro <- c("Slc10a2","Slc51a","Slc51b","Aldh1a2","Cyp27a1","Abca1","Abcg1","Apoe","Abcc3")
for (g in bile_macro) {
  cat(sprintf("  %-10s | Macro:%s | Fibro:%s\n",
              g, getm(g,"Macrophages"), getm(g,"Fibroblasts")))
}

# Macrophages GOBP_RETINOL_METABOLIC_PROCESS (5/14 = 36%)
cat("\n--- Macrophages GOBP_RETINOL_METABOLIC_PROCESS (36% ambient) ---\n")
retinol_macro <- c("Aldh1a2","Dhrs9","Cyp27a1","Rxra","Lrat","Rbp1","Stard5","Abca1","Abcg1","Apoe","Lpl","Cd36","Fabp5","Abcc3")
for (g in retinol_macro) {
  cat(sprintf("  %-10s | Macro:%s | Fibro:%s\n",
              g, getm(g,"Macrophages"), getm(g,"Fibroblasts")))
}

# KEGG_RETINOL_METABOLISM — Fibroblasts (7/12 = 58%) and Macrophages (9/16 = 56%)
cat("\n--- Fibroblasts KEGG_RETINOL_METABOLISM (58% ambient) ---\n")
retinol_fibro <- c("Aldh1a2","Aldh1a3","Rbp1","Lrat","Dhrs9","Cyp27a1","Rxra","Abca1","Abcg1","Apoe","Lpl","Cd36")
for (g in retinol_fibro) {
  cat(sprintf("  %-10s | Fibro:%s | Macro:%s\n",
              g, getm(g,"Fibroblasts"), getm(g,"Macrophages")))
}

cat("\n--- Macrophages KEGG_RETINOL_METABOLISM (56% ambient) ---\n")
retinol_macro_kegg <- c("Aldh1a2","Aldh1a3","Rbp1","Lrat","Dhrs9","Cyp27a1","Rxra","Abca1","Abcg1","Apoe","Lpl","Cd36","Fabp5","Stard5","Abcc3","Cyp3a11")
for (g in retinol_macro_kegg) {
  cat(sprintf("  %-10s | Macro:%s | Fibro:%s\n",
              g, getm(g,"Macrophages"), getm(g,"Fibroblasts")))
}

# ============================================================
# SUMMARY: Compile all verdicts into a table
# ============================================================
cat("\n", strrep("=", 70), "\n", sep="")
cat("SUMMARY: All gene-level verdicts\n")
cat(strrep("=", 70), "\n\n")

all_verdicts <- rbindlist(list(
  data.table(gene=names(ambient_verdicts), category="ambient", verdict=unlist(ambient_verdicts)),
  data.table(gene=names(preserve_verdicts), category="preserve", verdict=unlist(preserve_verdicts)),
  data.table(gene=names(doublet_verdicts), category="doublet_annotation", verdict=unlist(doublet_verdicts))
))
setorder(all_verdicts, category, gene)
cat(sprintf("  Total genes evaluated: %d\n", nrow(all_verdicts)))
cat("\n  Verdict distribution:\n")
print(table(all_verdicts$verdict))

# Save verdicts
fwrite(all_verdicts, "/mnt/results/gene_level_verdicts.csv")
cat("\nSaved: /mnt/results/gene_level_verdicts.csv\n")

cat("\n=== DONE: Cell-level validation complete ===\n")
