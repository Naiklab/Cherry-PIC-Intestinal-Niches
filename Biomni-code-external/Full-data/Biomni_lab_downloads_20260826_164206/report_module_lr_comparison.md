# Module-by-Module Comparison of Region-Unique LR Pairs: Duodenum vs Ileum

## Overview

This report compares which specific ligand→receptor (LR) combinations are used within each shared signaling module between duodenum and ileum. A "region-unique LR combo" is a ligand→receptor pair that is statistically significant (CellPhoneDB p < 0.05) in one region but not the other, even though the module as a whole is active in both regions.

**Key finding**: Of 28 modules, 24 use substantially different LR pairs between regions. Only 4 modules (Complement, Guanylate cyclase, Muc2-Agr2, Interferon) use identical LR pairs in both regions.

**Data**: 215 region-unique LR combos (100 Duodenum-only, 115 Ileum-only) across 24 modules.

---

## 1. BMP Signaling (28 region-unique combos: 10 Duo-only, 18 Ile-only)

BMP signaling shows the largest number of region-unique LR combos, with a striking asymmetry: Ileum-specific pairs are dominated by WNT/BMP modulators and non-canonical WNT ligands, while Duodenum-specific pairs involve TGFβ family members and BMP antagonists.

### Ileum-only LR combos (18)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Sfrp1 | Fzd2 | Fibroblasts, Endothelial | Stem cells | 1.27 |
| Sfrp1 | Fzd6 | Fibroblasts, Endothelial | Stem cells | 1.27 |
| Efna5 | Epha7 | Endothelial | TA cells | 0.74 |
| Wnt11 | Fzd2 | cDC1 | Stem cells | 0.38 |
| Wnt11 | Fzd6 | cDC1 | Stem cells | 0.37 |
| Wnt5a | Epha7 | Fibroblasts | TA cells | 0.25 |
| Fgf10 | Fgfrl1 | Fibroblasts | TA cells | 0.24 |
| Wnt5a | Fzd2 | Fibroblasts | TA cells | 0.23 |
| Wnt5a | Fzd6 | Fibroblasts | TA cells | 0.23 |
| Fgf2 | Fgfrl1 | Fibroblasts | TA cells | 0.22 |
| Gdf6 | Bmpr1a_Bmpr2 | Fibroblasts | Stem cells | 0.20 |
| Bmp8a | Bmpr1a_Bmpr2 | Goblet cells | Stem cells | 0.17 |
| Wnt4 | Fzd2_Lrp5 | Fibroblasts | TA cells | 0.15 |
| Wnt4 | Fzd2_Lrp6 | Fibroblasts | TA cells | 0.15 |
| Fgf1 | Fgfrl1 | Mid-villus EC | TA cells | 0.14 |
| Wnt4 | Fzd6_Lrp5 | Fibroblasts | TA cells | 0.14 |
| Wnt4 | Fzd6_Lrp6 | Fibroblasts | TA cells | 0.14 |
| Nr0b2 | Fgfrl1 | Upper-villus EC | TA cells | 0.10 |

### Duodenum-only LR combos (10)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Cthrc1 | Fzd5 | Enteroendocrine | Stem cells | 0.38 |
| Tgfb3 | Acvr1b_Tgfbr2 | Fibroblasts | Stem cells | 0.28 |
| Tgfb3 | Tgfbr1_Tgfbr2 | Fibroblasts | Stem cells | 0.28 |
| Gdf9 | Bmpr1a | Upper-villus EC | Stem cells | 0.23 |
| Fst | Bmpr2 | Fibroblasts | Stem cells | 0.14 |
| Cthrc1 | Ror2 | Enteroendocrine | TA cells | 0.12 |
| Gdf9 | Acvr1b_Bmpr2 | Upper-villus EC | Stem cells | 0.10 |
| Gdf9 | Acvr2a | Upper-villus EC | Stem cells | 0.09 |
| Inha | Acvr1 | Paneth cells | Stem cells | 0.07 |
| Gdf9 | Orai2 | Upper-villus EC | TA cells | 0.05 |

### Biological interpretation

The Ileum-specific BMP module is dominated by **WNT/BMP pathway modulators** rather than canonical BMP ligands. **Sfrp1→Fzd2/Fzd6** (secreted frizzled-related protein 1) is the strongest Ileum-specific pair (lr_means = 1.27), produced by fibroblasts and endothelial cells and received by stem cells. Sfrp1 is a WNT antagonist that also modulates BMP signaling; its enrichment in Ileum is consistent with the known role of mesenchymal Sfrp1 in shaping the intestinal BMP gradient [19, 20]. **Wnt11→Fzd2/Fzd6** from cDC1 and **Wnt5a→Fzd2/Fzd6/Epha7** from fibroblasts represent non-canonical WNT signaling that intersects with BMP pathway regulation. **Wnt4→Fzd_Lrp5/6** complexes further support non-canonical WNT involvement in the Ileum stem cell niche.

In contrast, the Duodenum-specific BMP module features **TGFβ3→Acvr1b/Tgfbr2** and **TGFβ3→Tgfbr1/Tgfbr2** from fibroblasts, representing canonical TGFβ signaling rather than BMP. **Gdf9→Bmpr1a/Acvr2a** from upper-villus enterocytes is a BMP family member but with a different receptor usage pattern than the Ileum-specific Gdf6→Bmpr1a_Bmpr2. **Fst→Bmpr2** (follistatin) is a BMP antagonist, suggesting more active BMP inhibition in the Duodenum stem cell niche. **Cthrc1→Fzd5/Ror2** from enteroendocrine cells is a WNT/PCP pathway modulator.

**Key insight**: The Ileum BMP module is enriched for WNT/BMP cross-talk (Sfrp1, Wnt11, Wnt5a, Wnt4), while the Duodenum BMP module is enriched for canonical TGFβ signaling and BMP antagonism (Fst). This suggests that the Ileum stem cell niche relies more on WNT/BMP pathway integration, while the Duodenum niche uses more direct TGFβ family signaling [17, 19, 20, 21].

---

## 2. Axon Guidance (17 region-unique combos: 0 Duo-only, 17 Ile-only)

Axon guidance is the most asymmetric module: all 17 region-unique combos are Ileum-specific. This module is dominated by ephrin→Eph receptor signaling.

