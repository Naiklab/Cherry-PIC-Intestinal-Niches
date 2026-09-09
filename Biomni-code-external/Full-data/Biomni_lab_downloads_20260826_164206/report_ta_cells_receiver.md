# Regional Comparison of Cell-Cell Communication: TA Cells Receiver

## Overview

This report compares cell-cell communication networks between duodenum and ileum using LIANA (ligand-receptor analysis) on merged scRNA-seq data, with **TA (transit-amplifying) cells as the receiver**. All other cell types served as senders. Module assignments use the **corrected ligand-only mapping** (canonical pathway membership based on ligand, not receptor).

## Methods

- **LIANA**: rank_aggregate method with mouseconsensus resource, expr_prop = 0.1
- **Significance filter**: CellPhoneDB p < 0.05
- **Module assignment**: 28 curated signaling modules, **ligand-only canonical mapping** (fixed from original receptor-based mapping)
- **Cell type merges**: FOXL1+/GREM1+ fibroblasts → "Fibroblasts"; 3 macrophage subtypes → "Macrophages"

## Results

### 1. Significant LR Pairs to TA Cells

| Region | Total pairs | Significant (p<0.05) |
|--------|------------|----------------------|
| Duodenum | 4,663 | 2,691 |
| Ileum | 4,718 | 2,502 |

**Comparison**: 1,802 shared pairs, 889 Duodenum-specific, 700 Ileum-specific.

### 2. Module-Level Regional Differences

**Top modules by total significant LR pairs to TA cells:**

| Module | Duo | Ile | Total | Diff | Direction |
|--------|-----|-----|-------|------|-----------|
| Other | 489 | 442 | 931 | -47 | Duodenum-biased |
| VEGF signaling | 283 | 251 | 534 | -32 | Duodenum-biased |
| Lipid signaling & transport | 249 | 208 | 457 | -41 | Duodenum-biased |
| IGF signaling | 198 | 182 | 380 | -16 | Duodenum-biased |
| Cell cycle / Proliferation | 147 | 151 | 298 | +4 | Similar |
| Cell adhesion & junctions | 162 | 132 | 294 | -30 | Duodenum-biased |
| ECM–Integrin | 134 | 113 | 247 | -21 | Duodenum-biased |
| EGFR signaling | 110 | 101 | 211 | -9 | Similar |
| BMP signaling | 96 | 100 | 196 | +4 | Similar |
| Retinoic acid signaling | 105 | 90 | 195 | -15 | Duodenum-biased |
| **Axon guidance** | **76** | **115** | **191** | **+39** | **Ileum-biased** |
| Mitochondrial & oxidative metabolism | 97 | 92 | 189 | -5 | Similar |
| Apoptosis / Cell survival | 94 | 84 | 178 | -10 | Similar |
| Antigen presentation | 84 | 74 | 158 | -10 | Similar |
| **WNT signaling** | **65** | **78** | **143** | **+13** | **Ileum-biased** |

**Key observations:**
- **Axon guidance** is Ileum-biased (+39 pairs), though less pronounced than in Stem cells (+73)
- **WNT signaling** is Ileum-biased (+13 pairs)
- **VEGF, Lipid signaling, Cell adhesion, ECM–Integrin, IGF, Retinoic acid** are all Duodenum-biased
- TA cells show stronger Duodenum bias overall compared to Stem cells

### 3. Region-Unique LR Combos by Module

Modules with the most region-unique LR combinations (pairs significant in one region only):

| Module | Duo-only | Ile-only | Total |
|--------|----------|----------|-------|
| WNT signaling | 21 | 23 | 44 |
| Other | 21 | 17 | 38 |
| VEGF signaling | 13 | 4 | 17 |
| Axon guidance | 0 | 16 | 16 |
| FGF signaling | 3 | 10 | 13 |
| Lipid signaling & transport | 2 | 9 | 11 |
| Apoptosis / Cell survival | 6 | 4 | 10 |
| Cell adhesion & junctions | 7 | 3 | 10 |
| IGF signaling | 3 | 7 | 10 |
| ECM–Integrin | 7 | 0 | 7 |

