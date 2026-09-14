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
| **3B** | RCTD dominant cell type, spatial — duodenum | `Cherry-PIC-ST-data/final_figures/01_spatial_clusters/scripts/Fig3_VisiumHD_final.Rmd` |
| **3C** | RCTD dominant cell type, spatial — ileum | *same* |
| **3D** | Composition of deconvolved cell identities, duodenum vs ileum (replicates pooled per region) | *same* |
| **3E** | Epithelial UMAP along the crypt–villus axis, 16 µm | `Cherry-PIC-ST-data/final_figures/04_spatial_clusters_16um/scripts/Fig3E_16um_final.Rmd` |
| **3F** | Dot plots, region-specific enterocyte programs (proximal and distal), scRNA | `DR26001-scRNA-project/final_figures/DR26001-scRNA/04-merge-controls/scripts/Fig3F_DotPlots_final.Rmd` |
| **4A** | Spatial expression of *Fabp1*, *Reg1*, *Fabp6*, *Slc10a2* across duodenum and ileum | `Cherry-PIC-ST-data/final_figures/02_regional_genes/scripts/Fig4A_VisiumHD_final.Rmd` |
| **6B** | scRNA UMAP of sorted Cherry-PIC niches, broad cell type | `Cherry-PIC-scRNA-project/final_figures/10x-Cherry-PIC-scRNA/02-clustering-and-annotation/scripts/Fig6_scRNA_final.Rmd` |
| **6C** | Cell-type composition by region, with propeller tests | *same* |
| **6D** | RCTD dominant cell type, hi-res spatial — duodenum niche | `Cherry-PIC-scRNA-project/final_figures/10x-Cherry-PIC-scRNA/03-deconvolution-with-ST-data/scripts/Fig6_Deconvolution_StemNiche_final.Rmd` |
| **6E** | RCTD dominant cell type, hi-res spatial — ileum niche | *same* |
| **6F** | Venn of region overlap in ligand–receptor pairs | `Biomni-code-external/01_liana_nichenet/scripts/plot_venn_region_overlap.py` |
| **6G** | Hub-and-spoke sender summaries, stem-cell receiver | `Biomni-code-external/01_liana_nichenet/scripts/plot_sender_all.R` |
| **6H** | GSEA diverging bars — fibroblasts and endothelium | `Biomni-code-external/02_pathway_analysis/scripts/regenerate_pathway_figures.R` |

Panels **3A** and **6A** are experimental schematics. Of Figure 4, only **4A** is derived
from sequencing data.

### Supplementary figures

| Panel | What it shows | Notebook |
|---|---|---|
| **S3A** | Spatial cluster maps, duodenum and ileum | `Cherry-PIC-ST-data/final_figures/01_spatial_clusters/scripts/FigS3_VisiumHD_QC_Clusters_final.Rmd` |
| **S3B** | UMAP of spatial clusters with annotation | *same* |
| **S3C** | Features vs UMI counts per replicate, pre-filter | *same* |
| **S3D** | QC violins — UMI, features, mitochondrial percent | *same* |
| **S4A** | Marker dot plots, epithelial spatial clusters (proximal villus; distal villus, Tuft, Crypts) | `Cherry-PIC-ST-data/final_figures/01_spatial_clusters/scripts/FigS4_DotPlots_final.Rmd` |
| **S4B** | Marker dot plots, stromal and immune spatial clusters | *same* |
| **S5A** | Integrated reference atlas UMAP, coloured by dataset of origin | `Cherry-PIC-ST-data/final_figures/03_scrna_reference/scripts/FigS5_scRNA_Reference_final.Rmd` |
| **S5B** | Integrated reference atlas UMAP, coloured by broad cell type | *same* |
| **S5C–E** | Marker dot plots of the reference atlas — epithelia, stroma, immune | `Biomni-code-external/04_marker_dotplots/scripts/dotplot_markers_final.R` |
| **S7A** | Marker dot plots, Cherry-PIC niche scRNA — epithelia | `Cherry-PIC-scRNA-project/final_figures/10x-Cherry-PIC-scRNA/02-clustering-and-annotation/scripts/FigS7_DotPlots_final.Rmd` |
| **S7B** | Marker dot plots, Cherry-PIC niche scRNA — immune and stroma | *same* |
| **S8A/B** | Region-unique ligand–receptor pairs by module, stem-cell receiver — duodenum and ileum | `Biomni-code-external/01_liana_nichenet/scripts/plot_region_unique_byreceiver.R` |
| **S9A** | Pathway-by-cell-type NES heatmaps, grouped by module — Notch and WNT signalling | `Biomni-code-external/02_pathway_analysis/scripts/regenerate_pathway_figures.R` |
| **S9B** | Pathway-by-cell-type NES heatmap, grouped by module — retinoic acid signalling | *same* |
| **S9C** | GSEA diverging bars — macrophages | *same* |

