## ----chunk-01-----------------------------------------------------------------
if (nzchar(Sys.getenv("CHERRYPIC_R_LIB"))) .libPaths(c(Sys.getenv("CHERRYPIC_R_LIB"), .libPaths()))  # optional custom library


## ----chunk-02-----------------------------------------------------------------
library(Seurat)
library(tidyverse)
library(harmony)
library(glue)
library(EnhancedVolcano)
library(ggsci)


## ----chunk-03-----------------------------------------------------------------
# IGV colors for clusters (many distinct colors)
igv_colors <- pal_igv("default")(51)

# Different palettes for different variable types
npg_colors <- pal_npg("nrc")(10)        # Nature Publishing Group - good for Location (2 categories)
lancet_colors <- pal_lancet("lanonc")(9) # Lancet - good for Condition
d3_colors <- pal_d3("category20")(20)    # D3 - good for Sample_ID/orig.ident (many categories)

# Helper function to get colors based on number of clusters (for clustering)
get_igv_colors <- function(n) {
  if (n <= 51) {
    return(igv_colors[1:n])
  } else {
    return(rep(igv_colors, length.out = n))
  }
}

# Helper function to get colors for Location (NPG palette)
get_location_colors <- function(n) {
  if (n <= 10) {
    return(npg_colors[1:n])
  } else {
    return(rep(npg_colors, length.out = n))
  }
}

# Helper function to get colors for Condition (Lancet palette)
get_condition_colors <- function(n) {
  if (n <= 9) {
    return(lancet_colors[1:n])
  } else {
    return(rep(lancet_colors, length.out = n))
  }
}

# Helper function to get colors for Sample_ID/orig.ident (D3 palette)
get_sample_colors <- function(n) {
  if (n <= 20) {
    return(d3_colors[1:n])
  } else {
    return(rep(d3_colors, length.out = n))
  }
}


## ----chunk-04-----------------------------------------------------------------
Immune.scRNA.short.term <- readRDS("../../03-immune-clustering/outputs/short-term_immune-shor-term-2024-02-09.RDS")
cat("Immune short-term dataset:", ncol(Immune.scRNA.short.term), "cells\n")

Immune.scRNA.long.term <- readRDS("../../01-separate-epithelia-immune/outputs/long-term-2024-03-22_seu-obj-long-term-immune-2024-03-22-RNA-RNA_snn_res.0.5.RDS")
cat("Immune long-term dataset:", ncol(Immune.scRNA.long.term), "cells\n")


## ----chunk-07-----------------------------------------------------------------
# Short-term immune UMAP
p1 <- DimPlot(Immune.scRNA.short.term, label = TRUE) + 
  ggtitle("Short-term Immune Clustering") + 
  theme(legend.position = "right")

# Long-term immune UMAP
p2 <- DimPlot(Immune.scRNA.long.term, label = TRUE) + 
  ggtitle("Long-term Immune Clustering") + 
  theme(legend.position = "right")

print(p1)
print(p2)


## ----chunk-09-----------------------------------------------------------------
# Subset control samples only
Immune.scRNA.long.term.CTRL_only <- Immune.scRNA.long.term[, Immune.scRNA.long.term@meta.data$Condition == "Control"]
Immune.scRNA.short.term.CTRL_only <- Immune.scRNA.short.term[, Immune.scRNA.short.term@meta.data$Condition == "Control"]

cat("Long-term CTRL only:", ncol(Immune.scRNA.long.term.CTRL_only), "cells\n")
cat("Short-term CTRL only:", ncol(Immune.scRNA.short.term.CTRL_only), "cells\n")


## ----chunk-10-----------------------------------------------------------------
Immune.CTRL_data <- merge(Immune.scRNA.long.term.CTRL_only, Immune.scRNA.short.term.CTRL_only)
cat("Merged immune CTRL dataset:", ncol(Immune.CTRL_data), "cells\n")


## ----chunk-12-----------------------------------------------------------------
# Split based on orig.ident (seq run) for Harmony
# Join Layers (to then split)
Immune.CTRL_data <- JoinLayers(Immune.CTRL_data)

