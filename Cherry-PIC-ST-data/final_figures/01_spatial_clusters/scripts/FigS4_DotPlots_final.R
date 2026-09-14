## ----setup, include=FALSE-----------------------------------------------------
if (nzchar(Sys.getenv("CHERRYPIC_R_LIB"))) .libPaths(c(Sys.getenv("CHERRYPIC_R_LIB"), .libPaths()))  # optional custom library

library(Seurat)
library(tidyverse)
library(patchwork)

knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)


## ----config-------------------------------------------------------------------
rds_hires <- "../data/final_analysis_object_with_master_deconv_hires.RDS"
ann_csv   <- "../data/8um-binned-updated-annotations(res2) Apr 21 with exclusion.csv"
out_dir   <- "../outputs"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
op <- function(f) file.path(out_dir, f)

inferno_rev <- c("#FCFFA4", "#F7D13D", "#FB9A06", "#ED6925", "#CF4446",
                 "#A52C60", "#781C6D", "#4A0C6B", "#1B0C42", "#000004")

cluster_col <- "sketch_snn_res.2"


## ----load---------------------------------------------------------------------
merged.object <- readRDS(rds_hires)
cat("Spots:", ncol(merged.object), "\n")

ann <- read.csv(ann_csv, stringsAsFactors = FALSE, check.names = TRUE)
ann$Cluster <- as.character(ann$Cluster)
cluster_map    <- setNames(trimws(ann$Annotation), ann$Cluster)
cluster_levels <- unique(trimws(ann$Annotation))

cl <- as.character(merged.object@meta.data[[cluster_col]])
cluster_annotation_vec <- unname(cluster_map[cl])

# A second independent review found Fig S4A's proximal panel merges two manuscript rows:
# clusters 10 and 14 are both named "Mid-villus proximal enterocytes-4" in the crosswalk
# (a deliberate shared label -- unlike Crypts and Muscularis, which also span multiple
# clusters and are correctly meant to be averaged together as one row here). Give 10 and
# 14 alone a disambiguating suffix so they display as two rows; every other label,
# including the other multi-cluster ones, is untouched.
cluster_annotation_vec[cl == "10"] <- paste0(cluster_annotation_vec[cl == "10"], " (cl.10)")
cluster_annotation_vec[cl == "14"] <- paste0(cluster_annotation_vec[cl == "14"], " (cl.14)")
cluster_levels <- append(cluster_levels,
                         c("Mid-villus proximal enterocytes-4 (cl.10)", "Mid-villus proximal enterocytes-4 (cl.14)"),
                         after = match("Mid-villus proximal enterocytes-4", cluster_levels))
cluster_levels <- setdiff(cluster_levels, "Mid-villus proximal enterocytes-4")
merged.object$cluster_annotation <- factor(cluster_annotation_vec, levels = cluster_levels)

# The object arrives with normalized expression already in the default assay's
# "data" layer, so no NormalizeData call is needed here.
cat("Default assay:", DefaultAssay(merged.object), "\n")
cat("cluster_annotation levels:", length(levels(merged.object$cluster_annotation)), "\n")
print(table(merged.object$cluster_annotation, useNA = "ifany"))