### Ileum-only LR combos (17)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Efna5 | Epha4 | Fibroblasts, Endothelial | Stem cells | 0.77 |
| Sema4a | Plxnb1 | Stem cells, TA cells | Stem cells | 0.43 |
| Efna1 | Epha4 | Stem cells, TA cells | TA cells | 0.42 |
| Efna1 | Epha7 | Stem cells, Upper-villus EC | Stem cells | 0.39 |
| Efnb1 | Epha4 | Upper-villus EC | Stem cells | 0.37 |
| Sema4d | Plxnb1 | cDC1, CD8aa IEL, Plasmablasts | Stem cells | 0.36 |
| Efnb2 | Epha4 | TA cells, Upper-villus EC | TA cells | 0.33 |
| Efna4 | Epha4 | TA cells, Stem cells | Stem cells | 0.27 |
| Efna4 | Epha7 | TA cells/early prog. | TA cells | 0.23 |
| Efna2 | Epha4 | Fibroblasts | TA cells | 0.23 |
| Efna2 | Epha7 | Fibroblasts | TA cells | 0.19 |
| Fgfr3 | Epha4 | Paneth cells, TA cells | TA cells | 0.18 |
| Fgfr4 | Epha4 | Goblet cells, TA cells | TA cells | 0.18 |
| Efnb3 | Epha4 | cDC1 | TA cells | 0.13 |
| Efna3 | Epha4 | TA cells/early prog. | TA cells | 0.12 |
| Efna3 | Epha7 | TA cells, TA cells/early prog. | TA cells | 0.09 |
| Efnb3 | Rhbdl2 | cDC1 | TA cells | 0.07 |

### Biological interpretation

The Ileum-specific axon guidance module is entirely composed of **ephrin→Eph receptor** and **semaphorin→plexin** signaling. The dominant theme is **EphA4** as a receptor: 10 of 17 Ileum-specific combos target Epha4, with ligands including Efna5 (strongest, lr_means = 0.77), Efna1, Efnb1, Efnb2, Efna4, Efna2, Efnb3, and Efna3. This suggests that EphA4-mediated signaling is a hallmark of the Ileum stem cell niche.

Ephrin signaling is well-established in intestinal crypt architecture, where EphB/ephrin-B interactions regulate cell positioning along the crypt-villus axis [1, 2]. However, EphA4 is less studied in the intestine. EphA4 is known to regulate cell migration, axon guidance, and tissue boundary formation in other contexts [2, 4]. The enrichment of EphA4-targeting ephrins in Ileum suggests a role in maintaining the distinct crypt architecture or cell positioning in the distal intestine.

**Sema4d→Plxnb1** from immune cells (cDC1, CD8aa IEL, Plasmablasts) to stem cells represents neuroimmune semaphorin signaling. Sema4d is known to regulate T cell activation and immune cell migration [24, 25, 26]. Its presence in the Ileum stem cell niche suggests immune-epithelial cross-talk via semaphorin signaling, potentially related to the higher density of immune cells in the distal intestine.

**Sema4a→Plxnb1** from stem/TA cells to stem cells represents autocrine semaphorin signaling. Sema4a has been shown to stabilize regulatory T cells and modulate immune responses [25, 28].

**Key insight**: The Ileum stem cell niche is uniquely enriched for ephrin→EphA4 signaling from multiple cell types (fibroblasts, endothelial, epithelial, immune), suggesting that EphA4-mediated cell positioning and migration cues are more prominent in the distal intestine. This may reflect differences in crypt architecture, innervation patterns, or immune-epithelial interactions along the proximal-distal axis [1, 2, 7].

---

## 3. VEGF Signaling (17 region-unique combos: 13 Duo-only, 4 Ile-only)

VEGF signaling shows a strong Duodenum bias, with 13 Duo-only vs 4 Ile-only combos. The Duo-only pairs are dominated by ECM/integrin interactions, while the Ile-only pairs involve different laminin/collagen isoforms.

### Duodenum-only LR combos (13)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Lamc2 | Itga6_Itgb1 | CLU+ reserve stem | TA cells | 0.51 |
| Spp1 | Itgav_Itgb1 | CLU+ reserve stem | TA cells | 0.46 |
| Col13a1 | Itga1_Itgb1 | Endothelial | Stem cells | 0.28 |
| Col7a1 | Itga1_Itgb1 | Enteroendocrine | TA cells | 0.26 |
| Col6a6 | Itga1_Itgb1 | Enteroendocrine | Stem cells | 0.21 |
| Col13a1 | Itga2_Itgb1 | Endothelial | TA cells | 0.19 |
| Col7a1 | Itga2_Itgb1 | Enteroendocrine | Stem cells | 0.18 |
| Amh | Egfr | Enteroendocrine | Stem cells | 0.17 |
| Fgl1 | Egfr | Enteroendocrine | Stem cells | 0.17 |
| Chad | Itga2_Itgb1 | Activated/helper T | TA cells | 0.15 |
| Col6a6 | Itga3_Itgb1 | Enteroendocrine | TA cells | 0.13 |
| Col6a6 | Itga2_Itgb1 | Enteroendocrine | Stem cells | 0.12 |
| Csf2 | Sdc2 | Upper-villus EC | TA cells | 0.08 |

### Ileum-only LR combos (4)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Lama3 | Itga6_Itgb1 | Upper-villus EC | TA cells | 0.57 |
| Col19a1 | Itga1_Itgb1 | TA cells | Stem cells | 0.26 |
| Col19a1 | Itga2_Itgb1 | TA cells | Stem cells | 0.16 |
| Reln | Itga3_Itgb1 | Plasmablasts | TA cells | 0.11 |

### Biological interpretation

The Duodenum-specific VEGF module is dominated by **ECM→integrin** interactions rather than canonical VEGF ligands. **Lamc2→Itga6_Itgb1** (laminin γ2 to α6β1 integrin) from CLU+ reserve stem cells to TA cells is the strongest Duo-specific pair (lr_means = 0.51). Laminin-332 (containing Lamc2) is a key basement membrane component that regulates epithelial cell adhesion and migration. **Spp1→Itgav_Itgb1** (osteopontin) from CLU+ reserve stem cells is another strong Duo-specific pair, involved in cell adhesion and survival.

The Duo-specific module also features multiple **collagen→integrin** pairs: Col13a1, Col7a1, and Col6a6 from endothelial and enteroendocrine cells to Itga1/Itga2/Itga3_Itgb1 on stem/TA cells. These collagens provide structural support and signaling cues for the stem cell niche.

In contrast, the Ileum-specific VEGF module uses **Lama3→Itga6_Itgb1** (laminin α3) from upper-villus enterocytes instead of Lamc2, and **Col19a1→Itga1/Itga2_Itgb1** from TA cells instead of the Duo-specific collagens. **Reln→Itga3_Itgb1** (reelin) from plasmablasts is unique to Ileum.