**Key insight**: Similar to Stem cells, WNT signaling has the most region-unique combos (44), indicating differential WNT ligand usage between regions. However, TA cells show more Duodenum-unique combos in VEGF, ECM–Integrin, and Cell adhesion modules.

### 4. Top Region-Specific LR Pairs to TA Cells

**Top Duodenum-specific pairs** (by lr_means):

| Sender | Ligand | Receptor | Module | lr_means |
|--------|--------|----------|--------|----------|
| CLU+ reserve stem | App | Rpsa | Lipid signaling | 2.60 |
| CD8aa IEL | Gzma | Pard3 | Granzyme/cytotoxicity | 2.28 |
| CD8aa IEL | Gzma | F2rl1 | Granzyme/cytotoxicity | 2.06 |
| Activated/helper T | Hspa8 | Ldlr | Antigen presentation | 1.96 |
| Activated/helper T | B2m | Tfrc | Antigen presentation | 1.92 |
| Fibroblasts | Dcn | Egfr | Lipid signaling | 1.85 |
| Macrophages | Psap | Lrp1 | PDGF signaling | 1.82 |
| Fibroblasts | Col1a1 | Cd44 | ECM–Integrin | 1.78 |
| Paneth cells | Wnt3 | Fzd5_Lrp6 | WNT signaling | 1.75 |
| CLU+ reserve stem | Cdh1 | Ptprm | Cell adhesion | 1.72 |

**Top Ileum-specific pairs** (by lr_means):

| Sender | Ligand | Receptor | Module | lr_means |
|--------|--------|----------|--------|----------|
| Macrophages | Psap | Celsr1 | PDGF signaling | 2.31 |
| Mid-villus EC | App | Rpsa | Lipid signaling | 1.89 |
| cDC1 | Psap | Celsr1 | PDGF signaling | 1.82 |
| Mid-villus EC | Guca2a | Gucy2c | Guanylate cyclase | 1.68 |
| Fibroblasts | Piga | Pigr | Other | 1.66 |
| Fibroblasts | Sfrp1 | Fzd2 | WNT signaling | 1.27 |
| Fibroblasts | Sfrp1 | Fzd6 | WNT signaling | 1.27 |
| Endothelial | Efna5 | Epha4 | Axon guidance | 0.74 |
| cDC1 | Wnt11 | Fzd2 | WNT signaling | 0.38 |
| cDC1 | Wnt11 | Fzd6 | WNT signaling | 0.37 |

### 5. Key Biological Findings

#### 5.1 Axon Guidance Signaling is Ileum-Biased

Axon guidance shows **+39 more significant LR pairs in Ileum TA cells** and **16 Ileum-unique LR combos** (0 Duodenum-unique). Key Ileum-specific pairs include:

- **Efna5→Epha4** (Endothelial→TA): Ephrin-A5 signaling
- **Efna1→Epha4** (Stem, TA→TA): Autocrine ephrin signaling
- **Efnb2→Epha4** (TA, Upper-villus EC→TA): Ephrin-B2 signaling
- **Fgfr3→Epha4** (Paneth, TA→TA): FGFR3-EphA4 cross-talk
- **Fgfr4→Epha4** (Goblet, TA→TA): FGFR4-EphA4 cross-talk

The presence of FGFR→EphA4 pairs suggests potential receptor cross-talk between FGF and ephrin signaling pathways in the Ileum TA compartment.

#### 5.2 WNT Signaling Uses Different LR Pairs Between Regions

WNT signaling has the most region-unique combos (44 total: 21 Duo-only, 23 Ile-only):

**Ileum-specific WNT pairs:**
- **Sfrp1→Fzd2/Fzd6** (Fibroblasts→TA): WNT antagonist signaling
- **Wnt11→Fzd2/Fzd6** (cDC1→TA): Non-canonical WNT11
- **Wnt5a→Fzd2/Fzd6/Epha7** (Fibroblasts→TA): Non-canonical WNT5A
- **Wnt4→Fzd2_Lrp5/Lrp6** (Fibroblasts→TA): WNT4 signaling

**Duodenum-specific WNT pairs:**
- **Wnt3→Fzd5_Lrp6** (Paneth cells→TA): Canonical WNT3
- **Wnt6→Fzd7_Lrp6** (Paneth cells→TA): Canonical WNT6
- **Cthrc1→Fzd5/Ror2** (Enteroendocrine→TA): WNT/PCP modulator

