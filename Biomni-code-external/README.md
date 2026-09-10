# Reproducible Code Package

This package contains all code and essential input data needed to reproduce the final plots from two analyses:

1. **LIANA + NicheNet combined cell–cell communication analysis** — Venn diagrams and hub-and-spoke plots
2. **Pathway enrichment analysis with ambient RNA audit** — module heatmaps and bar plots

## Directory structure

```
reproducible_package/
├── README.md                              # This file
├── 01_liana_nichenet/
│   ├── scripts/                           # 3 scripts
│   ├── data/                              # 3 input CSVs
│   └── outputs/                           # Reference outputs (for comparison)
├── 02_pathway_analysis/
│   ├── scripts/                           # 4 scripts
│   ├── data/                              # 6 input CSVs
│   └── outputs/                           # Reference outputs (for comparison)
└── 03_shared_data/
    ├── pseudobulk_new/                    # 9 pseudobulk DESeq2 CSVs
    └── DR26001_v2_annotated_seurat_singlets_with_replicates.rds  # Seurat object (510 MB)
```

## 01_liana_nichenet — Cell–cell communication analysis

### Input data (`data/`)

| File | Description |
|------|-------------|
| `liana_duodenum_st_ta_sig_noclu.csv` | LIANA significant L-R pairs, Duodenum, Stem/TA receivers, CLU+ excluded |
| `liana_ileum_st_ta_sig_noclu.csv` | LIANA significant L-R pairs, Ileum, Stem/TA receivers, CLU+ excluded |
| `nichenet_liana_combined_all.csv` | NicheNet ligand activity + LIANA combined, all runs |

### Scripts (`scripts/`) — run in order

| Script | Purpose | Input | Output |
|--------|---------|-------|--------|
| `build_sender_counts_merged.py` | Build sender summary counts | LIANA sig CSVs + NicheNet combined CSV | `sender_summary_interaction_counts.csv` |
| `plot_sender_all.R` | Hub-and-spoke + sender circle plots | `sender_summary_interaction_counts.csv` | 16 PNG + 16 SVG |
| `plot_venn_region_overlap.py` | Venn diagrams (region overlap) | LIANA sig CSVs + NicheNet combined CSV | 4 PNG + 4 SVG + 1 CSV |

### Run instructions

Paths are now resolved relative to each script's own location, so run from the package
subfolder. No `/mnt` mounts required.

```bash
cd 01_liana_nichenet
python3 scripts/build_sender_counts_merged.py   # -> outputs/sender_summary_circles/
Rscript  scripts/plot_sender_all.R              # -> outputs/sender_summary_circles/
python3  scripts/plot_venn_region_overlap.py    # -> outputs/venn_region_overlap/
```

All three run clean and reproduce the shipped reference outputs byte-for-byte on the
counts CSV.

### Expected outputs (`outputs/`)

- `venn_region_overlap/` — 4 Venn diagrams (LIANA-only vs combined, Stem vs TA) + panel + counts CSV
- `sender_summary_circles/` — 8 hub-and-spoke plots (LIANA vs combined × Duo/Ile × Stem/TA) + 8 sender circle plots

## 02_pathway_analysis — Pathway enrichment with ambient RNA audit

### Input data (`data/`)

| File | Description |
|------|-------------|
| `pathway_table_cleaned.csv` | Cleaned pathway table (408 rows, 11 REMOVE pathways excluded) — **input for plotting** |
| `ambient_annotated_pathway_table.csv` | Full audit table (419 rows, 16 columns) |
| `ambient_rna_audit.csv` | Audit rationale for 115 non-KEEP pathways |
| `gene_level_verdicts.csv` | Gene-level verdicts for 62 genes |
| `cell_level_expression_validation.csv` | Cell-level validation (79 genes × 10 cell types) |
| `module_pathway_leading_edges.csv` | Leading edge genes per pathway (input for ambient audit) |

### Scripts (`scripts/`) — run in order

| Script | Purpose | Input | Output |
|--------|---------|-------|--------|
| `ambient_rna_audit.R` | Identify ambient RNA contamination | `module_pathway_leading_edges.csv` | `ambient_annotated_pathway_table.csv` |
| `cell_level_validation_fix.R` | Validate ambient genes at cell level | Seurat object + ambient panel | `cell_level_expression_validation.csv` |
| `filter_and_rerun_fgsea_v5.R` | Re-run FGSEA without ambient genes | Pseudobulk CSVs + ambient panel | Filtered FGSEA results |
| `regenerate_pathway_figures.R` | Generate heatmaps + bar plots | `pathway_table_cleaned.csv` | 25 heatmaps + 6 bar plots |

### Run instructions

```bash
# 1. Run ambient RNA audit (optional — already done)
Rscript scripts/ambient_rna_audit.R

# 2. Run cell-level validation (optional — already done, requires Seurat object)
Rscript scripts/cell_level_validation_fix.R

# 3. Re-run FGSEA without ambient genes (optional — already done)
Rscript scripts/filter_and_rerun_fgsea_v5.R

# 4. Generate final plots (this is the main plotting script)
Rscript scripts/regenerate_pathway_figures.R
```

