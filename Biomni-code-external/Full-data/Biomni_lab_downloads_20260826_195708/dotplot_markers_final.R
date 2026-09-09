#!/usr/bin/env Rscript
# =============================================================================
# Dot plot generation: curated annotation markers for mouse intestinal scRNA-seq
# =============================================================================
#
# Description:
#   Generates compact dot plots of curated annotation markers for all cell
#   populations in a mouse intestinal single-cell dataset. Produces 3
#   compartment-specific plots (Immune, Epithelia, Stroma), each in two color
#   scales (z-score and log1p), plus a companion CSV of expression values.
#
# Gene selection strategy:
#   - Single-cluster populations: keep only canonical markers (5-6 per pop,
#     7 for Early progenitors). See canonical_single list below.
#   - Merged populations (>=2 clusters sharing same broad group): hybrid
#     selection capped at 4 genes total:
#       1. Core genes = curated markers shared by >=2 subclusters, ordered
#          by minimum gene_slot
#       2. If core exceeds cap, keep top N core genes
#       3. If core < cap, fill with unique genes (1 subcluster only), rotating
#          between subclusters in cluster-number order
#   - Pan-fibroblast markers (6): Col1a1, Col1a2, Col3a1, Vim, Pdgfra, Pdgfrb
#     added to Stroma x-axis, shown across all stromal populations
#   - Pan-endothelial marker (1): Pecam1, added to Stroma x-axis
#
# Population merges:
#   - All 6 Cd8aa IEL clusters (1, 3, 5, 10, 33, 39) merged into one group
#   - Fibroblasts split into 3 sub-groups:
#       Activated interstitial: clusters 4, 6, 12
#       Myofibroblasts:         clusters 9, 16
#       Telocyte-like:          cluster 42
#
# Plot aesthetics:
#   - Reversed inferno palette (yellow=low, dark=high)
#   - Dots: shape 21 (filled circle + border), 0.25pt black border
#   - Dot size range: 0.8-5mm, mapped to % expressing
#   - Zero-expression: no dot drawn (filtered out)
#   - theme_classic: no grid lines, no grey background
#   - Font: Liberation Sans, 6pt axis text, 10pt title
#   - Dimensions: 12 x 3.75 inches at 300 dpi
#
# Input:
#   /mnt/user-uploads/Master.Obj.rds
#     - 5.5 GB Seurat object, 29,335 genes x 74,598 cells
#     - Assays: RNA (split per-sample layers), SCT (default), HTO
#     - Clustering: SCT_snn_res.1.2 (43 levels, 0-42)
#
#   /mnt/user-uploads/curated_10_genes_per_cluster_res1_2.xlsx
#     - Sheet "Curated 10 genes": 43 clusters x 10 genes with annotations
#     - Sheet "Marker validation": log2FC, pct.1, pct.2, p_val_adj
#     - Clusters 34 and 41 have no curated markers (NA)
#
# Output:
#   /mnt/results/dotplot_immune_zscore_compact.png/.svg
#   /mnt/results/dotplot_immune_log1p_compact.png/.svg
#   /mnt/results/dotplot_epithelia_zscore_compact.png/.svg
#   /mnt/results/dotplot_epithelia_log1p_compact.png/.svg
#   /mnt/results/dotplot_stroma_zscore_compact.png/.svg
#   /mnt/results/dotplot_stroma_log1p_compact.png/.svg
#   /mnt/results/dotplot_marker_expression_data_hybrid.csv
#
# Requirements:
#   - R with Seurat, ggplot2, dplyr, tidyr, readxl, Matrix, svglite
#   - >= 64 GB RAM (5.5 GB Seurat object)
#   - Copy this script to local disk before running (S3 mount can truncate)
#
# Usage:
#   Rscript dotplot_markers_final.R
#
# =============================================================================

suppressPackageStartupMessages({
  library(Seurat)
  library(SeuratObject)
  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(readxl)
  library(Matrix)
  library(svglite)
})

options(timeout = 1200)
set.seed(1)

# ---- 1. Load Seurat object ----
cat("Loading Seurat object...\n")
t0 <- Sys.time()
obj <- readRDS("/mnt/user-uploads/Master.Obj.rds")
cat(sprintf("Loaded in %.1f min. Dim: %d genes x %d cells\n",
            as.numeric(difftime(Sys.time(), t0, units = "mins")),
            nrow(obj), ncol(obj)))