# Resplit Layers
Immune.CTRL_data[["RNA"]] <- split(Immune.CTRL_data[["RNA"]],
                                   f = Immune.CTRL_data$orig.ident)

# Verify that layers are as I expect
Layers(Immune.CTRL_data)


## ----chunk-13-----------------------------------------------------------------
multi_sample_pipeline <- function(merged_seu_obj, split_col = "orig.ident", res_cols = "RNA") {
  
  if (res_cols == "SCT") {
    merged_seu_obj <- SCTransform(merged_seu_obj, verbose = FALSE)
  } else {
    merged_seu_obj <- NormalizeData(merged_seu_obj)
    merged_seu_obj <- FindVariableFeatures(merged_seu_obj)
    merged_seu_obj <- ScaleData(merged_seu_obj)
  }
  
  merged_seu_obj <- RunPCA(merged_seu_obj)
  # Harmony's k-means initialisation is stochastic and carries no default seed,
  # unlike RunUMAP (seed.use = 42) and FindClusters (random.seed = 0).
  set.seed(42)
  merged_seu_obj <- RunHarmony(merged_seu_obj, assay.use = res_cols, group.by.vars = split_col)
  merged_seu_obj <- RunUMAP(merged_seu_obj, reduction = "harmony", dims = 1:40)
  merged_seu_obj <- FindNeighbors(merged_seu_obj, reduction = "harmony", dims = 1:40)
  merged_seu_obj <- FindClusters(merged_seu_obj, resolution = c(1:10 / 10))
  
  return(merged_seu_obj)
}


## ----message=FALSE------------------------------------------------------------
Immune.CTRL_data.processed <- multi_sample_pipeline(Immune.CTRL_data)


## ----chunk-14-----------------------------------------------------------------
# Create plots showing clustering at different resolutions with IGV colors
# Loop through all resolutions from 0.1 to 1.0
for (res in grep("^RNA_snn", colnames(Immune.CTRL_data.processed@meta.data), value = TRUE)) {
  n_clusters <- length(unique(Immune.CTRL_data.processed@meta.data[[res]]))
  p <- DimPlot(Immune.CTRL_data.processed, group.by = res, label = TRUE, label.size = 3, 
               cols = get_igv_colors(n_clusters)) + 
    ggtitle(paste("Clustering at", res)) + 
    theme(legend.position = "right")
  print(p)
}



## ----chunk-15-----------------------------------------------------------------
create.dir <- function(dir_path) {
  if (!dir.exists(dir_path)) {
    dir.create(dir_path, recursive = TRUE)
  }
}

create.dir("../outputs/immune_UMAP")
create.dir("../outputs/immune_Feature-Plots")


## ----chunk-16-----------------------------------------------------------------
# Individual UMAP with IGV colors
pdf(glue("../outputs/immune_UMAP-All-Resolutions.pdf"), height = 8, width = 12)
for (res in grep("^RNA_snn", colnames(Immune.CTRL_data.processed@meta.data), value = TRUE)) {
  n_clusters <- length(unique(Immune.CTRL_data.processed@meta.data[[res]]))
  print(DimPlot(Immune.CTRL_data.processed, group.by = res, cols = get_igv_colors(n_clusters)) + 
          ggplot2::ggtitle(glue("Resolution: {res}")))
}
dev.off()

pdf(glue("../outputs/immune_UMAP-All-Resolutions-labeled.pdf"), height = 8, width = 12)
for (res in grep("^RNA_snn", colnames(Immune.CTRL_data.processed@meta.data), value = TRUE)) {
  n_clusters <- length(unique(Immune.CTRL_data.processed@meta.data[[res]]))
  print(DimPlot(Immune.CTRL_data.processed, group.by = res, label = TRUE, cols = get_igv_colors(n_clusters)) + 
          ggplot2::ggtitle(glue("Resolution: {res}")))
}
dev.off()

