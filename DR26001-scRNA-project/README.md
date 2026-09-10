# DR26001 regional scRNA-seq

Duodenum vs ileum single-cell RNA-seq of small-intestinal epithelium and immune cells,
merged across a short-term and a long-term experiment. Organised to match the layout used
in `Cherry-PIC-ST-data/` and `Cherry-PIC-scRNA-project/`: numbered stage folders, each
with a flat `scripts/`, `data/` and `outputs/`.

This project produces no manuscript figure of its own. It feeds two downstream analyses:

1. **Master single-cell reference (Figure S5)** — supplies the "Daniel epithelial" and
   "Daniel immune" objects, two of the twelve inputs to `Master.Obj.rds`.
2. **Ligand–receptor analysis (Figures 6F–6G, S8)** — supplies the stem cell and TA cell
   populations used as receivers.

## Directory structure

```
DR26001-scRNA-project/
├── README.md
├── _REORGANIZATION_MANIFEST.tsv        # old path -> new path for all 214 moved files
└── final_figures/
    └── DR26001-scRNA/
        ├── 00-hashtag-pools/           # 3 input objects, no scripts
        ├── 01-separate-epithelia-immune/
        ├── 02-epithelia-clustering/
        ├── 03-immune-clustering/
        ├── 04-merge-controls/
        ├── 05-reannotation-and-qc/
        └── 06-downstream-handoffs/
```

## Stages

### 00-hashtag-pools — inputs

| File | Size |
|---|---|
| `data/final-htp-seu-obj-2024-02-09-RNA.RDS` | 461 MB |
| `data/final-htp-seu-obj-2024-06-05-RNA.RDS` | 454 MB |
| `data/final-htp-seu-obj-2024-03-22-LongTerm.RDS` | 739 MB |

`htp` = hashtag pool. These arrive already demultiplexed, carrying `Location`
(Duodenum / Ileum), `Condition`, `Sample_ID` and `Time_Course`. **The Cell Ranger run and
HTO demultiplexing that produced them are not in this project** — the only genuine
upstream gap. `scripts/` is intentionally empty.

### 01-separate-epithelia-immune

| Script | Does |
|---|---|
| `Separate-Epithelia-Immune-ShortTerm.Rmd` | clusters the 2024-02-09 pool at `RNA_snn_res.0.5`, splits on Ptprc/Epcam |
| `Separate-Epithelia-Immune-LongTerm.Rmd` | same for the 2024-03-22 pool |

Outputs: 4 RDS + 4 QC plots, prefixed `short-term-2024-02-09_` / `long-term-2024-03-22_`.

### 02-epithelia-clustering

| Script | Produces |
|---|---|
| `Combined-short-term-epithelia-analysis.Rmd` | merges the 02-09 and 06-05 pools → `short-term_seu_obj_short_term_combined_processed.RDS` (+ `-UCell-Added`) |
| `long-term-epithelia-analysis.Rmd` | `long-term_seu_obj_epi_long_term_2024_03_22_transfer_labels-UCell-Added.RDS` |

79 outputs: RDS, marker tables, UMAPs and feature plots, prefixed `short-term_` / `long-term_`.

### 03-immune-clustering

| Script | Produces |
|---|---|
| `short-term-immune-analysis-2024-02-09.Rmd` | `short-term_immune-shor-term-2024-02-09.RDS` |
| `long-term-immune-analysis.Rmd` | long-term immune marker tables and UMAPs |

### 04-merge-controls — the stage everything downstream depends on

`Analysis-part1-Epithelia.Rmd`:

1. Subset `Condition == "Control"` from both epithelial arms.
2. `merge()` → `EP.CTRL_data`.
3. Split the RNA assay by sample, run the Harmony multi-sample pipeline.
4. `TransferData()` from the short-term object to carry cell-type labels onto the merge.
5. Annotate `RNA_snn_res.0.8` from `data/Combined-cell-type-annotations.csv` → `cell_type_labels`.
6. Drop the `Immune` clusters, then `JoinLayers()` + `NormalizeData()`.
7. Duodenum vs Ileum `FindMarkers`, globally and per cell type.

