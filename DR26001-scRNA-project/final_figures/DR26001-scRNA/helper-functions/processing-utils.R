# processing-utils.R
#
# Shared marker helper for the DR26001 notebooks. Each notebook defines its own
# multi_sample_pipeline() inline; this file deliberately does not, so that sourcing
# it can never replace the version a notebook has already run.

run.presto.specific.columns <- function(seu_obj, col_name_list = NULL, RNA_cols = F) {
  
  DefaultAssay(seu_obj) <- "RNA"
  seu_obj <- JoinLayers(seu_obj)
  
  if (RNA_cols) {
    col_name_list <- colnames(seu_obj@meta.data)[startsWith(colnames(seu_obj@meta.data), "RNA_snn")]
  }
  
  # Get Wilcox AUC results
  wilcox.auc.list <- list()
  
  i <- 1
  for (col in col_name_list) {
    wilcox.auc.list[[i]] <- presto::wilcoxauc(seu_obj, group_by = col_name_list[i])
    i <- i + 1
  }
  
  names(wilcox.auc.list) <- col_name_list
  
  # Get Filered Wilcox AUC results
  filtered.markers.list <- lapply(wilcox.auc.list, FUN = function(x) {
    x <- x %>%
      dplyr::filter(auc > 0.5) %>%
      dplyr::filter(padj < 0.05) %>%
      dplyr::filter(pct_in > 50)
  })
  
  # Presto Top Markers
  top.markers.list <- lapply(wilcox.auc.list, FUN = function(x) {
    x <- presto::top_markers(x, n = 100, auc_min = 0.5, padj_max = 0.05, pct_in_min = 50)
  })
  
  # Final Results List
  final_results_list <- list(wilcox.auc.list, filtered.markers.list, top.markers.list)
  names(final_results_list) <- c("Raw-Markers", "Filtered-Markers", "Top-Markers")
  
  return(final_results_list)
}
