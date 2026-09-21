# Reproduce Plots: Mouse Duodenum + Ileum scRNA-seq

Reproducible code package for UMAP, composition, and annotation dot plots from a mouse duodenum + ileum single-cell RNA-seq Seurat v5 object, with Mid-villus enterocytes removed.

## Requirements

- **R** >= 4.4.x
- **Packages**: Seurat (v5), harmony, ggplot2, svglite
- **Input data**: `DR26001_v2_annotated_seurat_singlets_with_replicates.rds` (original Seurat object, not included)

Install packages:
```r
install.packages(c("Seurat", "harmony", "ggplot2", "svglite"))
```

## Quick Start

1. Edit `run_all.R` — set `base_dir` to this directory and `input_obj` to the path of your original Seurat object.
2. Run:
```bash
Rscript run_all.R
```

The script skips steps whose output files already exist (filtered/recomputed RDS objects, panel CSVs), so you can re-run safely. To force a full recompute, delete the files in `objects/` and `data/` first.

## Running Individual Scripts

Each script in `scripts/` is self-contained. Edit `base_dir` (and `input_obj` where needed) at the top, then run:
```bash
Rscript scripts/step1_filter.R
Rscript scripts/step2_umap_composition.R
# etc.
```

## Pipeline

```
Original Seurat object
        |
        v
  step1_filter.R  -----> objects/obj_no_midvillus.rds (10,068 cells, 13 types)
        |                           |
        |                           v
        |                    step3_recompute.R -----> objects/obj_no_midvillus_recomputed.rds
        |                           |                           |
        v                           v                           v
  step2_umap_composition.R   step4_umap_comp_recomputed.R
  (Harmony-only UMAP)        (Recomputed UMAP + composition)
        |                           |
        v                           v
  figures/umap_no_midvillus.*   figures/umap_no_midvillus_recomputed*
  figures/composition_by_region.*  figures/composition_by_region_reordered.*

  rebuild_panel_stringent.R -----> data/annotation_marker_genes.csv (140 genes, 14 types)
        |
        v
  build_reduced_panel.R -----> data/annotation_marker_genes_reduced.csv (76 genes, 14 types)
        |
        v
  dotplot_final.R (uses objects/obj_no_midvillus.rds + reduced panel)
        |
        v
  figures/dotplot_epithelial_zscore.*      figures/dotplot_immune_stroma_zscore.*
  figures/dotplot_epithelial_log1p.*       figures/dotplot_immune_stroma_log1p.*
```

## Expected Outputs

### UMAP plots
| File | Description | Dimensions |
|------|-------------|------------|
| `umap_no_midvillus.png/.svg` | Harmony-only UMAP (original embeddings) | 10.75 x 3.75 in |
| `umap_no_midvillus_recomputed.png/.svg` | Recomputed UMAP (narrow) | 5.38 x 3.75 in |
| `umap_no_midvillus_recomputed_wide_6in.png/.svg` | Recomputed UMAP (wide, 6in) | 6 x 3.75 in |
| `umap_no_midvillus_recomputed_wide_7in.png/.svg` | Recomputed UMAP (wide, 7in) | 7 x 3.75 in |
| `umap_no_midvillus_recomputed_wide_8in.png/.svg` | Recomputed UMAP (wide, 8in) | 8 x 3.75 in |

### Composition plots
| File | Description | Dimensions |
|------|-------------|------------|
| `composition_by_region.png/.svg` | Composition by region (original order) | 12 x 3.75 in |
| `composition_by_region_reordered.png/.svg` | Composition by region (PDF-matched order) | 4.54 x 3.75 in |

### Dot plots
| File | Description | Dimensions |
|------|-------------|------------|
| `dotplot_epithelial_zscore.png/.svg` | Epithelial markers, z-score color | 12 x 3.75 in |
| `dotplot_epithelial_log1p.png/.svg` | Epithelial markers, log1p color | 12 x 3.75 in |
| `dotplot_immune_stroma_zscore.png/.svg` | Immune+Stroma markers, z-score color | 12 x 3.75 in |
| `dotplot_immune_stroma_log1p.png/.svg` | Immune+Stroma markers, log1p color | 12 x 3.75 in |

## Color Scheme

Colors and cell type ordering are matched to Figure 6v12.pdf:

| Cell type | Hex color |
|-----------|-----------|
| CLU+ reserve stem cells | #B12121 |
| TA cells/early progenitors | #1C5E8E |
| Bottom-Villus enterocytes | #9E9AC7 |
| Mid-villus enterocytes (removed) | #614B71 |
| Paneth cells | #006C2C |
| Enteroendocrine cells | #74C476 |
| Goblet cells | #11A44B |
| Blood vascular endothelial cells | #495800 |
| Fibroblasts | #DEB89A |
| Macrophages | #A04F57 |
| Plamsablasts | #F8BAD0 |
| T_helper cells | #088A91 |
| Cd8aa IEL | #004D5E |
| cDC1 | #7D1C28 |

## Notes

- **"Plamsablasts"** is spelled with a typo in the source data metadata. This is preserved intentionally to match the original object.
- The RNA assay data layer is empty in the original object; `NormalizeData()` is called before expression-based analysis in `dotplot_final.R`.
- The recomputed pipeline (step3) uses SCT assay for FindVariableFeatures, ScaleData, PCA, and Harmony, matching the original workflow.
- Harmony batch correction uses `orig.ident` (Duodenum vs Ileum) as the grouping variable.
- Dot plots use a reversed inferno palette with shape=21 dots, zero-expression dots removed, and z-score computed per gene across cell types.
- 65 cells were reclassified from endothelial to fibroblasts in the corrected annotations (`data/corrected_broad_cell_type.rds`).

## Package Contents

```
reproduce_plots/
├── README.md                 (this file)
├── run_all.R                 (master script)
├── scripts/
│   ├── step1_filter.R
│   ├── step2_umap_composition.R
│   ├── step3_recompute.R
│   ├── step4_umap_comp_recomputed.R
│   ├── rebuild_panel_stringent.R
│   ├── build_reduced_panel.R
│   └── dotplot_final.R
├── data/
│   ├── corrected_broad_cell_type.rds
│   ├── annotation_marker_genes.csv
│   └── annotation_marker_genes_reduced.csv
├── objects/
│   ├── obj_no_midvillus.rds              (430 MB)
│   └── obj_no_midvillus_recomputed.rds   (240 MB)
└── figures/                              (populated by scripts)
```