# GroupBy UMAPs with appropriate color scales for each variable
pdf("../outputs/immune_UMAP-groupby-plots.pdf", height = 8, width = 12)
n_orig <- length(unique(Immune.CTRL_data.processed$orig.ident))
n_loc <- length(unique(Immune.CTRL_data.processed$Location))
n_cond <- length(unique(Immune.CTRL_data.processed$Condition))
n_sample <- length(unique(Immune.CTRL_data.processed$Sample_ID))
DimPlot(Immune.CTRL_data.processed, group.by = "orig.ident", cols = get_sample_colors(n_orig)) %>% print()
DimPlot(Immune.CTRL_data.processed, group.by = "Location", cols = get_location_colors(n_loc)) %>% print()
DimPlot(Immune.CTRL_data.processed, group.by = "Condition", cols = get_condition_colors(n_cond)) %>% print()
DimPlot(Immune.CTRL_data.processed, group.by = "Sample_ID", cols = get_sample_colors(n_sample)) %>% print()
dev.off()


## ----chunk-17-----------------------------------------------------------------
Immune.CTRL_data.processed <- JoinLayers(Immune.CTRL_data.processed)
Immune.CTRL_data.processed <- NormalizeData(Immune.CTRL_data.processed)
saveRDS(Immune.CTRL_data.processed, file = "../outputs/immune_Immune.CTRL_data.processed.RDS")


## ----chunk-18-----------------------------------------------------------------
Immune.CTRL_data.processed <- readRDS("../outputs/immune_Immune.CTRL_data.processed.RDS")


## ----chunk-19-----------------------------------------------------------------
# Find markers for each resolution to help with cell type annotation
# Get all resolution columns from metadata
resolutions_to_analyze <- grep("^RNA_snn_res", colnames(Immune.CTRL_data.processed@meta.data), value = TRUE)

for (res in resolutions_to_analyze) {
  cat("\n=== Finding markers for", res, "===\n")
  
  Idents(Immune.CTRL_data.processed) <- res
  
  # Find all markers for this resolution
  immune.markers <- FindAllMarkers(Immune.CTRL_data.processed, only.pos = TRUE, min.pct = 0.25, logfc.threshold = 0.25)
  
  # Get top markers per cluster
  immune.markers %>%
    group_by(cluster) %>%
    slice_max(n = 10, order_by = avg_log2FC) -> top10.immune.markers
  
  # Create resolution-specific filename
  res_name <- gsub("RNA_snn_", "", res)
  
  # Save all markers
  write.csv(immune.markers, 
            file = paste0("../outputs/immune_All-Cluster-Markers-", res_name, ".csv"))
  
  # Save top 10 markers
  write.csv(top10.immune.markers, 
            file = paste0("../outputs/immune_Top10-Cluster-Markers-", res_name, ".csv"))
  
  cat("Saved markers for", res, "- found", nrow(immune.markers), "total markers across", 
      length(unique(immune.markers$cluster)), "clusters\n")
}

# Print the top markers at the resolution the annotation below is applied to (res 0.9),
# so the table shown here describes the same clusters that receive labels.
Idents(Immune.CTRL_data.processed) <- "RNA_snn_res.0.9"
cat("\n=== Top 10 markers per cluster (res 0.9) ===\n")
print(read.csv("../outputs/immune_Top10-Cluster-Markers-res.0.9.csv"))


## ----chunk-20-----------------------------------------------------------------
# Read the immune cell type annotations
immune.cell.type.annot <- read.csv("../data/immune-annotation.csv", stringsAsFactors = FALSE)

# View the annotations
cat("Immune cell type annotations:\n")
print(immune.cell.type.annot)

# Check column names
cat("\nColumn names in annotation file:\n")
print(colnames(immune.cell.type.annot))


## ----chunk-21-----------------------------------------------------------------
# Set the clustering resolution to use for annotation (adjust if needed)
Idents(Immune.CTRL_data.processed) <- "RNA_snn_res.0.9"

cat("Current cluster levels:\n")
print(levels(Idents(Immune.CTRL_data.processed)))

# Create mapping from cluster number to cell type
# Using the "Cell.type" column from your CSV (adjust column name if different)
cluster_to_celltype <- setNames(immune.cell.type.annot$Cell.type, immune.cell.type.annot$Cluster)