Similar to Stem cells, **Ileum TA cells receive more non-canonical WNT signaling** while **Duodenum TA cells receive more canonical WNT from Paneth cells**.

#### 5.3 VEGF, ECM, and Cell Adhesion are Duodenum-Biased

TA cells show stronger Duodenum bias than Stem cells in several modules:

- **VEGF signaling**: -32 pairs (Duo-biased)
- **Lipid signaling**: -41 pairs (Duo-biased)
- **Cell adhesion**: -30 pairs (Duo-biased)
- **ECM–Integrin**: -21 pairs (Duo-biased)

Key Duodenum-specific pairs:
- **Cdh1→Ptprm** (CLU+ reserve stem→TA): E-cadherin adhesion
- **Col1a1→Cd44** (Fibroblasts→TA): Collagen-CD44 signaling
- **Vegfa→Itgb1/Ephb2** (CLU+ reserve stem, Enteroendocrine→TA): VEGF signaling

This suggests stronger adhesive, angiogenic, and ECM signaling in the duodenal TA compartment, potentially supporting the higher proliferative capacity of duodenal TA cells.

#### 5.4 Granzyme/Cytotoxicity Signaling is Duodenum-Specific

Granzyme A (Gzma) signaling from CD8aa IELs to Pard3 and F2rl1 on TA cells is among the strongest Duodenum-specific interactions (lr_means ~2.0-2.3), similar to Stem cells.

#### 5.5 Guanylate Cyclase Signaling is Ileum-Enriched

**Guca2a→Gucy2c** (Mid-villus enterocytes→TA) is a strong Ileum-specific pair (lr_means = 1.68), consistent with the role of GUCY2C in distal intestinal physiology.

#### 5.6 Retinoic Acid Signaling is Duodenum-Biased

Retinoic acid signaling shows **-15 pairs in Ileum** (Duodenum-biased), with **21 Duodenum-unique** vs **6 Ileum-unique** LR combos. Key Duodenum-specific pairs include:

- **Ybx1→Notch1** (CLU+ reserve stem, Stem cells→TA): Y-box binding protein 1 to Notch1 (lr_means = 1.24)
- **Bsg→Slc16a1** (CLU+ reserve stem, Enteroendocrine, Fibroblasts→TA): Basigin to monocarboxylate transporter 1 (lr_means = 1.18)
- **Apoc2→Lrp1** (Mid-villus EC→TA): Apolipoprotein C2 to LRP1 (lr_means = 0.78)
- **Angptl4→Sdc4** (Macrophages, TA/early prog.→TA): Angiopoietin-like 4 to syndecan-4 (lr_means = 0.70)

Ileum-specific pairs include:
- **Ybx1→Notch1** (TA/early prog.→TA): Same ligand-receptor but different sender (lr_means = 1.32)
- **Lpl→Cd44** (Fibroblasts→TA): Lipoprotein lipase to CD44 (lr_means = 0.63)

**Note**: Similar to Stem cells, the "Retinoic acid" module primarily captures **metabolic and lipid-related signaling** rather than canonical retinoic acid ligands. The Duodenum bias suggests stronger metabolic/lipid signaling in the proximal intestine TA compartment.

#### 5.7 Cell Cycle/Proliferation Signaling is Similar Between Regions

Cell cycle/proliferation shows **+4 pairs in Ileum** (similar), with **46 Ileum-unique** vs **42 Duodenum-unique** LR combos. Key Ileum-specific pairs include:

- **Mif→Cd44_Cd74** (TA cells→TA): Macrophage migration inhibitory factor to CD44/CD74 (lr_means = 1.16)
- **Mdk→Ncl** (Macrophages, Plasmablasts→TA): Midkine to nucleolin (lr_means = 1.01)
- **Lamc1→Cd44** (Endothelial→TA): Laminin to CD44 (lr_means = 0.80)