Figures **1, 2, 5, S1, S2** and **S6** are not derived from sequencing data and have no code
here.

**Ligand–receptor analysis (6F, 6G, S8).** The scored LIANA and NicheNet tables are provided
in `01_liana_nichenet/data/`, and everything applied to them — sender exclusions, the NicheNet
activity filter, the region-uniqueness set logic, counting and plotting — is in
`01_liana_nichenet/scripts/`. Every number in these figures can therefore be checked from this
repository. The scoring step itself is two package calls, `liana_wrap()` and
`predict_ligand_activities()`, with parameters given in the Methods.

**6F and 6G do not plot the same set of pairs.** `plot_venn_region_overlap.py` (6F) keeps a
pair significant in both regions only if NicheNet supports it in both; `build_sender_counts_merged.py`
(6G) keeps any LIANA-significant pair with region-matched NicheNet support, with no such
both-regions requirement. Recomputed directly from the tracked CSVs: combined-evidence
distinct pairs are 282/341 (stem, duodenum/ileum) and 186/270 (TA), against 259/320 and
171/199 actually represented in the 6F Venn — 23–71 pairs per receiver are LIANA-shared but
NicheNet-asymmetric, and so appear in 6G's per-sender counts but not in 6F's Venn. An earlier
version of this note said the two figures "summarise the same interaction set" differently
counted; that was imprecise. Methods §9 is corrected accordingly.

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
    04_spatial_clusters_16um/  Fig 3E, and the 16 um preprocessing under scripts/upstream/

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

The integrated reference atlas combines seven source datasets — one generated for this
manuscript and six published — merged, SCTransformed and batch-corrected with Harmony. All
are *Mus musculus*.

The data generated here are **one experiment sequenced as three pools** (9 February,
22 March and 5 June 2024); epithelial and immune compartments were split into two objects
after annotation and enter the atlas as two labelled entries, so they appear as two rows
below but are not independent datasets. Their full processing chain, from raw matrices
onward, is in `DR26001-scRNA-project/`.

