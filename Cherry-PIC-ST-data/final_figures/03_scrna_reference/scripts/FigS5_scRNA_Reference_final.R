## ----setup, include=FALSE-----------------------------------------------------
.libPaths("/sc/arion/projects/naiklab/ikjot/R")
library(Seurat)
library(tidyverse)
library(patchwork)
library(readxl)          # Aug-12 xlsx: Broad annotation for panel S5B
knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)


## ----pipeline-provenance, child='Preprocessing_scRNA_Reference_final.Rmd'-----

## ----ppref-doc-setup, include=FALSE-------------------------------------------
# Documentation notebook — every chunk below is marked eval=FALSE individually
# (safe to include as a knitr child without disabling the parent's figure chunks).


## ----ppref-load, eval=FALSE---------------------------------------------------
# .libPaths("/sc/arion/projects/naiklab/ikjot/R")
# library(Seurat); library(tidyverse); library(patchwork); library(harmony); library(clustree)
# 
# # Lab-supplied processed objects (note: two different Daniels — see Stage 2 naming note)
# Fib.Obj    <- readRDS(fib_path)      # Glisovic fibroblast — public, GEO GSE269017
# Epi.Obj    <- readRDS(epi_path)      # Rosenblum epithelial, this manuscript (cell_type_labels/broad/narrow)
# Immune.Obj <- readRDS(immune_path)   # Rosenblum immune, this manuscript
# 
# # Reference datasets prepared in Stage 0
# SpaceFold.Obj  <- readRDS("Reference-Single-Cell-Data/rds-objects/SI-data_SpaceFold-paper.RDS")
# rds_path <- "Reference-Single-Cell-Data/rds-objects"
# Degirmenci.Obj <- readRDS(file.path(rds_path, "Degirmenci.Obj.rds"))
# Kinchen.Obj    <- readRDS(file.path(rds_path, "Kinchen.Obj.rds"))
# McCarthy.Obj   <- readRDS(file.path(rds_path, "McCarthy.Obj.rds"))
# Roulis.Obj.1   <- readRDS(file.path(rds_path, "Roulis.Obj.C1A.rds"))
# Roulis.Obj.2   <- readRDS(file.path(rds_path, "Roulis.Obj.C1B.rds"))
# Roulis.Obj.3   <- readRDS(file.path(rds_path, "Roulis.Obj.C2A.rds"))
# Roulis.Obj.4   <- readRDS(file.path(rds_path, "Roulis.Obj.C2B.rds"))
# Roulis.Obj.5   <- readRDS(file.path(rds_path, "Roulis.Obj.C2C.rds"))


## ----ppref-qc, eval=FALSE-----------------------------------------------------
# all_objects <- list(Fib.Obj = Fib.Obj, Epi.Obj = Epi.Obj, Immune.Obj = Immune.Obj,
#                     SpaceFold.Obj = SpaceFold.Obj, Degirmenci.Obj = Degirmenci.Obj,
#                     Kinchen.Obj = Kinchen.Obj, McCarthy.Obj = McCarthy.Obj,
#                     Roulis.Obj.1 = Roulis.Obj.1, Roulis.Obj.2 = Roulis.Obj.2,
#                     Roulis.Obj.3 = Roulis.Obj.3, Roulis.Obj.4 = Roulis.Obj.4,
#                     Roulis.Obj.5 = Roulis.Obj.5)
# 
# for (nm in names(all_objects)) {
#   obj <- all_objects[[nm]]; DefaultAssay(obj) <- "RNA"
#   obj[["percent.mt"]]   <- if (any(grepl("^mt-|^Mt-|^MT-", rownames(obj))))   PercentageFeatureSet(obj, "^mt-|^Mt-|^MT-") else 0
#   obj[["percent.ribo"]] <- if (any(grepl("^Rp[sl]|^RP[SL]", rownames(obj))))  PercentageFeatureSet(obj, "^Rp[sl]|^RP[SL]") else 0
#   all_objects[[nm]] <- obj
# }
# 
# qc <- list(min_features = 200, max_features = 8000, min_counts = 500, max_counts = 50000, max_mt = 15)
# all_objects <- lapply(all_objects, function(obj) subset(obj,
#   subset = nFeature_RNA >= qc$min_features & nFeature_RNA <= qc$max_features &
#            nCount_RNA  >= qc$min_counts   & nCount_RNA  <= qc$max_counts   &
#            percent.mt  <= qc$max_mt))
# list2env(all_objects, envir = environment())   # write filtered objects back by name


