# Regional Comparison of Cell-Cell Communication: Stem Cells Receiver

## Overview

This report compares cell-cell communication networks between duodenum and ileum using LIANA (ligand-receptor analysis) on merged scRNA-seq data, with **Stem cells as the receiver**. All other cell types served as senders. Module assignments use the **corrected ligand-only mapping** (canonical pathway membership based on ligand, not receptor).

## Methods

- **LIANA**: rank_aggregate method with mouseconsensus resource, expr_prop = 0.1
- **Significance filter**: CellPhoneDB p < 0.05
- **Module assignment**: 28 curated signaling modules, **ligand-only canonical mapping** (fixed from original receptor-based mapping)
- **Cell type merges**: FOXL1+/GREM1+ fibroblasts → "Fibroblasts"; 3 macrophage subtypes → "Macrophages"

## Results

### 1. Significant LR Pairs to Stem Cells

| Region | Total pairs | Significant (p<0.05) |
|--------|------------|----------------------|
| Duodenum | 4,663 | 2,370 |
| Ileum | 4,718 | 2,459 |

**Comparison**: 1,655 shared pairs, 715 Duodenum-specific, 804 Ileum-specific.

### 2. Module-Level Regional Differences

**Top modules by total significant LR pairs to Stem cells:**

| Module | Duo | Ile | Total | Diff | Direction |
|--------|-----|-----|-------|------|-----------|
| Other | 387 | 359 | 746 | -28 | Duodenum-biased |
| VEGF signaling | 265 | 248 | 513 | -17 | Duodenum-biased |
| Lipid signaling & transport | 205 | 208 | 413 | +3 | Similar |
| IGF signaling | 182 | 184 | 366 | +2 | Similar |
| Cell cycle / Proliferation | 128 | 157 | 285 | +29 | Ileum-biased |
| Cell adhesion & junctions | 145 | 128 | 273 | -17 | Duodenum-biased |
| ECM–Integrin | 119 | 123 | 242 | +4 | Similar |
| Apoptosis / Cell survival | 108 | 115 | 223 | +7 | Similar |
| BMP signaling | 96 | 115 | 211 | +19 | Ileum-biased |
| Retinoic acid signaling | 102 | 88 | 190 | -14 | Duodenum-biased |
| **Axon guidance** | **57** | **130** | **187** | **+73** | **Strongly Ileum-biased** |
| EGFR signaling | 74 | 86 | 160 | +12 | Ileum-biased |
| Antigen presentation | 75 | 70 | 145 | -5 | Similar |
| **WNT signaling** | **62** | **82** | **144** | **+20** | **Ileum-biased** |
| Mitochondrial & oxidative metabolism | 69 | 73 | 142 | +4 | Similar |

**Key observations:**
- **Axon guidance** shows the strongest regional bias (+73 pairs in Ileum), driven by ephrin→Eph receptor signaling
- **WNT signaling** is Ileum-biased (+20 pairs), with more WNT ligand→Frizzled receptor interactions
- **BMP signaling** is Ileum-biased (+19 pairs)
- **Cell cycle/Proliferation** is Ileum-biased (+29 pairs)
- **VEGF, Cell adhesion, Retinoic acid** are Duodenum-biased

### 3. Region-Unique LR Combos by Module

Modules with the most region-unique LR combinations (pairs significant in one region only):

| Module | Duo-only | Ile-only | Total |
|--------|----------|----------|-------|
| WNT signaling | 17 | 25 | 42 |
| Other | 20 | 15 | 35 |
| Axon guidance | 0 | 22 | 22 |
| VEGF signaling | 12 | 5 | 17 |
| Lipid signaling & transport | 1 | 13 | 14 |
| Apoptosis / Cell survival | 3 | 7 | 10 |
| FGF signaling | 4 | 6 | 10 |
| BMP signaling | 5 | 3 | 8 |
| IGF signaling | 3 | 4 | 7 |
| Mitochondrial & oxidative metabolism | 1 | 6 | 7 |

**Key insight**: WNT signaling has the most region-unique combos (42), indicating that while WNT signaling is active in both regions, the specific WNT ligand→receptor pairs used differ substantially between duodenum and ileum.

### 4. Top Region-Specific LR Pairs to Stem Cells

**Top Duodenum-specific pairs** (by lr_means):

| Sender | Ligand | Receptor | Module | lr_means |
|--------|--------|----------|--------|----------|
| CLU+ reserve stem | App | Rpsa | Lipid signaling | 2.78 |
| CD8aa IEL | Gzma | Pard3 | Granzyme/cytotoxicity | 2.28 |
| CD8aa IEL | Gzma | F2rl1 | Granzyme/cytotoxicity | 2.05 |
| CLU+ reserve stem | Lamb2 | Rpsa | Other | 2.03 |
| Activated/helper T | Hspa8 | Ldlr | Antigen presentation | 1.96 |
| CD8aa IEL | B2m | Tfrc | Antigen presentation | 1.92 |
| Fibroblasts | Dcn | Egfr | Lipid signaling | 1.85 |
| Macrophages | Psap | Lrp1 | PDGF signaling | 1.82 |
| Fibroblasts | Col1a1 | Cd44 | ECM–Integrin | 1.78 |
| Paneth cells | Wnt3 | Fzd5_Lrp6 | WNT signaling | 1.75 |