**Key insight**: Both regions use ECM→integrin signaling within the VEGF module, but with different laminin and collagen isoforms. The Duodenum uses Lamc2, Spp1, and Col13a1/Col7a1/Col6a6, while the Ileum uses Lama3 and Col19a1. This suggests regional specialization of the basement membrane composition and ECM niche, potentially reflecting differences in mechanical properties or cell adhesion requirements along the proximal-distal axis.

---

## 4. Lipid Signaling & Transport (19 region-unique combos: 7 Duo-only, 12 Ile-only)

Lipid signaling shows a moderate Ileum bias, with 12 Ile-only vs 7 Duo-only combos. The Ile-only pairs are dominated by TNF and WNT signaling, while the Duo-only pairs involve WNT and chemokine signaling.

### Ileum-only LR combos (12)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Grn | Tnfrsf1b | Macrophages | TA cells | 1.25 |
| App | Dcc | Endothelial | TA cells | 0.95 |
| Ntn1 | Dcc | Fibroblasts, Endothelial | Stem cells | 0.54 |
| Tnf | Tnfrsf1a | Macrophages | Stem cells | 0.44 |
| Sostdc1 | Lrp4 | CD8aa IEL | Stem cells | 0.38 |
| Tnf | Tnfrsf1b | Macrophages | TA cells | 0.37 |
| Sostdc1 | Lrp6 | CD8aa IEL | Stem cells | 0.36 |
| Ntn4 | Dcc | TA cells, TA/early prog. | TA cells | 0.28 |
| Wnt3 | Fzd2_Lrp6 | Goblet cells | TA cells | 0.28 |
| Wnt3 | Fzd6_Lrp6 | Goblet cells | TA cells | 0.27 |
| Wnt9a | Fzd2_Lrp6 | Fibroblasts | TA cells | 0.15 |
| Wnt9a | Fzd6_Lrp6 | Fibroblasts | TA cells | 0.15 |

### Duodenum-only LR combos (7)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Wnt7b | Fzd5_Lrp6 | CLU+ reserve stem | Stem cells | 0.57 |
| Wnt7b | Fzd7_Lrp6 | CLU+ reserve stem | Stem cells | 0.45 |
| Cklf | Lrp6 | CD8aa IEL, cDC1 | TA cells | 0.37 |
| Wnt7a | Fzd7_Lrp6 | CLU+ reserve stem | TA cells | 0.11 |
| Tnfsf4 | Traf2 | Enteroendocrine | TA cells | 0.08 |
| Wnt9b | Fzd7_Lrp6 | Enteroendocrine | TA cells | 0.07 |
| Wnt6 | Fzd7_Lrp6 | Upper-villus EC | TA cells | 0.07 |

### Biological interpretation

The Ileum-specific lipid signaling module is dominated by **TNF→Tnfrsf1a/b** from macrophages and **Grn→Tnfrsf1b** (granulysin) from macrophages. Grn→Tnfrsf1b is the strongest Ileum-specific pair in this module (lr_means = 1.25). Granulysin is a cytolytic protein expressed by cytotoxic lymphocytes and NK cells; its receptor Tnfrsf1b (TNFR2) is involved in TNF signaling and immune regulation [43, 44, 47]. The enrichment of TNF signaling in Ileum is consistent with the higher immune cell density and inflammatory tone in the distal intestine.

**Ntn1→Dcc** (netrin-1) from fibroblasts and endothelial cells to stem cells is another strong Ileum-specific pair (lr_means = 0.54). Netrin-1/DCC signaling regulates cell migration and survival; in the intestine, DCC is known to direct progenitor cell integration and maintain epithelial turnover [38, 42]. **Ntn4→Dcc** from TA cells represents autocrine netrin signaling.

**Sostdc1→Lrp4/Lrp6** (sclerostin domain containing 1, also known as Wise or Ectodin) from CD8aa IEL to stem cells is a WNT antagonist that modulates LRP5/6 signaling [58, 61]. Its presence in Ileum suggests immune-mediated regulation of WNT signaling in the stem cell niche.

The Duodenum-specific lipid signaling module features **Wnt7b→Fzd5/7_Lrp6** from CLU+ reserve stem cells, representing canonical WNT signaling. **Cklf→Lrp6** (chemokine-like factor) from immune cells is a less well-characterized interaction.

**Key insight**: The Ileum lipid signaling module is enriched for TNF/immune signaling (Grn, Tnf) and netrin/DCC guidance cues, while the Duodenum module uses canonical WNT ligands (Wnt7b, Wnt7a, Wnt9b, Wnt6). This suggests that the Ileum niche integrates more immune and guidance signals, while the Duodenum niche relies more on canonical WNT signaling for stem cell maintenance.

---

## 5. FGF Signaling (13 region-unique combos: 10 Duo-only, 3 Ile-only)

FGF signaling shows a strong Duodenum bias, with 10 Duo-only vs 3 Ile-only combos. The Duo-only pairs feature Fgf7 and Fgf12, while the Ile-only pairs feature Fgf15.

### Duodenum-only LR combos (10)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Fgf7 | Fgfr2 | Fibroblasts | TA cells | 1.24 |
| Fgf12 | Fgfr2 | Enteroendocrine | Stem cells | 1.16 |
| Thbs1 | Lrp1 | Macrophages | TA cells | 0.90 |
| Thbs1 | Ptprj | Macrophages, Endothelial | Stem cells | 0.84 |
| Nmu | Adra2a | Enteroendocrine | TA cells | 0.15 |
| Fgf7 | Fgfr4 | Fibroblasts | Stem cells | 0.14 |
| Fgf7 | Fgfr3 | Fibroblasts | TA cells | 0.13 |
| Npb | Adra2a | Enteroendocrine | TA cells | 0.12 |
| Nmu | Grm7 | Enteroendocrine | TA cells | 0.07 |
| Npb | Grm7 | Enteroendocrine | TA cells | 0.04 |

### Ileum-only LR combos (3)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Fgf15 | Fgfr2 | Upper-villus EC | TA cells | 1.23 |
| Fgf15 | Fgfr4 | Upper-villus EC | Stem cells | 0.20 |
| Fgf15 | Fgfr3 | Upper-villus EC | TA cells | 0.16 |

### Biological interpretation

The Duodenum-specific FGF module is dominated by **Fgf7→Fgfr2** (keratinocyte growth factor) from fibroblasts to TA cells (lr_means = 1.24) and **Fgf12→Fgfr2** from enteroendocrine cells to stem cells (lr_means = 1.16). Fgf7 is a well-known mitogen for epithelial cells and plays a key role in intestinal wound repair and stem cell maintenance [13, 15]. Fgf12 is an intracellular FGF that modulates voltage-gated sodium channels and has less characterized extracellular signaling roles.

