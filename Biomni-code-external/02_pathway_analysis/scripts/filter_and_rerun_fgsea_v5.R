###############################################################################
# Contamination filtering + FGSEA re-run (v5 — secondary filter only on LE)
#
# v4 showed the primary filter (mean >= 1) removes ~300k leading-edge genes —
# far too many, since scRNA-seq raw counts are sparse and most real genes have
# mean < 1. The primary filter was useful for IDENTIFYING contamination scope
# but is too aggressive for ACTUAL removal.
#
# Final approach:
#   1. Run FGSEA on original unfiltered pseudobulk rankings (all genes)
#   2. Apply ONLY the secondary filter to leading-edge genes:
#      Remove curated cell-type-specific markers from non-target lineages
#      (literature-validated: Paneth, Goblet, Enterocyte, Enteroendocrine,
#       Plasmablast markers)
#   3. Keep all other leading-edge genes (including low-expression real genes)
#   4. Save filtered FGSEA results
###############################################################################


.here <- local({a <- commandArgs(FALSE); f <- sub("^--file=", "", a[grep("^--file=", a)])
          if (length(f)) dirname(normalizePath(f)) else getwd()})
DATA <- normalizePath(file.path(.here, "..", "data"), mustWork = FALSE)

suppressMessages({
  library(fgsea)
  library(msigdbr)
  library(dplyr)
  library(tibble)
  library(tidyr)
})
set.seed(42)

pb_dir <- normalizePath(file.path(.here, "..", "..", "03_shared_data", "pseudobulk_new"), mustWork = FALSE)
pb_stem_dir <- pb_dir   # stem-cell pseudobulk now lives alongside the rest
out_dir <- normalizePath(file.path(.here, "..", "outputs", "pathways_filtered"), mustWork = FALSE)
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

# ---- 1. Contamination filter definitions ----

epithelial <- c("Stem_cells", "TA_cells", "Paneth cells", "Goblet cells",
                "Enteroendocrine cells", "Mid-villus enterocytes",
                "Upper-villus enterocytes", "Bottom-Villus enterocytes")
immune <- c("Activated/helper-like T cells", "Cd8aa IEL", "Plamsablasts",
            "Resident macrophages", "Monocyte-derived macrophages",
            "Proliferating resident macrophages", "cDC1")

paneth_markers <- c("Defa3","Defa5","Defa17","Defa21","Defa22","Defa23","Defa24",
                    "Defa26","Defa29","Defa30","Defa34","Defa36","Itln1","Mptx2",
                    "Ang4","Reg3g","Reg3b")
goblet_markers <- c("Zg16","Tff3","Muc2","Fcgbp","Agr2","Spink4","Clca1","Guca2a")
enterocyte_markers <- c("Fabp1","Fabp2","Fabp6","Rbp2","Sis","Prap1")
enteroendocrine_markers <- c("Cck","Chgb","Chga","Ghrl","Gcg","Pyy","Sst","Sct",
                             "Gip","Tph1")
plasmablast_markers <- c("Igha","Igkc","Jchain","Iglv1","Iglc1")

keep_genes <- c("Lgals3","Crip1","Plac8","Sparc","Mgp","Dcn","Col1a1","Col3a1",
                "Dbi","Anpep","Krt8","Krt19","Lgals2","Lyz1","Apoa1","Apoa4","Apoc2")

get_removal_set <- function(seurat_types) {
  is_epi <- any(seurat_types %in% epithelial)
  is_imm <- any(seurat_types %in% immune)
  removal <- c()
  if (!is_epi) removal <- c(removal, paneth_markers, goblet_markers,
                            enterocyte_markers, enteroendocrine_markers)
  if (!is_imm) removal <- c(removal, plasmablast_markers)
  setdiff(unique(removal), keep_genes)
}

# ---- 2. Cell type mapping ----

