## ----setup, include=FALSE-----------------------------------------------------
if (nzchar(Sys.getenv("CHERRYPIC_R_LIB"))) .libPaths(c(Sys.getenv("CHERRYPIC_R_LIB"), .libPaths()))  # optional custom library

library(Seurat)
library(tidyverse)
library(patchwork)
library(RColorBrewer)

knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)


## ----config-------------------------------------------------------------------
rds_hires <- "../data/final_analysis_object_with_master_deconv_hires.RDS"
out_dir   <- "../outputs"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

op   <- function(f) file.path(out_dir, f)     # path helper for outputs
ubar <- function(x) gsub("\\.", "_", x)       # "Ileum.2.008um" -> "Ileum_2_008um"

FIG4A_GENES <- c("Fabp1", "Reg1", "Fabp6", "Slc10a2")


## ----load---------------------------------------------------------------------
merged.object <- readRDS(rds_hires)
sample_images <- Images(merged.object)

genes_present <- intersect(FIG4A_GENES, rownames(merged.object))
missing <- setdiff(FIG4A_GENES, genes_present)
if (length(missing) > 0) warning("Genes not in data: ", paste(missing, collapse = ", "))
cat("Genes plotted:", paste(genes_present, collapse = ", "), "\n")


## ----panel_4a_plots, fig.width=6, fig.height=6--------------------------------
PUBLISHED_REPLICATE <- c("Duodenum.3.008um", "Ileum.3.008um")

for (gene in genes_present) {
  gene_range <- range(FetchData(merged.object, vars = gene)[[gene]], na.rm = TRUE)

  plots <- lapply(sample_images, function(img) {
    p <- SpatialFeaturePlot(merged.object, features = gene, images = img,
                            pt.size.factor = 1.25, crop = TRUE)
    p[[1]] +
      scale_fill_gradientn(colours = rev(brewer.pal(11, "Spectral")),
                           limits = gene_range, name = "Expr") +
      labs(title = paste0(gene, " — ", img)) +
      theme(plot.title = element_text(size = 10, hjust = 0.5),
            legend.key.size = unit(0.4, "cm"))
  })
  names(plots) <- sample_images

  for (img in sample_images) {
    prefix <- if (img %in% PUBLISHED_REPLICATE) "fig4A_spatial_" else "supporting_spatial_"
    ggsave(op(paste0(prefix, gene, "_", ubar(img), ".pdf")),
           plots[[img]], width = 6, height = 6)
  }
  cat("Saved 4A panels:", gene, "\n")
}


## ----supporting_all_samples, fig.width=22, fig.height=6-----------------------
for (gene in genes_present) {
  gene_range <- range(FetchData(merged.object, vars = gene)[[gene]], na.rm = TRUE)

  plots <- lapply(sample_images, function(img) {
    p <- SpatialFeaturePlot(merged.object, features = gene, images = img,
                            pt.size.factor = 1.25, crop = TRUE)
    p[[1]] +
      scale_fill_gradientn(colours = rev(brewer.pal(11, "Spectral")),
                           limits = gene_range, name = "Expr") +
      labs(title = paste0(gene, " — ", img)) +
      theme(plot.title = element_text(size = 10, hjust = 0.5),
            legend.key.size = unit(0.4, "cm"))
  })

  p_row <- wrap_plots(plots, nrow = 1, guides = "collect")
  ggsave(op(paste0("supporting_spatial_", gene, "_all_samples.pdf")), p_row, width = 22, height = 6)
  cat("Saved supporting row:", gene, "\n")
}


## ----session_info-------------------------------------------------------------
sessionInfo()

