## ----setup, include=FALSE-----------------------------------------------------
library(Seurat)
library(tidyverse)
library(RColorBrewer)
library(patchwork)

knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)


## ----config-------------------------------------------------------------------
rds_obj <- "../outputs/epithelia_EP.CTRL_data.processed(no-immune).RDS"
out_dir <- "../outputs"
op <- function(f) file.path(out_dir, f)

spectral_rev <- rev(brewer.pal(11, "Spectral"))

genes_proximal <- c("Adh6a","Adh1","S100g","Papss2","Gstm3","Reg1","Rbp2","Fabp1","Prdm16","Ces2g")
genes_distal   <- c("Slc5a8","Slc10a2","Fgf15","Suox","Plb1","Tmigd1","Ly6a","Ifi27l2a","Hoxb9","Fabp6")


## ----load---------------------------------------------------------------------
obj <- readRDS(rds_obj)
cat("Cells:", ncol(obj), "| Genes:", nrow(obj), "\n")
print(table(obj$cell_type_labels))
print(table(obj$Location))

entero <- subset(obj, cell_type_labels == "Enterocytes")
DefaultAssay(entero) <- "RNA"
cat("Enterocytes:", ncol(entero), "| by Location:\n")
print(table(entero$Location))

missing <- setdiff(c(genes_proximal, genes_distal), rownames(entero))
if (length(missing)) warning("Genes not in object: ", paste(missing, collapse = ", "))
cat("Missing genes:", length(missing), "of 20\n")


## ----dotplot_fn---------------------------------------------------------------
make_dotplot_3F <- function(obj, genes, title, fill_limits = NULL) {
  genes <- intersect(genes, rownames(obj))
  data_mat <- GetAssayData(obj, assay = "RNA", layer = "data")[genes, , drop = FALSE]
  loc <- obj$Location
  regions <- c("Duodenum", "Ileum")

  avg_exp <- matrix(NA_real_, nrow = length(genes), ncol = length(regions),
                    dimnames = list(genes, regions))
  pct_exp <- avg_exp
  for (r in regions) {
    cells <- colnames(obj)[loc == r]
    sub <- data_mat[, cells, drop = FALSE]
    avg_exp[, r] <- Matrix::rowMeans(sub)
    pct_exp[, r] <- Matrix::rowSums(sub > 0) / length(cells)
  }

  df <- merge(
    as.data.frame(as.table(avg_exp), responseName = "avg_exp"),
    as.data.frame(as.table(pct_exp), responseName = "pct_exp"),
    by = c("Var1", "Var2")
  )
  colnames(df)[1:2] <- c("gene", "region")
  df$gene <- factor(as.character(df$gene), levels = rev(genes))
  df$region <- factor(ifelse(df$region == "Duodenum", "Duo", "Ile"), levels = c("Duo", "Ile"))

  p <- ggplot(df, aes(x = region, y = gene)) +
    geom_point(aes(size = pct_exp, fill = avg_exp), shape = 21, stroke = 0.25, color = "black") +
    scale_fill_gradientn(colors = spectral_rev, name = "Ave. exp.", limits = fill_limits) +
    scale_size_continuous(range = c(1, 6), name = "Prop. %", limits = c(0, 1),
                          labels = scales::percent_format(accuracy = 1)) +
    labs(x = NULL, y = NULL, title = title) +
    theme_classic(base_size = 9) +
    theme(
      axis.text.x = element_text(size = 8),
      axis.text.y = element_text(size = 8, face = "italic"),
      plot.title = element_text(face = "bold", size = 10, hjust = 0.5),
      legend.position = "right",
      legend.text = element_text(size = 7),
      legend.title = element_text(size = 8),
      plot.margin = margin(6, 6, 6, 6)
    )
  attr(p, "avg_exp_df") <- df   # carried through for the export chunk below
  p
}

# Two averaging conventions for the same gene x region cells, for direct comparison --
# not a decision about which is correct. mean_log matches what this notebook plots;
# expm1_mean matches Seurat's own DotPlot() default.
export_both_conventions <- function(obj, genes, region_label) {
  genes <- intersect(genes, rownames(obj))
  data_mat <- GetAssayData(obj, assay = "RNA", layer = "data")[genes, , drop = FALSE]
  loc <- obj$Location
  regions <- c("Duodenum", "Ileum")
  out <- data.frame()
  for (r in regions) {
    cells <- colnames(obj)[loc == r]
    sub <- data_mat[, cells, drop = FALSE]
    out <- rbind(out, data.frame(
      program = region_label, gene = genes, region = r,
      mean_log = Matrix::rowMeans(sub),
      expm1_mean = log1p(Matrix::rowMeans(expm1(sub))),
      pct_exp = Matrix::rowSums(sub > 0) / length(cells)
    ))
  }
  out
}


## ----fig3F_shared_scale-------------------------------------------------------
# Shared colour scale across both panels, computed before either is plotted.
all_genes <- intersect(c(genes_proximal, genes_distal), rownames(entero))
all_mat <- GetAssayData(entero, assay = "RNA", layer = "data")[all_genes, , drop = FALSE]
shared_fill_limits <- range(Matrix::rowMeans(all_mat[, entero$Location == "Duodenum", drop = FALSE]),
                            Matrix::rowMeans(all_mat[, entero$Location == "Ileum", drop = FALSE]))
cat("Shared Ave. exp. scale:", shared_fill_limits[1], "-", shared_fill_limits[2], "\n")

exp_table <- rbind(
  export_both_conventions(entero, genes_proximal, "Proximal"),
  export_both_conventions(entero, genes_distal, "Distal")
)
write.csv(exp_table, op("supporting_fig3F_expression_both_conventions.csv"), row.names = FALSE)
cat("Wrote both averaging conventions for", nrow(exp_table), "gene x region rows to",
    "supporting_fig3F_expression_both_conventions.csv\n")


## ----fig3F_proximal, fig.width=3.2, fig.height=3.5----------------------------
p_prox <- make_dotplot_3F(entero, genes_proximal, "Proximal SI program", fill_limits = shared_fill_limits)
ggsave(op("fig3F_dotplot_proximal_program.pdf"), p_prox, width = 3.2, height = 3.5)
p_prox


## ----fig3F_distal, fig.width=3.2, fig.height=3.5------------------------------
p_dist <- make_dotplot_3F(entero, genes_distal, "Distal SI program", fill_limits = shared_fill_limits)
ggsave(op("fig3F_dotplot_distal_program.pdf"), p_dist, width = 3.2, height = 3.5)
p_dist


## ----supporting_combined, fig.width=6.5, fig.height=3.5-----------------------
p_combined <- p_prox + p_dist
ggsave(op("supporting_dotplot_proximal_distal_combined.pdf"), p_combined, width = 6.5, height = 3.5)
p_combined


## ----session_info-------------------------------------------------------------
sessionInfo()