cell_types <- list(
  list(name = "Endothelial",
       pb_file = "pseudobulk_Blood_vascular_endothelial_cells_Ileum_vs_Duodenum.csv",
       pb_dir = pb_dir, seurat_types = "Blood vascular endothelial cells"),
  list(name = "Macrophages",
       pb_file = "pseudobulk_Macrophages_Ileum_vs_Duodenum.csv",
       pb_dir = pb_dir, seurat_types = c("Resident macrophages", "Monocyte-derived macrophages",
                        "Proliferating resident macrophages")),
  list(name = "Fibroblasts",
       pb_file = "pseudobulk_Fibroblasts_Ileum_vs_Duodenum.csv",
       pb_dir = pb_dir, seurat_types = c("FOXL1+ fibroblasts", "GREM1+ fibroblasts")),
  list(name = "Bottom-villus EC",
       pb_file = "pseudobulk_Bottom-Villus_enterocytes_Ileum_vs_Duodenum.csv",
       pb_dir = pb_dir, seurat_types = "Bottom-Villus enterocytes"),
  list(name = "Plasmablasts",
       pb_file = "pseudobulk_Plasmablasts_Ileum_vs_Duodenum.csv",
       pb_dir = pb_dir, seurat_types = "Plamsablasts"),
  list(name = "Stem cells",
       pb_file = "pseudobulk_Stem_cells_Ileum_vs_Duodenum.csv",
       pb_dir = pb_stem_dir, seurat_types = "Stem_cells"),
  list(name = "cDC1",
       pb_file = "pseudobulk_cDC1_Ileum_vs_Duodenum.csv",
       pb_dir = pb_dir, seurat_types = "cDC1")
)

# ---- 3. Build gene sets ----

cat("Building msigdbr gene sets...\n")
collections <- list(
  Hallmark = msigdbr(species = "Mus musculus", collection = "H"),
  KEGG = msigdbr(species = "Mus musculus", collection = "C2", subcollection = "CP:KEGG_LEGACY"),
  Reactome = msigdbr(species = "Mus musculus", collection = "C2", subcollection = "CP:REACTOME"),
  WikiPathways = msigdbr(species = "Mus musculus", collection = "C2", subcollection = "CP:WIKIPATHWAYS"),
  BioCarta = msigdbr(species = "Mus musculus", collection = "C2", subcollection = "CP:BIOCARTA"),
  GOBP = msigdbr(species = "Mus musculus", collection = "C5", subcollection = "GO:BP"),
  GOCC = msigdbr(species = "Mus musculus", collection = "C5", subcollection = "GO:CC"),
  GOMF = msigdbr(species = "Mus musculus", collection = "C5", subcollection = "GO:MF")
)

coll_codes <- list(Hallmark="MH", KEGG="M2", Reactome="M2", WikiPathways="M2",
                   BioCarta="M2", GOBP="M5", GOCC="M5", GOMF="M5")
coll_subcoll <- list(Hallmark=NA, KEGG="CP:KEGG_LEGACY", Reactome="CP:REACTOME",
                     WikiPathways="CP:WIKIPATHWAYS", BioCarta="CP:BIOCARTA",
                     GOBP="GO:BP", GOCC="GO:CC", GOMF="GO:MF")

all_pathways <- list()
pathway_meta <- data.frame()
for (cname in names(collections)) {
  gs <- collections[[cname]] %>%
    select(gs_name, gene_symbol) %>%
    split(.$gs_name) %>%
    lapply(function(x) as.character(x$gene_symbol))
  all_pathways <- c(all_pathways, gs)
  pathway_meta <- bind_rows(pathway_meta, data.frame(
    pathway = names(gs), gs_collection = coll_codes[[cname]],
    gs_subcollection = coll_subcoll[[cname]], stringsAsFactors = FALSE))
}
cat(sprintf("Total gene sets: %d\n", length(all_pathways)))

# ---- 4. Process each cell type ----

all_removed <- data.frame()

