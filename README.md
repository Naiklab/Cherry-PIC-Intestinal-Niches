# Cherry-PIC

### Cherry-PIC enables functional interrogation of cellular neighborhoods in vivo

Analysis code for **Rosenblum et al. (2026)** — Visium HD spatial and 10x single-cell
transcriptomics of the mouse small intestine.

Every manuscript panel derived from sequencing data is produced by a notebook here. The
[figure index](#figure-index) maps each panel to the code that makes it.

---

## Data availability

> **Deposition is pending.** Processed data will be deposited to **Zenodo** and released with
> the publication, and the DOI added here. Sequencing data will be submitted to **GEO**.
> **Reviewers can be given access to the processed data on request** while the manuscript is
> under consideration — please contact the corresponding author.

This repository holds code and documentation. The analysis objects and rendered figures are
about 50 GB and are deposited separately.

| Deposit contents | Size |
|---|---|
| Seurat objects, including the integrated reference atlas | 29 GB |
| Rendered figure panels | 17 GB |
| Differential expression and marker tables | 3 GB |
| Ligand–receptor and pathway result tables | 1 GB |

| Sequencing data | Status |
|---|---|
| Visium HD spatial — duodenum ×2, ileum ×2 | To be deposited at GEO |
| 10x scRNA — Cherry-PIC niches, DR26001 time course | To be deposited at GEO |

Public datasets reused in the integrated reference are listed under
[reference datasets](#reference-datasets). Per-dataset accessions and filtering are recorded
in `Dataset_Documentation.xlsx`.

---

## Figure index

### Main figures

| Panel | What it shows | Notebook |
|---|---|---|
| **3B** | RCTD dominant cell type, spatial — duodenum | `Cherry-PIC-ST-data/.../01_spatial_clusters/scripts/Fig3_VisiumHD_final.Rmd` |
| **3C** | RCTD dominant cell type, spatial — ileum | *same* |
| **3D** | Composition of deconvolved cell identities, duodenum vs ileum (replicates pooled per region) | *same* |
| **3E** | Epithelial UMAP along the crypt–villus axis, 16 µm | `Cherry-PIC-ST-data/.../04_spatial_clusters_16um/scripts/Fig3E_16um_final.Rmd` |
| **3F** | Dot plots, region-specific enterocyte programs (proximal and distal), scRNA | `DR26001-scRNA-project/.../04-merge-controls/scripts/Fig3F_DotPlots_final.Rmd` |
| **4A** | Spatial expression of *Fabp1*, *Reg1*, *Fabp6*, *Slc10a2* across duodenum and ileum | `Cherry-PIC-ST-data/.../02_regional_genes/scripts/Fig4A_VisiumHD_final.Rmd` |
| **6B** | scRNA UMAP of sorted Cherry-PIC niches, broad cell type | `Cherry-PIC-scRNA-project/.../02-clustering-and-annotation/scripts/Fig6_scRNA_final.Rmd` |
| **6C** | Cell-type composition by region, with propeller tests | *same* |
| **6D** | RCTD dominant cell type, hi-res spatial — duodenum niche | `Cherry-PIC-scRNA-project/.../03-deconvolution-with-ST-data/scripts/Fig6_Deconvolution_StemNiche_final.Rmd` |
| **6E** | RCTD dominant cell type, hi-res spatial — ileum niche | *same* |
| **6F** | Venn of region overlap in ligand–receptor pairs | `Biomni-code-external/01_liana_nichenet/scripts/plot_venn_region_overlap.py` |
| **6G** | Hub-and-spoke sender summaries, stem-cell receiver | `Biomni-code-external/01_liana_nichenet/scripts/plot_sender_all.R` |
| **6H** | GSEA diverging bars — fibroblasts and endothelium | `Biomni-code-external/02_pathway_analysis/scripts/regenerate_pathway_figures.R` |

Panels **3A** and **6A** are experimental schematics. Of Figure 4, only **4A** is derived
from sequencing data.

### Supplementary figures

| Panel | What it shows | Notebook |
|---|---|---|
| **S3A** | Spatial cluster maps, duodenum and ileum | `Cherry-PIC-ST-data/.../01_spatial_clusters/scripts/FigS3_VisiumHD_QC_Clusters_final.Rmd` |
| **S3B** | UMAP of spatial clusters with annotation | *same* |
| **S3C** | Features vs UMI counts per replicate, pre-filter | *same* |
| **S3D** | QC violins — UMI, features, mitochondrial percent | *same* |
| **S4A** | Marker dot plots, epithelial spatial clusters (proximal villus; distal villus, Tuft, Crypts) | `Cherry-PIC-ST-data/.../01_spatial_clusters/scripts/FigS4_DotPlots_final.Rmd` |
| **S4B** | Marker dot plots, stromal and immune spatial clusters | *same* |
| **S5A** | Integrated reference atlas UMAP, coloured by dataset of origin | `Cherry-PIC-ST-data/.../03_scrna_reference/scripts/FigS5_scRNA_Reference_final.Rmd` |
| **S5B** | Integrated reference atlas UMAP, coloured by broad cell type | *same* |
| **S5C–E** | Marker dot plots of the reference atlas — epithelia, stroma, immune | `Biomni-code-external/.../dotplot_markers_final.R` |
| **S7A** | Marker dot plots, Cherry-PIC niche scRNA — epithelia | `Cherry-PIC-scRNA-project/.../02-clustering-and-annotation/scripts/FigS7_DotPlots_final.Rmd` |
| **S7B** | Marker dot plots, Cherry-PIC niche scRNA — immune and stroma | *same* |
| **S8A/B** | Region-unique ligand–receptor pairs by module, stem-cell receiver — duodenum and ileum | `Biomni-code-external/01_liana_nichenet/` |
| **S9A** | Module score heatmaps — Notch and WNT signalling | `Biomni-code-external/02_pathway_analysis/scripts/regenerate_pathway_figures.R` |
| **S9B** | Module score heatmap — retinoic acid signalling | *same* |
| **S9C** | GSEA diverging bars — macrophages | *same* |

Figures **1, 2, 5, S1, S2** and **S6** are not derived from sequencing data and have no code
here.

---

## Repository layout

Four analysis projects. Each figure folder contains `scripts/`, `data/` (inputs) and
`outputs/` (figures, deposited separately).

```
Cherry-PIC-ST-data/            Visium HD spatial transcriptomics
  final_figures/
    00_preprocessing/          pipeline documentation
    01_spatial_clusters/       Fig 3B–3D, Fig S3, Fig S4
    02_regional_genes/         Fig 4A
    03_scrna_reference/        Fig S5A/B — integrated reference atlas
    04_spatial_clusters_16um/  Fig 3E

Cherry-PIC-scRNA-project/      10x scRNA of Cherry-PIC niches
  final_figures/10x-Cherry-PIC-scRNA/
    02-clustering-and-annotation/   Fig 6B/6C, Fig S7
    03-deconvolution-with-ST-data/  Fig 6D/6E

DR26001-scRNA-project/         10x scRNA time course — Fig 3F

Biomni-code-external/          ligand–receptor and pathway analysis
  01_liana_nichenet/           Fig 6F/6G, Fig S8
  02_pathway_analysis/         Fig 6H, Fig S9
```

---

## Reference datasets

The integrated reference atlas combines eight datasets — two generated for this manuscript
and six public — merged, SCTransformed and batch-corrected with Harmony.

| Dataset | Source | Accession | Cells |
|---|---|---|---|
| Rosenblum — epithelial | This manuscript | to be deposited | 17,552 |
| Rosenblum — immune | This manuscript | to be deposited | 27,863 |
| Glisovic *et al.* 2025 | *J Cell Sci* | GSE269017 | 7,221 |
| Niec *et al.* 2022 | *Cell Stem Cell* | GSE190037 | 2,237 |
| Degirmenci *et al.* 2018 | | GSE113043 | 4,464 |
| Kinchen *et al.* 2018 | | GSE114374 | 3,713 |
| McCarthy *et al.* 2020 | | GSE130681 | 5,397 |
| Roulis *et al.* 2020 | | GSE142431 | 6,151 |

The build is in `Cherry-PIC-ST-data/final_figures/03_scrna_reference/scripts/upstream/`,
together with executed notebooks recording the run.

---

## Running the code

Each notebook has an `.R` twin generated with `knitr::purl()`, which runs without pandoc.
Paths inside notebooks are relative, so run from the notebook's own folder.

```bash
cd <notebook folder>
Rscript FigS7_DotPlots_final.R
```

Notebooks reading the Visium HD or integrated-atlas objects need more memory than a laptop
has; each notebook states its requirement at the top. On a cluster:

```bash
module load R/4.4.1
export OPENBLAS_NUM_THREADS=1
Rscript Fig3_VisiumHD_final.R
```

Figure notebooks read pre-computed objects and do not rebuild them. The `Preprocessing_*`
notebooks document how those objects were made.

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

Python components (Figures 6F, 6G, S8) use pandas, numpy, matplotlib and matplotlib-venn.

---

## Notes

**Sample naming.** The code uses internal sample names; the figures use the deposition
names. `Duodenum_3` → Duodenum-1, `Duodenum_4` → Duodenum-2, `Ileum_3` → Ileum-1, and
`Ileum_2` is unchanged. Representative spatial panels use Duodenum_3 and Ileum_3.

**Output names.** A `fig` prefix marks a published panel; `supporting_` marks analyses that
are not in the manuscript.

**Figures 6F, 6G and S8** count the same ligand–receptor results three different ways and
are not expected to match: 6F counts distinct pairs, 6G counts each sender's contribution,
and S8 lists the region-unique pairs themselves.

---

## Citation

> Rosenblum et al. (2026). *Cherry-PIC enables functional interrogation of cellular
> neighborhoods in vivo.* Manuscript in preparation.

Questions about the code: open an issue, or contact Ikjot Sidhu.

## License

MIT — see [LICENSE.md](LICENSE.md).