**Top Ileum-specific pairs** (by lr_means):

| Sender | Ligand | Receptor | Module | lr_means |
|--------|--------|----------|--------|----------|
| Macrophages | Psap | Celsr1 | PDGF signaling | 2.32 |
| Fibroblasts | Dcn | Erbb4 | Lipid signaling | 2.16 |
| Plasmablasts | App | Rpsa | Lipid signaling | 2.04 |
| Paneth cells | App | Rpsa | Lipid signaling | 2.01 |
| cDC1 | Psap | Celsr1 | PDGF signaling | 1.84 |
| Mid-villus EC | Guca2a | Gucy2c | Guanylate cyclase | 1.68 |
| Fibroblasts | Piga | Pigr | Other | 1.66 |
| Fibroblasts | Sfrp1 | Fzd2 | WNT signaling | 1.27 |
| Fibroblasts | Sfrp1 | Fzd6 | WNT signaling | 1.27 |
| Endothelial | Efna5 | Epha4 | Axon guidance | 0.77 |

### 5. Key Biological Findings

#### 5.1 Axon Guidance Signaling is Strongly Ileum-Biased

Axon guidance (ephrin/semaphorin) shows the largest regional difference, with **+73 more significant LR pairs in Ileum stem cells** and **22 Ileum-unique LR combos** (0 Duodenum-unique). Key Ileum-specific pairs include:

- **Efna5→Epha4** (Fibroblasts, Endothelial→Stem): Ephrin-A5 signaling to EphA4
- **Efna1→Epha4/Epha7** (Stem, Upper-villus EC→Stem): Autocrine ephrin signaling
- **Sema4d→Plxnb1** (cDC1, CD8aa IEL, Plasmablasts→Stem): Semaphorin 4D from immune cells
- **Efnb3→Epha4** (cDC1→Stem): Ephrin-B3 from dendritic cells

This suggests that ephrin-mediated cell positioning and axon guidance cues are more prominent in the ileum stem cell niche, potentially reflecting differences in crypt architecture or innervation patterns.

#### 5.2 WNT Signaling Uses Different LR Pairs Between Regions

WNT signaling has the most region-unique combos (42 total: 17 Duo-only, 25 Ile-only). While both regions show active WNT signaling, the specific ligand→receptor pairs differ:

**Ileum-specific WNT pairs:**
- **Sfrp1→Fzd2/Fzd6** (Fibroblasts, Endothelial→Stem): Secreted frizzled-related protein 1 (WNT antagonist)
- **Wnt11→Fzd2/Fzd6** (cDC1→Stem): Non-canonical WNT11 signaling
- **Wnt5a→Fzd2/Fzd6** (Fibroblasts→Stem): Non-canonical WNT5A signaling

**Duodenum-specific WNT pairs:**
- **Wnt3→Fzd5_Lrp6** (Paneth cells→Stem): Canonical WNT3 signaling
- **Wnt6→Fzd7_Lrp6** (Paneth cells→Stem): Canonical WNT6 signaling
- **Wnt9b→Fzd5_Lrp5** (Paneth cells→Stem): Canonical WNT9B signaling

This suggests that **Ileum stem cells receive more non-canonical WNT signaling** (Wnt5a, Wnt11) and **WNT modulation** (Sfrp1), while **Duodenum stem cells receive more canonical WNT signaling** (Wnt3, Wnt6, Wnt9b) from Paneth cells.

#### 5.3 BMP Signaling is Ileum-Biased

BMP signaling shows **+19 more significant pairs in Ileum stem cells**. Key Ileum-specific pairs include:

- **Gdf6→Bmpr1a_Bmpr2** (Fibroblasts→Stem): Growth differentiation factor 6
- **Bmp8a→Bmpr1a_Bmpr2** (Goblet cells→Stem): BMP8A signaling

Duodenum-specific BMP pairs include:
- **Gdf9→Bmpr1a** (Upper-villus EC→Stem): GDF9 signaling
- **Fst→Bmpr2** (Fibroblasts→Stem): Follistatin (BMP antagonist)

This is consistent with the known role of BMP signaling in maintaining stem cell quiescence and regulating differentiation along the proximal-distal axis.

#### 5.4 Granzyme/Cytotoxicity Signaling is Duodenum-Specific

Granzyme A (Gzma) signaling from CD8aa IELs to Pard3 and F2rl1 on stem cells is among the strongest Duodenum-specific interactions (lr_means ~2.0-2.3). This suggests enhanced cytotoxic lymphocyte activity in the duodenal epithelium, potentially related to higher antigen exposure in the proximal intestine.