Duodenum-specific pairs include:
- **Mdk→Ncl** (Endothelial→TA): Same ligand-receptor but different sender (lr_means = 1.07)
- **Lamc1/Lamc2/Lamb3/Lama3→Dag1** (CLU+ reserve stem→TA): Laminins to dystroglycan (lr_means = 0.89)
- **Sema4g→Plxnb2** (CLU+ reserve stem→TA): Semaphorin 4G to plexin-B2 (lr_means = 0.80)

**Key insight**: Unlike Stem cells (which show Ileum bias), TA cells show similar cell cycle/proliferation signaling between regions. The Duodenum-specific pairs involve more **laminin-dystroglycan** adhesion signaling from CLU+ reserve stem cells, while Ileum-specific pairs involve more **MIF→CD44/CD74** autocrine signaling.

#### 5.8 EGFR Signaling Shows Regional Differences in Ligand Usage

EGFR signaling is slightly Duodenum-biased (-9 pairs), with **34 Ileum-unique** vs **43 Duodenum-unique** LR combos. The regions use different EGFR ligands and receptors:

**Ileum-specific pairs:**
- **Hbegf→Cd9** (Upper-villus EC, Fibroblasts, Mid-villus EC, Goblet→TA): HB-EGF to CD9 (lr_means = 0.86)
- **Hbegf→Cd44** (Upper-villus EC→TA): HB-EGF to CD44 (lr_means = 0.69)
- **Hbegf→Prlr** (Mid-villus EC, Plasmablasts→TA): HB-EGF to prolactin receptor (lr_means = 0.55)

**Duodenum-specific pairs:**
- **Hbegf→Prlr** (CLU+ reserve stem, Enteroendocrine, T helper→TA): HB-EGF to prolactin receptor (lr_means = 0.71)
- **Ereg→Erbb3** (Endothelial→TA): Epiregulin to ERBB3 (lr_means = 0.68)
- **Tgfa→Erbb3** (CLU+ reserve stem→TA): TGF-α to ERBB3 (lr_means = 0.57)
- **Btc→Erbb3** (CLU+ reserve stem→TA): Betacellulin to ERBB3 (lr_means = 0.54)

**Key insight**: Similar to Stem cells, Ileum TA cells receive more **HB-EGF from upper-villus enterocytes** via CD9/CD44, while Duodenum TA cells receive more **diverse EGFR ligands** (Ereg, Tgfa, Btc) from CLU+ reserve stem cells and endothelial cells via ERBB3.

#### 5.9 FGF Signaling is Ileum-Biased

FGF signaling shows **+29 pairs in Ileum**, with **10 Ileum-unique** vs **3 Duodenum-unique** LR combos. Key Ileum-specific pairs include:

- **Fgf2→Fgfr2** (Fibroblasts→TA): FGF2 to FGFR2 (lr_means = 0.45)
- **Fgf10→Fgfr2** (Fibroblasts→TA): FGF10 to FGFR2 (lr_means = 0.38)
- **Fgf7→Fgfr2** (Fibroblasts→TA): FGF7 to FGFR2 (lr_means = 0.35)

**Key insight**: Similar to Stem cells, the Ileum bias is driven by **FGF2, FGF10, and FGF7 from fibroblasts** signaling to FGFR2 on TA cells.

#### 5.10 Hedgehog Signaling is Ileum-Biased

Hedgehog signaling shows **+10 pairs in Ileum**, with **1 Ileum-unique** vs **0 Duodenum-unique** LR combos. The key Ileum-specific pair is:

- **Ihh→Ptch1** (TA cells→TA): Indian hedgehog to Patched-1 (lr_means = 0.42)

**Key insight**: Similar to Stem cells, IHH from epithelial cells signals to Ptch1 on TA cells. The Ileum bias suggests stronger hedgehog pathway activity in the distal intestine TA compartment.

#### 5.11 TGFβ Signaling is Duodenum-Biased

TGFβ signaling shows **-20 pairs in Ileum** (Duodenum-biased), with **20 Duodenum-unique** vs **0 Ileum-unique** LR combos. Key Duodenum-specific pairs include:

- **Tgfb1→Lpp** (T helper, CD8aa IEL→TA): TGF-β1 to LPP (lr_means = 0.90)
- **Tgfb1→Itgb1** (Plasmablasts→TA): TGF-β1 to integrin β1 (lr_means = 0.82)
- **Tgfb1→Itgav_Itgb6** (Plasmablasts→TA): TGF-β1 to integrin αVβ6 (lr_means = 0.60)
- **Tgfb1→Tgfbr1_Tgfbr2** (Plasmablasts→TA): Canonical TGF-β receptor (lr_means = 0.60)

**Key insight**: The Duodenum bias is driven by **TGF-β1 from immune cells** (T helper, CD8aa IEL, plasmablasts). TGF-β signaling is generally inhibitory to proliferation and promotes differentiation. The stronger TGF-β signaling in Duodenum may contribute to regional differences in TA cell differentiation rates.

#### 5.12 Notch Signaling is Duodenum-Biased

Notch signaling shows **-11 pairs in Ileum** (Duodenum-biased), with **12 Duodenum-unique** vs **1 Ileum-unique** LR combos. Key Duodenum-specific pairs include:

- **Dll4→Notch1/Notch2** (Enteroendocrine→TA): Delta-like 4 to Notch1/2 (lr_means = 0.45)
- **Dll1→Notch1/Notch2** (Paneth cells→TA): Delta-like 1 to Notch1/2 (lr_means = 0.27)
- **Dll4→Notch1/Notch2** (Paneth cells→TA): Delta-like 4 to Notch1/2 (lr_means = 0.27)
- **Jag1→Notch1** (Endothelial→TA): Jagged 1 to Notch1 (lr_means = 0.20)

Ileum-specific pair:
- **Jag2→Notch1** (Enteroendocrine→TA): Jagged 2 to Notch1 (lr_means = 0.29)

**Key insight**: Similar to Stem cells, the Duodenum bias is driven by **DLL1/DLL4 from Paneth cells and enteroendocrine cells** signaling to Notch1/Notch2 on TA cells. Notch signaling regulates TA cell proliferation and differentiation.

#### 5.13 Chemokine Signaling is Duodenum-Biased

Chemokine signaling shows **-22 pairs in Ileum** (Duodenum-biased), with **25 Duodenum-unique** vs **3 Ileum-unique** LR combos. Key Duodenum-specific pairs include:

- **Calr→Lrp1/Itgav/Itga3** (Macrophages, Fibroblasts, cDC1, TA→TA): Calreticulin to LRP1/integrins (lr_means = 1.29)
- **Fbln1→Itgb1** (Endothelial, Upper-villus EC→TA): Fibulin-1 to integrin β1 (lr_means = 0.68)

Ileum-specific pairs include:
- **Calr→Itga3/Itgav** (Goblet cells→TA): Calreticulin from goblet cells (lr_means = 1.19)

**Key insight**: Similar to Stem cells, the Duodenum bias is driven by **calreticulin (CALR) from macrophages, fibroblasts, and cDC1** signaling to integrins on TA cells.

#### 5.14 Interferon Signaling is Duodenum-Biased

Interferon signaling shows **-15 pairs in Ileum** (Duodenum-biased), with **22 Duodenum-unique** vs **7 Ileum-unique** LR combos. Key Duodenum-specific pairs include:

- **Cxcl10→Sdc4** (Endothelial, T helper, cDC1→TA): CXCL10 to syndecan-4 (lr_means = 0.88)
- **Spon2→Itgb1** (Endothelial→TA): Spondin-2 to integrin β1 (lr_means = 0.60)
- **Efnb2→Ephb2** (Endothelial, CLU+ reserve stem→TA): Ephrin-B2 to EphB2 (lr_means = 0.60)

Ileum-specific pairs include:
- **Cxcl10→Sdc4** (Macrophages→TA): CXCL10 from macrophages (lr_means = 0.79)
- **Efnb2→Ephb2/Ephb4** (cDC1→TA): Ephrin-B2 from dendritic cells (lr_means = 0.37)

**Key insight**: Similar to Stem cells, the Duodenum bias is driven by **CXCL10 from endothelial cells and T helper cells** signaling to syndecan-4 on TA cells.

### 6. Conserved Interactions Between Regions

Many LR pairs are **significant in both regions**, representing core niche signals for TA cells.

#### 6.1 WNT Signaling — Conserved Core