**Thbs1→Lrp1/Ptprj** (thrombospondin-1) from macrophages and endothelial cells is another strong Duo-specific pair. Thbs1 promotes intestinal mucosal wound repair by regulating cell migration and adhesion [29, 33]. Its enrichment in Duodenum suggests enhanced wound healing and repair signaling in the proximal intestine.

The Ileum-specific FGF module features **Fgf15→Fgfr2/Fgfr4/Fgfr3** from upper-villus enterocytes. Fgf15 (human FGF19 ortholog) is a hormone-like FGF produced by ileal enterocytes in response to bile acid signaling. It regulates bile acid synthesis, glucose metabolism, and intestinal epithelial proliferation [13, 14]. Fgf15 is specifically expressed in the ileum, making it a canonical marker of distal intestinal identity.

**Key insight**: The regional FGF switch is one of the most striking findings: **Fgf7/Fgf12 in Duodenum vs Fgf15 in Ileum**. Fgf7 is a paracrine mitogen from fibroblasts, while Fgf15 is an endocrine hormone from ileal enterocytes. This reflects the fundamental functional difference between the proximal intestine (nutrient absorption, high turnover) and distal intestine (bile acid recycling, metabolic regulation) [13, 14].

---

## 6. Cell Adhesion & Junctions (10 region-unique combos: 7 Duo-only, 3 Ile-only)

### Duodenum-only LR combos (7)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Cx3cl1 | Itgav | CLU+ reserve stem | TA cells | 0.42 |
| Vegfa | Tyro3 | Upper-villus EC | TA cells | 0.39 |
| Mfng | Notch1 | CD8aa IEL, Enteroendocrine | Stem cells | 0.30 |
| Dll3 | Notch1 | Paneth cells | Stem cells | 0.23 |
| Mfng | Notch2 | CD8aa IEL | Stem cells | 0.22 |
| Fndc5 | Itgav | cDC1 | Stem cells | 0.20 |
| Dll3 | Notch2 | Paneth cells | Stem cells | 0.16 |

### Ileum-only LR combos (3)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Adam10 | Tspan5 | Plasmablasts, TA cells | Stem cells | 0.40 |
| Bdnf | Sort1 | Enteroendocrine | Stem cells | 0.40 |
| Vegfa | Grin2b | Stem cells, TA cells | TA cells | 0.26 |

### Biological interpretation

The Duodenum-specific cell adhesion module features **Cx3cl1→Itgav** (fractalkine) from CLU+ reserve stem cells to TA cells. Cx3cl1 is a chemokine that also functions as an adhesion molecule, regulating immune cell recruitment and epithelial integrity. **Mfng→Notch1/Notch2** (manic fringe) from immune and enteroendocrine cells modulates Notch signaling, which is critical for stem cell fate decisions. **Dll3→Notch1/Notch2** from Paneth cells is a Notch ligand that regulates stem cell differentiation.

The Ileum-specific cell adhesion module features **Adam10→Tspan5** (a disintegrin and metalloproteinase 10) from plasmablasts and TA cells to stem cells. Adam10 is a sheddase that cleaves Notch ligands and other cell surface proteins, regulating Notch signaling and cell adhesion. **Bdnf→Sort1** (brain-derived neurotrophic factor to sortilin) from enteroendocrine cells to stem cells represents neurotrophin signaling in the gut. BDNF is expressed in the GI tract and modulates motility, secretion, and mucosal integrity [68, 70].

**Key insight**: The Duodenum uses Notch-modulating adhesion signals (Mfng, Dll3) and chemokine adhesion (Cx3cl1), while the Ileum uses neurotrophin signaling (Bdnf) and Adam10-mediated shedding. This suggests that the proximal niche relies more on Notch-mediated cell fate decisions, while the distal niche integrates neurotrophin and proteolytic regulation.

---

## 7. IGF Signaling (10 region-unique combos: 3 Duo-only, 7 Ile-only)

### Duodenum-only LR combos (3)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Hsp90b1 | Lrp1 | Macrophages, Endothelial | TA cells | 1.50 |
| Ltf | Tfrc | CLU+ reserve stem | Stem cells | 0.50 |
| Spp1 | Itgav_Itgb6 | CLU+ reserve stem | TA cells | 0.46 |

### Ileum-only LR combos (7)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Hsp90b1 | Tlr1 | Goblet cells, TA cells | TA cells | 1.23 |
| Fn1 | Cd79a | Fibroblasts, TA cells | TA cells | 0.87 |
| Vcan | Tlr1 | Endothelial | TA cells | 0.79 |
| Trf | Hfe | Macrophages | TA cells | 0.77 |
| Tnr | Itgav_Itgb6 | Enteroendocrine | Stem cells | 0.40 |
| Bdnf | Erbb2 | Enteroendocrine | Stem cells | 0.25 |
| Nrg2 | Erbb2_Erbb4 | cDC1 | Stem cells | 0.11 |

### Biological interpretation

The Duodenum-specific IGF module features **Hsp90b1→Lrp1** (heat shock protein 90 beta 1 to LDL receptor-related protein 1) from macrophages and endothelial cells to TA cells (lr_means = 1.50). Hsp90b1 (also known as gp96) is an endoplasmic reticulum chaperone that can signal through Lrp1 to regulate cell survival and immune responses. **Ltf→Tfrc** (lactoferrin to transferrin receptor) from CLU+ reserve stem cells represents iron metabolism signaling.

The Ileum-specific IGF module features **Hsp90b1→Tlr1** instead of Hsp90b1→Lrp1, suggesting a switch from Lrp1-mediated survival signaling to Tlr1-mediated immune signaling. **Fn1→Cd79a** (fibronectin to CD79a) from fibroblasts and TA cells is an unusual interaction; CD79a is typically a B-cell receptor component, suggesting potential B-cell/epithelial cross-talk. **Trf→Hfe** (transferrin to HFE) from macrophages represents iron homeostasis signaling. **Bdnf→Erbb2** and **Nrg2→Erbb2_Erbb4** from enteroendocrine cells and cDC1 represent neurotrophin and neuregulin signaling in the Ileum niche.

**Key insight**: The Ileum IGF module integrates more immune (Tlr1, Cd79a) and neurotrophin (Bdnf, Nrg2) signals, while the Duodenum module uses Lrp1-mediated survival and iron metabolism (Ltf) signaling. This reflects the higher immune and neural density in the distal intestine.

---

## 8. Apoptosis / Cell Survival (21 region-unique combos: 11 Duo-only, 10 Ile-only)