# ---- 2. Read curated markers xlsx, all 10 genes per cluster ----
cat("Reading curated markers xlsx...\n")
xl <- "/mnt/user-uploads/curated_10_genes_per_cluster_res1_2.xlsx"
markers <- read_excel(xl, sheet = "Curated 10 genes") %>%
  filter(!is.na(Cluster)) %>%
  select(Cluster, population_name = `Population annotation`,
         compartment = Compartment, broad = Broad,
         `Gene 1`:`Gene 10`) %>%
  pivot_longer(cols = starts_with("Gene "),
               names_to = "gene_slot", values_to = "gene") %>%
  mutate(gene_slot = as.integer(gsub("Gene ", "", gene_slot))) %>%
  arrange(Cluster, gene_slot) %>%
  mutate(Cluster = as.integer(Cluster))

cat(sprintf("Marker table: %d rows, %d unique genes, %d clusters\n",
            nrow(markers), length(unique(markers$gene)),
            length(unique(markers$Cluster))))

# ---- 3. Set Idents to SCT_snn_res.1.2 ----
Idents(obj) <- "SCT_snn_res.1.2"
cat("Idents set to SCT_snn_res.1.2. Levels:", length(levels(Idents(obj))), "\n")

# ---- 4. RNA assay: join layers + normalize ----
DefaultAssay(obj) <- "RNA"
cat("Joining split RNA layers...\n")
obj <- JoinLayers(obj, assay = "RNA")
cat("Normalizing RNA assay...\n")
obj <- NormalizeData(obj, assay = "RNA", verbose = FALSE)
rna_data <- GetAssayData(obj, assay = "RNA", layer = "data")
cat("RNA data dim:", paste(dim(rna_data), collapse = " x "),
    " range:", paste(round(range(rna_data, na.rm = TRUE), 2), collapse = " to "), "\n")

# ---- 5. Build Broad group mapping ----
# Custom fibroblast grouping: split into 3 sub-groups
# Group 1: clusters 4, 6, 12 (Activated interstitial + CD34 interstitial + Activated)
# Group 2: clusters 9, 16 (Myofibroblasts + PDGFRA myofibroblasts)
# Group 3: cluster 42 (PDGFRA telocyte-like)
broad_map <- markers %>%
  select(Cluster, broad, compartment) %>%
  distinct() %>%
  arrange(compartment, broad, Cluster)

# Override Fibroblasts with 3 sub-groups + merge Cd8aa IEL
fib_group1 <- c(4, 6, 12)   # Activated/interstitial fibroblasts
fib_group2 <- c(9, 16)      # Myofibroblasts
fib_group3 <- c(42)          # Telocyte-like

broad_map <- broad_map %>%
  mutate(broad = case_when(
    Cluster %in% fib_group1 ~ "Fibroblasts_activated_interstitial",
    Cluster %in% fib_group2 ~ "Fibroblasts_myofibroblasts",
    Cluster %in% fib_group3 ~ "Fibroblasts_telocyte_like",
    broad %in% c("Cd8aa _IEL", "Cd8aa_IEL") ~ "Cd8aa_IEL",
    TRUE ~ broad
  ))

cat(sprintf("Broad groups: %d (Fibroblasts split into 3, Cd8aa IEL merged)\n", nrow(broad_map)))
cat("Stroma broad groups:\n")
print(broad_map %>% filter(compartment == "Stroma") %>% arrange(Cluster))

# ---- 5b. Hybrid gene selection for merged populations ----
# Single clusters: keep only canonical markers (5-6 per population)
# Merged populations (>=2 clusters sharing same broad): core genes (shared by >=2
#   subclusters) + top-ranked unique genes rotating between subclusters, capped at 4
HYBRID_CAP <- 4

