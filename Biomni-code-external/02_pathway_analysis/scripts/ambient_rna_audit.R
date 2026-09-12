suppressPackageStartupMessages({
  library(data.table)
  library(stringr)
})

# ============================================================
# Ambient RNA Contamination Audit — Steps 1-3 (revised)
# ============================================================

# --- Load module pathway table ---

.here <- local({a <- commandArgs(FALSE); f <- sub("^--file=", "", a[grep("^--file=", a)])
          if (length(f)) dirname(normalizePath(f)) else getwd()})
DATA <- normalizePath(file.path(.here, "..", "data"), mustWork = FALSE)

le <- fread(file.path(DATA, "module_pathway_leading_edges.csv"))
cat("Loaded module_pathway_leading_edges.csv:", nrow(le), "rows\n")

# --- Step 1: Define ambient gene panel ---

paneth_genes <- c("Defa3","Defa5","Defa17","Defa21","Defa22","Defa23","Defa24",
                  "Defa26","Defa29","Defa30","Defa36","Reg3b","Reg3g","Itln1")
enterocyte_genes <- c("Fabp1","Fabp2","Fabp6","Apoa1","Apoa4","Rbp2","Mttp","Apob")
bile_acid_transport <- c("Slc10a2","Slc51a","Slc51b")
xenobiotic_genes <- c("Cyp3a11","Cyp3a13","Cyp3a25","Cyp2c65","Cyp2c66",
                      "Cyp2b10","Ugt2a3","Ugt2b34","Ugt2b35")

ambient_panel <- unique(c(paneth_genes, enterocyte_genes, bile_acid_transport, xenobiotic_genes))
cat("Ambient panel:", length(ambient_panel), "genes\n\n")

# Genes to PRESERVE (biologically credible in non-epithelial cells)
preserve_genes <- c("Aldh1a2","Aldh1a3","Rbp1","Lrat","Dhrs9","Cyp27a1","Rxra",
                    "Abca1","Abcg1","Apoe","Lpl","Cd36","Fabp5","Stard5","Abcc3")

# Non-epithelial cell types
non_epithelial <- c("Fibroblasts","Endothelial","Macrophages","Plasmablasts","cDC1")
epithelial_types <- c("Bottom-villus EC","Stem cells")

# --- Helper: parse leading edge genes ---
parse_le_genes <- function(gene_str) {
  if (is.na(gene_str) || gene_str == "") return(character(0))
  genes <- strsplit(gene_str, "[;,]\\s*")[[1]]
  genes <- trimws(genes)
  genes <- genes[genes != ""]
  return(genes)
}

# --- Step 2: Quantify ambient contribution ---

cat("=== Step 2: Quantifying ambient contribution ===\n\n")

# Add columns
le[, ambient_genes := ""]
le[, n_ambient_genes := 0L]
le[, ambient_fraction := 0.0]
le[, ambient_status := "None"]

for (i in seq_len(nrow(le))) {
  ct <- le$cell_type[i]
  genes <- parse_le_genes(le$leading_edge_genes[i])
  n_le <- length(genes)

  if (ct %in% epithelial_types) {
    set(le, i, "ambient_status", "N/A (epithelial)")
    next
  }

  amb <- genes[genes %in% ambient_panel]
  n_amb <- length(amb)
  frac <- if (n_le > 0) n_amb / n_le else 0

  set(le, i, "ambient_genes", if (n_amb > 0) paste(amb, collapse="; ") else "")
  set(le, i, "n_ambient_genes", n_amb)
  set(le, i, "ambient_fraction", round(frac, 3))

  if (frac >= 0.5) status <- "Strong"
  else if (frac >= 0.25) status <- "Borderline"
  else if (frac > 0) status <- "Low"
  else status <- "None"

  set(le, i, "ambient_status", status)
}

cat("Ambient status (non-epithelial):\n")
le[cell_type %in% non_epithelial, .N, by=ambient_status][order(-N)] |> print()
cat("\n")

# --- Step 3a: Apply DEFAULT recommendations based on ambient_status ---

cat("=== Step 3a: Default recommendations ===\n")

le[, recommendation := "KEEP"]
le[, reason := ""]

