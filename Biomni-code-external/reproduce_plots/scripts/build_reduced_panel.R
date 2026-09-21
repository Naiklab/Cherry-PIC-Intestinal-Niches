#!/usr/bin/env Rscript
# Build reduced canonical marker panel (5-6 genes per cell type)
# from the full 10-gene panel, preserving literature_source.
# Input:  data/annotation_marker_genes.csv
# Output: data/annotation_marker_genes_reduced.csv (76 genes, 14 types)

# ---- Configuration ----
base_dir <- "."  # Path to the reproduce_plots/ directory

# Derived paths (do not edit below)
data_dir <- file.path(base_dir, "data")

full <- read.csv(file.path(data_dir, "annotation_marker_genes.csv"), stringsAsFactors = FALSE)

# Curated canonical marker lists (5-6 per type, annotation-defining)
reduced <- list(
  "CLU+ reserve stem cells"          = c("Clu","Sox9","Olfm4","Prom1","Krt19","Anxa1"),
  "TA cells/early progenitors"       = c("Mki67","Top2a","Birc5","Stmn1","Cdk1"),
  "Bottom-Villus enterocytes"        = c("Fabp2","Fabp1","Rbp2","Apoa1","Aldob","Reg1"),
  "Mid-villus enterocytes"           = c("Npc1l1","Mttp","Slc15a1","Alpi","Apoa4"),
  "Goblet cells"                     = c("Muc2","Agr2","Tff3","Zg16","Clca1"),
  "Paneth cells"                     = c("Lyz1","Defa24","Mmp7","Ang4","Itln1"),
  "Enteroendocrine cells"            = c("Chga","Chgb","Neurod1","Tph1","Cpe"),
  "T_helper cells"                   = c("Cd3e","Il7r","Tcf7","Lef1","Cd28"),
  "Cd8aa IEL"                        = c("Cd8a","Cd3g","Itgae","Cd160","Nkg7","Ccl5"),
  "Plamsablasts"                     = c("Jchain","Mzb1","Cd79a","Ighm","Ms4a1"),
  "cDC1"                             = c("Xcr1","Clec9a","Batf3","Zbtb46","Itgax","Flt3"),
  "Macrophages"                      = c("Adgre1","Csf1r","C1qa","Mrc1","Cx3cr1"),
  "Fibroblasts"                      = c("Pdgfra","Dcn","Col1a1","Cxcl12","Rspo3","Acta2"),
  "Blood vascular endothelial cells" = c("Pecam1","Cdh5","Kdr","Flt1","Emcn")
)

rows <- list()
for (ct in names(reduced)) {
  genes <- reduced[[ct]]
  for (i in seq_along(genes)) {
    g <- genes[i]
    src <- full$literature_source[full$broad_cell_type == ct & full$gene == g]
    src <- if (length(src) >= 1) src[1] else NA_character_
    rows[[length(rows)+1]] <- data.frame(
      broad_cell_type = ct, gene = g, gene_order = i,
      literature_source = src, stringsAsFactors = FALSE
    )
  }
}
panel <- do.call(rbind, rows)

# Sanity: all genes must exist in full panel
missing <- panel$gene[is.na(panel$literature_source)]
if (length(missing) > 0) cat("WARNING: no source found for:", paste(missing, collapse=", "), "\n")

out <- file.path(data_dir, "annotation_marker_genes_reduced.csv")
write.csv(panel, out, row.names = FALSE)
cat("Saved:", out, "|", nrow(panel), "genes across",
    length(unique(panel$broad_cell_type)), "types\n")

# Report per-type counts and duplicate check
tab <- table(panel$broad_cell_type)
print(tab)
dups <- names(which(table(panel$gene) > 1))
cat("Duplicate genes across types:", if (length(dups)) paste(dups, collapse=", ") else "none", "\n")