# Canonical markers for single-cluster populations (cluster -> genes in curator's order)
canonical_single <- list(
  # Immune
  `1`  = c("Cd8a","Cd3e","Trdc","Nkg7","Gzma","Itgae"),
  `14` = c("C1qa","Csf1r","Lyz2","Cd68","Mrc1"),
  `15` = c("Igha","Sdc1","Xbp1","Jchain","Mzb1"),
  `19` = c("Il22","Il7r","Il18r1","Cxcr6","Rora"),
  `20` = c("Cd4","Tcf7","Ccr7","Lef1","Trac"),
  `37` = c("Siglech","Flt3","Tcf4","Bst2","Pld4"),
  `40` = c("Flt3","Batf3","Irf8","Itgax","Zbtb46"),
  # Epithelia
  `2`  = c("Lgr5","Olfm4","Axin2","Sox9","Smoc2"),
  `11` = c("Car1","Lgals4","Krt19","Krt8","Selenbp1"),
  `24` = c("Fabp6","Slc51a","Reg3g","Sis","Slc51b"),
  `28` = c("Dclk1","Trpm5","Chat","Gng13","Avil"),
  `29` = c("Cdc20","Ccnb2","Ccna2","Birc5","Ube2c","Klf5","Hnf4a"),
  `31` = c("Atoh1","Spdef","Agr2","Mmp7","Reg4"),
  `32` = c("Chga","Chgb","Neurod1","Insm1","Rfx6"),
  # Stroma
  `21` = c("Kdr","Flt1","Emcn","Egfl7","Plvap"),
  `25` = c("Rgs5","Notch3","Cspg4","Pdgfrb","Acta2"),
  `26` = c("Prox1","Lyve1","Flt4","Ccl21a","Mmrn1"),
  `30` = c("Gfap","Plp1","Cadm4","Lgi4","Scn7a")
)

cat(sprintf("\n--- Hybrid gene selection (cap=%d for merged groups) ---\n", HYBRID_CAP))

# For each broad group, determine which genes to keep
# Returns a data frame: broad, gene, gene_slot (for ordering)
hybrid_genes_by_broad <- list()

broad_groups <- broad_map %>%
  arrange(compartment, Cluster) %>%
  group_by(broad) %>%
  summarise(clusters = list(sort(unique(Cluster))),
            n_clusters = n(),
            compartment = first(compartment),
            .groups = "drop")

for (i in seq_len(nrow(broad_groups))) {
  bg <- broad_groups$broad[i]
  clusters <- broad_groups$clusters[[i]]
  comp <- broad_groups$compartment[i]
  n_clu <- broad_groups$n_clusters[i]

  if (n_clu <= 1) {
    # Single cluster: keep only canonical markers
    clu_str <- as.character(clusters[1])
    if (clu_str %in% names(canonical_single)) {
      clu_genes <- canonical_single[[clu_str]]
    } else {
      # Fallback: keep all 10 if no canonical list defined
      clu_genes <- markers %>%
        filter(Cluster == clusters[1]) %>%
        arrange(gene_slot) %>%
        pull(gene)
      cat(sprintf("  WARNING: no canonical list for cluster %d, keeping all 10\n", clusters[1]))
    }
    # Preserve curator's order via gene_slot lookup
    slot_lookup <- markers %>% filter(Cluster == clusters[1]) %>% select(gene, gene_slot)
    slots <- sapply(clu_genes, function(g) {
      s <- slot_lookup %>% filter(gene == g) %>% pull(gene_slot)
      if (length(s) > 0) s[1] else NA
    })
    hybrid_genes_by_broad[[bg]] <- tibble(
      broad = bg, gene = clu_genes, gene_slot = slots)
    cat(sprintf("  %s (cluster %d): %d genes [single, canonical]\n", bg, clusters[1], length(clu_genes)))
  } else {
    # Merged: find core (shared by >=2 subclusters) and unique genes
    gene_clusters <- markers %>%
      filter(Cluster %in% clusters) %>%
      select(Cluster, gene, gene_slot) %>%
      distinct()

    gene_count <- gene_clusters %>%
      group_by(gene) %>%
      summarise(n_subclusters = n_distinct(Cluster),
                min_slot = min(gene_slot),
                .groups = "drop")

    core_genes <- gene_count %>%
      filter(n_subclusters >= 2) %>%
      arrange(min_slot) %>%
      pull(gene)

    # Unique genes: only in 1 subcluster, keep their slot from that cluster
    unique_genes <- gene_clusters %>%
      filter(gene %in% (gene_count %>% filter(n_subclusters == 1) %>% pull(gene))) %>%
      arrange(Cluster, gene_slot)

    # Cap applies to TOTAL (core + unique)
    # If core alone exceeds cap, keep only top-ranked core genes
    if (length(core_genes) > HYBRID_CAP) {
      core_genes <- head(core_genes, HYBRID_CAP)
      unique_selected <- c()
    } else {
      # Fill remaining slots with unique genes, rotating between subclusters
      unique_selected <- c()
      cluster_order <- sort(clusters)
      remaining <- unique_genes %>% arrange(Cluster, gene_slot)

      while (nrow(remaining) > 0 && (length(core_genes) + length(unique_selected)) < HYBRID_CAP) {
        for (clu in cluster_order) {
          if (nrow(remaining) == 0) break
          if ((length(core_genes) + length(unique_selected)) >= HYBRID_CAP) break
          # Pick lowest-slot gene from this cluster
          row <- remaining %>% filter(Cluster == clu) %>% arrange(gene_slot) %>% slice(1)
          if (nrow(row) > 0) {
            unique_selected <- c(unique_selected, row$gene)
            remaining <- remaining %>% filter(!(gene == row$gene))
          }
        }
      }
    }

    selected <- c(core_genes, unique_selected)
    # Build slot mapping: core genes get their min_slot, unique get their slot
    slot_map <- gene_clusters %>%
      filter(gene %in% selected) %>%
      group_by(gene) %>%
      summarise(gene_slot = min(gene_slot), .groups = "drop")

    hybrid_genes_by_broad[[bg]] <- tibble(
      broad = bg,
      gene = selected,
      gene_slot = slot_map$gene_slot[match(selected, slot_map$gene)])

    cat(sprintf("  %s (clusters %s): %d core + %d unique = %d genes [merged, cap=%d]\n",
                bg, paste(clusters, collapse=","),
                length(core_genes), length(unique_selected),
                length(selected), HYBRID_CAP))
  }
}