## ----marker_panels------------------------------------------------------------
panel_A_prox <- list(
  genes = c("Krt19","Lgals4","Selenbp1","Phgr1","Ms4a18","Gstm3","Ces2g","Acy1","Casp6",
           "Alpi","Anpep","Apoa1","Apoc2","Papss2","Rbp2","Slc5a12","Pck1","Slc36a1",
           "Slc5a4b","Slc7a15","Lct","Ace","Cyp2b10","Mme","Slc5a4a","Slc5a1","Itga6",
           "Selenop","Muc3","Sectm1b","Slc37a2","Slc16a9","Otop3","Sult6b2","Slc4a7",
           "Tmprss15","Akp3","S100g","Slc40a1","Car2","Aqp8","Car4","Enpp3","Apoa4",
           "Apoc3","Slc23a4","Bmp8a","Clca4a","Rab30","Cldn4","Cybrd1","Ada","Slc28a2",
           "Nt5e","Ly6m","Ifit1bl1","Isg15","Ifit1","Ifit3","Usp18"),
  # A second independent review found this list silently loses two manuscript rows:
  # "Tip-villus proximal enterocytes-3" was never a real crosswalk label (cluster 25 is
  # "Tip-villus activated proximal enterocytes") and intersect() in make_dotplot() drops
  # unmatched requests with no warning; and clusters 10 & 14 share one label, which
  # merges two manuscript rows into one when grouped by that label alone. Corrected to
  # the real label and the two disambiguated (cl.10)/(cl.14) labels set up above -- 9
  # rows now, matching the manuscript's nine proximal rows.
  cell_types_top_to_bottom = c(
    "Tip-villus activated proximal enterocytes", "Tip-villus proximal enterocytes-2",
    "Tip-villus proximal enterocytes-1", "Mid-villus proximal enterocytes-4 (cl.14)",
    "Mid-villus proximal enterocytes-4 (cl.10)", "Mid-villus proximal enterocytes-3",
    "Mid-villus proximal enterocytes-2", "Mid-villus proximal enterocytes-1",
    "Bottom-villus proximal enterocytes")
)

panel_A_dist <- list(
  genes = c("Olfm4","Lgr5","Smoc2","Spink4","Adamdec1","Ifitm2","Eef1a1","Tmem176b","Car1",
           "Krt19","Lgals4","Gsdmc2","Gsdmc4","Fgfbp1","Bmp3","Reg3b","Ace2","Fabp6",
           "Nr1h4","Slc10a2","Nos2","Slc25a48","Tmigd1","Slc1a1","Naaladl1","Zg16","Muc2",
           "Pdzk1","Ezr","Fam151a","Enpp7","Xpnpep2","Vnn1","Slc34a2","Aqp4","Car4",
           "Lhfpl2","Clca4a","Areg","Lratd1","Pmp22","Avil","Dclk1","Trpm5","Sh2d6",
           "Ccnj","Siglecf","Hck","Alox5"),
  cell_types_top_to_bottom = c(
    "Tuft cells", "Tip-villus distal enterocytes",
    "Mid-villus distal enterocytes-3", "Mid-villus distal enterocytes-2",
    "Mid-villus distal enterocytes-1", "Bottom-villus distal enterocytes", "Crypts")
)

panel_B <- list(
  genes = c("C1qa","Cd68","Lyz2","Iglc1","Igkc","Igfbp3","Acta2","Myh11","Tagln","Tpm2",
           "Actg2","Rgs5","Cd4","Trac","Cd74","mt-Nd4","mt-Co2","Cps1","Cd79a","Cd19",
           "Ms4a1","Pax5","Fcer2a","Tnfrsf13c","Muc6","Tff2","Aqp5","Gkn3","Pgc","Glp1r",
           "Plp1","Gfap","Uchl1","Syt1","Snap25","Calb2"),
  cell_types_top_to_bottom = c(
    "Muscularis/Enteric plexus", "Brunner's gland", "Peyer's patch",
    "Lamina propria", "Muscularis", "Immune LP")
)

for (nm in c("panel_A_prox", "panel_A_dist", "panel_B")) {
  p <- get(nm)
  missing <- setdiff(p$genes, rownames(merged.object))
  cat(nm, ":", length(p$genes), "genes,", length(p$cell_types_top_to_bottom),
      "cell types —", length(missing), "genes missing\n")
  if (length(missing)) warning(nm, " genes not in object: ", paste(missing, collapse = ", "))
  missing_ct <- setdiff(p$cell_types_top_to_bottom, levels(merged.object$cluster_annotation))
  if (length(missing_ct)) warning(nm, " cell types not in cluster_annotation: ",
                                  paste(missing_ct, collapse = ", "))
}