### Duodenum-only LR combos (11)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Mmp9 | Lrp1 | Macrophages | TA cells | 0.87 |
| Spp1 | Cd44 | CLU+ reserve stem | Stem cells | 0.73 |
| Wnt7b | Fzd5_Lrp5 | CLU+ reserve stem | TA cells | 0.54 |
| Hgf | Itgb1 | Fibroblasts | Stem cells | 0.51 |
| Wnt7b | Fzd7_Lrp5 | CLU+ reserve stem | Stem cells | 0.45 |
| Wnt7a | Fzd5_Lrp5 | CLU+ reserve stem | Stem cells | 0.19 |
| Wnt9b | Fzd5_Lrp5 | Enteroendocrine | Stem cells | 0.16 |
| Wnt6 | Fzd5_Lrp5 | Upper-villus EC | Stem cells | 0.16 |
| Wnt7a | Fzd7_Lrp5 | CLU+ reserve stem | TA cells | 0.11 |
| Wnt9b | Fzd7_Lrp5 | Enteroendocrine | TA cells | 0.07 |
| Wnt6 | Fzd7_Lrp5 | Upper-villus EC | TA cells | 0.07 |

### Ileum-only LR combos (10)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Psen1 | Cd44 | Upper-villus EC | Stem cells | 0.80 |
| Lama3 | Cd44 | Upper-villus EC | Stem cells | 0.80 |
| Col4a5 | Cd44 | Fibroblasts, TA cells | Stem cells | 0.72 |
| Col4a6 | Cd44 | Fibroblasts | Stem cells | 0.67 |
| Sostdc1 | Lrp5 | CD8aa IEL | Stem cells | 0.33 |
| Wnt3 | Fzd2_Lrp5 | Goblet cells | TA cells | 0.28 |
| Slit2 | Dcc | TA cells, Goblet cells | TA cells | 0.28 |
| Wnt3 | Fzd6_Lrp5 | Goblet cells | TA cells | 0.27 |
| Wnt9a | Fzd2_Lrp5 | Fibroblasts | TA cells | 0.15 |
| Wnt9a | Fzd6_Lrp5 | Fibroblasts | TA cells | 0.15 |

### Biological interpretation

The Duodenum-specific apoptosis module features **Mmp9→Lrp1** (matrix metalloproteinase 9) from macrophages to TA cells (lr_means = 0.87). Mmp9 is involved in ECM remodeling and wound healing; its signaling through Lrp1 regulates cell survival and migration. **Spp1→Cd44** (osteopontin to CD44) from CLU+ reserve stem cells to stem cells is another strong Duo-specific pair, involved in cell adhesion and survival. **Hgf→Itgb1** (hepatocyte growth factor) from fibroblasts to stem cells promotes cell survival and proliferation.

The Duodenum module also features multiple **Wnt→Fzd_Lrp5** pairs (Wnt7b, Wnt7a, Wnt9b, Wnt6) from CLU+ reserve stem cells and enteroendocrine cells, representing canonical WNT signaling for stem cell maintenance.

The Ileum-specific apoptosis module features **Psen1→Cd44** (presenilin 1) from upper-villus enterocytes to stem cells (lr_means = 0.80). Psen1 is a component of the γ-secretase complex that cleaves Notch and other substrates; its signaling through CD44 may regulate stem cell survival. **Lama3→Cd44** and **Col4a5/Col4a6→Cd44** from fibroblasts and epithelial cells represent ECM→CD44 signaling for cell adhesion and survival. **Slit2→Dcc** from TA cells and goblet cells represents axon guidance cue signaling for cell positioning.

**Key insight**: The Duodenum apoptosis module uses Mmp9/Lrp1 and canonical WNT signaling for cell survival, while the Ileum module uses Psen1/CD44 and ECM→CD44 interactions. This suggests different mechanisms of stem cell survival regulation: protease-mediated in the proximal intestine vs. γ-secretase/ECM-mediated in the distal intestine.

---

## 9. ECM–Integrin (8 region-unique combos: 7 Duo-only, 1 Ile-only)

### Duodenum-only LR combos (7)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Col4a2 | Itga1_Itgb1 | Fibroblasts, Endothelial | Stem cells | 0.45 |
| Col4a2 | Itga2_Itgb1 | Fibroblasts, Endothelial | Stem cells | 0.38 |
| Col4a1 | Itga1_Itgb1 | Fibroblasts, Endothelial | Stem cells | 0.35 |
| Col4a1 | Itga2_Itgb1 | Fibroblasts, Endothelial | Stem cells | 0.32 |
| Lama4 | Itga1_Itgb1 | Endothelial | Stem cells | 0.28 |
| Lama4 | Itga2_Itgb1 | Endothelial | Stem cells | 0.25 |
| Fn1 | Itga5_Itgb1 | Fibroblasts | Stem cells | 0.22 |

### Ileum-only LR combos (1)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Col4a5 | Itga1_Itgb1 | Fibroblasts | Stem cells | 0.28 |

### Biological interpretation

The Duodenum-specific ECM module features **Col4a2→Itga1/Itga2_Itgb1** and **Col4a1→Itga1/Itga2_Itgb1** (collagen IV α1/α2) from fibroblasts and endothelial cells to stem cells. Collagen IV is the major component of basement membranes; these interactions provide structural support and signaling for the stem cell niche. **Lama4→Itga1/Itga2_Itgb1** (laminin α4) from endothelial cells and **Fn1→Itga5_Itgb1** (fibronectin) from fibroblasts are additional ECM→integrin pairs.

The Ileum-specific ECM module uses **Col4a5→Itga1_Itgb1** (collagen IV α5) instead of Col4a1/Col4a2. Col4a5 is a different collagen IV isoform that forms distinct basement membrane networks.

**Key insight**: Both regions use collagen IV→integrin signaling, but with different collagen IV isoforms: Col4a1/Col4a2 in Duodenum vs Col4a5 in Ileum. This suggests regional specialization of basement membrane composition, potentially reflecting differences in mechanical properties or cell adhesion requirements.

---

## 10. Retinoic Acid Signaling (7 region-unique combos: 5 Duo-only, 2 Ile-only)

### Duodenum-only LR combos (5)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Rbp4 | Stra6 | Macrophages | Stem cells | 0.35 |
| Rbp4 | Lrp2 | Macrophages | Stem cells | 0.28 |
| Alb | Lrp2 | Macrophages | Stem cells | 0.22 |
| Ttr | Stra6 | Macrophages | Stem cells | 0.18 |
| Ttr | Lrp2 | Macrophages | Stem cells | 0.15 |

### Ileum-only LR combos (2)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Rbp4 | Rara | Macrophages | Stem cells | 0.25 |
| Rbp4 | Rarg | Macrophages | Stem cells | 0.20 |

### Biological interpretation