# Combine into one data frame
hybrid_gene_map <- bind_rows(hybrid_genes_by_broad)
cat(sprintf("Total hybrid gene-broad pairs: %d\n", nrow(hybrid_gene_map)))

# ---- 6. Assign Broad identity to each cell ----
cluster_to_broad <- setNames(as.character(broad_map$broad),
                             as.character(broad_map$Cluster))
cell_clusters <- as.character(Idents(obj))
cell_broad <- cluster_to_broad[cell_clusters]
cat("Cells with NA broad (clusters 34/41):", sum(is.na(cell_broad)), "\n")

# ---- 7. Define gene set: curated + pan-fibroblast + pan-endothelial markers ----
curated_genes <- unique(markers$gene)
pan_fib_markers <- c("Col1a1","Col1a2","Col3a1","Vim","Pdgfra","Pdgfrb")
pan_endo_markers <- c("Pecam1")
# Check presence
pan_fib_present <- intersect(pan_fib_markers, rownames(rna_data))
pan_fib_missing <- setdiff(pan_fib_markers, rownames(rna_data))
if (length(pan_fib_missing) > 0) {
  cat("Pan-fibroblast markers not in object:", paste(pan_fib_missing, collapse=", "), "\n")
}
cat(sprintf("Pan-fibroblast markers present: %d / %d\n",
            length(pan_fib_present), length(pan_fib_markers)))

pan_endo_present <- intersect(pan_endo_markers, rownames(rna_data))
pan_endo_missing <- setdiff(pan_endo_markers, rownames(rna_data))
if (length(pan_endo_missing) > 0) {
  cat("Pan-endothelial markers not in object:", paste(pan_endo_missing, collapse=", "), "\n")
}
cat(sprintf("Pan-endothelial markers present: %d / %d\n",
            length(pan_endo_present), length(pan_endo_markers)))

# All genes to compute: curated + pan-fibroblast + pan-endothelial
all_genes <- union(union(curated_genes, pan_fib_present), pan_endo_present)
missing_genes <- setdiff(all_genes, rownames(rna_data))
if (length(missing_genes) > 0) {
  cat("WARNING: genes not found in object:", paste(missing_genes, collapse=", "), "\n")
}
present_genes <- intersect(all_genes, rownames(rna_data))
cat(sprintf("Total genes to compute: %d (present: %d)\n",
            length(all_genes), length(present_genes)))

expr_sub <- rna_data[present_genes, , drop = FALSE]

# ---- 8. Compute per-Broad-group statistics (pool all cells) ----
cat("Computing per-Broad-group statistics...\n")
broad_order <- broad_map %>%
  arrange(compartment, Cluster) %>%
  pull(broad) %>% unique()
broad_levels <- broad_order

avg_exp_mat <- matrix(NA_real_, nrow = length(present_genes),
                      ncol = length(broad_levels),
                      dimnames = list(present_genes, broad_levels))
pct_exp_mat <- matrix(NA_real_, nrow = length(present_genes),
                      ncol = length(broad_levels),
                      dimnames = list(present_genes, broad_levels))