#### 5.5 Guanylate Cyclase Signaling is Ileum-Enriched

**Guca2a→Gucy2c** (Mid-villus enterocytes→Stem) is a strong Ileum-specific pair (lr_means = 1.68). GUCY2C signaling regulates intestinal fluid secretion, cell proliferation, and barrier function. Its enrichment in Ileum is consistent with the known role of guanylin peptides in distal intestinal physiology.

#### 5.6 Retinoic Acid Signaling is Duodenum-Biased

Retinoic acid signaling shows **-14 pairs in Ileum** (Duodenum-biased), with **22 Duodenum-unique** vs **8 Ileum-unique** LR combos. Key Duodenum-specific pairs include:

- **Ybx1→Notch1** (CLU+ reserve stem, Stem cells→Stem): Y-box binding protein 1 signaling to Notch1 (lr_means = 1.29)
- **Bsg→Slc16a1** (CLU+ reserve stem, Fibroblasts→Stem): Basigin (CD147) to monocarboxylate transporter 1 (lr_means = 1.09)
- **Angptl4→Sdc4** (Macrophages, TA/early prog.→Stem): Angiopoietin-like 4 to syndecan-4 (lr_means = 0.79)
- **Apoc2→Lrp1/Ldlr** (Mid-villus EC→Stem): Apolipoprotein C2 to LDL receptors (lr_means = 0.74)

Ileum-specific pairs include:
- **Bsg→Slc16a1** (TA/early prog.→Stem): Same ligand-receptor but different sender (lr_means = 0.78)
- **Lpl→Cd44/Lrp1** (Endothelial, Fibroblasts→Stem): Lipoprotein lipase signaling (lr_means = 0.65)

**Note**: The "Retinoic acid" module name is somewhat misleading — the actual retinoic acid ligands (Rara, Rarb, etc.) are not well-represented in the LIANA resource. The module primarily captures **metabolic and lipid-related signaling** (Ybx1, Bsg, Angptl4, Apoc2, Lpl) that intersects with retinoic acid pathway regulation. The Duodenum bias suggests stronger metabolic/lipid signaling in the proximal intestine stem cell niche.

#### 5.7 Cell Cycle/Proliferation Signaling is Ileum-Biased

Cell cycle/proliferation shows **+29 pairs in Ileum**, with **60 Ileum-unique** vs **31 Duodenum-unique** LR combos. Key Ileum-specific pairs include:

- **Mif→Cd44_Cd74** (TA cells, TA/early prog., Stem cells→Stem): Macrophage migration inhibitory factor to CD44/CD74 complex (lr_means = 1.38)
- **Mdk→Ncl** (Macrophages, Plasmablasts→Stem): Midkine to nucleolin (lr_means = 1.11)
- **Mdk→Sdc4** (Macrophages, Plasmablasts→Stem): Midkine to syndecan-4 (lr_means = 0.83)
- **Has2→Cd44** (Fibroblasts→Stem): Hyaluronan synthase 2 to CD44 (lr_means = 0.59)

Duodenum-specific pairs include:
- **Mdk→Ncl** (Endothelial, Enteroendocrine→Stem): Same ligand-receptor but different senders (lr_means = 1.15)
- **Sema4g→Plxnb2** (CLU+ reserve stem→Stem): Semaphorin 4G to plexin-B2 (lr_means = 0.78)
- **Lamc1/Lamc2→Dag1** (CLU+ reserve stem→Stem): Laminin to dystroglycan (lr_means = 0.76)

**Key insight**: The Ileum bias is driven by **MIF→CD44/CD74** signaling from TA cells and stem cells themselves, suggesting autocrine/paracrine proliferative signaling in the Ileum stem cell niche. MIF is a pleiotropic cytokine that promotes cell proliferation and survival. The Duodenum-specific pairs involve more **laminin-dystroglycan** adhesion signaling from CLU+ reserve stem cells.

#### 5.8 EGFR Signaling Shows Regional Differences in Ligand Usage

EGFR signaling is slightly Ileum-biased (+12 pairs), with **44 Ileum-unique** vs **32 Duodenum-unique** LR combos. The regions use different EGFR ligands and receptors:

**Ileum-specific pairs:**
- **Hbegf→Cd44/Cd9** (Upper-villus EC→Stem): HB-EGF to CD44/CD9 (lr_means = 0.91)
- **Hbegf→Prlr** (Mid-villus EC, Plasmablasts→Stem): HB-EGF to prolactin receptor (lr_means = 0.55)
- **Areg→Erbb3** (Mid-villus EC→Stem): Amphiregulin to ERBB3 (lr_means = 0.45)
- **Hbegf→Erbb2_Erbb4** (Upper-villus EC→Stem): HB-EGF to ERBB2/ERBB4 heterodimer (lr_means = 0.44)