**Conserved WNT pairs** include Wnt3 from enteroendocrine and Paneth cells (canonical WNT), Wnt5a from fibroblasts (non-canonical WNT), and Dkk2 from fibroblasts (WNT antagonist). These are similar to the conserved core for Stem cells.

#### 6.2 BMP Signaling — Conserved Core

**Conserved BMP pairs** include Bmp4 from fibroblasts (to RGMB, LRP6, BMPR1A/BMPR2) and Bmp7 from Paneth cells and TA cells. These are similar to the conserved core for Stem cells.

#### 6.3 Notch Signaling — Conserved Core

**Conserved Notch pairs** include Dll4 from enteroendocrine and endothelial cells, Dll1 from goblet cells, and Jag2 from cDC1. These are similar to the conserved core for Stem cells.

#### 6.4 EGFR Signaling — Conserved Core

**Conserved EGFR pairs** include Ereg from fibroblasts (to ERBB3 and EGFR/ERBB2) and Hbegf from multiple cell types (to PRLR). These are similar to the conserved core for Stem cells.

#### 6.5 FGF Signaling — Conserved Core

**Conserved FGF pairs** include Fgf14 from enteroendocrine, goblet, and TA cells, and Fgf2/Fgf10 from fibroblasts (all to FGFR2). These are similar to the conserved core for Stem cells.

#### 6.6 Hedgehog Signaling — Conserved Core

**Conserved Hedgehog pairs** include Ihh from epithelial cells (upper-villus EC, TA, goblet) to Ptch1/Smo. These are similar to the conserved core for Stem cells.

#### 6.7 TGFβ Signaling — Conserved Core

**Conserved TGFβ pairs** include Tgfb1 from immune cells (cDC1, macrophages, plasmablasts, T helper) to multiple receptors (LPP, ITGB1, EGFR, SDC2). These are similar to the conserved core for Stem cells.

#### 6.8 Axon Guidance — Conserved Core

**Conserved axon guidance pairs** include Efnb1 from multiple epithelial cell types (to EPHB2) and Sema4d from CD8aa IELs (to PLXNB2 and MET). These are similar to the conserved core for Stem cells.

#### 6.9 Cell Cycle/Proliferation — Conserved Core

**Conserved cell cycle pairs** include laminins (LAMA2, LAMC1, LAMB1) and fibronectin (FN1) from fibroblasts (to DAG1, CD44, integrins), and Mdk from fibroblasts and TA cells (to NCL). These are similar to the conserved core for Stem cells.

#### 6.10 Retinoic Acid — Conserved Core

**Conserved retinoic acid pairs** include collagens (COL4A1, COL6A1) and laminins (LAMA1, LAMA2) from fibroblasts (to integrins, CD44, syndecans). These are similar to the conserved core for Stem cells.

### 7. Sender Contributions to TA Cells

**Fibroblasts**: Dominant sender of ECM/integrin (Col1a1), lipid signaling (App, Dcn), WNT modulators (Sfrp1), and VEGF. Also contribute ephrins (Efna2) and FGF ligands.

**Endothelial cells**: Major source of VEGF, Sfrp1, and Efna5. Also contribute Psap and chemokines.

**Immune cells** (Macrophages, cDC1, CD8aa IEL, T helper, Plasmablasts): Diverse signaling including antigen presentation (B2m, Hspa8), granzyme/cytotoxicity (Gzma), ephrins (Efnb3, Sema4d), Psap, and Wnt11.

**Epithelial cells** (Paneth, Goblet, enterocytes, enteroendocrine, TA/early progenitors, CLU+ reserve stem): Autocrine and paracrine signaling including WNT ligands (Wnt3, Wnt6 from Paneth), guanylate cyclase (Guca2a/b), cell adhesion (Cdh1), and App.

## Conclusions

1. **Axon guidance signaling is Ileum-biased in TA cells**, though less pronounced than in Stem cells. The presence of FGFR→EphA4 pairs suggests potential FGF-ephrin pathway cross-talk in the Ileum TA compartment.