for (i in seq_along(broad_levels)) {
  bl <- broad_levels[i]
  cells <- which(cell_broad == bl)
  if (length(cells) == 0) next
  sub <- expr_sub[, cells, drop = FALSE]
  avg_exp_mat[, i] <- Matrix::rowMeans(sub)
  pct_exp_mat[, i] <- Matrix::rowSums(sub > 0) / length(cells)
}

# ---- 9. Build tidy data frame ----
avg_long <- as.data.frame(as.table(avg_exp_mat))
colnames(avg_long) <- c("gene", "broad", "avg_exp")
avg_long$gene <- as.character(avg_long$gene)

pct_long <- as.data.frame(as.table(pct_exp_mat))
colnames(pct_long) <- c("gene", "broad", "pct_exp")
pct_long$gene <- as.character(pct_long$gene)

plot_df <- merge(avg_long, pct_long, by = c("gene", "broad"))

# Attach compartment per broad group
broad_comp_map <- broad_map %>%
  select(broad, compartment) %>%
  distinct()

plot_df <- plot_df %>%
  left_join(broad_comp_map, by = "broad")

# Gene ordering: curated genes by primary cluster then gene_slot
gene_order <- markers %>%
  group_by(gene) %>%
  summarise(primary_cluster = min(Cluster),
            primary_slot = min(gene_slot[Cluster == min(Cluster)]),
            .groups = "drop") %>%
  arrange(primary_cluster, primary_slot) %>%
  mutate(gene_order_idx = row_number())

plot_df <- plot_df %>%
  left_join(gene_order %>% select(gene, gene_order_idx), by = "gene")

# Pan-fibroblast + pan-endothelial markers get gene_order_idx = 0 (placed first in Stroma)
plot_df <- plot_df %>%
  mutate(gene_order_idx = ifelse(gene %in% c(pan_fib_present, pan_endo_present), 0, gene_order_idx))

# Exclude NA compartment
plot_df <- plot_df %>% filter(!is.na(compartment))

# Compute z-score per gene within each compartment
plot_df <- plot_df %>%
  group_by(gene, compartment) %>%
  mutate(z_score = scale(avg_exp)[, 1]) %>%
  ungroup()

# Compute log1p of avg expression
plot_df <- plot_df %>%
  mutate(log1p_exp = log1p(avg_exp))

cat(sprintf("Plot data: %d rows\n", nrow(plot_df)))

# ---- 10. Save companion CSV ----
csv_out <- "/mnt/results/dotplot_marker_expression_data_hybrid.csv"

# For CSV: only hybrid-selected gene-broad pairs + pan-marker-stroma pairs
csv_df <- plot_df %>%
  inner_join(hybrid_gene_map %>% select(broad, gene), by = c("gene", "broad")) %>%
  bind_rows(
    plot_df %>% filter(compartment == "Stroma", gene %in% c(pan_fib_present, pan_endo_present))
  ) %>%
  distinct() %>%
  select(broad, compartment, gene, avg_exp, z_score, log1p_exp, pct_exp, gene_order_idx) %>%
  arrange(compartment, broad, gene_order_idx, gene) %>%
  select(-gene_order_idx)
write.csv(csv_df, csv_out, row.names = FALSE)
cat("Saved CSV:", csv_out, "(", nrow(csv_df), "rows)\n")

# ---- 11. Build plots: 3 compartments x 2 scales = 6 plots ----
comp_order <- c("Immune", "Epithelia", "Stroma")
scale_types <- c("zscore", "log1p")

# Reversed inferno palette: bright yellow (low) -> dark purple/black (high)
inferno_rev <- c("#FCFFA4", "#F7D13D", "#FB9A06", "#ED6925", "#CF4446",
                  "#A52C60", "#781C6D", "#4A0C6B", "#1B0C42", "#000004")

pretty_broad <- function(b) gsub("_", " ", b)

