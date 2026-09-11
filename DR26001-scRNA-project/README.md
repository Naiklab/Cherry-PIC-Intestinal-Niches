# DR26001 regional scRNA-seq

Duodenum vs ileum single-cell RNA-seq of small-intestinal epithelium and immune cells,
merged across a short-term and a long-term experiment. Organised to match the layout used
in `Cherry-PIC-ST-data/` and `Cherry-PIC-scRNA-project/`: numbered stage folders, each
with a flat `scripts/`, `data/` and `outputs/`.

This project produces one manuscript panel of its own — Figure 3F, the enterocyte dot plots
(`04-merge-controls/scripts/Fig3F_DotPlots_final.Rmd`) — and feeds two downstream analyses:

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

## From raw matrices to the two deposited objects

Every step is in this repository. The chain, with the script that performs each link:

```
PIPseeker filtered matrices (Gene Expression + Cell Hashing, sensitivity_5)
  │   paths in 00-hashtag-pools/data/hto-sample-sheets/<pool>/hto-samples-sheet.xlsx
  ▼   00-hashtag-pools/scripts/htp/scripts/HTO-QC.R
demultiplexed, singlets only            HTODemux(positive.quantile = 0.99) on CLR hashing
  ▼   .../htp/scripts/RNA-QC.R
filtered and merged per pool            nFeature_RNA 500–7,000, percent.mt < 20
  ▼   .../htp/scripts/HTP-Processing.R
final-htp-seu-obj.RDS  ──[renamed per pool, see below]──▶  00-hashtag-pools/data/
  ▼   01-separate-epithelia-immune/scripts/Separate-Epithelia-Immune-{ShortTerm,LongTerm}.Rmd
epithelial and immune subsets per arm   cluster at res 0.5, split on Epcam / Ptprc
  ▼   02-epithelia-clustering/  and  03-immune-clustering/
per-arm clustering and label transfer   Harmony over pool, 40 dims, res 0.1–1.0
  ▼   04-merge-controls/scripts/Analysis-part1-Epithelia.Rmd
      04-merge-controls/scripts/Analysis-part2-Immune.Rmd
epithelia_EP.CTRL_data.processed.RDS        ← the reference-atlas handoff
epithelia_EP.CTRL_data.processed(no-immune).RDS  ← the ligand–receptor handoff
immune_Immune.CTRL_data.processed.RDS
```

**The one manual link.** `HTP-Processing.R` writes a generic
`htp-outs/Downstream-Analysis/RDS/final-htp-seu-obj.RDS` inside whichever pool directory it is
run from. Each run's output was then renamed into `00-hashtag-pools/data/`:

| Pool run | Produced | Renamed to |
|---|---|---|
| 2024-02-09 (short-term) | `final-htp-seu-obj.RDS` | `final-htp-seu-obj-2024-02-09-RNA.RDS` |
| 2024-06-05 (short-term) | `final-htp-seu-obj.RDS` | `final-htp-seu-obj-2024-06-05-RNA.RDS` |
| 2024-03-22 (long-term) | `final-htp-seu-obj.RDS` | `final-htp-seu-obj-2024-03-22-LongTerm.RDS` |

Nothing in the code performs that rename; it was done by hand between the pipeline and stage 01.
The pool each file holds is verifiable from its own metadata — `Sequencing_Date`,
`Time_Course` and the `_ST`/`_LT` suffix on every `Sample_ID` all agree.

**Two asymmetries worth knowing.** The 2024-02-09 and 2024-03-22 pools are split into
epithelial and immune subsets at stage 01, but the 2024-06-05 pool is read whole by
`Combined-short-term-epithelia-analysis.Rmd`, which takes its epithelial clusters directly
while merging. And `05-reannotation-and-qc` reads one object,
`seu-obj-V5-Annotation-pre-removal-2025-03-26.RDS`, that no script here produces — it comes
from the earlier annotation lineage. Neither affects the three objects above.

## Stages

### 00-hashtag-pools — inputs

| File | Size |
|---|---|
| `data/final-htp-seu-obj-2024-02-09-RNA.RDS` | 461 MB |
| `data/final-htp-seu-obj-2024-06-05-RNA.RDS` | 454 MB |
| `data/final-htp-seu-obj-2024-03-22-LongTerm.RDS` | 739 MB |

`htp` = hashtag pool. These carry `Location` (Duodenum / Ileum), `Condition`, `Sample_ID`
and `Time_Course`, assigned during demultiplexing.

**The pipeline that produced them is now included**, recovered from
`Daniel-Redone-Analysis-NYU-Transfer` on the cluster. It ran under `module load r/4.2.2`,
separately from the R 4.4.1 library the rest of this repository uses, and its own package
versions were not recovered — treat it as code-of-record for the deposited pools.

```
scripts/htp/
├── routes/            run-htp-hto-qc.sh → run-htp-rna-qc.sh → run-htp-processing.sh
└── scripts/
    ├── HTO-QC.R           demultiplex, keep singlets
    ├── RNA-QC.R           per-cell filtering, merge
    ├── HTP-Processing.R   Harmony pipeline + markers → final-htp-seu-obj.RDS
    └── helper-functions/  utils, hto-utils, rna-utils, processing-utils
```

Run each route from the directory holding `htp/`; the scripts resolve
`htp/scripts/...` and `htp/raw-data/...` relative to it. The three stages are:

| Stage | Does | Key parameters |
|---|---|---|
| `HTO-QC.R` | Reads the PIPseeker HTO matrices, builds one Seurat object per pool, demultiplexes | `CreateSeuratObject(min.cells = 3, min.features = 200)`; barcodes intersected between Gene Expression and Cell Hashing; HTO normalised `CLR`; `HTODemux(positive.quantile = 0.99)`; keeps `HTO_classification.global == "Singlet"` |
| `RNA-QC.R` | Adds `percent.mt` from `^mt-`, merges pools, filters | `nFeature_RNA > 500 & < 7000 & percent.mt < 20` |
| `HTP-Processing.R` | Normalise → HVG → scale → PCA → Harmony over `orig.ident` → UMAP and clusters on 40 dims, resolutions 0.1–1.0 → presto markers | writes `final-htp-seu-obj.RDS`, the object this stage holds |

### An earlier, superseded per-region QC

`scripts/earlier-per-region-qc/` holds five notebooks by A. Prystupa, dated 18 June 2024, that
processed the 2024-06-05 PIPseeker matrices **separately per region** before the pooled `htp`
pipeline above was written. They are kept as the record of that earlier pass; they did **not**
produce the objects in `data/`:

| | Earlier per-region QC | `htp` pipeline (of record) |
|---|---|---|
| Duodenum filter | `nFeature_RNA` 500–6,000, `percent.mt < 20` | `nFeature_RNA` 500–7,000, `percent.mt < 20` |
| Ileum filter | `nFeature_RNA` **1,000**–6,000, `percent.mt < 20` | same 500–7,000 filter for both regions |
| Demultiplexing | `HTODemux(positive.quantile = 0.99)`, singlets kept | identical |
| `orig.ident` | `Duodenum_2024-06-05` (hyphens) | `Duodenum_2024_06_05` (underscores) |
| Sample metadata | none assigned | `Sample_ID`, `Location`, `Condition`, `Time_Course`, `Sequencing_Date` from the sheets |

The last two rows are what settle it: the deposited pools carry underscored identities and the
full metadata schema, so they came from `htp`, not from these notebooks. The per-region
thresholds above therefore describe a pass that no reported result depends on.
`Step-2-Older-Sample-Analysis.Rmd` is a 25-line stub that reads a 2024-02-09 object from an
NYU path no longer reachable; the corresponding 2024-02-09 notebooks are not on the cluster.

`data/hto-sample-sheets/` holds each pool's two sheets: `hto-samples-sheet.xlsx` (run name →
PIPseeker matrix path) and `hto-samples-groups.xlsx` (hashtag → `Sample_ID`, `Location`,
`Condition`, `Sequencing_Date`, one worksheet per run). Those are the experimental design.
The paths inside them point at the sequencing facility's storage and will need substituting.

**The pool identities are settled by the objects themselves.** Every cell's `Sample_ID`
carries a `_ST` or `_LT` suffix, and `Sequencing_Date` and `Time_Course` agree with it:

| Object | Cells | `orig.ident` | Date | Arm |
|---|---|---|---|---|
| `final-htp-seu-obj-2024-02-09-RNA.RDS` | 27,060 | `{Duodenum,Ileum}_2024_02_09_pool{1,2}` | `2024_02_09` | short_term |
| `final-htp-seu-obj-2024-06-05-RNA.RDS` | 22,785 | `{Duodenum,Ileum}_2024_06_05` | `2024_06_05` | short_term |
| `final-htp-seu-obj-2024-03-22-LongTerm.RDS` | 45,822 | `{Duodenum,Ileum}_2024_03_22_pool{1A,1B,2A,2B}` | `2024_03_22` | long_term |

So the four-way `pool{1A,1B,2A,2B}` split belongs to the **long-term 2024-03-22** pool, and the
short-term 2024-02-09 pool is a simple `pool1`/`pool2`. The three pools share essentially no
barcodes (4, 6 and 1 cells across the three pairwise comparisons — chance collisions in a fixed
barcode whitelist), so they are disjoint cell sets.

That explains the sheet under `2024-02-09-Short-Term-HTP/`: its paths point at
`.../naiklab/2024-03-22/Pool-{1a,1b,2a,2b}` and its run names carry a stale `2024_02_09`
prefix. **That HTP directory was reused to process the long-term pool** — which is also why the
cluster has no separate long-term HTP directory — and the run names were corrected to
`2024_03_22` before the object was written. Read the sheet as the long-term pool's, and take
the object's identities as authoritative.

### Conditions: control cells only

The pools contain more than one experimental group. **Every analysis in this repository uses
the control cells only** — 45,435 of the 95,667 cells across the three pools — selected at
stage 04 with `Condition == "Control"`. Nothing downstream of that filter touches the other
groups, and they are not described in the manuscript.

The short-term / long-term distinction is likewise not a biological variable in any result. It
appears in the code only to nominate reference and query for the label transfer in
`long-term-{epithelia,immune}-analysis.Rmd`, and as one grouping among several in QC plots.

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

A superseded earlier export of the 2024-06-05 pool (`seu-obj-short-term-epithelia-2024-06-05.RDS`,
25,049 cells with no pool or arm metadata, against the 22,785-cell pool stage 02 reads) sat in
this folder unused; it was deleted on 10 September 2026.

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