2. **WNT signaling uses different ligand→receptor pairs between regions**: Ileum TA cells receive more non-canonical WNT (Wnt5a, Wnt11, Wnt4) and WNT modulation (Sfrp1), while Duodenum TA cells receive more canonical WNT (Wnt3, Wnt6) from Paneth cells.

3. **VEGF, ECM–Integrin, Cell adhesion, and Lipid signaling are more strongly Duodenum-biased in TA cells** compared to Stem cells, suggesting stronger proliferative, angiogenic, and adhesive support in the duodenal TA compartment.

4. **Granzyme/cytotoxicity signaling from CD8aa IELs** is Duodenum-specific, suggesting enhanced immune surveillance in the proximal intestine.

5. **Guanylate cyclase signaling (GUCY2C)** is Ileum-enriched, consistent with its role in distal intestinal fluid and electrolyte homeostasis.

6. **Retinoic acid signaling is Duodenum-biased**, driven by metabolic/lipid-related signaling (Ybx1, Bsg, Apoc2, Angptl4) rather than canonical retinoic acid ligands.

7. **Cell cycle/proliferation signaling is similar between regions** in TA cells (unlike Stem cells which show Ileum bias), with Duodenum using more laminin-dystroglycan adhesion and Ileum using more MIF→CD44/CD74 autocrine signaling.

8. **EGFR signaling shows regional differences in ligand usage**: Ileum uses more HB-EGF→CD9/CD44, while Duodenum uses more diverse ligands (Ereg, Tgfa, Btc)→ERBB3.

9. **FGF signaling is Ileum-biased**, driven by FGF2, FGF10, and FGF7 from fibroblasts to FGFR2.

10. **Hedgehog signaling is Ileum-biased**, driven by IHH→PTCH1 autocrine signaling.

11. **TGFβ signaling is Duodenum-biased**, driven by TGF-β1 from immune cells (T helper, CD8aa IEL, plasmablasts).

12. **Notch signaling is Duodenum-biased**, driven by DLL1/DLL4 from Paneth cells and enteroendocrine cells.

13. **Chemokine signaling is Duodenum-biased**, driven by calreticulin (CALR) from macrophages, fibroblasts, and cDC1.

14. **Interferon signaling is Duodenum-biased**, driven by CXCL10 from endothelial cells and T helper cells.

15. **Conserved core interactions**: Many LR pairs are significant in both regions, representing core niche signals. These include Wnt3/Dkk2 (WNT), Bmp4/Bmp7 (BMP), Dll4/Jag2 (Notch), Ereg/Hbegf (EGFR), Fgf2/Fgf14 (FGF), Ihh (Hedgehog), Tgfb1 (TGFβ), Efnb1/Sema4d (axon guidance), and laminins/collagens (ECM). These conserved interactions suggest that the fundamental architecture of the intestinal TA cell niche is maintained regardless of region, with regional differences layered on top.

## Comparison with Stem Cells

| Feature | Stem Cells | TA Cells |
|---------|-----------|----------|
| Axon guidance bias | +73 (strongly Ileum) | +39 (Ileum) |
| WNT signaling bias | +20 (Ileum) | +13 (Ileum) |
| VEGF bias | -17 (Duo) | -32 (strongly Duo) |
| Cell adhesion bias | -17 (Duo) | -30 (strongly Duo) |
| Lipid signaling bias | +3 (similar) | -41 (strongly Duo) |
| ECM–Integrin bias | +4 (similar) | -21 (Duo) |

**Key insight**: TA cells show stronger Duodenum bias in proliferative/angiogenic/adhesive modules, while Stem cells show stronger Ileum bias in axon guidance and WNT signaling. This suggests that the duodenal niche provides stronger proliferative support to TA cells, while the ileal niche provides stronger positional/identity cues to stem cells.

## Files Generated

**Summary tables:**
- `summary_module_ta_cells_fixed.csv` — Module × region summary
- `top_duo_specific_ta_cells_fixed.csv` — Top Duodenum-specific pairs
- `top_ile_specific_ta_cells_fixed.csv` — Top Ileum-specific pairs
- `region_unique_modules_ta_cells_fixed.csv` — Region-unique combos by module

**Figures:**
- `circle_plots_individual_senders_ta/` — 29 chord diagrams (15 senders × 2 regions, TA cells receiver)