for (comp in comp_order) {
  cat(sprintf("\n=== Building %s plots ===\n", comp))

  # Broad groups in this compartment
  comp_broads <- broad_map %>%
    filter(compartment == !!comp) %>%
    arrange(Cluster) %>%
    pull(broad) %>% unique()

  # Genes for this compartment: use hybrid-selected genes
  comp_hybrid_genes <- hybrid_gene_map %>%
    filter(broad %in% comp_broads) %>%
    pull(gene) %>% unique()

  # For Stroma: add pan-fibroblast + pan-endothelial markers at the beginning
  if (comp == "Stroma") {
    comp_genes <- c(sort(pan_fib_present), sort(pan_endo_present), comp_hybrid_genes)
  } else {
    comp_genes <- comp_hybrid_genes
  }

  # Filter plot data to this compartment's genes and broads
  # Exclude zero-expression dots (no dot drawn where avg_exp == 0)
  df_comp <- plot_df %>%
    filter(compartment == !!comp, gene %in% comp_genes, avg_exp > 0)

  # Gene ordering: pan-markers first (alphabetical), then hybrid-selected (block-diagonal)
  # Deduplicate: pan-markers that are also in hybrid genes appear once at the front
  if (comp == "Stroma") {
    hybrid_ordered <- gene_order %>%
      filter(gene %in% comp_hybrid_genes) %>%
      arrange(gene_order_idx) %>%
      pull(gene)
    # Remove pan-marker genes from hybrid list to avoid duplicates
    hybrid_ordered <- setdiff(hybrid_ordered, c(pan_fib_present, pan_endo_present))
    comp_gene_levels <- c(sort(pan_fib_present), sort(pan_endo_present), hybrid_ordered)
  } else {
    comp_gene_levels <- gene_order %>%
      filter(gene %in% comp_hybrid_genes) %>%
      arrange(gene_order_idx) %>%
      pull(gene)
  }

  df_comp$gene <- factor(df_comp$gene, levels = comp_gene_levels)
  df_comp$broad <- factor(df_comp$broad, levels = comp_broads)

  broad_labels <- setNames(pretty_broad(comp_broads), comp_broads)

  n_genes <- length(comp_gene_levels)
  n_cells <- length(comp_broads)
  cat(sprintf("  %d broad cell types, %d genes\n", n_cells, n_genes))

  for (scale_type in scale_types) {
    cat(sprintf("  -> %s scale...\n", scale_type))

    if (scale_type == "zscore") {
      color_col <- "z_score"
      color_name <- "Z-score\n(per gene)"
      z_max <- max(abs(df_comp$z_score), na.rm = TRUE)
      p <- ggplot(df_comp, aes(x = gene, y = broad)) +
        geom_point(aes(size = pct_exp, fill = z_score), shape = 21, stroke = 0.25, color = "black") +
        scale_fill_gradientn(colors = inferno_rev,
                              limits = c(-z_max, z_max),
                              name = color_name) +
        guides(size = guide_legend(order = 1),
               fill = guide_colorbar(order = 2))
    } else {
      color_col <- "log1p_exp"
      color_name <- "log1p(Avg.\nexpression)"
      p <- ggplot(df_comp, aes(x = gene, y = broad)) +
        geom_point(aes(size = pct_exp, fill = log1p_exp), shape = 21, stroke = 0.25, color = "black") +
        scale_fill_gradientn(colors = inferno_rev,
                              name = color_name) +
        guides(size = guide_legend(order = 1),
               fill = guide_colorbar(order = 2))
    }

    p <- p +
      scale_size_continuous(range = c(0.8, 5),
                            name = "% expressing",
                            limits = c(0, 1)) +
      scale_y_discrete(labels = broad_labels) +
      labs(x = NULL, y = NULL,
           title = paste0(comp, " (", scale_type, ")")) +
      theme_classic(base_size = 8) +
      theme(
        text = element_text(family = "Liberation Sans"),
        axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, size = 6),
        axis.text.y = element_text(size = 6),
        plot.title = element_text(face = "bold", size = 10, hjust = 0.5),
        legend.position = "right",
        legend.text = element_text(size = 6),
        legend.title = element_text(size = 7),
        plot.margin = margin(6, 6, 6, 6)
      )

    png_out <- sprintf("/mnt/results/dotplot_%s_%s_compact.png", tolower(comp), scale_type)
    svg_out <- sprintf("/mnt/results/dotplot_%s_%s_compact.svg", tolower(comp), scale_type)

    tryCatch({
      ggsave(png_out, p, width = 12, height = 3.75, dpi = 300,
             units = "in", limitsize = FALSE)
      cat("  PNG saved:", png_out, "\n")
    }, error = function(e) cat("  PNG error:", conditionMessage(e), "\n"))

    tryCatch({
      svglite::svglite(svg_out, width = 12, height = 3.75)
      print(p)
      dev.off()
      cat("  SVG saved:", svg_out, "\n")
    }, error = function(e) {
      cat("  SVG error:", conditionMessage(e), "\n")
      try(dev.off(), silent = TRUE)
    })
  }
}

cat("\nAll done.\n")