## ----ppref-metadata, eval=FALSE-----------------------------------------------
# # Representative assignments (one block per dataset in the original; condensed here).
# Fib.Obj$dataset_label       <- "Glisovic_Fibroblast";  Fib.Obj$cell_class       <- "Fibroblast"
# Epi.Obj$dataset_label       <- "Rosenblum_Epithelial"; Epi.Obj$cell_class       <- "Epithelial"
# Immune.Obj$dataset_label    <- "Rosenblum_Immune";     Immune.Obj$cell_class    <- "Immune"
# SpaceFold.Obj$dataset_label <- "Niec_SpaceFold_SI"
# # Niec spans all three compartments; cell_class is derived from the authors' own
# # coarse annotation, not set to one value. See Master-dataset-integration.Rmd.
# SpaceFold.Obj$cell_class    <- niec_cell_class[as.character(SpaceFold.Obj$coarse_cluster_dbRM)]
# Degirmenci.Obj$dataset_label<- "Degirmenci_2018";     Degirmenci.Obj$cell_class<- "Mesenchymal"
# Kinchen.Obj$dataset_label   <- "Kinchen_2018";        Kinchen.Obj$cell_class   <- "Mesenchymal"
# McCarthy.Obj$dataset_label  <- "McCarthy_2020";       McCarthy.Obj$cell_class  <- "Mesenchymal"
# for (nm in paste0("Roulis.Obj.", 1:5)) {
#   obj <- get(nm); obj$dataset_label <- "Roulis_2020"; obj$cell_class <- "Mesenchymal"; assign(nm, obj)
# }
# # (sequencing_tech / tissue / dataset_id / orig_annotation set per dataset in the source.)


## ----ppref-sct-merge, eval=FALSE----------------------------------------------
# obj_names <- c("Fib.Obj","Epi.Obj","Immune.Obj","SpaceFold.Obj","Degirmenci.Obj",
#                "Kinchen.Obj","McCarthy.Obj","Roulis.Obj.1","Roulis.Obj.2",
#                "Roulis.Obj.3","Roulis.Obj.4","Roulis.Obj.5")
# for (nm in obj_names) {
#   obj <- get(nm); DefaultAssay(obj) <- "RNA"
#   assign(nm, SCTransform(obj, assay = "RNA", verbose = FALSE))
# }
# Master.Obj <- merge(Fib.Obj, y = lapply(obj_names[-1], get), merge.data = FALSE)


## ----ppref-pca-harmony, eval=FALSE--------------------------------------------
# DefaultAssay(Master.Obj) <- "SCT"
# Master.Obj <- FindVariableFeatures(Master.Obj, nfeatures = 3000)
# Master.Obj <- RunPCA(Master.Obj, assay = "SCT", verbose = FALSE)
# 
# # Harmony's k-means initialisation is stochastic and carries no default seed,
# # unlike RunUMAP (seed.use = 42) and FindClusters (random.seed = 0).
# set.seed(42)
# Master.Obj <- RunHarmony(Master.Obj,
#                          group.by.vars  = c("dataset_label", "sequencing_tech"),
#                          reduction      = "pca", reduction.save = "harmony",
#                          assay.use      = "SCT", verbose = FALSE)


## ----ppref-umap-cluster, eval=FALSE-------------------------------------------
# n_dims <- 30
# cluster_resolutions <- c(0.1,0.2,0.3,0.4,0.5,0.8,1,1.2,1.5,2,2.5,3)
# selected_resolution <- 1.2
# 
# Master.Obj <- RunUMAP(Master.Obj, reduction = "harmony", dims = 1:n_dims, verbose = FALSE)
# Master.Obj <- FindNeighbors(Master.Obj, reduction = "harmony", dims = 1:n_dims, verbose = FALSE)
# Master.Obj <- FindClusters(Master.Obj, resolution = cluster_resolutions, verbose = FALSE)
# Master.Obj$seurat_clusters <- Master.Obj@meta.data[["SCT_snn_res.1.2"]]
# Idents(Master.Obj) <- "seurat_clusters"