The Duodenum-specific retinoic acid module features **Rbp4→Stra6/Lrp2** (retinol-binding protein 4) from macrophages to stem cells. Stra6 is the canonical Rbp4 receptor that mediates retinol uptake; Lrp2 (megalin) is an endocytic receptor that also internalizes Rbp4. **Alb→Lrp2** (albumin) and **Ttr→Stra6/Lrp2** (transthyretin) from macrophages represent additional retinoid transport pathways.

The Ileum-specific retinoic acid module uses **Rbp4→Rara/Rarg** (retinoic acid receptors α/γ) instead of Stra6/Lrp2. This suggests a switch from retinol uptake (Stra6/Lrp2) to direct retinoic acid receptor signaling (Rara/Rarg).

**Key insight**: The Duodenum uses retinol transport and uptake pathways (Stra6, Lrp2), while the Ileum uses direct retinoic acid receptor signaling (Rara, Rarg). This may reflect differences in retinoid metabolism or signaling requirements along the proximal-distal axis.

---

## 11. Mitochondrial & Oxidative Metabolism (7 region-unique combos: 3 Duo-only, 4 Ile-only)

### Duodenum-only LR combos (3)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Cyba | Cybb | Macrophages | Stem cells | 0.28 |
| Ncf1 | Cybb | Macrophages | Stem cells | 0.25 |
| Ncf2 | Cybb | Macrophages | Stem cells | 0.22 |

### Ileum-only LR combos (4)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Cyba | Nox1 | Macrophages | Stem cells | 0.30 |
| Ncf1 | Nox1 | Macrophages | Stem cells | 0.28 |
| Ncf2 | Nox1 | Macrophages | Stem cells | 0.25 |
| Cyba | Nox2 | Macrophages | Stem cells | 0.22 |

### Biological interpretation

Both regions use NADPH oxidase components (Cyba, Ncf1, Ncf2) from macrophages, but with different catalytic subunits: **Cybb** (Nox2/gp91phox) in Duodenum vs **Nox1** and **Nox2** in Ileum. Nox1 is the predominant NADPH oxidase in intestinal epithelial cells and plays a role in host defense and wound healing. Nox2 is the phagocyte NADPH oxidase.

**Key insight**: The Ileum uses Nox1-containing NADPH oxidase complexes, consistent with the higher epithelial NADPH oxidase activity in the distal intestine for host defense against the denser microbial community.

---

## 12. PDGF Signaling (6 region-unique combos: 0 Duo-only, 6 Ile-only)

### Ileum-only LR combos (6)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Psap | Celsr1 | Macrophages, cDC1 | Stem cells | 2.32 |
| Psap | Celsr1 | Macrophages, cDC1 | TA cells | 2.31 |
| Psap | Gpr37l1 | Macrophages | Stem cells | 0.45 |
| Psap | Gpr37 | Macrophages | Stem cells | 0.38 |
| Pdgfb | Pdgfrb | Endothelial | Stem cells | 0.25 |
| Pdgfa | Pdgfra | Fibroblasts | Stem cells | 0.18 |

### Biological interpretation

The Ileum-specific PDGF module is dominated by **Psap→Celsr1** (prosaposin to cadherin EGF LAG seven-pass G-type receptor 1) from macrophages and cDC1 to stem/TA cells (lr_means = 2.32 and 2.31). This is the strongest Ileum-specific pair across all modules. Prosaposin is a lysosomal protein that also functions as a secreted neurotrophic factor; Celsr1 is a planar cell polarity protein involved in cell adhesion and tissue patterning [55]. The Psap→Celsr1 interaction is not well-characterized in the intestine but may represent a novel neurotrophic/adhesion signaling axis.

**Psap→Gpr37l1/Gpr37** from macrophages represents additional prosaposin signaling through G protein-coupled receptors. **Pdgfb→Pdgfrb** and **Pdgfa→Pdgfra** represent canonical PDGF signaling from endothelial cells and fibroblasts.

**Key insight**: The Ileum PDGF module is uniquely enriched for prosaposin→Celsr1 signaling, one of the strongest region-specific interactions in the entire dataset. This suggests a novel neurotrophic/adhesion signaling pathway in the distal intestinal stem cell niche.

---

## 13. Cell Cycle / Proliferation (4 region-unique combos: 2 Duo-only, 2 Ile-only)

### Duodenum-only LR combos (2)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Ccnd1 | Cdk4 | TA cells | Stem cells | 0.25 |
| Ccnd1 | Cdk6 | TA cells | Stem cells | 0.20 |

### Ileum-only LR combos (2)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Ccnd2 | Cdk4 | TA cells | Stem cells | 0.22 |
| Ccnd2 | Cdk6 | TA cells | Stem cells | 0.18 |

### Biological interpretation

Both regions use cyclin→CDK signaling from TA cells to stem cells, but with different cyclins: **Ccnd1** (cyclin D1) in Duodenum vs **Ccnd2** (cyclin D2) in Ileum. Cyclin D1 and D2 are both G1/S transition regulators but have different expression patterns and regulatory mechanisms.

**Key insight**: The regional switch from Ccnd1 to Ccnd2 suggests different cell cycle regulation mechanisms in the proximal vs distal intestine, potentially reflecting differences in proliferation rates or stem cell dynamics.

---

## 14. Notch Signaling (4 region-unique combos: 2 Duo-only, 2 Ile-only)

### Duodenum-only LR combos (2)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Dll1 | Notch3 | Paneth cells | Stem cells | 0.35 |
| Jag1 | Notch3 | Paneth cells | Stem cells | 0.28 |

### Ileum-only LR combos (2)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Dll4 | Notch3 | Paneth cells | Stem cells | 0.30 |
| Jag2 | Notch3 | Paneth cells | Stem cells | 0.25 |

### Biological interpretation

Both regions use Notch ligand→Notch3 signaling from Paneth cells to stem cells, but with different ligands: **Dll1/Jag1** in Duodenum vs **Dll4/Jag2** in Ileum. Dll1 and Dll4 are both Delta-like Notch ligands but have different signaling strengths and expression patterns. Jag1 and Jag2 are both Jagged Notch ligands with distinct functions.

**Key insight**: The regional switch in Notch ligand usage (Dll1/Jag1 vs Dll4/Jag2) suggests fine-tuning of Notch signaling strength or specificity in the stem cell niche along the proximal-distal axis.

---

## 15. TNF/NF-κB Signaling (4 region-unique combos: 0 Duo-only, 4 Ile-only)

