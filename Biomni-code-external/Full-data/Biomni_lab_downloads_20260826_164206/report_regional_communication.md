# Regional Comparison of Cell-Cell Communication: Duodenum vs Ileum

## Overview

This report compares cell-cell communication networks between duodenum and ileum using LIANA (ligand-receptor analysis) on merged scRNA-seq data, integrated with pathway enrichment analysis. Stem cells and TA (transit-amplifying) cells were analyzed as receivers; all other cell types served as senders.

## Methods

- **LIANA**: rank_aggregate method with mouseconsensus resource, expr_prop = 0.1
- **Significance filter**: CellPhoneDB p < 0.05
- **Module assignment**: 28 curated signaling modules (expanded from 24 original + 4 new), "either ligand OR receptor mapped" rule
- **fgsea**: Curated module gene lists as custom gene sets on Stem/TA DE rankings (avg_log2FC, Ileum vs Duodenum)
- **Cell type merges**: FOXL1+/GREM1+ fibroblasts → "Fibroblasts"; 3 macrophage subtypes → "Macrophages"

## Results

### 1. Significant LR Pairs

| Region | Total pairs | Significant (p<0.05) | % |
|--------|------------|----------------------|---|
| Duodenum | 9,326 | 5,061 | 54.3% |
| Ileum | 9,436 | 4,961 | 52.6% |

**Comparison**: 3,457 shared pairs, 1,604 Duodenum-specific, 1,504 Ileum-specific.

| Receiver | Shared | Duo-specific | Ile-specific |
|----------|--------|-------------|-------------|
| Stem cells | 1,655 | 715 | 804 |
| TA cells | 1,802 | 889 | 700 |

### 2. Module-Level Regional Differences

**Top modules by total significant LR pairs:**

| Module | Duo (Stem) | Ile (Stem) | Duo (TA) | Ile (TA) | Total |
|--------|-----------|-----------|---------|---------|-------|
| VEGF signaling | 294 | 278 | 311 | 279 | 1,162 |
| Lipid signaling | 218 | 233 | 270 | 231 | 952 |
| BMP signaling | 219 | 252 | 221 | 229 | 921 |
| IGF signaling | 182 | 184 | 198 | 182 | 746 |
| Cell adhesion | 179 | 153 | 187 | 146 | 665 |

**Modules with strongest Ileum bias** (more LR pairs in Ileum):

| Module | Receiver | Duo | Ile | Diff | Interpretation |
|--------|----------|-----|-----|------|----------------|
| Axon guidance | Stem | 57 | 130 | +73 | Strongest Ileum bias; ephrin/semaphorin signaling |
| Axon guidance | TA | 76 | 115 | +39 | Also Ileum-biased in TA cells |
| BMP signaling | Stem | 219 | 252 | +33 | More BMP signaling to Ileum stem cells |
| Cell cycle | Stem | 138 | 166 | +28 | More proliferative signaling in Ileum |
| Hedgehog | Stem | 41 | 53 | +12 | Slightly more Hh signaling in Ileum |
| WNT | Stem | 22 | 32 | +10 | More WNT signaling to Ileum stem cells |

**Modules with strongest Duodenum bias** (more LR pairs in Duodenum):

| Module | Receiver | Duo | Ile | Diff | Interpretation |
|--------|----------|-----|-----|------|----------------|
| Cell adhesion | TA | 187 | 146 | -41 | Stronger adhesion signaling in Duo TA |
| Lipid signaling | TA | 270 | 231 | -39 | More lipid-related signaling in Duo TA |
| VEGF | TA | 311 | 279 | -32 | More VEGF signaling in Duo TA |
| Cell adhesion | Stem | 179 | 153 | -26 | Also Duo-biased in stem cells |
| Chemokine | TA | 45 | 23 | -22 | More chemokine signaling in Duo TA |
| ECM–Integrin | TA | 134 | 113 | -21 | More ECM signaling in Duo TA |

### 3. Pathway Enrichment (fgsea with Curated Module Gene Sets)

fgsea was run using the curated signaling module gene lists as custom gene sets on Stem/TA DE rankings (Ileum vs Duodenum).

**Significant enrichment (padj < 0.05):**

| Module | Receiver | NES | padj | Direction |
|--------|----------|-----|------|-----------|
| Guanylate cyclase | TA cells | 1.65 | 0.033 | Up in Ileum |

**Nominal significance (p < 0.05, padj > 0.05):**

| Module | Receiver | NES | Direction |
|--------|----------|-----|-----------|
| Guanylate cyclase | Stem cells | 1.53 | Up in Ileum |
| Neurotransmitter/serotonin | Stem cells | 1.59 | Up in Ileum |
| Apoptosis | TA cells | -1.33 | Up in Duodenum |