# Epithelial populations
le[cell_type %in% epithelial_types, reason := "Epithelial population — epithelial genes are genuine biology"]

# Non-epithelial with no ambient genes
le[cell_type %in% non_epithelial & ambient_status == "None",
   reason := "No suspected ambient genes in leading edge."]

# Non-epithelial with Low ambient
le[cell_type %in% non_epithelial & ambient_status == "Low",
   `:=`(recommendation = "KEEP",
        reason = paste0(n_ambient_genes, "/", n_le_genes, " LE genes are ambient epithelial (",
                        ambient_genes, "). Low ambient contribution; pathway signal is primarily genuine."))]

# Non-epithelial with Borderline ambient (default — will be overridden for specific pathways)
le[cell_type %in% non_epithelial & ambient_status == "Borderline",
   `:=`(recommendation = "KEEP_WITH_CAUTION",
        reason = paste0(n_ambient_genes, "/", n_le_genes, " LE genes are ambient epithelial (",
                        ambient_genes, "). Ambient contribution is substantial but does not fully define pathway."))]

# Non-epithelial with Strong ambient (default — will be overridden for specific pathways)
le[cell_type %in% non_epithelial & ambient_status == "Strong",
   `:=`(recommendation = "REMOVE_FROM_INTERPRETATION",
        reason = paste0(n_ambient_genes, "/", n_le_genes, " LE genes are ambient epithelial (",
                        ambient_genes, "). Pathway is dominated by ambient RNA."))]

cat("Default recommendations applied\n\n")

# --- Step 3b: Override with SPECIFIC recommendations ---

cat("=== Step 3b: Specific recommendations (override defaults) ===\n\n")

# Helper using data.table := for reliable modification
override_rec <- function(ct, pw, rec, reason_str) {
  n <- le[cell_type == ct & pathway == pw, .N]
  if (n > 0) {
    le[cell_type == ct & pathway == pw,
       `:=`(recommendation = rec, reason = reason_str)]
    cat(sprintf("  %s - %s -> %s\n", ct, substr(pw, 1, 55), rec))
  } else {
    cat(sprintf("  WARNING: %s - %s NOT FOUND\n", ct, pw))
  }
}

# NOTE ON THE FOUR "borderline" OVERRIDES BELOW (bile acid signaling x2,
# GOBP_RETINOL_METABOLIC_PROCESS, and KEGG_RETINOL_METABOLISM's REVIEW calls):
# these represent a case this script builds for reconsidering pathways the biologist
# asked to have excluded as ambient-driven. It was never adopted — the published
# figure and the shipped ambient_annotated_pathway_table.csv / pathway_table_cleaned.csv
# reflect the biologist's original exclusion, not these overrides. Running this script
# end to end will NOT reproduce the shipped files; it will re-include these pathways.
# Do not regenerate the shipped data from a run of this script without the biologist's
# renewed sign-off on the specific cases below.
cat("--- 6 pre-identified REMOVE pathways ---\n")
override_rec("Fibroblasts", "REACTOME_ANTIMICROBIAL_PEPTIDES", "REMOVE_FROM_INTERPRETATION",
  "13/14 LE genes are Paneth/secretory epithelial markers (Defa family, Reg3g, Reg3b, Itln1). Pathway identity is entirely defined by ambient epithelial transcripts.")
override_rec("Macrophages", "REACTOME_DEFENSINS", "REMOVE_FROM_INTERPRETATION",
  "10/13 LE genes are Defa family genes. Defensins are Paneth-cell-specific in mouse; mouse myeloid cells lack functional alpha-defensin genes. Pathway driven by ambient Paneth RNA.")
override_rec("Macrophages", "REACTOME_ANTIMICROBIAL_PEPTIDES", "REMOVE_FROM_INTERPRETATION",
  "11/15 LE genes are Defa/Itln1 genes. Same rationale as REACTOME_DEFENSINS — Paneth-specific antimicrobial peptides misattributed to macrophages via ambient RNA.")