**Duodenum-specific pairs:**
- **Hbegf→Prlr** (CLU+ reserve stem, Enteroendocrine, T helper→Stem): HB-EGF to prolactin receptor (lr_means = 0.68)
- **Ereg→Erbb3** (Endothelial→Stem): Epiregulin to ERBB3 (lr_means = 0.65)
- **Tgfa→Erbb3** (CLU+ reserve stem→Stem): TGF-α to ERBB3 (lr_means = 0.55)
- **Btc→Erbb3** (CLU+ reserve stem→Stem): Betacellulin to ERBB3 (lr_means = 0.52)

**Key insight**: Ileum stem cells receive more **HB-EGF from upper-villus enterocytes** via CD44/CD9 co-receptors, while Duodenum stem cells receive more **diverse EGFR ligands** (Ereg, Tgfa, Btc) from CLU+ reserve stem cells and endothelial cells via ERBB3. This suggests regional differences in EGFR pathway activation mechanisms.

#### 5.9 FGF Signaling is Ileum-Biased

FGF signaling shows **+21 pairs in Ileum**, with **10 Ileum-unique** vs **4 Duodenum-unique** LR combos. Key Ileum-specific pairs include:

- **Fgf2→Fgfr2** (Fibroblasts→Stem): FGF2 to FGFR2 (lr_means = 0.45)
- **Fgf10→Fgfr2** (Fibroblasts→Stem): FGF10 to FGFR2 (lr_means = 0.38)
- **Fgf7→Fgfr2** (Fibroblasts→Stem): FGF7 (KGF) to FGFR2 (lr_means = 0.35)

Duodenum-specific pairs are limited but include **Fgf2→Fgfr1** from fibroblasts.

**Key insight**: The Ileum bias is driven by **FGF2, FGF10, and FGF7 from fibroblasts** signaling to FGFR2 on stem cells. FGF signaling is known to support intestinal stem cell proliferation and survival. The stronger FGF signaling in Ileum may contribute to regional differences in stem cell maintenance.

#### 5.10 Hedgehog Signaling is Ileum-Biased

Hedgehog signaling shows **+13 pairs in Ileum**, with **1 Ileum-unique** vs **0 Duodenum-unique** LR combos. The key Ileum-specific pair is:

- **Ihh→Ptch1** (Stem cells→Stem): Indian hedgehog to Patched-1 (lr_means = 0.42)

**Key insight**: IHH is produced by intestinal epithelial cells and signals to Ptch1 on stem cells to regulate proliferation and differentiation. The Ileum bias suggests stronger hedgehog pathway activity in the distal intestine stem cell niche.

#### 5.11 TGFβ Signaling is Duodenum-Biased

TGFβ signaling shows **-14 pairs in Ileum** (Duodenum-biased), with **20 Duodenum-unique** vs **1 Ileum-unique** LR combos. Key Duodenum-specific pairs include:

- **Tgfb1→Lpp** (CD8aa IEL, Endothelial→Stem): TGF-β1 to LIM domain containing preferred translocation partner in lipoma (lr_means = 0.79)
- **Tgfb1→Itgb1** (Plasmablasts→Stem): TGF-β1 to integrin β1 (lr_means = 0.77)
- **Tgfb1→Tgfbr1_Tgfbr2** (Plasmablasts→Stem): Canonical TGF-β receptor signaling (lr_means = 0.60)
- **Tgfb1→Acvr1b_Tgfbr2** (Plasmablasts→Stem): Activin receptor/TGF-β receptor complex (lr_means = 0.60)

**Key insight**: The Duodenum bias is driven by **TGF-β1 from immune cells** (CD8aa IEL, plasmablasts) and endothelial cells. TGF-β signaling is generally inhibitory to stem cell proliferation and promotes differentiation. The stronger TGF-β signaling in Duodenum may contribute to regional differences in stem cell quiescence.

#### 5.12 Notch Signaling is Duodenum-Biased

Notch signaling shows **-11 pairs in Ileum** (Duodenum-biased), with **15 Duodenum-unique** vs **4 Ileum-unique** LR combos. Key Duodenum-specific pairs include:

- **Dll1→Notch1/Notch2** (Paneth cells→Stem): Delta-like 1 to Notch1/2 (lr_means = 0.32)
- **Dll4→Notch1/Notch2** (Paneth cells→Stem): Delta-like 4 to Notch1/2 (lr_means = 0.32)
- **Jag1→Notch1** (Endothelial→Stem): Jagged 1 to Notch1 (lr_means = 0.25)
- **Dll3→Notch1** (Paneth cells→Stem): Delta-like 3 to Notch1 (lr_means = 0.23)

Ileum-specific pairs include:
- **Jag2→Notch2** (Enteroendocrine→Stem): Jagged 2 to Notch2 (lr_means = 0.29)
- **Dll1→Notch1** (Stem cells, TA cells→Stem): Autocrine Delta-like 1 (lr_means = 0.26)

**Key insight**: The Duodenum bias is driven by **DLL1, DLL4, and DLL3 from Paneth cells** signaling to Notch1/Notch2 on stem cells. Notch signaling is critical for maintaining intestinal stem cell identity and regulating differentiation. The stronger Notch signaling in Duodenum is consistent with the higher density of Paneth cells in the proximal intestine.