# Apply the cell type labels
Immune.CTRL_data.processed <- RenameIdents(Immune.CTRL_data.processed, cluster_to_celltype)
Immune.CTRL_data.processed@meta.data$cell_type_labels <- Idents(Immune.CTRL_data.processed)

# Also add cell state if available
if ("Cell.state" %in% colnames(immune.cell.type.annot)) {
  cluster_to_cellstate <- setNames(immune.cell.type.annot$Cell.state, immune.cell.type.annot$Cluster)
  Immune.CTRL_data.processed@meta.data$cell_state_labels <- cluster_to_cellstate[as.character(Immune.CTRL_data.processed@meta.data$RNA_snn_res.0.9)]
}

cat("\n✅ Cell type labels applied!\n")
cat("Unique cell types:\n")
print(table(Immune.CTRL_data.processed$cell_type_labels))


## ----chunk-22-----------------------------------------------------------------
# Get number of unique cell types for color palette
n_celltypes <- length(unique(Immune.CTRL_data.processed$cell_type_labels))

# UMAP colored by cell type
p1 <- DimPlot(Immune.CTRL_data.processed, group.by = "cell_type_labels", label = TRUE, 
              label.size = 3, repel = TRUE, cols = get_igv_colors(n_celltypes)) + 
  ggtitle("Immune Cell Types") + 
  theme(legend.position = "right")
print(p1)

# Compare with cluster labels
p2 <- DimPlot(Immune.CTRL_data.processed, group.by = "RNA_snn_res.0.9", label = TRUE, 
              cols = get_igv_colors(length(unique(Immune.CTRL_data.processed$RNA_snn_res.0.9)))) + 
  ggtitle("Clusters (res 0.9)")
print(p1 + p2)

# Save cell type UMAP
pdf("../outputs/immune_UMAP-Cell-Type-Annotations.pdf", height = 8, width = 12)
print(p1)
print(p1 + p2)
dev.off()


## ----chunk-23-----------------------------------------------------------------
# Option 1: Use cells parameter with row selection
cells_to_keep <- rownames(Immune.CTRL_data.processed@meta.data)[
  !(Immune.CTRL_data.processed@meta.data$cell_type_labels %in% c("remove", "Unknown", ""))
]
Immune.CTRL_data.filtered <- subset(Immune.CTRL_data.processed, cells = cells_to_keep)


## ----chunk-24-----------------------------------------------------------------
saveRDS(Immune.CTRL_data.filtered,file="../outputs/immune_Immune.CTRL_data.filtered.RDS")


## ----chunk-25-----------------------------------------------------------------
# Composition plot by cell type and location
n_celltypes <- length(unique(Immune.CTRL_data.processed$cell_type_labels))

composition.celltype.df <- table(Immune.CTRL_data.processed$cell_type_labels, 
                                  Immune.CTRL_data.processed$Location) %>% 
  as.data.frame() %>% 
  dplyr::rename(cell_type = Var1, Location = Var2)

pdf("../outputs/immune_PERCENTAGE_COMPOSTION_PLOT_GROUP_BY_LOCATION_IMMUNE-CellTypes.pdf", height = 14, width = 10)
print(ggplot(composition.celltype.df, aes(x = Location, y = Freq, fill = cell_type)) + 
  geom_bar(stat = "identity", position = "fill") + 
  scale_fill_manual(values = get_igv_colors(n_celltypes)) +
  ggplot2::theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                 panel.background = element_blank(), 
                 axis.text.x = element_text(face = "bold", color = "black", size = 14, angle = 90, vjust = 0.5, hjust = 1)) + 
  scale_y_continuous(breaks = c(0, 0.25, 0.5, 0.75, 1), labels = scales::percent(c(0, 0.25, 0.5, 0.75, 1))) + 
  ylab("% Composition of Location by Cell Type"))
dev.off()