| Dataset | Publication | Accession | Cells |
|---|---|---|---|
| Rosenblum — epithelial compartment | This manuscript (same experiment as below) | to be deposited | 17,552 |
| Rosenblum — immune compartment | This manuscript (same experiment as above) | to be deposited | 27,863 |
| Glisovic *et al.* 2025 | Intestinal fibroblast heterogeneity — unifying RNA-seq studies and introducing consensus-driven nomenclature. *J Cell Sci* 138(23):jcs264147. [10.1242/jcs.264147](https://doi.org/10.1242/jcs.264147) | [GSE269017](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE269017) | 7,221 |
| Niec *et al.* 2022 | Lymphatics act as a signaling hub to regulate intestinal stem cell activity. *Cell Stem Cell* 29(7):1067–1082.e18. [10.1016/j.stem.2022.05.007](https://doi.org/10.1016/j.stem.2022.05.007) | [GSE190037](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE190037) | 2,237 |
| Degirmenci *et al.* 2018 | GLI1-expressing mesenchymal cells form the essential Wnt-secreting niche for colon stem cells. *Nature* 558(7710):449–453. [10.1038/s41586-018-0190-3](https://doi.org/10.1038/s41586-018-0190-3) | [GSE113043](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE113043) | 4,464 |
| Kinchen *et al.* 2018 | Structural remodeling of the human colonic mesenchyme in inflammatory bowel disease. *Cell* 175(2):372–386.e17. [10.1016/j.cell.2018.08.067](https://doi.org/10.1016/j.cell.2018.08.067) | [GSE114374](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE114374) | 3,713 |
| McCarthy *et al.* 2020 | Distinct mesenchymal cell populations generate the essential intestinal BMP signaling gradient. *Cell Stem Cell* 26(3):391–402.e5. [10.1016/j.stem.2020.01.008](https://doi.org/10.1016/j.stem.2020.01.008) | [GSE130681](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE130681) | 5,397 |
| Roulis *et al.* 2020 | Paracrine orchestration of intestinal tumorigenesis by a mesenchymal niche. *Nature* 580(7804):524–529. [10.1038/s41586-020-2166-3](https://doi.org/10.1038/s41586-020-2166-3) | [GSE142431](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE142431) | 6,151 |

**GSE114374 is a mixed-species series.** Kinchen *et al.* deposited both human and mouse
data; only the **mouse** samples are used here — three healthy controls, immune cells removed
on *Ptprc*.

Per-dataset filtering and the label each dataset carries inside the object are recorded in
`Dataset_Documentation.xlsx`. The build is in
`Cherry-PIC-ST-data/final_figures/03_scrna_reference/scripts/upstream/`, together with
executed notebooks recording the run.

---

## Running the code

Each notebook has an `.R` twin generated with `knitr::purl()`, which runs without pandoc.
Paths inside notebooks are relative, so run from the notebook's own folder.

Several figure notebooks embed their `Preprocessing_*` notebook as a child, so editing a
preprocessing notebook changes the figure twin too. Regenerate from the notebook's folder,
writing to a temporary name and moving it over — `purl()` will not overwrite a twin that is
newer than the notebook, and a child edit leaves it exactly that:

```bash
Rscript -e "knitr::purl('Fig6_scRNA_final.Rmd', output='tmp.R', documentation=1)" && mv tmp.R Fig6_scRNA_final.R
```

The release check compares twin content against a fresh `purl()`, so a stale twin fails it.

This analysis is sized for a compute cluster, not a workstation. Notebooks reading the
Visium HD or integrated-atlas objects need tens of gigabytes of memory; each states its
requirement at the top. Run them on a compute node:

```bash
export OPENBLAS_NUM_THREADS=1     # keep BLAS single-threaded under a scheduler
cd <notebook folder>
Rscript Fig3_VisiumHD_final.R
```

Three environment variables adapt the code to your system. All are optional; each falls back
to a sensible default.

| Variable | Default | Purpose |
|---|---|---|
| `CHERRYPIC_R_LIB` | R's own library paths | Prepend a library holding the analysis packages |
| `CHERRYPIC_RAWDATA` | `rawdata` | Space Ranger output root, one folder per sample |
| `CHERRYPIC_SOURCE_SCRNA` | the DR26001 project's `04-merge-controls/outputs` | Source scRNA objects for the atlas build |
| `CHERRYPIC_MASTER_OBJ` | `../data/Master.Obj.rds` | Integrated atlas object, for the Figure S5C–E dot plots |
| `CHERRYPIC_MARKER_XLSX` | `../data/curated_10_genes_per_cluster_res1_2.xlsx` | Curated marker workbook for those dot plots |

```bash
export CHERRYPIC_R_LIB=/path/to/your/R/library
```

`submit_Fig6_Deconvolution_StemNiche_final.sh` is an example batch script written for LSF;
its resource requests are portable, its scheduler directives are not.

Figure notebooks read pre-computed objects and do not rebuild them. The `Preprocessing_*`
notebooks document how those objects were made.

---

## Environment

```
R 4.4.1 (2024-06-14), x86_64-pc-linux-gnu, Rocky Linux 9.8
BLAS/LAPACK: reference libRblas / libRlapack, LAPACK 3.12.0
```

| Package | Version | | Package | Version |
|---|---|---|---|---|
| Seurat | 5.5.0 | | spacexr (RCTD) | 2.2.1 |
| SeuratObject | 5.4.0 | | harmony | 2.0.3 |
| sp | 2.2-1 | | sctransform | 0.4.3 |
| Matrix | 1.7-5 | | fgsea | 1.32.4 |
| tidyverse | 2.0.0 | | msigdbr | 26.1.0 |
| dplyr | 1.2.1 | | UCell | 2.10.1 |
| ggplot2 | 4.0.3 | | speckle | 1.6.0 |
| patchwork | 1.3.2 | | presto | 1.0.0 |
| readxl | 1.5.0 | | nichenetr | 2.2.1.1 |
| RColorBrewer | 1.1-3 | | liana | 0.1.14 |
| viridis | 0.6.5 | | openxlsx | 4.2.8.1 |
| knitr | 1.51 | | | |

Also used, by stage:

| Package | Version | Used for |
|---|---|---|
| ComplexHeatmap | 2.22.0 | annotation heatmaps |
| EnhancedVolcano | 1.24.0 | differential-expression volcanoes |
| clustree | 0.5.1 | clustering-resolution trees |
| scDblFinder | 1.20.2 | doublet detection |
| pheatmap | 1.0.13 | marker heatmaps |
| circlize | 0.4.18 | circular layouts |
| ggpubr | 0.6.3 | statistical annotation on plots |
| ggrepel | 0.9.8 | non-overlapping labels |
| ggsci | 5.0.0 | palettes |
| svglite | 2.2.2 | SVG output |
| data.table | 1.18.4 | fast table I/O |
| jsonlite | 2.0.0 | metadata I/O |
| png | 0.1-9 | raster import |
| glue | 1.8.1 | string construction |
| stringr | 1.6.0 | string handling |
| tibble | 3.3.1 | data frames |
| tidyr | 1.3.2 | reshaping |
| grid | base R | low-level graphics, used by the heatmap layouts |
| gridExtra | 2.3 | multi-panel QC layouts in the hashtag-pool pipeline |

**The hashtag-pool pipeline ran under a different R.** `DR26001-scRNA-project/.../00-hashtag-pools/scripts/`
was executed with `module load r/4.2.2` in 2024, before the analysis library below existed, and
additionally loads **SCpubr** for its UMAP panels. Its package versions are not in the manifest
and were not recovered; treat it as code-of-record for the deposited pools rather than as part
of the reproducible environment.

`Cell_type-reAnnotation.Rmd` additionally loads **SingleR** and **celldex** for reference-based
label transfer. Neither is present in the analysis library, so that notebook's SingleR chunks
were run in a separate session; its outputs are provided rather than regenerated.

All analysis was run on a Linux HPC cluster. Versions are read from the analysis library and
confirmed against `sessionInfo()` recorded in the render logs.

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

## Release checks

`bash .checks/release_check.sh` verifies the repository against the documentation: that no
credential patterns or oversized files are tracked, that every path named in a README exists,
that each `.R` twin is current, that every `library()` call is documented, and that the figure
index covers all 28 panels. Run it before any release.

## Citation

> Rosenblum et al. (2026). *Cherry-PIC enables functional interrogation of cellular
> neighborhoods in vivo.* Manuscript in preparation.

Questions about the code: open an issue, or contact Ikjot Sidhu.

## License

MIT — see [LICENSE.md](LICENSE.md).

---

## Optional — reproducing the environment exactly

The versions above are the record of what was used, and are enough to read, cite and check
the analysis. This section is only needed to *re-run* it, and offers two levels of fidelity.

**1. Install the direct dependencies** — quickest, and enough for most notebooks.

```bash
Rscript .checks/install_environment.R --dry-run   # report what differs, change nothing
Rscript .checks/install_environment.R             # install
```

Pins the ~40 packages the analysis loads directly: 29 CRAN via `remotes::install_version()`,
8 from Bioconductor 3.20, 4 from GitHub. Transitive dependencies resolve to whatever those
require.

**2. Restore the package closure** — pins all **308** packages at the versions used: the 41
above (29 CRAN, 8 Bioconductor, 4 GitHub) plus the 267 they pull in. `presto`, `liana` and
`nichenetr` were missing from this lockfile despite being declared everywhere else
(the installer, the table above); added with the exact commit each declared version
resolves to.

```r
install.packages("renv")
renv::restore()            # reads renv.lock
```

A few graphics packages compile against system libraries — freetype, libpng, libtiff, libjpeg
and libwebp. Compute nodes often lack the development headers for these, and adding them needs
root. Where that is the case, level 1 is the practical route, since it builds on the packages
the cluster already provides.

Neither level reproduces the platform, and package versions alone do not determine results —
the OS, compiler and BLAS/LAPACK do too. The analysis ran on **Rocky Linux 9.8, R 4.4.1,
reference `libRblas`/`libRlapack`, LAPACK 3.12.0**. A different BLAS changes floating-point
summation order, so PCA, UMAP and clustering can differ in the last digits even with identical
package versions.

`.checks/r_library_manifest.tsv` lists the full library as plain text, for comparing an existing
installation rather than building a new one. `renv.lock` is generated from that library rather
than captured during each render — it is the same library the figures were produced from.