override_rec("Macrophages", "WP_DISORDERS_OF_BILE_ACID_SYNTHESIS_AND_BILIARY_TRANSPORT", "REMOVE_FROM_INTERPRETATION",
  "4/6 LE genes are ileal bile acid transport genes (Fabp6, Slc10a2, Slc51a, Slc51b). These are enterocyte-specific transporters; remaining genes (Abcc3, Cyp27a1) are macrophage-compatible but insufficient to support pathway independently.")
override_rec("Endothelial", "WP_DISORDERS_OF_BILE_ACID_SYNTHESIS_AND_BILIARY_TRANSPORT", "REMOVE_FROM_INTERPRETATION",
  "4/7 LE genes are ileal bile acid transport genes (Fabp6, Slc10a2, Slc51a, Slc51b). Endothelial cells have no biological role in bile acid transport. Remaining genes (Abcb1a, Abcd3, Atp8b1) are generic transporters not specific to bile acid biology.")
override_rec("Endothelial", "GOBP_BILE_ACID_AND_BILE_SALT_TRANSPORT", "REMOVE_FROM_INTERPRETATION",
  "3/6 LE genes are bile acid transporters (Slc10a2, Slc51a, Slc51b). Endothelial cells do not transport bile acids. Nr1h4 (FXR) is a nuclear receptor not expressed in endothelium. Pathway entirely driven by ambient enterocyte RNA.")
cat("\n")

cat("--- 2 REVIEW pathways (KEGG_RETINOL_METABOLISM) ---\n")
override_rec("Fibroblasts", "KEGG_RETINOL_METABOLISM", "REVIEW",
  "7/12 LE genes are suspicious CYP/UGT xenobiotic genes (Cyp2b10, Ugt2b34, Cyp3a13, Cyp3a11, Ugt2a3, Cyp3a25, Cyp2c65). However, 5 LE genes (Lrat, Aldh1a2, Rdh11, Dhrs3, Adh5) are biologically plausible retinoid genes in stromal cells. Must determine if genuine retinoid program remains after removing ambient contribution.")
override_rec("Macrophages", "KEGG_RETINOL_METABOLISM", "REVIEW",
  "9/16 LE genes are suspicious CYP/UGT genes (Cyp3a13, Ugt2b34, Cyp2b10, Cyp2c65, Ugt2a3, Cyp3a11, Cyp2c66, Cyp3a25, Ugt2b35). However, Aldh1a2, Dhrs9, Dhrs4, Adh1, Adh5, Dgat1, Dgat2 are macrophage-compatible retinoid/lipid genes. Must determine if genuine retinoid program remains.")
cat("\n")

cat("--- 4 borderline pathways ---\n")
override_rec("Macrophages", "REACTOME_RECYCLING_OF_BILE_ACIDS_AND_SALTS", "KEEP_WITH_CAUTION",
  "4/9 LE genes are ambient (Fabp6, Slc10a2, Slc51a, Slc51b). Remaining 5 genes (Abcc3, Stard5, Ncoa1, Rxra, Nr1h4) form a coherent FXR/RXR bile acid signaling program in macrophages. Abcc3 and Stard5 are macrophage-compatible. The signaling core is genuine; only the transport component is ambient.")
override_rec("Macrophages", "REACTOME_BILE_ACID_AND_BILE_SALT_METABOLISM", "KEEP_WITH_CAUTION",
  "4/9 LE genes are ambient (Fabp6, Slc10a2, Slc51a, Slc51b). Remaining 5 genes include Cyp27a1 (genuine macrophage bile acid synthesis enzyme), Abcc3, Stard5, Ncoa1, Rxra — a coherent bile acid metabolism and signaling program. The enzymatic/signaling core is genuine; only the uptake transport component is ambient.")
override_rec("Macrophages", "GOBP_RETINOL_METABOLIC_PROCESS", "KEEP_WITH_CAUTION",
  "5/14 LE genes are ambient (Fabp1, Cyp3a13, Cyp2c65, Cyp3a11, Cyp2c66). Remaining 9 genes include Aldh1a2, Dhrs9 (macrophage retinoid genes), Dgat1/2, Adh1, Akr1b3/8, Dhrs4, Rdh13 — a coherent retinoid metabolism program. The CYP/UGT component is ambient but the dehydrogenase/reductase core is genuine.")