## ----ppref-annotate-save, eval=FALSE------------------------------------------
# annotation.file <- "single cell seq combined datasets annotation res 1_2 With colors RCTD apr 2nd.csv"
# annotations <- read.csv(annotation.file, stringsAsFactors = FALSE)
# annotations <- annotations[!is.na(annotations$X.) & annotations$X. != "", ]
# annotations$Population[is.na(annotations$Population) | annotations$Population == ""] <- "Unannotated"
# 
# # Map res-1.2 cluster number -> Population label
# cluster_to_annot <- setNames(annotations$Population, as.character(annotations$X.))
# annot_vec <- cluster_to_annot[as.character(Master.Obj@meta.data[["SCT_snn_res.1.2"]])]
# annot_vec[is.na(annot_vec)] <- "Unannotated"
# Master.Obj@meta.data$cluster_annotation <- annot_vec
# 
# saveRDS(Master.Obj, "output/master_integration/rds/Master.Obj.rds")



## ----config-------------------------------------------------------------------
rds_master <- "../data/Master.Obj.rds"
out_dir    <- "../outputs"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
op <- function(f) file.path(out_dir, f)

# ---- FINALIZED annotation source: Aug-10th CSV ------------------------------
# The saved object's cluster_annotation was mapped from an EARLIER annotation CSV
# whose per-cluster labels differed from the finalized Aug-10th set (May-8th vs
# later reassigned clusters 9/38/40: Myofibroblasts / Goblet cells / cDC1). The
# Aug-10th file also has an encoding quirk for "Resident CD8aa IELs" (mojibake α +
# double space). To keep labels AND colours consistent from ONE finalized source,
# we (1) re-map cluster_annotation from res-1.2 cluster IDs using Aug-10th, and
# (2) ASCII-sanitize BOTH the labels and the colour keys identically so the join
# is exact (no silent grey fallback).
sc_annot_file <- "../data/single cell seq combined datasets annotation res 1_2 With colors RCTD broad August 10th.csv"
sc_annot  <- read.csv(sc_annot_file, stringsAsFactors = FALSE, check.names = FALSE)

# Same normalisation the master-integration pipeline applied to Population labels,
# plus the Aug-10th mojibake sequence for alpha ("Œ±" = U+0152 U+00B1 -> a) so the
# CD8aa label renders cleanly and matches the sanitized colour key.
sanitize_ascii <- function(x) {
  x <- gsub("Œ±", "a", x)      # double-encoded alpha (mojibake) -> a
  x <- gsub("α", "a", x)            # proper Greek alpha -> a
  x <- gsub("—|–", "-", x)     # em/en dash -> hyphen
  x <- iconv(x, to = "ASCII//TRANSLIT", sub = "")  # drop any remaining non-ASCII
  gsub("\\s+", " ", trimws(x))                # collapse whitespace (fixes double spaces)
}

clnum_col <- names(sc_annot)[1]               # first column is the res-1.2 cluster '#'
sc_annot$Population_clean <- sanitize_ascii(sc_annot$Population)

# cluster '#' -> sanitized Population, and sanitized Population -> Hex
cluster_to_pop <- setNames(sc_annot$Population_clean, as.character(sc_annot[[clnum_col]]))
pop_color_map  <- setNames(trimws(sc_annot[["Hex Code"]]), sc_annot$Population_clean)
pop_color_map  <- pop_color_map[!duplicated(names(pop_color_map))]

# Curated cell-type marker list (Cell_Type -> markers) for the dot plots.
marker_csv <- "../data/Custom-Marker-genes-only-from-Daniel.csv"
markers_df <- read.csv(marker_csv, stringsAsFactors = FALSE) |>
  transmute(Cell_Type = trimws(Cell_Type), Marker = trimws(Marker)) |>
  filter(!is.na(Marker), Marker != "")


## ----load---------------------------------------------------------------------
Master.Obj <- readRDS(rds_master)
cat("Cells:", ncol(Master.Obj), "| Reductions:", paste(Reductions(Master.Obj), collapse = ", "), "\n")
cat("cell_class:\n"); print(table(Master.Obj$cell_class))

