#!/usr/bin/env Rscript
# Build full 10-gene marker panel with specificity-first approach
# Input:  Original Seurat object (for gene verification)
# Output: data/annotation_marker_genes.csv (140 genes, 14 cell types)
#
# Sources: Haber 2017, Moor 2018, Zwick 2024, Kim 2020, Timmermans 2024 + FindMarkers

suppressMessages({library(Seurat); library(tools)})

# ---- Configuration ----
base_dir   <- "."  # Path to the reproduce_plots/ directory
input_obj  <- "/path/to/DR26001_v2_annotated_seurat_singlets_with_replicates.rds"  # Original Seurat object

# Derived paths (do not edit below)
data_dir <- file.path(base_dir, "data")
dir.create(data_dir, showWarnings = FALSE, recursive = TRUE)

obj <- readRDS(input_obj)
DefaultAssay(obj) <- "RNA"
obj <- NormalizeData(obj, assay = "RNA", verbose = FALSE)
all_genes <- rownames(obj[["RNA"]])

# ---- CLU+ reserve stem cells ----
stem_genes <- c("Clu","Sox9","Olfm4","Prom1","Krt19","Areg","Anxa1","Tff2","Pgc","Agr2")
stem_src <- "[20]+FindMarkers"

# ---- TA cells/early progenitors ----
ta_genes <- c("Mki67","Stmn1","Birc5","Top2a","Cdk1","Cdca7","Tubb5","Hmgb2","Cenpu","Hmgn2")
ta_src <- "[20]+FindMarkers"

# ---- Bottom-Villus enterocytes ----
bottom_genes <- c("Fabp2","Fabp1","Rbp2","Apoa1","Aldob","Anpep","Reg1","Sis","Slc5a1","Apoa4")
bottom_src <- "[20,23]+FindMarkers"

# ---- Mid-villus enterocytes (includes Upper-villus/tip) ----
mid_genes <- c("Npc1l1","Mttp","Slc15a1","Slc5a1","Alpi","Apoa4","Aldob","Mep1b","Arg2","Sis")
mid_src <- "[20,23]+FindMarkers"

# ---- Goblet cells ----
goblet_genes <- c("Muc2","Agr2","Tff3","Zg16","Clca1","Klf4","Atoh1","Fer1l6","Ano7","Capn9")
goblet_src <- "[20]+FindMarkers"

# ---- Paneth cells ----
paneth_genes <- c("Lyz1","Defa22","Defa20","Defa24","Mmp7","Ang4","Itln1","Reg3g","Defa21","Defa5")
paneth_src <- "[19,20]+FindMarkers"

# ---- Enteroendocrine cells ----
ee_genes <- c("Chga","Chgb","Neurod1","Tph1","Scgn","Cpe","Tac1","Ghrl","Neurog3","Cck")
ee_src <- "[20]+FindMarkers"

# ---- T_helper cells ----
th_genes <- c("Cd3e","Il7r","Il2ra","Lef1","Tcf7","Cd28","Icos","Gata3","Camk4","Thy1")
th_src <- "[20]+FindMarkers"

# ---- Cd8aa IEL ----
cd8_genes <- c("Cd8a","Gzmb","Gzma","Ccl5","Nkg7","Itgae","Tbx21","Cd160","Cd7","Cd3g")
cd8_src <- "canonical+FindMarkers"

# ---- Plamsablasts ----
plasm_genes <- c("Jchain","Ighm","Mzb1","Cd79a","Cd19","Ms4a1","Igkc","Ighd","Pax5","Blk")
plasm_src <- "canonical+FindMarkers"

# ---- cDC1 ----
cdc_genes <- c("Xcr1","Itgax","Clec9a","Batf3","Wdfy4","Ccl22","Ccl17","Flt3","Zbtb46","Serpinb9")
cdc_src <- "canonical+FindMarkers"

# ---- Macrophages ----
mac_genes <- c("Adgre1","Csf1r","Mrc1","Cx3cr1","Mafb","C1qa","C1qb","Stab1","Pf4","Trem2")
mac_src <- "canonical+FindMarkers"

# ---- Fibroblasts (incl telocytes) ----
fibro_genes <- c("Pdgfra","Dcn","Col1a1","Gli1","Wnt2b","Grem1","Rspo3","Cxcl12","Bmp4","Acta2")
fibro_src <- "[10]+FindMarkers"

# ---- Blood vascular endothelial cells ----
endo_genes <- c("Pecam1","Cdh5","Kdr","Emcn","Plvap","Flt1","Podxl","Mmrn2","Fabp4","Ptprb")
endo_src <- "[10]+FindMarkers"

# ---- Build panel ----
panel <- list(
  "CLU+ reserve stem cells" = list(genes = stem_genes, src = stem_src),
  "TA cells/early progenitors" = list(genes = ta_genes, src = ta_src),
  "Bottom-Villus enterocytes" = list(genes = bottom_genes, src = bottom_src),
  "Mid-villus enterocytes" = list(genes = mid_genes, src = mid_src),
  "Goblet cells" = list(genes = goblet_genes, src = goblet_src),
  "Paneth cells" = list(genes = paneth_genes, src = paneth_src),
  "Enteroendocrine cells" = list(genes = ee_genes, src = ee_src),
  "T_helper cells" = list(genes = th_genes, src = th_src),
  "Cd8aa IEL" = list(genes = cd8_genes, src = cd8_src),
  "Plamsablasts" = list(genes = plasm_genes, src = plasm_src),
  "cDC1" = list(genes = cdc_genes, src = cdc_src),
  "Macrophages" = list(genes = mac_genes, src = mac_src),
  "Fibroblasts" = list(genes = fibro_genes, src = fibro_src),
  "Blood vascular endothelial cells" = list(genes = endo_genes, src = endo_src)
)

# ---- Verify all genes present ----
rows <- list()
for (ct in names(panel)) {
  genes <- panel[[ct]]$genes
  src <- panel[[ct]]$src
  missing <- genes[!genes %in% all_genes]
  if (length(missing) > 0) cat("MISSING in", ct, ":", paste(missing, collapse=", "), "\n")
  for (i in seq_along(genes)) {
    rows[[length(rows)+1]] <- data.frame(
      broad_cell_type = ct, gene = genes[i], gene_order = i,
      literature_source = src, stringsAsFactors = FALSE
    )
  }
}
df <- do.call(rbind, rows)
cat("Panel:", nrow(df), "rows,", length(unique(df$broad_cell_type)), "types,",
    length(unique(df$gene)), "unique genes\n")

out <- file.path(data_dir, "annotation_marker_genes.csv")
write.csv(df, out, row.names = FALSE)
cat("Saved:", out, "\n")

dups <- df$gene[duplicated(df$gene)]
if (length(dups) > 0) cat("Duplicate genes:", paste(unique(dups), collapse=", "), "\n")
