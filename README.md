# Cherry-PIC

### Cherry-PIC enables functional interrogation of cellular neighborhoods in vivo

Analysis code for **Rosenblum et al. (2026)**.

Spatial and single-cell transcriptomics of the mouse small intestine:

- **Visium HD spatial** — four samples (duodenum ×2, ileum ×2), clustered at 8 µm and
  16 µm, with RCTD deconvolution against an integrated single-cell reference
- **Integrated scRNA reference** — eight datasets merged and Harmony-corrected into one
  74,598-cell atlas, used both as the deconvolution reference and as a figure in its own right
- **10x scRNA** — clustering, annotation and cell-type composition of sorted Cherry-PIC
  niches, plus proximal–distal expression programs in enterocytes
- **Cell–cell communication and pathways** — LIANA and NicheNet ligand–receptor analysis
  around the stem-cell niche, and fgsea pathway enrichment

Every manuscript panel derived from sequencing data is produced by a notebook here. The
[Figure index](#figure-index) maps each panel to the notebook that makes it, the object it
reads, and where it has to run.

---

## Contents

- [Data availability](#data-availability)
- [Repository layout](#repository-layout)
- [Figure index](#figure-index)
- [Reference datasets](#reference-datasets)
- [Running a notebook](#running-a-notebook)
- [Environment](#environment)
- [Conventions](#conventions)

---

## Data availability

> **Deposition is pending.** The processed data described below will be deposited to
> **Zenodo** and released with the publication, and the DOI added here. Sequencing data
> will be submitted to **GEO**. **Reviewers can be given access to the processed data on
> request while the manuscript is under consideration** — please contact the corresponding
> author.

This repository holds code, small input files and documentation — about 32 MB. The analysis
objects and rendered figures are roughly 50 GB and are deposited separately rather than
version-controlled; `.gitignore` records exactly what is excluded and why.

### What is in the deposit

| Contents | Files | Size | Notes |
|---|---|---|---|
| Seurat objects | 46 | 29.0 GB | Includes the 5.8 GB integrated reference `Master.Obj.rds` and the 4.3 GB 8 µm spatial object |
| Rendered figures | 588 | 16.5 GB | Every `outputs/` directory. Visium HD panels embed the tissue image, so single PDFs run 40–240 MB |
| Marker tables | 10 | 2.8 GB | `wilcoxauc` Raw and Filtered tables; the Top tables are small and stay in this repository |
| Ligand–receptor / pathway bundle | 1,203 | 1.4 GB | Result tables behind Figures 6F–6H, S8 and S9. The scripts that produce them are in this repository |
| Manuscript figure PDFs | 16 | 0.6 GB | The assembled figures |

### Sequencing data

| Data | Status |
|---|---|
| Visium HD spatial — 4 samples (duodenum ×2, ileum ×2) | To be deposited at GEO |
| 10x scRNA — Cherry-PIC niches, DR26001 time course | To be deposited at GEO |

Public datasets reused in the integrated reference are listed under
[Reference datasets](#reference-datasets); their accessions are already public. Full
per-dataset provenance — accessions, filtering applied, and the label each carries inside
the objects — is in `Dataset_Documentation.xlsx`.

> **Sample naming — the code and the figures use different names.** The manuscript already
> uses the deposition names: Figure S3's axes read `Duo-1, Duo-2, Ile-1, Ile-2`. The code and
> every output filename use the internal names. The mapping is:
>
> | In the code and filenames | In the figures and GEO |
> |---|---|
> | `Duodenum_3` | Duodenum-1 |
> | `Duodenum_4` | Duodenum-2 |
> | `Ileum_3` | Ileum-1 |
> | `Ileum_2` | Ileum-2 |
>
> So `fig3B_deconv_dominant_Duodenum_3_008um.pdf` is the panel labelled **Duodenum-1**.
> Note that `Ileum_2` keeps its number but is *not* the same sample as `Duodenum_2`.

### Reproducing a figure without the deposit

Every figure notebook reads a frozen object it does not rebuild, so the deposit is required
to re-render. The [Figure index](#figure-index) names the object each notebook needs, and
whether it fits in laptop memory or requires a compute node.

---

## Repository layout

Four project folders, one per data modality or analysis stream. Each figure folder holds the
same three subfolders: `scripts/`, `data/` (inputs, frozen) and `outputs/` (figures).

```
Cherry-PIC-ST-data/            Visium HD spatial transcriptomics
  final_figures/
    00_preprocessing/          pipeline documentation (eval=FALSE, provenance only)
    01_spatial_clusters/       Fig 3B–3D, Fig S3, Fig S4
    02_regional_genes/         Fig 4A
    03_scrna_reference/        Fig S5A/B — integrated scRNA reference atlas
    04_spatial_clusters_16um/  Fig 3E — 16 µm epithelial subset

Cherry-PIC-scRNA-project/      10x scRNA, Cherry-PIC
  final_figures/10x-Cherry-PIC-scRNA/
    01-preprocessing/          pipeline documentation
    02-clustering-and-annotation/  Fig 6B/6C, Fig S7
    03-deconvolution-with-ST-data/ Fig 6D/6E

DR26001-scRNA-project/         10x scRNA, DR26001 time course
  final_figures/DR26001-scRNA/
    04-merge-controls/         Fig 3F

Biomni-code-external/          ligand–receptor and pathway analysis
  01_liana_nichenet/           Fig 6F/6G, Fig S8
  02_pathway_analysis/         Fig 6H, Fig S9
  03_shared_data/              objects shared by both
  Full-data/                   original vendor delivery, kept unmodified
```

> **Upstream DR26001 provenance.** An earlier reanalysis tree
> (`Daniel-Redone-Analysis-NYU-Transfer`) once sat here and produced no figure panels. Two
> notebooks read multi-GB objects from it purely to join one or two prior-annotation columns
> by barcode. Those columns are now vendored as CSVs in
> `02-epithelia-clustering/data/` and `03-immune-clustering/data/`, so every notebook in this
> repository runs without cluster access. The tree itself is preserved on Minerva at
> `/sc/arion/projects/naiklab/Alex/Daniel-Redone-Analysis-NYU-Transfer/`; a file listing is in
> `_sync/superseded-docs/`.

---

## Figure index

**Where it runs** is the practical constraint: notebooks reading the 8 µm spatial object or
the integrated reference need more memory than a laptop has and must go to a compute node.

### Main figures

| Panel | Notebook | Reads | Where it runs |
|---|---|---|---|
| 3B, 3C, 3D | `Cherry-PIC-ST-data/.../01_spatial_clusters/scripts/Fig3_VisiumHD_final.Rmd` | 8 µm hi-res object | Cluster |
| 3E | `Cherry-PIC-ST-data/.../04_spatial_clusters_16um/scripts/Fig3E_16um_final.Rmd` | 16 µm epithelial subset | Laptop |
| 3F | `DR26001-scRNA-project/.../04-merge-controls/scripts/Fig3F_DotPlots_final.Rmd` | CTRL epithelia | Laptop |
| 4A | `Cherry-PIC-ST-data/.../02_regional_genes/scripts/Fig4A_VisiumHD_final.Rmd` | 8 µm hi-res object | Cluster |
| 6B, 6C | `Cherry-PIC-scRNA-project/.../02-clustering-and-annotation/scripts/Fig6_scRNA_final.Rmd` | annotated scRNA object | Laptop |
| 6D, 6E | `Cherry-PIC-scRNA-project/.../03-deconvolution-with-ST-data/scripts/Fig6_Deconvolution_StemNiche_final.Rmd` | niche object + RCTD | Cluster |
| 6F | `Biomni-code-external/01_liana_nichenet/scripts/plot_venn_region_overlap.py` | LIANA + NicheNet tables | Laptop |
| 6G | `Biomni-code-external/01_liana_nichenet/scripts/plot_sender_all.R` | sender counts (`build_sender_counts_merged.py`) | Laptop |
| 6H | `Biomni-code-external/02_pathway_analysis/scripts/regenerate_pathway_figures.R` | fgsea results | Laptop |

Panel 3A is a schematic and is not generated from data. Of Figure 4, only panel **4A** is
sequencing-derived: 4B is smFISH imaging, 4C is an experimental schematic, and 4D/4E are
organoid immunofluorescence with MFI quantification.

### Supplementary figures

| Panel | Notebook | Reads | Where it runs |
|---|---|---|---|
| S3 | `Cherry-PIC-ST-data/.../01_spatial_clusters/scripts/FigS3_VisiumHD_QC_Clusters_final.Rmd` | 8 µm hi-res object + raw matrices | Cluster |
| S4 | `Cherry-PIC-ST-data/.../01_spatial_clusters/scripts/FigS4_DotPlots_final.Rmd` | 8 µm hi-res object | Cluster |
| S5A, S5B | `Cherry-PIC-ST-data/.../03_scrna_reference/scripts/FigS5_scRNA_Reference_final.Rmd` | `Master.Obj.rds` | Cluster |
| S5C–E | `Biomni-code-external/Full-data/.../dotplot_markers_final.R` | `Master.Obj.rds` | Cluster |
| S7 | `Cherry-PIC-scRNA-project/.../02-clustering-and-annotation/scripts/FigS7_DotPlots_final.Rmd` | annotated scRNA object | Laptop |
| S8 | `Biomni-code-external/01_liana_nichenet/` | region-unique L–R tables | Laptop |
| S9 | `Biomni-code-external/02_pathway_analysis/scripts/regenerate_pathway_figures.R` | fgsea results + module scores | Laptop |

Figures 1, 2, 5, S1, S2 and S6 are not derived from sequencing data and have no code here,
nor do Figure 4 panels B–E.

### Three set operations that answer different questions

Figures 6F, 6G and S8 all draw on the same significant ligand–receptor pairs but are **not
expected to reconcile arithmetically**:

- **6F (Venn)** — how many *distinct* L–R pair identities are region-unique. Deduplicated
  across senders, so a pair sent by seven cell types counts once.
- **6G (hub-and-spoke)** — how many pairs *each sender* contributes. The same multi-sender
  pair is counted once per sender, so the spokes sum higher than the Venn by design.
- **S8 (bubble)** — the region-unique pair list itself, using LIANA evidence only with a
  stem-cell receiver.

---

## Reference datasets

`Master.Obj.rds` integrates eight datasets — two generated for this manuscript, six public
— merged, SCTransformed, and batch-corrected with Harmony on
`dataset_label + sequencing_tech`.

| `dataset_label` | Source | Accession | Cells |
|---|---|---|---|
| `Rosenblum_Epithelial` | This manuscript | not yet deposited | 17,552 |
| `Rosenblum_Immune` | This manuscript | not yet deposited | 27,863 |
| `Glisovic_Fibroblast` | Glisovic *et al.* 2025, *J Cell Sci* | GSE269017 | 7,221 |
| `Niec_SpaceFold_SI` | Niec *et al.* 2022, *Cell Stem Cell* | GSE190037 | 2,237 |
| `Degirmenci_2018` | Degirmenci *et al.* 2018 | GSE113043 | 4,464 |
| `Kinchen_2018` | Kinchen *et al.* 2018 | GSE114374 | 3,713 |
| `McCarthy_2020` | McCarthy *et al.* 2020 | GSE130681 | 5,397 |
| `Roulis_2020` | Roulis *et al.* 2020 | GSE142431 | 6,151 |

The build itself is in
`Cherry-PIC-ST-data/final_figures/03_scrna_reference/scripts/upstream/Master-dataset-integration.Rmd`,
with per-dataset preparation in the two `Reference-single-cell-datasets-analysis` notebooks
alongside it. Executed `.nb.html` copies of all three are kept there as a run record.

---

## Running a notebook

Each notebook has a `.R` twin generated with `knitr::purl()`. The twin is what runs on the
cluster — it needs no pandoc and writes the same files. Edit the `.Rmd`; regenerate the twin
afterwards.

**On a laptop:**

```bash
cd <notebook folder>
Rscript FigS7_DotPlots_final.R
```

**On a compute node** (LSF), capping BLAS threads so R does not oversubscribe:

```bash
module load R/4.4.1
export OPENBLAS_NUM_THREADS=1
cd <notebook folder>
Rscript Fig3_VisiumHD_final.R
```

Paths inside notebooks are relative (`../data`, `../outputs`), so run from the `scripts/`
folder that contains the notebook.

**After editing an `.Rmd`,** regenerate its twin:

```bash
Rscript -e 'knitr::purl("Fig3_VisiumHD_final.Rmd", output="Fig3_VisiumHD_final.R", documentation=1)'
```

---

## Environment

R **4.4.1**, Seurat **5.5.0**.

| Purpose | Packages |
|---|---|
| Core | Seurat, SeuratObject, Matrix, tidyverse |
| Spatial | spacexr (RCTD), sf |
| Integration | harmony, sctransform |
| Cell–cell communication | liana, nichenetr |
| Pathways | fgsea, msigdbr, UCell |
| Composition | speckle (propeller) |
| Plotting | ggplot2, patchwork, RColorBrewer, viridis |
| I/O | readxl, openxlsx |

Python components (Figures 6F, 6G, S8) use pandas, numpy, matplotlib and
matplotlib-venn.

---

## Conventions

**Output names carry meaning.** A `fig` prefix means a published panel; anything else is
not in the manuscript.

| Prefix | Meaning |
|---|---|
| `fig3B_`, `figS5A_`, … | A published panel. The letter matches the manuscript. |
| `supporting_` | Real analysis, useful for review, not a printed panel. |
| `superseded_` | An earlier version kept for provenance. Do not use. |

A `fig` prefix is a claim about the manuscript, so do not apply one to an output that has
not been checked against the published figure.

**Published replicate.** Every representative spatial panel uses **Duodenum_3 and Ileum_3**.
Duodenum_4 and Ileum_2 are the second biological replicate — real data, but written under
`supporting_`. All four samples are always processed; only the prefix differs.

**Notebook structure.** Every figure notebook opens the same way: `Purpose`, `Outputs`,
`Inputs`, `Running this`, then any `Note` sections carrying caveats that affect
interpretation. Code is split into a manuscript-panels part and a supporting part.

**Frozen inputs.** Figure notebooks read pre-computed objects and do not rebuild them. The
`Preprocessing_*` notebooks in each folder document how those objects were made; their
chunks are `eval = FALSE` and exist as a provenance record, not to be re-run casually.

---

## Citation

> Rosenblum et al. (2026). *Cherry-PIC enables functional interrogation of cellular
> neighborhoods in vivo.* Manuscript in preparation.

Questions about the code: open an issue on
[Naiklab/Cherry-PIC-Intestinal-Niches](https://github.com/Naiklab/Cherry-PIC-Intestinal-Niches),
or contact Ikjot Sidhu.

---

## License

MIT — see [LICENSE.md](LICENSE.md).