# ---- Re-map cluster_annotation from res-1.2 IDs using the FINALIZED Aug-10th CSV ----
res_col <- "SCT_snn_res.1.2"
if (res_col %in% colnames(Master.Obj@meta.data)) {
  cl <- as.character(Master.Obj@meta.data[[res_col]])
  new_annot <- unname(cluster_to_pop[cl])
  n_unmapped <- sum(is.na(new_annot))
  if (n_unmapped > 0) warning(n_unmapped, " cells have a res-1.2 cluster with no Aug-10th label; kept as 'Unannotated'.")
  new_annot[is.na(new_annot)] <- "Unannotated"
  Master.Obj$cluster_annotation <- new_annot
  cat("Re-mapped cluster_annotation from", res_col, "using Aug-10th labels.\n")
} else {
  # Fallback: object lacks res-1.2 column — sanitize its stored labels so they still
  # join to the sanitized colour keys.
  warning(res_col, " not found; sanitizing stored cluster_annotation for colour matching.")
  Master.Obj$cluster_annotation <- sanitize_ascii(as.character(Master.Obj$cluster_annotation))
}

# Colour vector for the labels present; flag (don't silently grey) any without a colour.
annotation_labels <- sort(unique(as.character(Master.Obj$cluster_annotation)))
missing_col <- setdiff(annotation_labels, c(names(pop_color_map), "Unannotated"))
if (length(missing_col) > 0)
  warning("No Aug-10th colour for: ", paste(missing_col, collapse = ", "), " (using grey).")
annotation_colors <- sapply(annotation_labels, function(lbl) {
  hex <- pop_color_map[[lbl]]
  if (!is.null(hex) && !is.na(hex) && hex != "NA" && hex != "") hex else "#808080"
})
annotation_colors <- setNames(annotation_colors, annotation_labels)


## ----umap_dataset, fig.width=10, fig.height=8---------------------------------
# stored dataset_label -> published S5A legend entry
dataset_display <- c(
  Glisovic_Fibroblast  = "Glisovic et al 2025",
  Rosenblum_Epithelial = "Rosenblum et al 2026",
  Rosenblum_Immune     = "Rosenblum et al 2026",
  Daniel_Epithelial    = "Rosenblum et al 2026",   # legacy spelling in the frozen object
  Daniel_Immune        = "Rosenblum et al 2026",   # legacy spelling in the frozen object
  Niec_SpaceFold_SI    = "Niec et al 2022",
  SpaceFold_SI         = "Niec et al 2022",        # legacy spelling in the frozen object
  Degirmenci_2018      = "Degirmenci et al 2018",
  Kinchen_2018         = "Kinchen et al 2018",
  McCarthy_2020        = "McCarthy et al 2020",
  Roulis_2020          = "Roulis et al 2020"
)

stored <- as.character(Master.Obj$dataset_label)
unmapped <- setdiff(unique(stored), names(dataset_display))
if (length(unmapped))
  warning("dataset_label with no published-citation mapping: ", paste(unmapped, collapse = ", "))

# Unmapped values fall through unchanged rather than becoming NA (visible, not silent).
Master.Obj$dataset_citation <- ifelse(stored %in% names(dataset_display),
                                      dataset_display[stored], stored)

cat("Published S5A legend entries:", length(unique(Master.Obj$dataset_citation)),
    "— published figure has 7\n")
print(table(Master.Obj$dataset_citation))

p_dataset <- DimPlot(Master.Obj, reduction = "umap", group.by = "dataset_citation",
                     pt.size = 0.2) +
  ggtitle("Master reference — dataset of origin")
ggsave(op("figS5A_umap_dataset.pdf"), p_dataset, width = 10, height = 8)
p_dataset


## ----broad_annotation---------------------------------------------------------
broad_xlsx <- "../data/single cell seq combined datasets annotation res 1_2 With colors RCTD broad Aug12.xlsx"
broad_df   <- readxl::read_excel(broad_xlsx)

# Same normalisation used for the Fig 3B/3C broad palette, so keys join exactly.
norm_broad <- function(x) gsub("_+", "_", gsub("[^[:alnum:]]", "_", trimws(x)))

broad_df$Broad_clean <- norm_broad(broad_df$Broad)

# Published legend merges TA cells with Early progenitors into a single entry.
broad_df$Broad_clean[broad_df$Broad_clean %in% c("TA_cells", "Early_progenitors")] <-
  "TA_cells_Early_progenitors"

clnum <- names(broad_df)[1]                       # res-1.2 cluster '#'
cluster_to_broad <- setNames(broad_df$Broad_clean, as.character(broad_df[[clnum]]))
broad_colors <- setNames(trimws(broad_df$`Broad Hex code`), broad_df$Broad_clean)
broad_colors <- broad_colors[!duplicated(names(broad_colors))]
broad_comp   <- setNames(trimws(broad_df$Compartment), broad_df$Broad_clean)
broad_comp   <- broad_comp[!duplicated(names(broad_comp))]