override_rec("Fibroblasts", "REACTOME_BILE_ACID_AND_BILE_SALT_METABOLISM", "NEEDS_CELL_LEVEL_VALIDATION",
  "1/3 LE genes is ambient (Fabp6). Remaining genes (Ncoa1, Cyp7b1) could represent genuine bile acid metabolism signaling, but Cyp7b1 expression in fibroblasts requires cell-level validation. Small leading edge (3 genes) makes interpretation uncertain.")
cat("\n")

# --- Recommendation summary ---
cat("=== Recommendation summary (non-epithelial) ===\n")
le[cell_type %in% non_epithelial, .N, by=recommendation][order(-N)] |> print()
cat("\n")

# --- Scan for additional epithelial-restricted genes ---
cat("=== Scanning for additional epithelial-restricted genes ===\n")
all_ne_genes <- unique(unlist(lapply(
  le[cell_type %in% non_epithelial, leading_edge_genes], parse_le_genes)))
cat("Total unique genes in non-epithelial LEs:", length(all_ne_genes), "\n")

additional_candidates <- c("Mptx2","Ang4","Prap1","Sis","Guca2a","Tff3","Muc2",
                           "Zg16","Fcgbp","Agr2","Spink4","Clca1")
found <- all_ne_genes[all_ne_genes %in% additional_candidates]
not_in_panel <- found[!found %in% ambient_panel]
cat("Additional candidates found:", if (length(found) > 0) paste(found, collapse=", ") else "none", "\n")
cat("Not yet in panel:", if (length(not_in_panel) > 0) paste(not_in_panel, collapse=", ") else "none", "\n")

for (g in not_in_panel) {
  pw <- le[cell_type %in% non_epithelial & grepl(g, leading_edge_genes, fixed=TRUE),
           .(cell_type, pathway, module)]
  cat(sprintf("\n  %s in %d pathways:\n", g, nrow(pw)))
  for (j in seq_len(min(nrow(pw), 5)))
    cat(sprintf("    %s - %s [%s]\n", pw$cell_type[j], substr(pw$pathway[j],1,50), pw$module[j]))
}

# --- Save annotated table ---
fwrite(le, file.path(DATA, "ambient_annotated_pathway_table.csv"))
cat("\n\nSaved: ambient_annotated_pathway_table.csv (", nrow(le), "rows)\n")

# --- Derive and save the cleaned plotting table ---
# An independent audit found this derivation missing entirely: nothing regenerated
# pathway_table_cleaned.csv from a fresh audit, so a revised audit could sit alongside
# an unchanged final plotting table. The cleaned table is exactly the audit table's
# non-REMOVE_FROM_INTERPRETATION rows, with the audit-only columns dropped.
cleaned_cols <- c("module", "cell_type", "pathway", "region_class", "region_block",
                  "NES", "padj", "source", "leading_edge_genes", "n_le_genes")
cleaned <- le[recommendation != "REMOVE_FROM_INTERPRETATION", ..cleaned_cols]
fwrite(cleaned, file.path(DATA, "pathway_table_cleaned.csv"))
cat("Saved: pathway_table_cleaned.csv (", nrow(cleaned), "rows)\n")

# --- Print audit table ---
cat("\n=== AMBIENT RNA AUDIT TABLE ===\n")
audit <- le[cell_type %in% non_epithelial &
            (ambient_status %in% c("Strong","Borderline") |
             recommendation %in% c("REMOVE_FROM_INTERPRETATION","REVIEW","NEEDS_CELL_LEVEL_VALIDATION"))]
cat("Rows in audit:", nrow(audit), "\n\n")
for (i in seq_len(nrow(audit))) {
  cat(sprintf("%-15s | %-55s | NES=%5.2f padj=%.2e | amb=%d/%d (%.0f%%) | %s\n",
              audit$cell_type[i], substr(audit$pathway[i], 1, 55),
              audit$NES[i], audit$padj[i],
              audit$n_ambient_genes[i], audit$n_le_genes[i],
              audit$ambient_fraction[i]*100, audit$recommendation[i]))
}

cat("\n=== DONE Steps 1-3 ===\n")