# Display in notebook
ggplot(composition.celltype.df, aes(x = Location, y = Freq, fill = cell_type)) + 
  geom_bar(stat = "identity", position = "fill") + 
  scale_fill_manual(values = get_igv_colors(n_celltypes)) +
  ggplot2::theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                 panel.background = element_blank(), 
                 axis.text.x = element_text(face = "bold", color = "black", size = 14, angle = 90, vjust = 0.5, hjust = 1)) + 
  scale_y_continuous(breaks = c(0, 0.25, 0.5, 0.75, 1), labels = scales::percent(c(0, 0.25, 0.5, 0.75, 1))) + 
  ylab("% Composition of Location by Cell Type")


## ----chunk-26-----------------------------------------------------------------
# Common immune cell marker genes
immune_markers <- c(
  # T cells
  "CD3D", "CD3E", "CD4", "CD8A", "CD8B",
  # B cells
  "CD19", "MS4A1", "CD79A", "CD79B",
  # NK cells
  "NCAM1", "NKG7", "GNLY",
  # Macrophages/Monocytes
  "CD14", "CD68", "FCGR3A", "LYZ",
  # Dendritic cells
  "ITGAX", "CD1C", "CLEC9A",
  # General
  "PTPRC"  # CD45
)

# Check which markers are present in the data
available_markers <- immune_markers[immune_markers %in% rownames(Immune.CTRL_data.processed)]
cat("Available immune markers:\n")
print(available_markers)

# Feature plots for available markers
if (length(available_markers) > 0) {
  pdf("../outputs/immune_Immune-Marker-FeaturePlots.pdf", height = 12, width = 16)
  print(FeaturePlot(Immune.CTRL_data.processed, features = available_markers[1:min(9, length(available_markers))], ncol = 3))
  if (length(available_markers) > 9) {
    print(FeaturePlot(Immune.CTRL_data.processed, features = available_markers[10:min(18, length(available_markers))], ncol = 3))
  }
  dev.off()
  
  # Display in notebook
  FeaturePlot(Immune.CTRL_data.processed, features = available_markers[1:min(6, length(available_markers))], ncol = 3)
}


## ----chunk-27-----------------------------------------------------------------
# GroupBy UMAPs with appropriate color scales for each variable
pdf("../outputs/immune_Updated-UMAP-groupby-plots.pdf", height = 8, width = 12)
n_orig <- length(unique(Immune.CTRL_data.processed$orig.ident))
n_loc <- length(unique(Immune.CTRL_data.processed$Location))
n_cond <- length(unique(Immune.CTRL_data.processed$Condition))
n_sample <- length(unique(Immune.CTRL_data.processed$Sample_ID))
DimPlot(Immune.CTRL_data.processed, group.by = "orig.ident", pt.size = 1, cols = get_sample_colors(n_orig)) %>% print()
DimPlot(Immune.CTRL_data.processed, group.by = "Location", pt.size = 1, cols = get_location_colors(n_loc)) %>% print()
DimPlot(Immune.CTRL_data.processed, group.by = "Condition", pt.size = 1, cols = get_condition_colors(n_cond)) %>% print()
DimPlot(Immune.CTRL_data.processed, group.by = "Sample_ID", pt.size = 1, cols = get_sample_colors(n_sample)) %>% print()
for (res in grep("^RNA_snn_res", colnames(Immune.CTRL_data.processed@meta.data), value = TRUE)) {
  n_clusters <- length(unique(Immune.CTRL_data.processed@meta.data[[res]]))
  DimPlot(Immune.CTRL_data.processed, group.by = res, pt.size = 1, label = TRUE, cols = get_igv_colors(n_clusters)) %>% print()
}
dev.off()

# Composition by Location for each resolution
black.bold.16.text <- element_text(face = "bold", color = "black", size = 14, angle = 90, vjust = 0.5, hjust = 1)
brks <- c(0, 0.25, 0.5, 0.75, 1)