**Key observation**: Most modules show positive NES in Stem cells (up in Ileum) but negative NES in TA cells (up in Duodenum), suggesting a general pattern where signaling pathway gene expression is higher in Ileum stem cells but higher in Duodenum TA cells.

### 4. Region-Specific LR Pairs

**Top Duodenum-specific pairs** (by lr_means):

| Sender | Receiver | Ligand | Receptor | Module | lr_means |
|--------|----------|--------|----------|--------|----------|
| CLU+ reserve stem | Stem | App | Rpsa | Lipid signaling | 2.78 |
| CLU+ reserve stem | TA | App | Rpsa | Lipid signaling | 2.60 |
| CD8aa IEL | Stem | Gzma | Pard3 | Granzyme/cytotoxicity | 2.28 |
| CD8aa IEL | TA | Gzma | Pard3 | Granzyme/cytotoxicity | 2.28 |
| CD8aa IEL | TA | Gzma | F2rl1 | Granzyme/cytotoxicity | 2.06 |
| CLU+ reserve stem | Stem | Lamb2 | Rpsa | TGFβ | 2.03 |

**Top Ileum-specific pairs** (by lr_means):

| Sender | Receiver | Ligand | Receptor | Module | lr_means |
|--------|----------|--------|----------|--------|----------|
| Macrophages | Stem | Psap | Celsr1 | PDGF | 2.32 |
| Macrophages | TA | Psap | Celsr1 | PDGF | 2.31 |
| Fibroblasts | Stem | Dcn | Erbb4 | Lipid signaling | 2.16 |
| Plasmablasts | Stem | App | Rpsa | Lipid signaling | 2.04 |
| Paneth cells | Stem | App | Rpsa | Lipid signaling | 2.01 |
| Mid-villus EC | TA | Guca2a | Gucy2c | Guanylate cyclase | 1.68 |

### 5. Key Biological Findings

#### 5.1 Axon Guidance Signaling is Strongly Ileum-Biased

Axon guidance (ephrin/semaphorin/netrin/slit) shows the largest regional difference, with +73 more significant LR pairs in Ileum stem cells and +39 in TA cells. Key Ileum-specific pairs include:

- **Efna5→Epha4/Epha1** (Fibroblasts→Stem): Ephrin-A5 signaling to Eph receptors
- **Efnb3→Ephb2/Ephb4** (cDC1→Stem): Ephrin-B3 from dendritic cells
- **Sema4d→Plxnb1** (cDC1, CD8aa IEL, Plasmablasts→Stem): Semaphorin 4D from immune cells
- **Efna1→Epha4/Epha7/Epha1** (Stem→Stem): Autocrine ephrin signaling

This suggests that ephrin-mediated cell positioning and axon guidance cues are more prominent in the ileum stem cell niche, potentially reflecting differences in crypt architecture or innervation patterns.

#### 5.2 Guanylate Cyclase Signaling is Ileum-Enriched

Guanylate cyclase signaling (Guca2a/Guca2b→Gucy2c) is the only module with significant fgsea enrichment (TA cells, NES=1.65, padj=0.033). This pathway involves:

- **Guca2a/Guca2b** (guanylin/uroguanylin) from enterocytes and goblet cells
- **Gucy2c** (guanylate cyclase C) on stem/TA cells

GUCY2C signaling regulates intestinal fluid secretion, cell proliferation, and barrier function. Its enrichment in Ileum is consistent with the known role of guanylin peptides in distal intestinal physiology.

#### 5.3 Granzyme/Cytotoxicity Signaling is Duodenum-Specific

Granzyme A (Gzma) signaling from CD8aa IELs to Pard3 and F2rl1 on stem/TA cells is among the strongest Duodenum-specific interactions (lr_means ~2.0-2.3). This suggests enhanced cytotoxic lymphocyte activity in the duodenal epithelium, potentially related to higher antigen exposure in the proximal intestine.

#### 5.4 BMP Signaling is Ileum-Biased in Stem Cells

BMP signaling shows +33 more significant pairs in Ileum stem cells. Key Ileum-specific pairs include:

- **Sfrp1→Fzd2/Fzd6** (Fibroblasts→Stem): Secreted frizzled-related protein 1 (WNT/BMP modulator)
- **Bmp7→Ptprk/Actr2** (CD8aa IEL, Fibroblasts→Stem): BMP7 signaling

This is consistent with the known role of BMP signaling in maintaining stem cell quiescence and regulating differentiation along the proximal-distal axis.