if (!res_col %in% colnames(Master.Obj@meta.data))
  stop(res_col, " not found — cannot build the Broad annotation for S5B.")

clb <- as.character(Master.Obj@meta.data[[res_col]])
Master.Obj$broad_annotation <- unname(cluster_to_broad[clb])

# Drop Unknown / unmapped from the panel (published legend excludes them).
keep <- !is.na(Master.Obj$broad_annotation) & Master.Obj$broad_annotation != "Unknown"
cat("Cells excluded from S5B (Unknown/unmapped):", sum(!keep), "of", ncol(Master.Obj), "\n")
Master.Obj.b <- Master.Obj[, keep]

# Order the legend Epithelia -> Stroma -> Immune, as published.
present_b <- sort(unique(Master.Obj.b$broad_annotation))
present_b <- present_b[order(match(broad_comp[present_b],
                                   c("Epithelia", "Stroma", "Immune"), nomatch = 4L),
                             present_b)]
Master.Obj.b$broad_annotation <- factor(Master.Obj.b$broad_annotation, levels = present_b)

missing_b <- setdiff(present_b, names(broad_colors))
if (length(missing_b)) warning("No Broad hex for: ", paste(missing_b, collapse = ", "))
cols_b <- vapply(present_b, function(b) {
  h <- unname(broad_colors[b]); if (!is.na(h) && nzchar(h) && h != "NA") h else "#808080"
}, character(1))

cat("S5B broad categories:", length(present_b), "— published figure has 25\n")
print(table(broad_comp[present_b]))


## ----umap_celltype, fig.width=14, fig.height=11-------------------------------
p_annot <- DimPlot(Master.Obj.b, reduction = "umap", group.by = "broad_annotation",
                   cols = cols_b, label = FALSE, pt.size = 0.2) +
  ggtitle("Master reference — cell-type annotation (broad)") +
  theme(legend.position = "right", legend.text = element_text(size = 7))
ggsave(op("figS5B_umap_celltype_broad.pdf"), p_annot, width = 16, height = 12)
p_annot


## ----supporting_umap_celltype_fine, fig.width=16, fig.height=12---------------
p_annot_fine <- DimPlot(Master.Obj, reduction = "umap", group.by = "cluster_annotation",
                        cols = annotation_colors, label = TRUE, label.size = 3, repel = TRUE,
                        pt.size = 0.2) +
  ggtitle("Master reference — cell-type annotation (fine / Population)") +
  theme(legend.position = "right", legend.text = element_text(size = 7))
ggsave(op("supporting_umap_celltype_fine.pdf"), p_annot_fine, width = 16, height = 12)
p_annot_fine


## ----dotplots, fig.width=20, fig.height=8-------------------------------------
# Top-5 curated markers per cell type, flattened for DotPlot (faithful to §11f).
marker_list <- split(markers_df$Marker, markers_df$Cell_Type)
marker_list <- lapply(marker_list, function(x) head(x[x %in% rownames(Master.Obj)], 5))
marker_list <- marker_list[vapply(marker_list, length, integer(1)) > 0]
all_top_markers <- unique(unlist(marker_list))

# Compartment grouping of cell_class: Stroma folds Fibroblast + Mesenchymal.
compartment_of <- c(Epithelial = "Epithelia", Immune = "Immune",
                    Fibroblast = "Stroma", Mesenchymal = "Stroma")
Master.Obj$compartment <- unname(compartment_of[as.character(Master.Obj$cell_class)])

for (comp in c("Epithelia", "Immune", "Stroma")) {
  cells <- colnames(Master.Obj)[!is.na(Master.Obj$compartment) & Master.Obj$compartment == comp]
  if (length(cells) == 0) next
  sub <- Master.Obj[, cells]
  Idents(sub) <- factor(sub$cluster_annotation)
  dp <- DotPlot(sub, features = all_top_markers, group.by = "cluster_annotation") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 7),
          axis.text.y = element_text(size = 8)) +
    ggtitle(paste0("Marker expression — ", comp))
  ggsave(op(paste0("superseded_dotplot_", tolower(comp), "_from_FigS5_Rmd.pdf")), dp, width = 20, height = 8, limitsize = FALSE)
  print(dp)
}