for (res in grep("^RNA_snn_res", colnames(Immune.CTRL_data.processed@meta.data), value = TRUE)) {
  Idents(Immune.CTRL_data.processed) <- res
  n_clusters <- length(unique(Idents(Immune.CTRL_data.processed)))
  
  composition.df <- table(Idents(Immune.CTRL_data.processed), Immune.CTRL_data.processed@meta.data$Location) %>% 
    as.data.frame() %>% 
    dplyr::rename(cluster = Var1, Location = Var2)
  
  res_name <- gsub("RNA_snn_", "", res)
  
  pdf(file = paste0("../outputs/immune_PERCENTAGE_COMPOSTION_PLOT_GROUP_BY_LOCATION_IMMUNE-", res_name, ".pdf"), height = 14, width = 8)
  print(ggplot(composition.df, aes(x = Location, y = Freq, fill = cluster)) + 
    geom_bar(stat = "identity", position = "fill") + 
    scale_fill_manual(values = get_igv_colors(n_clusters)) +
    ggplot2::theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                   panel.background = element_blank(), axis.text.x = black.bold.16.text) + 
    scale_y_continuous(breaks = brks, labels = scales::percent(brks)) + 
    ylab(paste("% Composition of Location by Clusters (", res_name, ")")))
  dev.off()
}

# Display in notebook (res 0.5 as default)
Idents(Immune.CTRL_data.processed) <- "RNA_snn_res.0.5"
n_clusters <- length(unique(Idents(Immune.CTRL_data.processed)))
composition.df <- table(Idents(Immune.CTRL_data.processed), Immune.CTRL_data.processed@meta.data$Location) %>% 
  as.data.frame() %>% 
  dplyr::rename(cluster = Var1, Location = Var2)

ggplot(composition.df, aes(x = Location, y = Freq, fill = cluster)) + 
  geom_bar(stat = "identity", position = "fill") + 
  scale_fill_manual(values = get_igv_colors(n_clusters)) +
  ggplot2::theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                 panel.background = element_blank(), axis.text.x = black.bold.16.text) + 
  scale_y_continuous(breaks = brks, labels = scales::percent(brks)) + 
  ylab("% Composition of Location by Clusters (res.0.5)")


## ----chunk-28-----------------------------------------------------------------
DE_Genes.DuodenumVsIleum.Immune <- FindMarkers(
  Immune.CTRL_data.processed, 
  group.by = "Location", 
  ident.1 = "Duodenum", 
  ident.2 = "Ileum", 
  assay = "RNA"
) %>% dplyr::filter(p_val_adj <= 0.05)

write.csv(DE_Genes.DuodenumVsIleum.Immune, 
          file = "../outputs/immune_DE_Genes.DuodenumVsIleum-CTRL(Immune-Cells-only).csv")

cat("Number of significant DE genes (Duodenum vs Ileum):", nrow(DE_Genes.DuodenumVsIleum.Immune), "\n")


## ----chunk-29-----------------------------------------------------------------
pdf("../outputs/immune_Volcano-Plot-DE_Genes.Duodenum.Vs.Ileum-CTRL-Immune.pdf", height = 10, width = 10)
print(EnhancedVolcano::EnhancedVolcano(
  DE_Genes.DuodenumVsIleum.Immune,
  x = 'avg_log2FC',
  y = 'p_val_adj',
  lab = rownames(DE_Genes.DuodenumVsIleum.Immune),
  title = "Duodenum vs Ileum - Immune Cells"
))
dev.off()

# Display in notebook
EnhancedVolcano::EnhancedVolcano(
  DE_Genes.DuodenumVsIleum.Immune,
  x = 'avg_log2FC',
  y = 'p_val_adj',
  lab = rownames(DE_Genes.DuodenumVsIleum.Immune),
  title = "Duodenum vs Ileum - Immune Cells"
)


## ----chunk-30-----------------------------------------------------------------
# Get unique clusters
clusters.of.interest <- unique(Idents(Immune.CTRL_data.processed))
cat("Clusters to analyze:\n")
print(clusters.of.interest)