`Analysis-part2-Immune.Rmd` does the same shape for the immune compartment.

Key outputs:

| File | Note |
|---|---|
| `outputs/epithelia_EP.CTRL_data.processed(no-immune).RDS` | 398 MB — the ligand–receptor handoff |
| `outputs/epithelia_EP.CTRL_data.processed.RDS` | 406 MB — before immune removal; the reference-atlas handoff |
| `outputs/immune_Immune.CTRL_data.processed.RDS` | 359 MB |
| `outputs/immune_Immune.CTRL_data.filtered.RDS` | 356 MB |
| `outputs/epithelia_DE_Genes.Duodenum.Vs.Ileum-CTRL-cell-type-*.csv` | 8 per-cell-type DE tables |

### 05-reannotation-and-qc

| Script | Does |
|---|---|
| `Cell_type-reAnnotation.Rmd` | annotates 21 clusters at res 0.8 — SC, TA, Pre-enterocytes-1/2, Proximal enterocytes-1/2/3, Distal enterocyte-1/2, Goblet, Paneth, Tuft, Enteroendocrine, Secretory progenitors — plus a 13-cluster trajectory subset and a SingleR comparison |
| `Doublet-test.Rmd` | scDblFinder plus a contaminant-gene UCell score |

The SC and TA labels defined here are what the ligand–receptor analysis consumes:
clusters **0, 9 → SC**; clusters **3, 5, 6, 7 → TA**.

`data/seu-obj-short-term-epithelia-2024-06-05.RDS` (482 MB) is a superseded earlier export of
the 2024-06-05 pool: 25,049 cells with no pool or arm metadata, against the 22,785-cell pool in
`00-hashtag-pools/data/` that stage 02 actually reads. No script uses it; it can be deleted.

### 06-downstream-handoffs

**Handoff A — master reference (Figure S5).** `Preprocessing_scRNA_Reference_final.Rmd`
in `Cherry-PIC-ST-data/` builds `Master.Obj.rds` from twelve objects; three come from here:

| Reference variable | This project |
|---|---|
| `Epi.Obj` | `04-merge-controls/outputs/epithelia_EP.CTRL_data.processed.RDS` — 17,567 cells; the atlas's per-dataset QC keeps 17,552 |
| `Immune.Obj` | `04-merge-controls/outputs/immune_Immune.CTRL_data.processed.RDS` — 27,868 cells; QC keeps 27,863 |
| `SpaceFold.Obj` | `06-downstream-handoffs/data/SI-data_SpaceFold-paper.RDS` |

That Rmd says only that these *"arrive already processed"* — stages 00–05 above are the
processing it refers to.

**Handoff B — stem and TA cells for LIANA/NicheNet.** The Biomni session received three
pre-extracted objects that still carry the `EP_CTRL` naming:

```
Biomni-code-external/Full-data/Biomni_lab_downloads_20260826_164206/
  EP_CTRL_Stem_cells_all.rds        (66 MB)
  EP_CTRL_Stem_cells_Duodenum.rds   (41 MB)
  EP_CTRL_Stem_cells_Ileum.rds      (40 MB)
```

They are subsets of `epithelia_EP.CTRL_data.processed(no-immune).RDS` on
`cell_type_labels`, split by `Location`. The export step is reconstructed in
`06-downstream-handoffs/scripts/export_receivers_for_LR.R`.

**This project supplies both receivers.** In the scored LIANA tables they appear as
`Stem cells` and `TA cells`, renamed from the `SC` and `TA` labels here:

| Receiver | Label here | All | Duodenum | Ileum |
|---|---|---|---|---|
| `Stem cells` | `SC` | 2,907 | 1,583 | 1,324 |
| `TA cells` | `TA` | 5,036 | 3,326 | 1,710 |