**Note:** Steps 1–3 are upstream and already done. To reproduce the plots, you only need step 4 with the provided `pathway_table_cleaned.csv`.

### Expected outputs (`outputs/`)

- `module_heatmaps/` — 25 module heatmaps (PNG + SVG), one per pathway module
- `pathways_ambient_removed/` — 6 bar plots (PNG + SVG), one per cell type

## 03_shared_data — Shared input data

| File | Description |
|------|-------------|
| `pseudobulk_new/` | 9 pseudobulk DESeq2 CSVs (Ileum vs Duodenum, one per cell type) |
| `DR26001_v2_annotated_seurat_singlets_with_replicates.rds` | Seurat object (510 MB, 11,338 cells × 20,319 genes) |

## Dependencies

### R packages
```r
install.packages(c("data.table", "ggplot2", "stringr", "svglite", "circlize"))
# ComplexHeatmap from Bioconductor
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("ComplexHeatmap")
# For upstream scripts only
install.packages(c("fgsea", "msigdbr", "Seurat"))
```

### Python packages
```bash
pip install pandas matplotlib matplotlib-venn
```

## Key parameters

### LIANA + NicheNet

The scoring step ran in the Biomni session of 6 August 2026 and is not among these scripts;
its record is the session's own reports, which state every parameter:

- `Full-data/Biomni_lab_downloads_20260826_164206/report_region_unique_liana.md`
- `Full-data/Biomni_lab_downloads_20260826_164206/report_biological_nichenet.md`

| Parameter | Value |
|---|---|
| Scoring object | `nichenet_obj.rds`, 19,280 cells, 17 cell types — the regional dataset's stem (2,907) and TA (5,036) cells merged with the sorted-niche object; duodenum 11,261 / ileum 8,019; not included here |
| LIANA | 0.1.14, `liana_wrap(idents_col = "cell_type", resource = "MouseConsensus")` per region, then `liana_aggregate()`; object converted to a `SingleCellExperiment` on logcounts |
| Resource | `MouseConsensus`, 3,998 mouse pairs — the default human-symbol resource returned 40 rows |
| Methods | NATMI, Connectome, LogFC, SingleCellSignalR, CellPhoneDB (500 permutations, single-threaded) |
| Significance | robust rank aggregation, `aggregate_rank ≤ 0.05` (the tables confirm: significant tables max exactly 0.0500, full tables run to 1.0) |
| CLU+ reserve stem cells | removed from the significant-pair tables after aggregation (`_noclu`); duodenum only |
| NicheNet networks | v2 mouse, Zenodo 7074291; ligand–target matrix 22,521 × 1,287 |
| Candidate ligands | 239 distinct LIANA-significant ligands (union of regions); 216 present in the matrix → `nichenet/v2/potential_ligands.txt` |
| Response gene sets | up-ileum (234) and up-duodenum (189) from DESeq2 pseudobulk by biological sample (6 vs 6), `padj < 0.05`, `|log2FC| > 0.5`; plus curated stem and TA marker sets |
| Background | genes expressed in ≥ 10% of receiver cells ∩ matrix rows — stem 7,962, TA 9,494 |
| Runs | 6: {stem, TA} × {up-ileum, up-duodenum, markers}; `predict_ligand_activities()` → Pearson, AUROC, AUPR |
| Activity threshold | Pearson > 0 |
| Receptors | expressed in ≥ 10% of receiver cells |
| Sender exclusions in figures | Bottom/Mid/Upper-villus enterocytes, Goblet, Enteroendocrine; Paneth kept |
| Region-uniqueness | LIANA-significant in one region but not the other |

### Pathway analysis
- **Significance threshold:** padj < 0.05
- **Ambient gene panel:** 34 genes (Paneth/secretory, enterocyte, bile acid transport, xenobiotic/metabolic)
- **Classification:** 11 REMOVE_FROM_INTERPRETATION, 1 KEEP_WITH_CAUTION, 407 KEEP
- **Color scale:** Blue (`#247CEF`) = Duodenum-up (NES<0), Red (`#E74C3C`) = Ileum-up (NES>0), Gray (`#ECE9E2`) = not present

## Ambient RNA audit summary

The ambient RNA audit identified 11 pathways driven by ambient epithelial RNA contamination:

**Initial removals (7)** — based on cell-level expression validation:
- 3 antimicrobial peptide pathways (Defa family, Reg3g, Reg3b, Itln1 — Paneth-specific)
- 4 bile acid transport pathways (Slc10a2, Slc51a, Slc51b, Fabp6 — enterocyte-specific)

**Additional removals (4)** — based on GSEA re-analysis without ambient genes:
- 2 macrophage bile acid pathways (significance driven by ambient transporters)
- 2 macrophage retinol metabolism pathways (significance driven by ambient Cyp/UGT genes)

**Kept (1):** Fibroblasts KEGG_RETINOL_METABOLISM — genuine Lrat + Aldh1a2 program, still significant without ambient genes (padj = 0.023).

See `02_pathway_analysis/data/ambient_rna_audit.csv` for full rationale.

## Contact

For questions about the analysis, contact Daniel Rosenblum.