## ----chunk-31-----------------------------------------------------------------
for (x in clusters.of.interest) {
  skip_to_next <- FALSE
  tryCatch({
    subset_data <- subset(Immune.CTRL_data.processed, idents = x)
    
    # Check if both locations are present
    if (length(unique(subset_data$Location)) < 2) {
      cat("Skipping cluster", x, "- not enough locations represented\n")
      next
    }
    
    DE_Genes.DuodenumVsIleum <- FindMarkers(
      subset_data, 
      group.by = "Location", 
      ident.1 = "Duodenum", 
      ident.2 = "Ileum", 
      assay = "RNA"
    ) %>% dplyr::filter(p_val_adj <= 0.05)
    
    if (nrow(DE_Genes.DuodenumVsIleum) > 0) {
      write.csv(DE_Genes.DuodenumVsIleum, 
                file = paste0("../outputs/immune_DE_Genes.Duodenum.Vs.Ileum-CTRL-cluster-", x, ".csv"))
      
      pdf(paste0("../outputs/immune_Volcano-Plot-DE_Genes.Duodenum.Vs.Ileum-CTRL-cluster-", x, ".pdf"))
      print(EnhancedVolcano::EnhancedVolcano(
        DE_Genes.DuodenumVsIleum,
        x = 'avg_log2FC',
        y = 'p_val_adj',
        lab = rownames(DE_Genes.DuodenumVsIleum),
        title = paste("Cluster", x, "- Duodenum vs Ileum")
      ))
      dev.off()
      
      cat("Cluster", x, ":", nrow(DE_Genes.DuodenumVsIleum), "DE genes\n")
    } else {
      cat("Cluster", x, ": No significant DE genes\n")
    }
    
  }, error = function(e) { 
    cat("Error in cluster", x, ":", conditionMessage(e), "\n")
    skip_to_next <<- TRUE 
  })
  
  if (skip_to_next) { next }
}


## ----chunk-32-----------------------------------------------------------------
Immune.CTRL_data.processed <- ScaleData(Immune.CTRL_data.processed, features = Features(Immune.CTRL_data.processed))


## ----chunk-33-----------------------------------------------------------------
# Get top upregulated genes in Duodenum
DE_Genes.DuodenumVsIleum.Immune %>%
  dplyr::filter(avg_log2FC > 0) %>%
  slice_head(n = 50) %>%
  ungroup() -> top50.Duodenum.Genes

# Get top upregulated genes in Ileum
DE_Genes.DuodenumVsIleum.Immune %>%
  dplyr::filter(avg_log2FC < 0) %>%
  slice_head(n = 50) %>%
  ungroup() -> top50.Ileum.Genes

cat("Top 50 Duodenum-upregulated genes:", nrow(top50.Duodenum.Genes), "\n")
cat("Top 50 Ileum-upregulated genes:", nrow(top50.Ileum.Genes), "\n")

if (nrow(top50.Duodenum.Genes) > 0 | nrow(top50.Ileum.Genes) > 0) {
  pdf("../outputs/immune_HEATMAP-Immune.CTRL_data-Top-50-Upregulated-genes-in-Duodenum-and-Ileum.pdf", height = 20, width = 15)
  DoHeatmap(Immune.CTRL_data.processed, 
            features = c(rownames(top50.Duodenum.Genes), rownames(top50.Ileum.Genes)), 
            group.by = "Location")
  dev.off()
  
  pdf("../outputs/immune_HEATMAP-Immune.CTRL_data-Top-50-Upregulated-genes-in-Duodenum-and-Ileum(Grouped-by-Cluster).pdf", height = 20, width = 15)
  DoHeatmap(Immune.CTRL_data.processed, 
            features = c(rownames(top50.Duodenum.Genes), rownames(top50.Ileum.Genes)), 
            group.by = "RNA_snn_res.0.5")
  dev.off()
  
  # Display in notebook
  DoHeatmap(Immune.CTRL_data.processed, 
            features = c(rownames(top50.Duodenum.Genes), rownames(top50.Ileum.Genes)), 
            group.by = "Location")
}


## ----chunk-34-----------------------------------------------------------------
saveRDS(Immune.CTRL_data.processed, file = "../outputs/immune_Immune.CTRL_data.processed.RDS")
cat("Saved processed immune data to RDS\n")


## ----chunk-35-----------------------------------------------------------------
Immune.CTRL_data.processed <- readRDS("../outputs/immune_Immune.CTRL_data.processed.RDS")

immune.annotation <- read.csv("../data/immune-annotation.csv")


## ----chunk-36-----------------------------------------------------------------
sessionInfo()