`TA cells` here and the Cherry-PIC niche object's `TA cells/early progenitors` (199 cells)
are two labels for the same transit-amplifying compartment: they are separate rows in the raw
LIANA tables and one sender, `TA / early progenitors`, in the final output. CLU+ reserve stem
cells are not
stem cells for this analysis and appear nowhere in the scored tables — the `_noclu` suffix
on those files records their exclusion.

## Script cleanup (done)

- **All paths rewritten** against this layout — 129 replacements across the 10 notebooks.
  Every `readRDS` / `read.csv` / `read_excel` input now resolves; verified programmatically.
- **`.libPaths()` calls guarded** — they now only apply when the HPC library tree exists,
  so the notebooks open cleanly off-cluster.
- **`setwd()` removed**; all paths are relative to each `scripts/` directory.
- **`Analysis-part1-Epithelia.Rmd` rebuilt** (534 → 327 lines): dead chunks removed,
  the three label transfers collapsed into one loop, duplicated plot blocks dropped,
  sections and an inputs/outputs header added. Every computation preserved.
- **Other nine notebooks tidied**: real titles (six had an HPC file path as the title),
  TOC + code folding, 124 anonymous chunks named, obsolete `create.dir()` calls dropped.
- **Two pre-existing bugs fixed** in `Analysis-part2-Immune.Rmd`: a stray `}` that closed
  nothing (the chunk could never have run) and a duplicated console plot block.
- **`Analysis-part2-Immune.Rmd` trimmed**: the unused colour-palette chunk and four
  print-only inspection chunks removed, and the marker table it prints moved to the
  resolution the annotation is applied to (0.9). Every computation preserved.
- **Heatmap reconstruction verified.** `Analysis-part1-Epithelia.Rmd` rebuilds `top100` and
  `top50` as the most significant DE genes; every gene name legible on the archived heatmap
  PDFs is in that set, and the alternative ordering by fold change is not.
- **`data/` filenames with spaces renamed**, with the one reader updated in the same commit.
- All 10 notebooks now pass an R syntax check.

## External dependencies — resolved

Recovered from the `Daniel-Redone-Analysis-NYU-Transfer` download and vendored in:

| File | Now at | Used by |
|---|---|---|
| `processing-utils.R` | `helper-functions/processing-utils.R` (one copy) | 4 scripts, via `source("../../helper-functions/processing-utils.R")` |
| `Onur_Markers.xlsx` | `02-epithelia-clustering/data/` | both stage-02 scripts |

The helper now contains only `run.presto.specific.columns()`, a presto/`wilcoxauc` wrapper
that returns the Raw / Filtered / Top marker tables. Every notebook defines its own
`multi_sample_pipeline()` inline; the helper deliberately does not, so sourcing it can never
replace the version a notebook has already run.

### Prior annotations — resolved, no longer external

Two notebooks needed prior-annotation columns that lived in multi-GB Seurat objects under
another user's account on the cluster. Only these columns were ever read from them, so they were
extracted once and vendored here as CSVs. The `left_join` in each notebook is unchanged.

| CSV | Columns | Cells | Used by |
|---|---|---|---|
| `02-epithelia-clustering/data/prior_annotations_epithelia_2024-03-24.csv` | `cell_type_broad`, `cell_type_narrow` | 35,981 | `Combined-short-term-epithelia-analysis.Rmd`; downstream by the stage-05 SingleR heatmaps |
| `03-immune-clustering/data/prior_annotations_immune_2024-08-06.csv` | `final_clusters` | 21,523 | `short-term-immune-analysis-2024-02-09.Rmd`; downstream as `refdata` for `TransferData` in `long-term-immune-analysis.Rmd` |

Source objects (1.1 GB and 4.5 GB) remain on the analysis cluster. Nothing in this
repository needs them.

