# Reproducible Code Package — LIANA+NicheNet & Pathway Analysis

## Goal
Package the code and essential input data so the user can reproduce the final plots from both analyses, including full upstream reproducibility (ambient RNA audit, cell-level validation, FGSEA re-analysis).

## Package structure

```
/mnt/results/reproducible_package/
├── README.md                              # Overview + run instructions
├── 01_liana_nichenet/
│   ├── scripts/
│   │   ├── build_sender_counts_merged.py  # Builds sender summary counts from LIANA+NicheNet
│   │   ├── plot_sender_all.R              # Hub-and-spoke + sender circle plots
│   │   └── plot_venn_region_overlap.py    # Venn diagrams (region overlap)
│   ├── data/
│   │   ├── liana_duodenum_st_ta_sig_noclu.csv      # LIANA sig pairs (Duo)
│   │   ├── liana_ileum_st_ta_sig_noclu.csv         # LIANA sig pairs (Ile)
│   │   └── nichenet_liana_combined_all.csv         # NicheNet+LIANA combined
│   └── outputs/                           # Reference outputs (for comparison)
│       ├── venn_region_overlap/           # 4 PNG + 4 SVG + 1 CSV
│       └── sender_summary_circles/        # 8 hub-and-spoke + 8 sender circle plots
├── 02_pathway_analysis/
│   ├── scripts/
│   │   ├── regenerate_pathway_figures.R   # Heatmaps + bar plots (final plotting script)
│   │   ├── ambient_rna_audit.R            # Ambient RNA audit (upstream)
│   │   ├── cell_level_validation_fix.R    # Cell-level validation (upstream)
│   │   └── filter_and_rerun_fgsea_v5.R    # FGSEA re-analysis (upstream)
│   ├── data/
│   │   ├── pathway_table_cleaned.csv      # Input for plotting (408 rows)
│   │   ├── ambient_annotated_pathway_table.csv  # Full audit table (419 rows)
│   │   ├── ambient_rna_audit.csv          # Audit rationale (115 rows)
│   │   ├── gene_level_verdicts.csv        # Gene-level verdicts (62 genes)
│   │   ├── cell_level_expression_validation.csv # Cell-level validation (840 rows)
│   │   └── module_pathway_leading_edges.csv     # Input for ambient audit
│   └── outputs/                           # Reference outputs
│       ├── module_heatmaps/               # 25 heatmaps (PNG + SVG)
│       └── pathways_ambient_removed/      # 6 bar plots (PNG + SVG)
└── 03_shared_data/
    ├── pseudobulk_new/                    # 9 pseudobulk DESeq2 CSVs (input for FGSEA)
    └── DR26001_v2_annotated_seurat_singlets_with_replicates.rds  # Seurat object (510 MB)
```

## What's included

**Scripts (8 total):**
- LIANA+NicheNet: `build_sender_counts_merged.py`, `plot_sender_all.R`, `plot_venn_region_overlap.py`
- Pathway analysis: `regenerate_pathway_figures.R`, `ambient_rna_audit.R`, `cell_level_validation_fix.R`, `filter_and_rerun_fgsea_v5.R`

**Input data (12 CSVs + 1 RDS):**
- LIANA+NicheNet: 3 CSVs (LIANA sig pairs × 2 regions, NicheNet+LIANA combined)
- Pathway analysis: 6 CSVs (cleaned table, annotated table, audit, gene verdicts, cell validation, leading edges)
- Shared: 9 pseudobulk DESeq2 CSVs + 1 Seurat object (510 MB)

**Reference outputs (for comparison):**
- Venn diagrams: 4 PNG + 4 SVG + 1 CSV
- Hub-and-spoke + sender circles: 16 PNG + 16 SVG
- Module heatmaps: 25 PNG + 25 SVG
- Bar plots: 6 PNG + 6 SVG

## README contents
- Overview of the two analyses
- Directory structure
- Run instructions for each script (in order)
- R/Python package dependencies
- Expected outputs and where to find them
- Notes on the ambient RNA audit methodology

## Assumptions
- User has R with `data.table`, `ggplot2`, `ComplexHeatmap`, `circlize`, `svglite`, `fgsea`, `msigdbr`, `Seurat` installed
- User has Python with `pandas`, `matplotlib`, `matplotlib_venn` installed
- User does not need to re-run the full LIANA/NicheNet inference (already done)
- User does not need to re-run the pseudobulk DESeq2 (already done)

## Total size estimate
- Scripts: ~100 KB
- Input data: ~5 MB
- Reference outputs: ~30 MB
- Seurat object: ~510 MB
- **Total: ~545 MB**