#### 5.13 Chemokine Signaling is Duodenum-Biased

Chemokine signaling shows **-10 pairs in Ileum** (Duodenum-biased), with **14 Duodenum-unique** vs **4 Ileum-unique** LR combos. Key Duodenum-specific pairs include:

- **Calr→Lrp1/Itgav/Itga3** (Macrophages, Fibroblasts, cDC1→Stem): Calreticulin to LRP1/integrins (lr_means = 1.25)
- **Fbln1→Itgb1** (Endothelial, Upper-villus EC→Stem): Fibulin-1 to integrin β1 (lr_means = 0.63)
- **Adam9→Itga3** (CLU+ reserve stem→Stem): ADAM9 to integrin α3 (lr_means = 0.46)

Ileum-specific pairs include:
- **Calr→Itga3/Itgav** (Goblet cells→Stem): Calreticulin from goblet cells (lr_means = 1.18)

**Key insight**: The Duodenum bias is driven by **calreticulin (CALR) from macrophages, fibroblasts, and cDC1** signaling to integrins on stem cells. CALR is an endoplasmic reticulum chaperone that can be secreted and signals to integrins. The stronger chemokine/adhesion signaling in Duodenum may reflect higher immune cell activity in the proximal intestine.

#### 5.14 Interferon Signaling is Duodenum-Biased

Interferon signaling shows **-8 pairs in Ileum** (Duodenum-biased), with **15 Duodenum-unique** vs **7 Ileum-unique** LR combos. Key Duodenum-specific pairs include:

- **Cxcl10→Sdc4** (Endothelial, T helper→Stem): CXCL10 to syndecan-4 (lr_means = 0.97)
- **Efnb2→Ephb2/Ephb4** (Endothelial, CLU+ reserve stem→Stem): Ephrin-B2 to EphB2/B4 (lr_means = 0.67)
- **Spon2→Itgb1** (Endothelial→Stem): Spondin-2 to integrin β1 (lr_means = 0.55)

Ileum-specific pairs include:
- **Cxcl10→Sdc4** (Macrophages→Stem): CXCL10 from macrophages (lr_means = 0.86)
- **Efnb2→Ephb2/Ephb4** (cDC1→Stem): Ephrin-B2 from dendritic cells (lr_means = 0.48)

**Key insight**: The Duodenum bias is driven by **CXCL10 from endothelial cells and T helper cells** signaling to syndecan-4 on stem cells. CXCL10 is an interferon-inducible chemokine. The stronger interferon signaling in Duodenum may reflect higher immune activation in the proximal intestine.

### 6. Conserved Interactions Between Regions

While regional differences are important, many LR pairs are **significant in both regions**, representing core niche signals. These conserved interactions are critical for maintaining stem cell function regardless of intestinal location.

#### 6.1 WNT Signaling — Conserved Core

**33 conserved WNT pairs** are significant in both regions. Top conserved pairs:

| Sender | Ligand | Receptor | Avg lr_means |
|--------|--------|----------|--------------|
| Fibroblasts | Wnt5a | Ptprk | 0.81 |
| Fibroblasts | Dkk2 | Lrp6 | 0.55 |
| Fibroblasts | Dkk2 | Lrp5 | 0.52 |
| cDC1 | Wnt11 | Fzd5 | 0.47 |
| Enteroendocrine | Wnt3 | Fzd5_Lrp6 | 0.44 |
| Enteroendocrine | Wnt3 | Fzd5_Lrp5 | 0.41 |
| Enteroendocrine | Wnt3 | Ryk | 0.41 |
| Paneth cells | Wnt3 | Fzd5_Lrp6 | 0.39 |
| Fibroblasts | Wnt5a | Fzd5 | 0.38 |
| Enteroendocrine | Wnt3 | Ror2 | 0.36 |

**Key insight**: The conserved WNT core includes **Wnt3 from enteroendocrine and Paneth cells** (canonical WNT) and **Wnt5a from fibroblasts** (non-canonical WNT). **Dkk2 from fibroblasts** (WNT antagonist) is also conserved, suggesting that WNT pathway modulation is a core feature of the intestinal stem cell niche regardless of region.

#### 6.2 BMP Signaling — Conserved Core

**82 conserved BMP pairs** are significant in both regions. Top conserved pairs:

| Sender | Ligand | Receptor | Avg lr_means |
|--------|--------|----------|--------------|
| Fibroblasts | Bmp4 | Rgmb | 1.25 |
| Fibroblasts | Bmp4 | Lrp6 | 0.97 |
| Fibroblasts | Bmp4 | Bmpr1a_Bmpr2 | 0.89 |
| Fibroblasts | Bmp4 | Acvr2a_Bmpr1a | 0.86 |
| Fibroblasts | Bmp4 | Acvr2b_Bmpr1a | 0.84 |
| Fibroblasts | Bmp2 | Rgmb | 0.80 |
| Fibroblasts | Bmp7 | Ptprk | 0.79 |
| Endothelial | Bmp4 | Rgmb | 0.75 |
| Paneth cells | Bmp7 | Ptprk | 0.70 |
| Stem cells | Bmp7 | Ptprk | 0.70 |