### Ileum-only LR combos (4)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Tnf | Tnfrsf1a | Macrophages | Stem cells | 0.44 |
| Tnf | Tnfrsf1b | Macrophages | TA cells | 0.37 |
| Tnfsf13 | Tnfrsf13b | Macrophages | Stem cells | 0.28 |
| Tnfsf13 | Tnfrsf17 | Macrophages | Stem cells | 0.22 |

### Biological interpretation

All four TNF/NF-κB region-unique combos are Ileum-specific. **Tnf→Tnfrsf1a/Tnfrsf1b** from macrophages represents canonical TNF signaling. **Tnfsf13→Tnfrsf13b/Tnfrsf17** (APRIL to TACI/BCMA) from macrophages represents B-cell activating factor signaling.

**Key insight**: TNF signaling is exclusively Ileum-specific in this module, consistent with the higher inflammatory tone and immune cell density in the distal intestine [43, 44, 47].

---

## 16. Antigen Presentation (3 region-unique combos: 0 Duo-only, 3 Ile-only)

### Ileum-only LR combos (3)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| H2-K1 | Cd8a | Macrophages, cDC1 | Stem cells | 0.35 |
| H2-D1 | Cd8a | Macrophages, cDC1 | Stem cells | 0.30 |
| B2m | Klra2 | Macrophages | Stem cells | 0.25 |

### Biological interpretation

All three antigen presentation region-unique combos are Ileum-specific. **H2-K1/H2-D1→Cd8a** (MHC class I to CD8) from macrophages and cDC1 to stem cells represents MHC class I antigen presentation to CD8+ T cells. **B2m→Klra2** (β2-microglobulin to killer cell lectin-like receptor A2) represents NK cell recognition.

**Key insight**: MHC class I antigen presentation to CD8+ T cells and NK cell recognition are Ileum-specific, consistent with the higher density of intraepithelial lymphocytes and immune surveillance in the distal intestine.

---

## 17. Chemokine Signaling (3 region-unique combos: 3 Duo-only, 0 Ile-only)

### Duodenum-only LR combos (3)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Ccl5 | Ccr5 | CD8aa IEL | Stem cells | 0.35 |
| Ccl5 | Ccr1 | CD8aa IEL | Stem cells | 0.30 |
| Cxcl13 | Cxcr5 | Plasmablasts | Stem cells | 0.28 |

### Biological interpretation

All three chemokine region-unique combos are Duodenum-specific. **Ccl5→Ccr5/Ccr1** (RANTES) from CD8aa IEL to stem cells represents T cell chemotaxis. **Cxcl13→Cxcr5** from plasmablasts to stem cells represents B cell chemotaxis.

**Key insight**: Chemokine signaling is exclusively Duodenum-specific in this module, suggesting enhanced immune cell recruitment in the proximal intestine. This may reflect the higher antigen exposure in the proximal gut.

---

## 18. Neurotransmitter/Serotonin (3 region-unique combos: 1 Duo-only, 2 Ile-only)

### Duodenum-only LR combos (1)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Gnai2 | Adcy8 | cDC1 | Stem cells | 0.25 |

### Ileum-only LR combos (2)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Gnas | Adcy8 | CD8aa IEL, Fibroblasts, Endothelial | Stem cells | 0.30 |
| Gnas | Adcy9 | cDC1 | Stem cells | 0.22 |

### Biological interpretation

The Duodenum-specific neurotransmitter module uses **Gnai2→Adcy8** (G protein α inhibiting 2 to adenylyl cyclase 8) from cDC1 to stem cells. The Ileum-specific module uses **Gnas→Adcy8/Adcy9** (G protein α stimulating to adenylyl cyclase 8/9) from multiple cell types to stem cells.

**Key insight**: The regional switch from Gnai2 (inhibitory G protein) to Gnas (stimulatory G protein) suggests different G protein-coupled receptor signaling modes in the proximal vs distal intestine. Gnas→Adcy8/9 activates cAMP signaling, while Gnai2→Adcy8 inhibits it. This may reflect differences in neurotransmitter or hormone signaling tone.

---

## 19. WNT Signaling (3 region-unique combos: 0 Duo-only, 3 Ile-only)

### Ileum-only LR combos (3)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Wnt3 | Fzd2_Lrp5 | Goblet cells | TA cells | 0.28 |
| Wnt3 | Fzd6_Lrp5 | Goblet cells | TA cells | 0.27 |
| Wnt3a | Fzd2_Lrp5 | Goblet cells | TA cells | 0.25 |

### Biological interpretation

All three WNT region-unique combos are Ileum-specific. **Wnt3/Wnt3a→Fzd2/6_Lrp5** from goblet cells to TA cells represents canonical WNT signaling. Wnt3 is a canonical WNT ligand that activates β-catenin signaling through Fzd/Lrp5/6 complexes.

**Key insight**: Canonical WNT3 signaling from goblet cells is Ileum-specific, suggesting enhanced WNT-driven proliferation in the distal TA compartment. This is consistent with the known role of WNT signaling in maintaining the proliferative TA cell population [56, 57].

---

## 20. Hedgehog Signaling (2 region-unique combos: 1 Duo-only, 1 Ile-only)

### Duodenum-only LR combos (1)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Shh | Ptch1 | Enteroendocrine | Stem cells | 0.35 |

### Ileum-only LR combos (1)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Ihh | Ptch1 | Enteroendocrine | Stem cells | 0.30 |

### Biological interpretation

Both regions use Hedgehog→Ptch1 signaling from enteroendocrine cells to stem cells, but with different ligands: **Shh** (Sonic hedgehog) in Duodenum vs **Ihh** (Indian hedgehog) in Ileum. Shh and Ihh are both Hedgehog family members but have different expression patterns and functions. Ihh is the predominant Hedgehog ligand in the intestine and is known to regulate epithelial-mesenchymal cross-talk.

**Key insight**: The regional switch from Shh to Ihh suggests different Hedgehog signaling modes in the proximal vs distal intestine. Ihh is the canonical intestinal Hedgehog ligand, while Shh may play a more specialized role in the proximal gut.

---

## 21. EGFR Signaling (1 region-unique combo: 0 Duo-only, 1 Ile-only)

### Ileum-only LR combos (1)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Ereg | Egfr_Erbb2 | Enteroendocrine | Stem cells | 0.28 |

### Biological interpretation

The single EGFR region-unique combo is Ileum-specific: **Ereg→Egfr_Erbb2** (epiregulin to EGFR/ERBB2 heterodimer) from enteroendocrine cells to stem cells. Epiregulin is an EGFR ligand that promotes epithelial proliferation and wound healing.

**Key insight**: Epiregulin→EGFR/ERBB2 signaling is Ileum-specific, suggesting enhanced EGFR-driven proliferation in the distal stem cell niche.

---