#### 5.5 Cell Adhesion and VEGF are Duodenum-Biased in TA Cells

Cell adhesion (-41 pairs) and VEGF signaling (-32 pairs) are more prominent in Duodenum TA cells. Key Duodenum-specific pairs include:

- **Psap→Lrp1/Sort1** (cDC1, Fibroblasts, Endothelial→TA): Prosaposin signaling
- **Cdh1→Ptprm/Egfr** (CLU+ reserve stem→TA): E-cadherin adhesion
- **Vegfa→Itgb1/Ephb2** (CLU+ reserve stem, Enteroendocrine→TA): VEGF signaling

This suggests stronger adhesive and angiogenic signaling in the duodenal TA compartment.

#### 5.6 Neurotransmitter/Serotonin Signaling is Ileum-Enriched in Stem Cells

Neurotransmitter/serotonin signaling shows nominal fgsea enrichment in Stem cells (NES=1.59, p<0.05). Key pairs include:

- **Tph1→Htr4** (Enteroendocrine→Stem): Serotonin signaling
- **Gnas→Adcy8** (CD8aa IEL, Fibroblasts, Endothelial→Stem): G-protein signaling
- **Arf1→Chrm3** (Upper-villus EC, Goblet→Stem): Muscarinic signaling

This is consistent with the higher density of enteroendocrine cells and serotonergic signaling in the ileum.

### 6. Sender Category Contributions

**Fibroblasts**: Dominant sender of ECM/integrin, lipid signaling, and axon guidance cues. Key ligands include collagens, laminins, App, Sfrp1, and ephrins.

**Endothelial cells**: Major source of VEGF, chemokine, and complement signaling. Also contribute Sfrp1 and Psap.

**Immune cells** (Macrophages, cDC1, CD8aa IEL, T helper, Plasmablasts): Diverse signaling including antigen presentation (B2m, H2-K1), granzyme/cytotoxicity (Gzma), ephrins (Efnb3, Sema4d), and Psap.

**Epithelial cells** (Paneth, Goblet, enterocytes, enteroendocrine, TA/early progenitors, CLU+ reserve stem): Autocrine and paracrine signaling including guanylate cyclase (Guca2a/b), serotonin (Tph1), cell adhesion (Cdh1), and BMP/WNT modulators.

## Conclusions

1. **Axon guidance signaling is the most regionally divergent module**, strongly enriched in Ileum. This may reflect differences in crypt-villus architecture, innervation, or immune-epithelial interactions along the proximal-distal axis.

2. **Guanylate cyclase signaling (GUCY2C)** is significantly enriched in Ileum TA cells, consistent with its role in distal intestinal fluid and electrolyte homeostasis.

3. **Granzyme/cytotoxicity signaling from CD8aa IELs** is Duodenum-specific, suggesting enhanced immune surveillance in the proximal intestine.

4. **BMP signaling to stem cells is Ileum-biased**, potentially contributing to regional differences in stem cell maintenance and differentiation.

5. **Cell adhesion and VEGF signaling to TA cells are Duodenum-biased**, suggesting stronger proliferative and angiogenic support in the proximal intestine.

6. **Neurotransmitter/serotonin signaling is Ileum-enriched in stem cells**, consistent with higher enteroendocrine cell density and serotonergic innervation in the distal intestine.

## Files Generated

- `liana_duodenum_st_ta_sig.csv` — Duodenum significant LR pairs (5,061)
- `liana_ileum_st_ta_sig.csv` — Ileum significant LR pairs (4,961)
- `liana_sig_comparison_duo_vs_ile.csv` — Region comparison (6,565 pairs)
- `liana_duodenum_st_ta_sig_modules.csv` — With module assignments
- `liana_ileum_st_ta_sig_modules.csv` — With module assignments
- `liana_sig_comparison_modules.csv` — Comparison with modules
- `fgsea_curated_modules_stem_ta.csv` — fgsea results with curated modules
- `summary_table_module_region_receiver.csv` — Module × region × receiver summary
- `summary_table_region_specificity.csv` — Region specificity summary
- `pathway_fgsea_lr_merged.csv` — Merged fgsea + LR evidence

**Figures:**
- `pathway_barplot_stem_cells_v2.png/svg` — Stem cell module enrichment
- `pathway_barplot_ta_cells_v2.png/svg` — TA cell module enrichment
- `pathway_barplot_combined_v2.png/svg` — Combined Stem vs TA
- `lr_counts_per_module.png/svg` — LR counts per module by region
- `circle_plots/` — 16 chord diagrams (4 sender categories × 2 receivers × 2 regions)