**Key insight**: The conserved BMP core is dominated by **BMP4 from fibroblasts** signaling to multiple receptors (RGMB, LRP6, BMPR1A/BMPR2, ACVR2A/B). **BMP7 from Paneth cells and stem cells** is also conserved. This suggests that BMP signaling from mesenchymal cells is a core feature of the intestinal stem cell niche.

#### 6.3 Notch Signaling — Conserved Core

**14 conserved Notch pairs** are significant in both regions. Top conserved pairs:

| Sender | Ligand | Receptor | Avg lr_means |
|--------|--------|----------|--------------|
| Enteroendocrine | Dll4 | Notch1 | 0.40 |
| Goblet cells | Dll1 | Notch1 | 0.40 |
| cDC1 | Jag2 | Notch1 | 0.38 |
| Endothelial | Dll4 | Notch1 | 0.37 |
| Goblet cells | Dll4 | Notch1 | 0.33 |
| Enteroendocrine | Dll4 | Notch2 | 0.32 |
| Goblet cells | Dll1 | Notch2 | 0.32 |
| Enteroendocrine | Jag2 | Notch1 | 0.31 |
| cDC1 | Jag2 | Notch2 | 0.30 |
| Endothelial | Dll4 | Notch2 | 0.30 |

**Key insight**: The conserved Notch core includes **DLL4 from enteroendocrine and endothelial cells**, **DLL1 from goblet cells**, and **JAG2 from cDC1**. This suggests that Notch signaling from multiple cell types is a core feature of the intestinal stem cell niche.

#### 6.4 EGFR Signaling — Conserved Core

**42 conserved EGFR pairs** are significant in both regions. Top conserved pairs:

| Sender | Ligand | Receptor | Avg lr_means |
|--------|--------|----------|--------------|
| Fibroblasts | Ereg | Erbb3 | 0.90 |
| Fibroblasts | Ereg | Egfr_Erbb2 | 0.72 |
| Upper-villus EC | Hbegf | Prlr | 0.70 |
| Upper-villus EC | Areg | Erbb3 | 0.64 |
| Endothelial | Hbegf | Prlr | 0.61 |
| Fibroblasts | Hbegf | Prlr | 0.56 |
| TA/early prog. | Hbegf | Prlr | 0.56 |
| Goblet cells | Hbegf | Prlr | 0.54 |
| Macrophages | Hbegf | Prlr | 0.52 |
| Goblet cells | Btc | Erbb3 | 0.47 |

**Key insight**: The conserved EGFR core includes **EREG from fibroblasts** (to ERBB3 and EGFR/ERBB2) and **HB-EGF from multiple cell types** (to PRLR). This suggests that EGFR signaling is a core proliferative signal in the intestinal stem cell niche.

#### 6.5 FGF Signaling — Conserved Core

**12 conserved FGF pairs** are significant in both regions. Top conserved pairs:

| Sender | Ligand | Receptor | Avg lr_means |
|--------|--------|----------|--------------|
| Enteroendocrine | Fgf14 | Fgfr2 | 1.53 |
| Fibroblasts | Fgf2 | Fgfr2 | 1.28 |
| Fibroblasts | Fgf10 | Fgfr2 | 1.24 |
| Goblet cells | Fgf14 | Fgfr2 | 1.17 |
| TA cells | Fgf14 | Fgfr2 | 1.14 |
| Fibroblasts | Fgf2 | Sdc4 | 0.93 |
| Fibroblasts | Fgf2 | Cd44 | 0.59 |
| Fibroblasts | Fgf2 | Sdc1 | 0.37 |
| Fibroblasts | Fgf2 | Gpc4 | 0.31 |
| Fibroblasts | Fgf2 | Sdc2 | 0.24 |

**Key insight**: The conserved FGF core includes **FGF14 from enteroendocrine, goblet, and TA cells** and **FGF2/FGF10 from fibroblasts**, all signaling to FGFR2. This suggests that FGF signaling is a core proliferative signal in the intestinal stem cell niche.

#### 6.6 Hedgehog Signaling — Conserved Core

**4 conserved Hedgehog pairs** are significant in both regions:

| Sender | Ligand | Receptor | Avg lr_means |
|--------|--------|----------|--------------|
| Upper-villus EC | Ihh | Ptch1_Smo | 0.22 |
| TA cells | Ihh | Ptch1_Smo | 0.15 |
| Goblet cells | Ihh | Ptch1_Smo | 0.15 |
| TA/early prog. | Ihh | Ptch1_Smo | 0.13 |

**Key insight**: The conserved Hedgehog core is **IHH from epithelial cells** (upper-villus EC, TA, goblet) signaling to PTCH1/SMO on stem cells. This suggests that hedgehog signaling is a core feature of the intestinal stem cell niche, though relatively weak compared to other pathways.