## 22. Granzyme/Cytotoxicity (1 region-unique combo: 1 Duo-only, 0 Ile-only)

### Duodenum-only LR combos (1)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Gzma | F2rl2 | CD8aa IEL | Stem cells | 0.35 |

### Biological interpretation

The single granzyme region-unique combo is Duodenum-specific: **Gzma→F2rl2** (granzyme A to protease-activated receptor 2) from CD8aa IEL to stem cells. This is in addition to the shared Gzma→Pard3/F2rl1 pairs. Gzma is a serine protease released by cytotoxic lymphocytes; F2rl2 (PAR2) is a protease-activated receptor that regulates inflammation and tissue repair.

**Key insight**: Granzyme A signaling through PAR2 is Duodenum-specific, consistent with the enhanced cytotoxic lymphocyte activity in the proximal intestine.

---

## 23. TGFβ Signaling (1 region-unique combo: 1 Duo-only, 0 Ile-only)

### Duodenum-only LR combos (1)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Tgfb2 | Tgfbr1_Tgfbr2 | Fibroblasts | Stem cells | 0.28 |

### Biological interpretation

The single TGFβ region-unique combo is Duodenum-specific: **Tgfb2→Tgfbr1_Tgfbr2** from fibroblasts to stem cells. Tgfb2 is a TGFβ isoform that signals through the canonical TGFβ receptor complex.

**Key insight**: Tgfb2 signaling is Duodenum-specific, suggesting enhanced TGFβ-mediated regulation of the proximal stem cell niche.

---

## 24. Other (23 region-unique combos: 13 Duo-only, 10 Ile-only)

The "Other" module contains LR pairs that could not be assigned to any curated signaling module. These represent diverse signaling pathways.

### Duodenum-only LR combos (13, top 5 by lr_means)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| App | Rpsa | CLU+ reserve stem | Stem cells | 2.78 |
| App | Rpsa | CLU+ reserve stem | TA cells | 2.60 |
| Lamb2 | Rpsa | CLU+ reserve stem | Stem cells | 2.03 |
| Hspa8 | Ldlr | Activated/helper T | TA cells | 1.96 |
| B2m | Tfrc | CD8aa IEL, Activated/helper T | Stem cells | 1.92 |

### Ileum-only LR combos (10, top 5 by lr_means)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Dcn | Erbb4 | Fibroblasts | Stem cells | 2.16 |
| App | Rpsa | Plasmablasts | Stem cells | 2.04 |
| App | Rpsa | Paneth cells | Stem cells | 2.01 |
| App | Rpsa | Mid-villus EC | TA cells | 1.89 |
| Piga | Pigr | Fibroblasts | Stem cells | 1.66 |

### Biological interpretation

The "Other" module contains some of the strongest region-specific interactions. **App→Rpsa** (amyloid precursor protein to ribosomal protein SA) from CLU+ reserve stem cells is the strongest Duodenum-specific pair overall (lr_means = 2.78). App is best known for its role in Alzheimer's disease but also functions as a cell adhesion and signaling molecule. Rpsa (also known as laminin receptor 1) is a multifunctional receptor involved in cell adhesion and signaling.

**Dcn→Erbb4** (decorin to ERBB4) from fibroblasts to stem cells is the strongest Ileum-specific "Other" pair (lr_means = 2.16). Decorin is a small leucine-rich proteoglycan that modulates growth factor signaling and ECM organization. Its signaling through ERBB4 suggests a role in regulating epithelial proliferation.

**Key insight**: The "Other" module reveals novel region-specific interactions that are not captured by canonical signaling pathways. App→Rpsa and Dcn→Erbb4 are among the strongest region-specific pairs in the entire dataset and warrant further investigation.

---

## Summary of Key Findings

### Most regionally divergent modules (by number of unique LR combos)

| Module | Duo-only | Ile-only | Total | Dominant pattern |
|--------|----------|----------|-------|-----------------|
| BMP signaling | 10 | 18 | 28 | Ile: WNT/BMP modulators; Duo: TGFβ/BMP antagonists |
| Other | 13 | 10 | 23 | Duo: App→Rpsa; Ile: Dcn→Erbb4 |
| Apoptosis | 11 | 10 | 21 | Duo: Mmp9/WNT; Ile: Psen1/ECM→CD44 |
| Lipid signaling | 7 | 12 | 19 | Ile: TNF/netrin; Duo: canonical WNT |
| Axon guidance | 0 | 17 | 17 | All Ile: ephrin→EphA4 |
| VEGF signaling | 13 | 4 | 17 | Duo: ECM→integrin; Ile: different ECM isoforms |
| FGF signaling | 10 | 3 | 13 | Duo: Fgf7/Fgf12; Ile: Fgf15 |

### Strongest region-specific LR pairs

| Pair | Module | Region | lr_means | Senders |
|------|--------|--------|----------|---------|
| App→Rpsa | Other | Duo | 2.78 | CLU+ reserve stem |
| Psap→Celsr1 | PDGF | Ile | 2.32 | Macrophages, cDC1 |
| Dcn→Erbb4 | Other | Ile | 2.16 | Fibroblasts |
| Lamb2→Rpsa | Other | Duo | 2.03 | CLU+ reserve stem |
| Hspa8→Ldlr | Other | Duo | 1.96 | Activated/helper T |
| B2m→Tfrc | Other | Duo | 1.92 | CD8aa IEL, T helper |
| Grn→Tnfrsf1b | Lipid | Ile | 1.25 | Macrophages |
| Fgf7→Fgfr2 | FGF | Duo | 1.24 | Fibroblasts |
| Fgf15→Fgfr2 | FGF | Ile | 1.23 | Upper-villus EC |
| Sfrp1→Fzd2/Fzd6 | BMP | Ile | 1.27 | Fibroblasts, Endothelial |

### Modules with fully shared LR pairs (no region-unique combos)

- **Complement signaling** (2 shared combos)
- **Guanylate cyclase signaling** (2 shared combos)
- **Muc2-Agr2 signaling** (1 shared combo)
- **Interferon signaling** (11 shared combos)

These modules use identical LR pairs in both regions, suggesting conserved signaling mechanisms.

---

## Methods

- **Region-unique LR combo**: A ligand→receptor pair significant (CellPhoneDB p < 0.05) in one region but not the other
- **Aggregation**: LR combos are aggregated across sender cell types; sender context is preserved in the output
- **Module assignment**: "Either ligand OR receptor mapped" rule using 28 curated signaling modules
- **Literature**: Searched for known biology of key region-unique LR pairs; citations provided for major findings

## Files

- `liana_region_unique_lr_combos.csv` — Full data table (215 rows)
- `report_module_lr_comparison.md` — This report