## ----dotplot_fn---------------------------------------------------------------
make_dotplot <- function(obj, genes, cell_types, title) {
  genes <- intersect(genes, rownames(obj))
  # A silent intersect() here is exactly how the missing-crosswalk-label bug above went
  # unnoticed: fail loudly instead if a requested row does not exist.
  missing_ct <- setdiff(cell_types, levels(obj$cluster_annotation))
  if (length(missing_ct) > 0)
    stop("make_dotplot(): requested cell type(s) not in cluster_annotation: ",
        paste(missing_ct, collapse = ", "))
  data_mat <- GetAssayData(obj, layer = "data")[genes, , drop = FALSE]
  ct <- obj$cluster_annotation

  avg_exp <- matrix(NA_real_, nrow = length(genes), ncol = length(cell_types),
                    dimnames = list(genes, cell_types))
  pct_exp <- avg_exp
  for (b in cell_types) {
    cells <- colnames(obj)[!is.na(ct) & ct == b]
    sub <- data_mat[, cells, drop = FALSE]
    avg_exp[, b] <- Matrix::rowMeans(sub)
    pct_exp[, b] <- Matrix::rowSums(sub > 0) / length(cells)
  }

  df <- merge(
    as.data.frame(as.table(avg_exp), responseName = "avg_exp"),
    as.data.frame(as.table(pct_exp), responseName = "pct_exp"),
    by = c("Var1", "Var2")
  )
  colnames(df)[1:2] <- c("gene", "broad")
  df$gene <- as.character(df$gene); df$broad <- as.character(df$broad)

  df <- df %>% group_by(gene) %>% mutate(z_score = scale(avg_exp)[, 1]) %>% ungroup()
  df <- df %>% filter(avg_exp > 0)

  df$gene  <- factor(df$gene,  levels = genes)
  df$broad <- factor(df$broad, levels = rev(cell_types))

  z_max <- max(abs(df$z_score), na.rm = TRUE)
  ggplot(df, aes(x = gene, y = broad)) +
    geom_point(aes(size = pct_exp, fill = z_score), shape = 21, stroke = 0.25, color = "black") +
    scale_fill_gradientn(colors = inferno_rev, limits = c(-z_max, z_max), name = "Z-score") +
    scale_size_continuous(range = c(0.8, 5), name = "Percent\nexpressed", limits = c(0, 1)) +
    labs(x = NULL, y = NULL, title = title) +
    theme_classic(base_size = 8) +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, size = 6),
      axis.text.y = element_text(size = 7),
      plot.title = element_text(face = "bold", size = 10, hjust = 0.5),
      legend.position = "right",
      legend.text = element_text(size = 6),
      legend.title = element_text(size = 7),
      plot.margin = margin(6, 6, 6, 6)
    )
}


## ----figS4A_prox, fig.width=14, fig.height=3.5--------------------------------
p1 <- make_dotplot(merged.object, panel_A_prox$genes, panel_A_prox$cell_types_top_to_bottom,
                   "Epithelia — proximal")
ggsave(op("figS4A_dotplot_epithelia_proximal.pdf"), p1, width = 14, height = 3.5)
p1


## ----figS4A_dist, fig.width=13, fig.height=3.2--------------------------------
p2 <- make_dotplot(merged.object, panel_A_dist$genes, panel_A_dist$cell_types_top_to_bottom,
                   "Epithelia — distal / Tuft / Crypts")
ggsave(op("figS4A_dotplot_epithelia_distal.pdf"), p2, width = 13, height = 3.2)
p2


## ----figS4B, fig.width=11, fig.height=3---------------------------------------
p3 <- make_dotplot(merged.object, panel_B$genes, panel_B$cell_types_top_to_bottom,
                   "Stromal + Immune")
ggsave(op("figS4B_dotplot_stromal_immune.pdf"), p3, width = 11, height = 3)
p3


## ----session_info-------------------------------------------------------------
sessionInfo()