#### 6.7 TGFβ Signaling — Conserved Core

**42 conserved TGFβ pairs** are significant in both regions. Top conserved pairs:

| Sender | Ligand | Receptor | Avg lr_means |
|--------|--------|----------|--------------|
| cDC1 | Tgfb1 | Lpp | 1.25 |
| Macrophages | Tgfb1 | Lpp | 1.25 |
| Plasmablasts | Tgfb1 | Lpp | 1.07 |
| T helper | Tgfb1 | Lpp | 0.99 |
| cDC1 | Tgfb1 | Itgb1 | 0.92 |
| Macrophages | Tgfb1 | Itgb1 | 0.92 |
| cDC1 | Tgfb1 | Egfr | 0.80 |
| Macrophages | Tgfb1 | Egfr | 0.80 |
| cDC1 | Tgfb1 | Sdc2 | 0.74 |
| Macrophages | Tgfb1 | Sdc2 | 0.74 |

**Key insight**: The conserved TGFβ core is **TGF-β1 from immune cells** (cDC1, macrophages, plasmablasts, T helper) signaling to multiple receptors (LPP, ITGB1, EGFR, SDC2). This suggests that TGF-β signaling from immune cells is a core feature of the intestinal stem cell niche, potentially regulating stem cell quiescence and immune-epithelial cross-talk.

#### 6.8 Axon Guidance — Conserved Core

**43 conserved axon guidance pairs** are significant in both regions. Top conserved pairs:

| Sender | Ligand | Receptor | Avg lr_means |
|--------|--------|----------|--------------|
| CD8aa IEL | Sema4d | Plxnb2 | 0.70 |
| Upper-villus EC | Efnb1 | Ephb2 | 0.68 |
| TA cells | Efnb1 | Ephb2 | 0.64 |
| Goblet cells | Efnb1 | Ephb2 | 0.64 |
| Stem cells | Efnb1 | Ephb2 | 0.63 |
| TA/early prog. | Efnb1 | Ephb2 | 0.61 |
| Fibroblasts | Efnb1 | Ephb2 | 0.58 |
| Enteroendocrine | Efnb1 | Ephb2 | 0.58 |
| Mid-villus EC | Efnb1 | Ephb2 | 0.57 |
| CD8aa IEL | Sema4d | Met | 0.57 |

**Key insight**: The conserved axon guidance core includes **EFNB1 from multiple epithelial cell types** (to EPHB2) and **SEMA4D from CD8aa IELs** (to PLXNB2 and MET). This suggests that ephrin-B1→EphB2 signaling is a core feature of the intestinal stem cell niche, potentially regulating cell positioning and crypt architecture.

#### 6.9 Cell Cycle/Proliferation — Conserved Core

**97 conserved cell cycle pairs** are significant in both regions. Top conserved pairs:

| Sender | Ligand | Receptor | Avg lr_means |
|--------|--------|----------|--------------|
| Fibroblasts | Lama2 | Dag1 | 1.71 |
| Fibroblasts | Lamc1 | Cd44 | 1.37 |
| Fibroblasts | Lamb1 | Dag1 | 1.36 |
| Fibroblasts | Mdk | Ncl | 1.32 |
| Fibroblasts | Fn1 | Cd44 | 1.32 |
| Fibroblasts | Lamc1 | Dag1 | 1.32 |
| Fibroblasts | Lamc1 | Itga6_Itgb1 | 1.19 |
| TA/early prog. | Mdk | Ncl | 1.07 |
| Fibroblasts | Lamc1 | Itga6_Itgb4 | 1.07 |
| Fibroblasts | Lamc1 | Itga2_Itgb1 | 1.05 |

**Key insight**: The conserved cell cycle core is dominated by **laminins (LAMA2, LAMC1, LAMB1) and fibronectin (FN1) from fibroblasts** signaling to dystroglycan (DAG1), CD44, and integrins. **MDK from fibroblasts and TA cells** is also conserved. This suggests that ECM-mediated proliferative signaling from mesenchymal cells is a core feature of the intestinal stem cell niche.

#### 6.10 Retinoic Acid — Conserved Core

**80 conserved retinoic acid pairs** are significant in both regions. Top conserved pairs:

| Sender | Ligand | Receptor | Avg lr_means |
|--------|--------|----------|--------------|
| Fibroblasts | Lama1 | Rpsa | 2.08 |
| Fibroblasts | Col6a1 | Itga6 | 1.87 |
| Fibroblasts | Col4a1 | Cd44 | 1.73 |
| Fibroblasts | Col6a1 | Cd44 | 1.72 |
| Fibroblasts | Lama2 | Itga1 | 1.54 |
| Fibroblasts | Col4a1 | Itga1_Itgb1 | 1.51 |
| Fibroblasts | Col4a1 | Sdc1 | 1.50 |
| Fibroblasts | Col6a1 | Itga1_Itgb1 | 1.50 |
| Fibroblasts | Col6a1 | Sdc1 | 1.49 |
| Fibroblasts | Col4a1 | Cd47 | 1.49 |