for (ct_entry in cell_types) {
  name <- ct_entry$name
  cat(sprintf("\n========== %s ==========\n", name))

  # Load pseudobulk and rank ALL genes
  pb_path <- file.path(ct_entry$pb_dir, ct_entry$pb_file)
  pb <- read.csv(pb_path, stringsAsFactors = FALSE)
  ranked <- pb %>%
    filter(!is.na(pvalue), pvalue > 0, !is.na(log2FoldChange)) %>%
    mutate(stat = sign(log2FoldChange) * -log10(pvalue)) %>%
    arrange(desc(stat)) %>%
    select(gene, stat) %>%
    deframe()
  cat(sprintf("  Ranked: %d genes\n", length(ranked)))

  # Run FGSEA on unfiltered ranking
  fg <- fgsea(pathways = all_pathways, stats = ranked,
              minSize = 10, maxSize = 500, eps = 0)
  fg_df <- as.data.frame(fg)

  # Get removal set
  removal_set <- get_removal_set(ct_entry$seurat_types)
  cat(sprintf("  Removal set: %d curated markers\n", length(removal_set)))

  # Filter leading-edge genes: remove only curated markers
  filter_le <- function(le_vec) {
    le_genes <- as.character(le_vec)
    n_before <- length(le_genes)
    passed <- setdiff(le_genes, removal_set)
    removed <- setdiff(le_genes, passed)
    if (length(removed) > 0) {
      all_removed <<- bind_rows(all_removed, data.frame(
        cell_type = name, gene = removed, stringsAsFactors = FALSE))
    }
    list(
      le = paste(passed, collapse = "/"),
      n_before = n_before,
      n_after = length(passed),
      removed = paste(removed, collapse = "/")
    )
  }

  fg_filtered <- fg_df %>%
    rowwise() %>%
    mutate(
      res = list(filter_le(leadingEdge)),
      leadingEdge_orig = paste(as.character(leadingEdge), collapse = "/"),
      leadingEdge = res$le,
      n_le_before = res$n_before,
      n_le_after = res$n_after,
      removed_genes = res$removed
    ) %>%
    ungroup() %>%
    select(-res) %>%
    left_join(pathway_meta, by = "pathway") %>%
    select(pathway, pval, padj, log2err, ES, NES, size, leadingEdge,
           gs_collection, gs_subcollection, n_le_before, n_le_after, removed_genes) %>%
    arrange(padj)

  # Save
  out_fg <- file.path(out_dir, paste0("fgsea_filtered_", gsub(" ", "_", name),
                                       "_Ileum_vs_Duodenum.csv"))
  write.csv(fg_filtered, out_fg, row.names = FALSE)

  sig <- fg_filtered %>% filter(padj < 0.05)
  sig_with_removal <- sig %>% filter(n_le_after < n_le_before)
  cat(sprintf("  Significant: %d | With removed LE genes: %d | Genes removed: %d\n",
              nrow(sig), nrow(sig_with_removal),
              sum(sig_with_removal$n_le_before - sig_with_removal$n_le_after)))

  if (nrow(sig_with_removal) > 0) {
    cat("  Removed from significant pathways:\n")
    removed_sig <- sig_with_removal %>%
      filter(removed_genes != "") %>%
      select(pathway, n_le_before, n_le_after, removed_genes) %>%
      head(10)
    for (i in seq_len(nrow(removed_sig))) {
      cat(sprintf("    %s: %d->%d (%s)\n", substr(removed_sig$pathway[i], 1, 50),
                  removed_sig$n_le_before[i], removed_sig$n_le_after[i],
                  removed_sig$removed_genes[i]))
    }
  }
}

# Save removal log
write.csv(all_removed, file.path(out_dir, "contamination_removal_log.csv"), row.names = FALSE)
cat(sprintf("\nTotal curated marker genes removed from ALL leading-edge lists: %d\n",
            nrow(all_removed)))
cat("Unique genes removed:", paste(unique(all_removed$gene), collapse = ", "), "\n")
cat("\n=== DONE ===\n")