**Key insight**: The conserved retinoic acid core is dominated by **collagens (COL4A1, COL6A1) and laminins (LAMA1, LAMA2) from fibroblasts** signaling to integrins, CD44, and syndecans. This suggests that ECM-mediated signaling from mesenchymal cells is a core feature of the intestinal stem cell niche.

### 7. Sender Contributions to Stem Cells

**Fibroblasts**: Dominant sender of ECM/integrin, lipid signaling, WNT modulators (Sfrp1), and axon guidance cues (Efna5). Key ligands include collagens, App, Dcn, Sfrp1, and ephrins.

**Endothelial cells**: Major source of VEGF, Sfrp1, and Efna5. Also contribute Psap and chemokines.

**Immune cells** (Macrophages, cDC1, CD8aa IEL, T helper, Plasmablasts): Diverse signaling including antigen presentation (B2m, H2-K1), granzyme/cytotoxicity (Gzma), ephrins (Efnb3, Sema4d), Psap, and App.

**Epithelial cells** (Paneth, Goblet, enterocytes, enteroendocrine, TA/early progenitors, CLU+ reserve stem): Autocrine and paracrine signaling including WNT ligands (Wnt3, Wnt6, Wnt9b from Paneth), guanylate cyclase (Guca2a/b), BMP ligands (Bmp8a from Goblet), and App.

## Conclusions

1. **Axon guidance signaling is the most regionally divergent module**, strongly enriched in Ileum stem cells. This may reflect differences in crypt-villus architecture, innervation, or immune-epithelial interactions along the proximal-distal axis.

2. **WNT signaling uses different ligand→receptor pairs between regions**: Ileum stem cells receive more non-canonical WNT (Wnt5a, Wnt11) and WNT modulation (Sfrp1), while Duodenum stem cells receive more canonical WNT (Wnt3, Wnt6, Wnt9b) from Paneth cells.

3. **BMP signaling to stem cells is Ileum-biased**, potentially contributing to regional differences in stem cell maintenance and differentiation.

4. **Granzyme/cytotoxicity signaling from CD8aa IELs** is Duodenum-specific, suggesting enhanced immune surveillance in the proximal intestine.

5. **Guanylate cyclase signaling (GUCY2C)** is Ileum-enriched, consistent with its role in distal intestinal fluid and electrolyte homeostasis.

6. **Retinoic acid signaling is Duodenum-biased**, driven by metabolic/lipid-related signaling (Ybx1, Bsg, Angptl4, Apoc2) rather than canonical retinoic acid ligands.

7. **Cell cycle/proliferation signaling is Ileum-biased**, driven by MIF→CD44/CD74 autocrine/paracrine signaling from TA cells and stem cells.

8. **EGFR signaling shows regional differences in ligand usage**: Ileum uses more HB-EGF→CD44/CD9, while Duodenum uses more diverse ligands (Ereg, Tgfa, Btc)→ERBB3.

9. **FGF signaling is Ileum-biased**, driven by FGF2, FGF10, and FGF7 from fibroblasts to FGFR2.

10. **Hedgehog signaling is Ileum-biased**, driven by IHH→PTCH1 autocrine signaling.

11. **TGFβ signaling is Duodenum-biased**, driven by TGF-β1 from immune cells (CD8aa IEL, plasmablasts).

12. **Notch signaling is Duodenum-biased**, driven by DLL1/DLL4/DLL3 from Paneth cells.

13. **Chemokine signaling is Duodenum-biased**, driven by calreticulin (CALR) from macrophages, fibroblasts, and cDC1.

14. **Interferon signaling is Duodenum-biased**, driven by CXCL10 from endothelial cells and T helper cells.

15. **Conserved core interactions**: Many LR pairs are significant in both regions, representing core niche signals. These include Wnt3/Dkk2 (WNT), Bmp4/Bmp7 (BMP), Dll4/Jag2 (Notch), Ereg/Hbegf (EGFR), Fgf2/Fgf14 (FGF), Ihh (Hedgehog), Tgfb1 (TGFβ), Efnb1/Sema4d (axon guidance), and laminins/collagens (ECM). These conserved interactions suggest that the fundamental architecture of the intestinal stem cell niche is maintained regardless of region, with regional differences layered on top.

## Files Generated

**Summary tables:**
- `summary_module_stem_cells_fixed.csv` — Module × region summary
- `top_duo_specific_stem_cells_fixed.csv` — Top Duodenum-specific pairs
- `top_ile_specific_stem_cells_fixed.csv` — Top Ileum-specific pairs
- `region_unique_modules_stem_cells_fixed.csv` — Region-unique combos by module

**Figures:**
- `circle_plots_individual_senders/` — 29 chord diagrams (15 senders × 2 regions, Stem cells receiver)
