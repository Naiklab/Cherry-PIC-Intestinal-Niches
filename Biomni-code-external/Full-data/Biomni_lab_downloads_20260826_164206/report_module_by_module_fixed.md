# Module-by-Module Comparison of LR Pairs: Duodenum vs Ileum

## Overview

This report compares ligand→receptor (LR) pairs within each signaling module between duodenum and ileum. For each module, three categories are shown:

- **Shared**: Same ligand→receptor pair significant (CellPhoneDB p < 0.05) in both regions — core niche signals. Sender differences between regions are noted with *.
- **Duodenum-only**: Ligand→receptor pair significant only in duodenum
- **Ileum-only**: Ligand→receptor pair significant only in ileum

**Module assignments**: Corrected ligand-only canonical mapping (fixed from original receptor-based mapping).

**Data**: 5,061 significant LR pairs (Duodenum), 4,961 (Ileum).

---

## Summary: LR Pair Counts by Module

| Module | Shared | Duo-only | Ile-only | Total |
|--------|--------|----------|----------|-------|
| WNT signaling | 35 | 18 | 23 | 76 |
| Notch signaling | 7 | 2 | 0 | 9 |
| BMP signaling | 40 | 5 | 2 | 47 |
| FGF signaling | 21 | 4 | 6 | 31 |
| EGFR signaling | 22 | 1 | 0 | 23 |
| Hedgehog signaling | 2 | 0 | 1 | 3 |
| TGFβ signaling | 20 | 2 | 0 | 22 |
| Other | 141 | 22 | 16 | 179 |
| VEGF signaling | 92 | 13 | 4 | 109 |
| Lipid signaling & transport | 61 | 2 | 8 | 71 |
| IGF signaling | 51 | 3 | 7 | 61 |
| Cell cycle / Proliferation | 40 | 2 | 2 | 44 |
| Cell adhesion & junctions | 30 | 5 | 3 | 38 |
| ECM–Integrin | 39 | 7 | 1 | 47 |
| Apoptosis / Cell survival | 43 | 3 | 6 | 52 |
| Retinoic acid signaling | 45 | 4 | 0 | 49 |
| Axon guidance (Netrin / Slit / Semaphorin / Ephrin) | 21 | 0 | 17 | 38 |
| Mitochondrial & oxidative metabolism | 31 | 2 | 4 | 37 |
| Antigen presentation | 19 | 0 | 3 | 22 |
| Neurotransmitter/serotonin | 7 | 1 | 2 | 10 |
| Interferon signaling | 10 | 0 | 0 | 10 |
| Chemokine signaling | 8 | 3 | 0 | 11 |
| Guanylate cyclase signaling | 2 | 0 | 0 | 2 |
| TNF/NF-κB signaling | 5 | 0 | 4 | 9 |
| PDGF signaling | 2 | 0 | 6 | 8 |
| Granzyme/cytotoxicity | 2 | 1 | 0 | 3 |
| Muc2-Agr2 signaling | 1 | 0 | 0 | 1 |
| Complement signaling | 2 | 0 | 0 | 2 |

---

## WNT

**35 shared | 18 Duodenum-only | 23 Ileum-only**

### Biological Summary

WNT signaling is critical for intestinal stem cell maintenance and crypt homeostasis. The conserved core includes Wnt3 from Paneth/enteroendocrine cells (canonical) and Wnt5a from fibroblasts (non-canonical), plus Dkk2/Dkk3 antagonists from fibroblasts. Regional differences: Ileum uses more non-canonical WNT (Wnt11→Fzd2/Fzd6 from cDC1, Wnt5a→Fzd2/Fzd6) and WNT modulation (Sfrp1→Fzd2/Fzd6), while Duodenum uses more canonical WNT from CLU+ reserve stem cells (Wnt7b, Wnt4). This suggests the ileal niche favors non-canonical/planar cell polarity WNT signaling, while the duodenal niche favors canonical β-catenin-dependent WNT signaling.

### Shared LR pairs (35)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Wnt5a | Ptprk | Fibroblasts | Fibroblasts | Stem cells, TA cells | 0.76 |
| Dkk2 | Lrp6 | Fibroblasts | Fibroblasts | D:TA cells, Stem cells I:Stem cells, TA cells | 0.54 |
| Wnt11 | Fzd5 | cDC1 | cDC1 | D:Stem cells, TA cells I:TA cells, Stem cells | 0.53 |
| Dkk2 | Lrp5 | Fibroblasts | Fibroblasts | Stem cells, TA cells | 0.51 |
| Wnt5a | Fzd5 | Fibroblasts | Fibroblasts | Stem cells, TA cells | 0.44 |
| Dkk2 | Kremen1 | Fibroblasts | Fibroblasts | D:TA cells I:Stem cells, TA cells | 0.44 |
| Wnt4 | Fzd5_Lrp6 | CLU+ reserve stem cells* | Fibroblasts* | D:TA cells, Stem cells I:Stem cells | 0.40 |
| Wnt3 | Fzd5_Lrp6 | Paneth cells, Enteroendocrine cells* | Paneth cells, Enteroendocrine cells, Goblet cells* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.39 |
| Wnt5a | Lrp6 | Fibroblasts | Fibroblasts | D:Stem cells, TA cells I:TA cells, Stem cells | 0.35 |
| Wnt3 | Ryk | Paneth cells, Enteroendocrine cells* | Enteroendocrine cells, Paneth cells, Goblet cells* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.35 |
| Wnt4 | Notch1 | CLU+ reserve stem cells* | Fibroblasts* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.34 |
| Wnt3 | Fzd5_Lrp5 | Paneth cells, Enteroendocrine cells* | Enteroendocrine cells, Paneth cells, Goblet cells* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.34 |
| Wnt4 | Fzd5_Lrp5 | CLU+ reserve stem cells* | Fibroblasts* | Stem cells, TA cells | 0.34 |
| Wnt5a | Ldlr | Fibroblasts | Fibroblasts | TA cells, Stem cells | 0.34 |
| Wnt5a | Ryk | Fibroblasts | Fibroblasts | D:TA cells, Stem cells I:Stem cells, TA cells | 0.33 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (18)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Wnt7b | Tmed5 | CLU+ reserve stem cells | TA cells, Stem cells | 0.60 |
| Wnt7b | Fzd5_Lrp6 | CLU+ reserve stem cells | Stem cells, TA cells | 0.57 |
| Wnt7b | Fzd5_Lrp5 | CLU+ reserve stem cells | TA cells, Stem cells | 0.54 |
| Wnt7b | Fzd7_Lrp5 | CLU+ reserve stem cells | Stem cells, TA cells | 0.45 |
| Wnt7b | Fzd7_Lrp6 | CLU+ reserve stem cells | Stem cells, TA cells | 0.45 |
| Wnt7a | Ldlr | CLU+ reserve stem cells | TA cells | 0.31 |
| Wnt5b | Fzd5_Lrp5 | Upper-villus enterocytes, Fibroblasts | Stem cells, TA cells | 0.21 |
| Wnt7a | Fzd5_Lrp5 | CLU+ reserve stem cells | Stem cells, TA cells | 0.19 |
| Wnt6 | Fzd5_Lrp5 | Upper-villus enterocytes | Stem cells, TA cells | 0.16 |
| Wnt9b | Fzd5_Lrp5 | Enteroendocrine cells | Stem cells, TA cells | 0.16 |
| Wnt5b | Fzd7_Lrp5 | Upper-villus enterocytes, Fibroblasts | TA cells, Stem cells | 0.13 |
| Wnt5b | Fzd7_Lrp6 | Upper-villus enterocytes, Fibroblasts | TA cells, Stem cells | 0.13 |
| Wnt7a | Fzd7_Lrp5 | CLU+ reserve stem cells | TA cells, Stem cells | 0.11 |
| Wnt7a | Fzd7_Lrp6 | CLU+ reserve stem cells | TA cells, Stem cells | 0.11 |
| Wnt6 | Fzd7_Lrp5 | Upper-villus enterocytes | TA cells, Stem cells | 0.07 |

### Ileum-only LR pairs (23)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Sfrp1 | Fzd2 | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.28 |
| Sfrp1 | Fzd6 | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.27 |
| Wnt11 | Fzd2 | cDC1 | Stem cells, TA cells | 0.38 |
| Wnt11 | Fzd6 | cDC1 | Stem cells, TA cells | 0.37 |
| Wnt3 | Fzd2_Lrp5 | Goblet cells, Enteroendocrine cells, Paneth cells | TA cells, Stem cells | 0.28 |
| Wnt3 | Fzd2_Lrp6 | Goblet cells, Enteroendocrine cells, Paneth cells | TA cells, Stem cells | 0.28 |
| Wnt3 | Fzd6_Lrp5 | Goblet cells, Paneth cells, Enteroendocrine cells | TA cells, Stem cells | 0.27 |
| Wnt3 | Fzd6_Lrp6 | Goblet cells, Paneth cells, Enteroendocrine cells | TA cells, Stem cells | 0.27 |
| Wnt5a | Epha7 | Fibroblasts | TA cells, Stem cells | 0.25 |
| Wnt5a | Fzd2 | Fibroblasts | TA cells, Stem cells | 0.23 |
| Wnt5a | Fzd6 | Fibroblasts | TA cells, Stem cells | 0.23 |
| Wnt4 | Fzd2_Lrp5 | Fibroblasts | TA cells, Stem cells | 0.15 |
| Wnt4 | Fzd2_Lrp6 | Fibroblasts | TA cells, Stem cells | 0.15 |
| Wnt9a | Fzd2_Lrp5 | Fibroblasts | TA cells, Stem cells | 0.15 |
| Wnt9a | Fzd2_Lrp6 | Fibroblasts | TA cells, Stem cells | 0.15 |

---

## Notch

**7 shared | 2 Duodenum-only | 0 Ileum-only**

### Biological Summary

Notch signaling regulates stem cell fate and differentiation along the crypt-villus axis. The conserved core includes Dll4 from enteroendocrine/endothelial cells and Dll1 from goblet cells. Regional differences: Duodenum has more Notch signaling from Paneth cells (Dll1, Dll4, Dll3→Notch1/2), consistent with higher Paneth cell density in proximal intestine. Ileum uses more Jag2 from enteroendocrine cells. Notch signaling is generally Duodenum-biased, reflecting the greater role of Paneth cell-mediated stem cell maintenance in the proximal intestine.

### Shared LR pairs (7)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Dll4 | Notch1 | Goblet cells, Blood vascular endothelial cells, Enteroendocrine cells, Paneth cells, TA cells/early progenitors* | Blood vascular endothelial cells, Goblet cells, Enteroendocrine cells* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.33 |
| Jag2 | Notch1 | cDC1, TA cells/early progenitors, Enteroendocrine cells* | Enteroendocrine cells, cDC1* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.31 |
| Jag2 | Notch2 | cDC1* | cDC1, Enteroendocrine cells* | Stem cells, TA cells | 0.29 |
| Dll4 | Notch2 | Enteroendocrine cells, Goblet cells, Blood vascular endothelial cells, Paneth cells* | Blood vascular endothelial cells, Goblet cells, Enteroendocrine cells* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.28 |
| Dll1 | Notch1 | Goblet cells, Paneth cells, CLU+ reserve stem cells, TA cells/early progenitors, Fibroblasts, Upper-villus enterocytes* | Goblet cells, Fibroblasts, TA cells, Stem cells* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.27 |
| Dll1 | Notch2 | Goblet cells, Fibroblasts, Paneth cells* | Goblet cells* | Stem cells, TA cells | 0.26 |
| Jag1 | Notch1 | CLU+ reserve stem cells, Blood vascular endothelial cells, TA cells, TA cells/early progenitors, Upper-villus enterocytes* | Goblet cells, TA cells, TA cells/early progenitors* | D:Stem cells, TA cells I:Stem cells | 0.23 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (2)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Dll3 | Notch1 | Paneth cells | Stem cells, TA cells | 0.23 |
| Dll3 | Notch2 | Paneth cells | Stem cells | 0.16 |

### Ileum-only LR pairs (0)

*None*


---

## BMP

**40 shared | 5 Duodenum-only | 2 Ileum-only**

### Biological Summary

BMP signaling maintains stem cell quiescence and regulates differentiation. The conserved core is dominated by Bmp4 from fibroblasts signaling to multiple receptors (Rgmb, Lrp6, Bmpr1a/Bmpr2, Acvr2a/b). Regional differences: Ileum has more BMP signaling (Gdf6→Bmpr1a_Bmpr2, Bmp8a→Bmpr1a_Bmpr2 from goblet cells), while Duodenum has more BMP antagonism (Fst→Bmpr2). This is consistent with the known role of BMP in maintaining stem cell quiescence in the distal intestine.

### Shared LR pairs (40)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Bmp4 | Rgmb | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 0.87 |
| Bmp4 | Lrp6 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 0.71 |
| Bmp7 | Ptprk | Stem cells, TA cells, Fibroblasts, TA cells/early progenitors, Paneth cells, Enteroendocrine cells, Goblet cells* | Fibroblasts, TA cells, Paneth cells, Cd8aa IEL, Enteroendocrine cells, TA cells/early progenitors, Goblet cells, Stem cells* | Stem cells, TA cells | 0.66 |
| Bmp4 | Bmpr1a_Bmpr2 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 0.63 |
| Bmp4 | Acvr2a_Bmpr1a | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | D:TA cells, Stem cells I:Stem cells, TA cells | 0.60 |
| Bmp2 | Actr2 | Fibroblasts, CLU+ reserve stem cells* | Fibroblasts* | TA cells, Stem cells | 0.59 |
| Bmp4 | Acvr2b_Bmpr1a | Fibroblasts, Blood vascular endothelial cells | Blood vascular endothelial cells, Fibroblasts | D:TA cells, Stem cells I:Stem cells, TA cells | 0.58 |
| Bmp7 | Actr2 | Fibroblasts | Fibroblasts | D:TA cells I:Stem cells, TA cells | 0.48 |
| Bmp2 | Rgmb | Fibroblasts, Upper-villus enterocytes, Goblet cells, TA cells/early progenitors, CLU+ reserve stem cells, Enteroendocrine cells* | Fibroblasts, Upper-villus enterocytes, Goblet cells, Enteroendocrine cells* | Stem cells, TA cells | 0.46 |
| Bmp5 | Bmpr1a_Bmpr2 | Fibroblasts* | Fibroblasts, Blood vascular endothelial cells* | Stem cells, TA cells | 0.45 |
| Bmp5 | Acvr2a_Bmpr1a | Fibroblasts* | Fibroblasts, Blood vascular endothelial cells* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.42 |
| Bmp5 | Acvr2b_Bmpr1a | Fibroblasts* | Fibroblasts, Blood vascular endothelial cells* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.40 |
| Bmp5 | Acvr1_Bmpr2 | Fibroblasts* | Fibroblasts, Blood vascular endothelial cells* | TA cells, Stem cells | 0.40 |
| Bmp5 | Acvr1_Acvr2a | Fibroblasts* | Fibroblasts, Blood vascular endothelial cells* | TA cells, Stem cells | 0.40 |
| Bmp5 | Acvr1_Acvr2b | Fibroblasts* | Fibroblasts, Blood vascular endothelial cells* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.39 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (5)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Gdf9 | Bmpr1a | Upper-villus enterocytes | Stem cells, TA cells | 0.23 |
| Gdf9 | Acvr1b_Bmpr2 | Upper-villus enterocytes | Stem cells, TA cells | 0.10 |
| Gdf9 | Acvr2a | Upper-villus enterocytes | Stem cells, TA cells | 0.09 |
| Inha | Acvr1 | Paneth cells | Stem cells, TA cells | 0.07 |
| Gdf9 | Orai2 | Upper-villus enterocytes | TA cells, Stem cells | 0.05 |

### Ileum-only LR pairs (2)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Gdf6 | Bmpr1a_Bmpr2 | Fibroblasts | Stem cells | 0.20 |
| Bmp8a | Bmpr1a_Bmpr2 | Goblet cells | Stem cells | 0.17 |

---

## FGF

**21 shared | 4 Duodenum-only | 6 Ileum-only**

### Biological Summary

FGF signaling supports intestinal stem cell proliferation and survival. The conserved core includes Fgf14 from enteroendocrine/goblet/TA cells and Fgf2/Fgf10 from fibroblasts, all signaling to Fgfr2. Regional differences: Ileum has more FGF signaling (Fgf2, Fgf10, Fgf7→Fgfr2 from fibroblasts), suggesting stronger mesenchymal proliferative support in the distal intestine.

### Shared LR pairs (21)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Fgf13 | Fgfr2 | Activated/helper-like T cells* | Cd8aa IEL* | TA cells, Stem cells | 1.37 |
| Fgf2 | Fgfr2 | Fibroblasts | Fibroblasts | TA cells, Stem cells | 1.29 |
| Fgf14 | Fgfr2 | Enteroendocrine cells, Fibroblasts, Goblet cells, TA cells* | Enteroendocrine cells, Goblet cells, TA cells* | TA cells, Stem cells | 1.28 |
| Fgf10 | Fgfr2 | Fibroblasts | Fibroblasts | TA cells, Stem cells | 1.25 |
| Fgf9 | Fgfr2 | CLU+ reserve stem cells, Enteroendocrine cells, Upper-villus enterocytes* | Fibroblasts* | D:Stem cells, TA cells I:TA cells, Stem cells | 1.17 |
| Fgf1 | Fgfr2 | CLU+ reserve stem cells* | TA cells, Upper-villus enterocytes, Enteroendocrine cells, Goblet cells, TA cells/early progenitors, Mid-villus enterocytes* | TA cells, Stem cells | 1.13 |
| Fgf2 | Sdc4 | Fibroblasts | Fibroblasts | Stem cells, TA cells | 0.89 |
| Fgf2 | Cd44 | Fibroblasts | Fibroblasts | Stem cells | 0.59 |
| Fgf2 | Sdc1 | Fibroblasts | Fibroblasts | Stem cells, TA cells | 0.38 |
| Fgf13 | Egfr | Activated/helper-like T cells* | Cd8aa IEL* | TA cells, Stem cells | 0.38 |
| Fgf13 | Fgfr4 | Activated/helper-like T cells* | Cd8aa IEL* | D:Stem cells I:TA cells, Stem cells | 0.37 |
| Fgf2 | Gpc4 | Fibroblasts | Fibroblasts | D:TA cells, Stem cells I:Stem cells, TA cells | 0.30 |
| Fgf13 | Fgfr3 | Activated/helper-like T cells* | Cd8aa IEL* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.29 |
| Fgf2 | Sdc2 | Fibroblasts | Fibroblasts | TA cells, Stem cells | 0.24 |
| Fgf2 | Fgfr4 | Fibroblasts | Fibroblasts | D:Stem cells I:TA cells, Stem cells | 0.22 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (4)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Fgf7 | Fgfr2 | Fibroblasts | TA cells, Stem cells | 1.24 |
| Fgf12 | Fgfr2 | Enteroendocrine cells | Stem cells, TA cells | 1.17 |
| Fgf7 | Fgfr4 | Fibroblasts | Stem cells | 0.14 |
| Fgf7 | Fgfr3 | Fibroblasts | TA cells, Stem cells | 0.13 |

### Ileum-only LR pairs (6)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Fgf15 | Fgfr2 | Upper-villus enterocytes | TA cells, Stem cells | 1.23 |
| Fgf10 | Fgfrl1 | Fibroblasts | TA cells, Stem cells | 0.24 |
| Fgf2 | Fgfrl1 | Fibroblasts | TA cells, Stem cells | 0.22 |
| Fgf15 | Fgfr4 | Upper-villus enterocytes | Stem cells, TA cells | 0.20 |
| Fgf15 | Fgfr3 | Upper-villus enterocytes | TA cells, Stem cells | 0.16 |
| Fgf1 | Fgfrl1 | Mid-villus enterocytes, Upper-villus enterocytes, TA cells, Goblet cells, TA cells/early progenitors, Enteroendocrine cells | TA cells, Stem cells | 0.14 |

---

## EGFR

**22 shared | 1 Duodenum-only | 0 Ileum-only**

### Biological Summary

EGFR signaling drives epithelial proliferation and regeneration. The conserved core includes Ereg from fibroblasts (to Erbb3 and Egfr/Erbb2) and Hbegf from multiple cell types (to Prlr). Regional differences: Ileum uses more Hbegf→Cd44/Cd9 from upper-villus enterocytes, while Duodenum uses more diverse ligands (Ereg, Tgfa, Btc→Erbb3) from CLU+ reserve stem cells and endothelial cells. This suggests regional differences in EGFR pathway activation mechanisms.

### Shared LR pairs (22)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Hbegf | Cd44 | CLU+ reserve stem cells* | Upper-villus enterocytes* | D:Stem cells I:Stem cells, TA cells | 0.74 |
| Ereg | Erbb3 | Fibroblasts, Blood vascular endothelial cells, Upper-villus enterocytes* | Mid-villus enterocytes, Fibroblasts, Enteroendocrine cells, Upper-villus enterocytes, TA cells/early progenitors* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.56 |
| Hbegf | Cd9 | TA cells/early progenitors, CLU+ reserve stem cells, Blood vascular endothelial cells* | Upper-villus enterocytes, Fibroblasts, Blood vascular endothelial cells, TA cells/early progenitors, Mid-villus enterocytes, Goblet cells, Macrophages, TA cells* | TA cells, Stem cells | 0.56 |
| Hbegf | Prlr | CLU+ reserve stem cells, Blood vascular endothelial cells, Macrophages, TA cells/early progenitors, Upper-villus enterocytes, Activated/helper-like T cells, Enteroendocrine cells, Fibroblasts, Goblet cells, TA cells* | Upper-villus enterocytes, TA cells/early progenitors, Fibroblasts, Blood vascular endothelial cells, Macrophages, TA cells, Goblet cells, Mid-villus enterocytes, Plamsablasts* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.55 |
| Areg | Erbb3 | Fibroblasts, Upper-villus enterocytes, Activated/helper-like T cells, TA cells/early progenitors, Goblet cells, Enteroendocrine cells* | Upper-villus enterocytes, Mid-villus enterocytes, Goblet cells, TA cells/early progenitors* | Stem cells, TA cells | 0.45 |
| Ereg | Egfr_Erbb2 | Fibroblasts, Upper-villus enterocytes, Blood vascular endothelial cells* | TA cells/early progenitors, Fibroblasts, Upper-villus enterocytes, Enteroendocrine cells, Mid-villus enterocytes* | TA cells, Stem cells | 0.40 |
| Tgfa | Erbb3 | Upper-villus enterocytes, Goblet cells, TA cells/early progenitors, TA cells, Stem cells, CLU+ reserve stem cells, Paneth cells* | TA cells/early progenitors, Enteroendocrine cells, Goblet cells, Mid-villus enterocytes, Stem cells, TA cells, Upper-villus enterocytes* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.40 |
| Btc | Erbb3 | Fibroblasts, Upper-villus enterocytes, Paneth cells, CLU+ reserve stem cells, Goblet cells, TA cells/early progenitors, Enteroendocrine cells* | Fibroblasts, Upper-villus enterocytes, Goblet cells, TA cells, TA cells/early progenitors* | Stem cells, TA cells | 0.39 |
| Hbegf | Cd82 | Blood vascular endothelial cells, Fibroblasts, TA cells/early progenitors, Goblet cells, Upper-villus enterocytes, CLU+ reserve stem cells, Activated/helper-like T cells, Macrophages, TA cells* | Macrophages, Goblet cells, Mid-villus enterocytes, Upper-villus enterocytes, Blood vascular endothelial cells, Fibroblasts* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.39 |
| Ereg | Erbb2_Erbb4 | Fibroblasts, Blood vascular endothelial cells* | Fibroblasts, Mid-villus enterocytes, Upper-villus enterocytes* | D:TA cells I:TA cells, Stem cells | 0.36 |
| Egf | Erbb3 | Paneth cells, cDC1, Enteroendocrine cells* | Goblet cells, Paneth cells* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.36 |
| Hbegf | Egfr_Erbb2 | TA cells/early progenitors, Upper-villus enterocytes, Blood vascular endothelial cells, CLU+ reserve stem cells, Fibroblasts, Goblet cells, Macrophages, TA cells, Activated/helper-like T cells* | Upper-villus enterocytes, Fibroblasts, Blood vascular endothelial cells, Goblet cells, Macrophages, Mid-villus enterocytes* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.30 |
| Egf | Ldlr | Paneth cells, Enteroendocrine cells, cDC1* | Goblet cells, Paneth cells* | D:TA cells, Stem cells I:TA cells | 0.28 |
| Areg | Egfr_Erbb2 | Goblet cells, Activated/helper-like T cells, Upper-villus enterocytes, Fibroblasts, TA cells/early progenitors* | TA cells/early progenitors, Upper-villus enterocytes, Goblet cells, Mid-villus enterocytes* | TA cells, Stem cells | 0.28 |
| Btc | Egfr_Erbb2 | CLU+ reserve stem cells, Goblet cells, TA cells/early progenitors, Fibroblasts, Upper-villus enterocytes* | TA cells/early progenitors, TA cells, Goblet cells, Fibroblasts, Upper-villus enterocytes* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.22 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (1)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Egf | Pld2 | cDC1, Paneth cells | TA cells | 0.13 |

### Ileum-only LR pairs (0)

*None*


---

## Hedgehog

**2 shared | 0 Duodenum-only | 1 Ileum-only**

### Biological Summary

Hedgehog signaling regulates stem cell proliferation and differentiation. The conserved core is Ihh from epithelial cells (upper-villus EC, TA, goblet) to Ptch1/Smo. Regional differences: Ileum has more Ihh→Ptch1 autocrine signaling, suggesting stronger hedgehog pathway activity in the distal intestine stem cell niche.

### Shared LR pairs (2)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Ihh | Ptch1_Smo | TA cells/early progenitors, TA cells, Goblet cells, CLU+ reserve stem cells, Upper-villus enterocytes* | Mid-villus enterocytes, Stem cells, TA cells/early progenitors, Goblet cells, TA cells, Upper-villus enterocytes* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.15 |
| Ihh | Cdon | TA cells, Goblet cells, Upper-villus enterocytes, CLU+ reserve stem cells* | Mid-villus enterocytes, Stem cells, TA cells/early progenitors, Goblet cells, TA cells, Upper-villus enterocytes* | D:TA cells I:TA cells, Stem cells | 0.11 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (0)

*None*


### Ileum-only LR pairs (1)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Ihh | Boc | Mid-villus enterocytes, Stem cells, TA cells/early progenitors, Goblet cells, TA cells, Upper-villus enterocytes | TA cells, Stem cells | 0.18 |

---

## TGFβ

**20 shared | 2 Duodenum-only | 0 Ileum-only**

### Biological Summary

TGFβ signaling inhibits stem cell proliferation and promotes differentiation. The conserved core is Tgfb1 from immune cells (cDC1, macrophages, plasmablasts, T helper) to multiple receptors (Lpp, Itgb1, Egfr, Sdc2). Regional differences: Duodenum has more TGFβ signaling from CD8aa IELs and plasmablasts, suggesting stronger immune-mediated inhibition of stem cell proliferation in the proximal intestine.

### Shared LR pairs (20)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Tgfb1 | Lpp | Macrophages, cDC1, Plamsablasts, Activated/helper-like T cells, Cd8aa IEL, Blood vascular endothelial cells* | cDC1, Macrophages, Plamsablasts, Activated/helper-like T cells, Fibroblasts* | Stem cells, TA cells | 1.04 |
| Tgfb1 | Itgb1 | Macrophages, cDC1, Plamsablasts* | cDC1, Macrophages* | TA cells, Stem cells | 0.91 |
| Tgfb1 | Egfr | Macrophages, cDC1, Plamsablasts, Activated/helper-like T cells* | cDC1, Macrophages, Plamsablasts* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.71 |
| Tgfb1 | Tgfbr1_Tgfbr2 | Plamsablasts, cDC1, Macrophages* | Macrophages, cDC1* | TA cells, Stem cells | 0.70 |
| Tgfb1 | Acvr1b_Tgfbr2 | Plamsablasts, cDC1, Macrophages* | Macrophages, cDC1* | TA cells, Stem cells | 0.70 |
| Tgfb1 | Itgav_Itgb6 | Plamsablasts, cDC1, Macrophages* | Macrophages, cDC1* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.69 |
| Tgfb1 | Acvr1_Tgfbr2 | Activated/helper-like T cells, Plamsablasts, cDC1, Macrophages* | Macrophages, cDC1* | TA cells, Stem cells | 0.65 |
| Tgfb1 | Acvr1_Tgfbr1_Tgfbr2 | Activated/helper-like T cells, Plamsablasts, cDC1, Macrophages* | Macrophages, cDC1* | TA cells, Stem cells | 0.65 |
| Tgfb1 | Sdc2 | Activated/helper-like T cells, Plamsablasts, cDC1, Macrophages* | Plamsablasts, cDC1, Macrophages* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.64 |
| Tgfb1 | Acvr1c_Tgfbr2 | Plamsablasts, Activated/helper-like T cells, cDC1, Macrophages* | Plamsablasts, Macrophages, cDC1* | Stem cells, TA cells | 0.64 |
| Tgfb3 | Itgb1 | Cd8aa IEL, Fibroblasts* | Fibroblasts* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.45 |
| Tgfb2 | Tgfbr1_Tgfbr2 | Fibroblasts | Fibroblasts | Stem cells, TA cells | 0.34 |
| Tgfb2 | Acvr1b_Tgfbr2 | Fibroblasts | Fibroblasts | Stem cells, TA cells | 0.34 |
| Tgfb2 | Acvr1c_Tgfbr2 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 0.27 |
| Tgfb2 | Acvr1_Tgfbr1_Tgfbr2 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | D:TA cells, Stem cells I:Stem cells, TA cells | 0.26 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (2)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Tgfb3 | Acvr1b_Tgfbr2 | Fibroblasts | Stem cells, TA cells | 0.27 |
| Tgfb3 | Tgfbr1_Tgfbr2 | Fibroblasts | Stem cells, TA cells | 0.27 |

### Ileum-only LR pairs (0)

*None*


---

## Other

**141 shared | 22 Duodenum-only | 16 Ileum-only**

### Biological Summary

This module contains LR pairs not assigned to canonical pathways. The conserved core includes diverse signals such as App→Rpsa (lipid-related), Psap→Lrp1/Sort1 (prosaposin), and various ECM components. Regional differences reflect the broad diversity of unassigned signaling interactions.

### Shared LR pairs (141)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Lamb2 | Rpsa | Fibroblasts, Blood vascular endothelial cells, CLU+ reserve stem cells* | Fibroblasts, Blood vascular endothelial cells* | Stem cells, TA cells | 1.95 |
| Ncam1 | Fgfr2 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.72 |
| Col1a2 | Sdc1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.62 |
| Piga | Pigr | TA cells/early progenitors, Goblet cells, Upper-villus enterocytes, CLU+ reserve stem cells, Enteroendocrine cells, TA cells* | TA cells/early progenitors, Enteroendocrine cells, Goblet cells, Upper-villus enterocytes, Fibroblasts, TA cells, Mid-villus enterocytes* | Stem cells, TA cells | 1.62 |
| Col1a2 | Itga1_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.60 |
| Col1a2 | Itga2_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.51 |
| Col1a2 | Itga3_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.48 |
| Cxcl12 | Sdc4 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.41 |
| Timp1 | Fgfr2 | Fibroblasts | Fibroblasts | TA cells, Stem cells | 1.28 |
| L1cam | Fgfr2 | TA cells, TA cells/early progenitors, Goblet cells, Stem cells, Enteroendocrine cells, Upper-villus enterocytes, CLU+ reserve stem cells* | TA cells/early progenitors, TA cells, Goblet cells, Stem cells, Mid-villus enterocytes, Cd8aa IEL, Enteroendocrine cells, Upper-villus enterocytes* | TA cells, Stem cells | 1.22 |
| Ccl5 | Sdc4 | Cd8aa IEL, Activated/helper-like T cells, Stem cells, TA cells* | Cd8aa IEL, cDC1, Stem cells, TA cells* | Stem cells, TA cells | 1.20 |
| Tgm2 | Sdc4 | Fibroblasts, Macrophages, cDC1, Blood vascular endothelial cells, TA cells, CLU+ reserve stem cells, Stem cells* | Fibroblasts, Blood vascular endothelial cells, Macrophages, Stem cells, TA cells* | Stem cells, TA cells | 1.19 |
| Cdh1 | Ptprf | CLU+ reserve stem cells, Stem cells, TA cells, TA cells/early progenitors, Goblet cells, Upper-villus enterocytes, Enteroendocrine cells, Paneth cells, Mid-villus enterocytes, Cd8aa IEL* | Stem cells, Upper-villus enterocytes, TA cells/early progenitors, TA cells, Goblet cells, Enteroendocrine cells, Mid-villus enterocytes, Cd8aa IEL, Bottom-Villus enterocytes, Paneth cells* | Stem cells, TA cells | 1.19 |
| P4hb | Mttp | Upper-villus enterocytes, Paneth cells, Fibroblasts, Mid-villus enterocytes, CLU+ reserve stem cells, TA cells, Blood vascular endothelial cells, Macrophages, Stem cells* | Upper-villus enterocytes, Goblet cells, Fibroblasts, Paneth cells, Mid-villus enterocytes, TA cells* | TA cells, Stem cells | 1.18 |
| Tnc | Sdc4 | Fibroblasts* | Fibroblasts, Blood vascular endothelial cells* | Stem cells, TA cells | 1.18 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (22)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Thbs1 | Lrp1 | Macrophages | TA cells, Stem cells | 0.90 |
| Thbs1 | Ptprj | Macrophages, Fibroblasts | Stem cells, TA cells | 0.84 |
| Timp1 | Cd63 | Fibroblasts | TA cells | 0.83 |
| Lama5 | Itga6_Itgb1 | Blood vascular endothelial cells, Paneth cells, CLU+ reserve stem cells | TA cells, Stem cells | 0.56 |
| Calca | Vipr1 | Activated/helper-like T cells | Stem cells, TA cells | 0.45 |
| Cx3cl1 | Cx3cr1 | CLU+ reserve stem cells, Upper-villus enterocytes | Stem cells, TA cells | 0.40 |
| Cthrc1 | Fzd5 | Enteroendocrine cells | Stem cells, TA cells | 0.38 |
| F2 | Gp1bb | Enteroendocrine cells | Stem cells, TA cells | 0.38 |
| Ucn3 | Il10rb | Enteroendocrine cells | TA cells, Stem cells | 0.33 |
| Calca | Ramp2 | Activated/helper-like T cells | TA cells, Stem cells | 0.28 |
| Cp | Slc40a1 | Fibroblasts | TA cells | 0.22 |
| Cd40lg | Traf3 | Activated/helper-like T cells | TA cells, Stem cells | 0.21 |
| Il13 | Tmem219 | Activated/helper-like T cells | TA cells, Stem cells | 0.20 |
| Alb | B2m_Fcgrt | Enteroendocrine cells | TA cells | 0.16 |
| Nmu | Adra2a | Enteroendocrine cells | TA cells, Stem cells | 0.15 |

### Ileum-only LR pairs (16)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| H2-K1 | Cd3g | Cd8aa IEL, Activated/helper-like T cells, cDC1, Macrophages, Plamsablasts | TA cells | 1.62 |
| Bgn | Ly96 | Fibroblasts, Blood vascular endothelial cells | TA cells | 1.42 |
| Bgn | Tlr1 | Fibroblasts, Blood vascular endothelial cells | TA cells | 1.40 |
| Ntrk3 | Ptprf | Enteroendocrine cells, Cd8aa IEL, Fibroblasts | Stem cells, TA cells | 0.77 |
| Efna5 | Epha7 | Blood vascular endothelial cells, Fibroblasts | TA cells, Stem cells | 0.74 |
| Il18 | Il1rapl1 | Upper-villus enterocytes, Macrophages, Mid-villus enterocytes | Stem cells, TA cells | 0.54 |
| Kitl | Kit | Blood vascular endothelial cells, Fibroblasts, Macrophages | Stem cells, TA cells | 0.52 |
| Cd200r1 | Cd200 | Macrophages, Cd8aa IEL | TA cells | 0.30 |
| Nrg2 | Erbb2_Erbb3 | cDC1 | Stem cells, TA cells | 0.27 |
| Btla | Cd79a | Cd8aa IEL, Plamsablasts, cDC1 | TA cells | 0.26 |
| Ntrk3 | Ptprs | Cd8aa IEL, Fibroblasts, Enteroendocrine cells | TA cells, Stem cells | 0.23 |
| Tnfsf12 | Tnfrsf12a | Macrophages, Fibroblasts | TA cells | 0.21 |
| Apoo | Il1rapl2 | Stem cells, Mid-villus enterocytes, Goblet cells, Upper-villus enterocytes, TA cells/early progenitors, TA cells | TA cells | 0.19 |
| Ntng2 | Lrrc4c | Fibroblasts, cDC1 | TA cells, Stem cells | 0.17 |
| Slitrk6 | Ptprs | Fibroblasts | TA cells, Stem cells | 0.16 |

---

## VEGF

**92 shared | 13 Duodenum-only | 4 Ileum-only**

### Biological Summary

VEGF signaling regulates angiogenesis and vascular permeability. The conserved core includes Vegfa from multiple cell types to various receptors (Itgb1, Ephb2, Flt1, Kdr). Regional differences: Duodenum has more VEGF signaling, particularly from CLU+ reserve stem cells and enteroendocrine cells, suggesting stronger angiogenic support in the proximal intestine.

### Shared LR pairs (92)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Dcn | Egfr | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | D:TA cells, Stem cells I:Stem cells, TA cells | 1.57 |
| Col4a2 | Itga1_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.18 |
| Lama2 | Itga6_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.16 |
| Col4a2 | Itga2_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.10 |
| Col4a2 | Itga3_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.06 |
| Col5a1 | Itga1_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.05 |
| Lum | Itgb1 | Fibroblasts, Blood vascular endothelial cells* | Fibroblasts* | TA cells, Stem cells | 1.04 |
| Col6a3 | Itga1_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.02 |
| Lama2 | Itga2_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.00 |
| Lamb1 | Itga6_Itgb1 | Fibroblasts, Blood vascular endothelial cells, Paneth cells* | Fibroblasts, Blood vascular endothelial cells* | TA cells, Stem cells | 0.97 |
| C3 | Cd81 | Fibroblasts, Blood vascular endothelial cells* | Fibroblasts* | TA cells, Stem cells | 0.96 |
| Cxcl12 | Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 0.96 |
| Tgm2 | Itgb1 | Fibroblasts, Macrophages* | Fibroblasts, Blood vascular endothelial cells, Macrophages* | TA cells, Stem cells | 0.96 |
| Lama2 | Itga3_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 0.96 |
| Col5a1 | Itga2_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 0.96 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (13)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Lamc2 | Itga6_Itgb1 | CLU+ reserve stem cells | TA cells, Stem cells | 0.51 |
| Spp1 | Itgav_Itgb1 | CLU+ reserve stem cells | TA cells, Stem cells | 0.46 |
| Col13a1 | Itga1_Itgb1 | Blood vascular endothelial cells | Stem cells, TA cells | 0.28 |
| Col7a1 | Itga1_Itgb1 | Enteroendocrine cells, Paneth cells | TA cells, Stem cells | 0.26 |
| Col6a6 | Itga1_Itgb1 | Enteroendocrine cells | Stem cells, TA cells | 0.21 |
| Col13a1 | Itga2_Itgb1 | Blood vascular endothelial cells | TA cells, Stem cells | 0.19 |
| Amh | Egfr | Enteroendocrine cells | Stem cells, TA cells | 0.17 |
| Col7a1 | Itga2_Itgb1 | Enteroendocrine cells, Paneth cells | Stem cells, TA cells | 0.17 |
| Fgl1 | Egfr | Enteroendocrine cells | Stem cells, TA cells | 0.17 |
| Chad | Itga2_Itgb1 | Activated/helper-like T cells | TA cells, Stem cells | 0.15 |
| Col6a6 | Itga3_Itgb1 | Enteroendocrine cells | TA cells | 0.13 |
| Col6a6 | Itga2_Itgb1 | Enteroendocrine cells | Stem cells, TA cells | 0.12 |
| Csf2 | Sdc2 | Upper-villus enterocytes | TA cells, Stem cells | 0.08 |

### Ileum-only LR pairs (4)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Lama3 | Itga6_Itgb1 | Upper-villus enterocytes, Blood vascular endothelial cells | TA cells, Stem cells | 0.57 |
| Col19a1 | Itga1_Itgb1 | TA cells | Stem cells, TA cells | 0.26 |
| Col19a1 | Itga2_Itgb1 | TA cells | Stem cells, TA cells | 0.16 |
| Reln | Itga3_Itgb1 | Plamsablasts | TA cells | 0.11 |

---

## Lipid Signaling & Transport

**61 shared | 2 Duodenum-only | 8 Ileum-only**

### Biological Summary

Lipid signaling regulates metabolism and membrane homeostasis. The conserved core includes App→Rpsa (amyloid precursor protein), Psap→Lrp1/Sort1 (prosaposin), and various apolipoproteins. Regional differences: Duodenum has more lipid signaling, particularly App→Rpsa from CLU+ reserve stem cells and Dcn→Egfr from fibroblasts, suggesting stronger metabolic signaling in the proximal intestine.

### Shared LR pairs (61)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Apoe | Sorl1 | Macrophages | Macrophages | D:TA cells, Stem cells I:Stem cells, TA cells | 2.72 |
| Apoe | Lrp6 | Macrophages | Macrophages | Stem cells, TA cells | 2.68 |
| Lama2 | Rpsa | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 2.67 |
| Apoe | Ldlr | Macrophages | Macrophages | TA cells, Stem cells | 2.67 |
| Apoe | Lrp4 | Macrophages | Macrophages | Stem cells, TA cells | 2.67 |
| Apoe | Lrp1 | Macrophages | Macrophages | TA cells, Stem cells | 2.66 |
| Apoe | Lrp5 | Macrophages | Macrophages | D:TA cells, Stem cells I:Stem cells, TA cells | 2.65 |
| Apoe | Sdc2 | Macrophages | Macrophages | Stem cells, TA cells | 2.57 |
| App | Rpsa | CLU+ reserve stem cells, Fibroblasts, TA cells/early progenitors, Enteroendocrine cells, Blood vascular endothelial cells, Macrophages, Stem cells, Goblet cells, TA cells, Upper-villus enterocytes, cDC1, Mid-villus enterocytes* | Fibroblasts, Blood vascular endothelial cells, Enteroendocrine cells, Goblet cells, Macrophages, Upper-villus enterocytes, TA cells/early progenitors, Stem cells, cDC1, TA cells, Mid-villus enterocytes, Plamsablasts, Paneth cells* | Stem cells, TA cells | 2.37 |
| Apoe | Lsr | Macrophages, Blood vascular endothelial cells, Fibroblasts* | Macrophages* | TA cells, Stem cells | 2.30 |
| Dcn | Met | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | D:TA cells, Stem cells I:Stem cells, TA cells | 1.55 |
| Dcn | Erbb4 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | D:TA cells I:TA cells, Stem cells | 1.47 |
| H2-K1 | Aplp2 | Cd8aa IEL, Activated/helper-like T cells, Plamsablasts, cDC1, Macrophages, Upper-villus enterocytes, Fibroblasts* | Cd8aa IEL, Activated/helper-like T cells, cDC1, Macrophages, Plamsablasts* | D:TA cells, Stem cells I:Stem cells, TA cells | 1.44 |
| Grn | Tnfrsf1a | Macrophages | Macrophages | TA cells, Stem cells | 1.24 |
| Grn | Sort1 | Macrophages, cDC1, Fibroblasts* | Macrophages* | Stem cells, TA cells | 1.15 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (2)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Cklf | Lrp6 | Cd8aa IEL, cDC1 | TA cells, Stem cells | 0.37 |
| Tnfsf4 | Traf2 | Enteroendocrine cells | TA cells | 0.07 |

### Ileum-only LR pairs (8)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Grn | Tnfrsf1b | Macrophages | TA cells | 1.25 |
| App | Dcc | Blood vascular endothelial cells, Enteroendocrine cells, Fibroblasts, Goblet cells, Macrophages, Upper-villus enterocytes, Stem cells | TA cells, Stem cells | 0.95 |
| Ntn1 | Dcc | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 0.54 |
| Tnf | Tnfrsf1a | Macrophages | Stem cells, TA cells | 0.44 |
| Sostdc1 | Lrp4 | Cd8aa IEL | Stem cells, TA cells | 0.38 |
| Tnf | Tnfrsf1b | Macrophages | TA cells | 0.37 |
| Sostdc1 | Lrp6 | Cd8aa IEL | Stem cells, TA cells | 0.36 |
| Ntn4 | Dcc | TA cells, TA cells/early progenitors, Stem cells, Enteroendocrine cells, Goblet cells | TA cells, Stem cells | 0.28 |

---

## IGF

**51 shared | 3 Duodenum-only | 7 Ileum-only**

### Biological Summary

IGF signaling promotes cell growth and survival. The conserved core includes Igf1/Igf2 from fibroblasts and other cells to Igf1r and insulin receptor. Regional differences are relatively small, suggesting IGF signaling is a core feature of the intestinal niche regardless of region.

### Shared LR pairs (51)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Apoa1 | Ldlr | Upper-villus enterocytes, Mid-villus enterocytes, Bottom-Villus enterocytes | Upper-villus enterocytes, Mid-villus enterocytes, Bottom-Villus enterocytes | TA cells, Stem cells | 1.30 |
| Apoa1 | Lrp1 | Upper-villus enterocytes, Mid-villus enterocytes, Bottom-Villus enterocytes | Upper-villus enterocytes, Mid-villus enterocytes, Bottom-Villus enterocytes | TA cells, Stem cells | 1.29 |
| H2-K1 | Erbb2 | Cd8aa IEL, Activated/helper-like T cells, Plamsablasts, cDC1, Macrophages, Upper-villus enterocytes, Fibroblasts, Blood vascular endothelial cells, TA cells* | Cd8aa IEL, Activated/helper-like T cells, cDC1, Macrophages, Plamsablasts, Fibroblasts, Stem cells, Upper-villus enterocytes, TA cells* | D:TA cells, Stem cells I:Stem cells, TA cells | 1.28 |
| Hsp90b1 | Erbb2 | Macrophages, Fibroblasts, TA cells/early progenitors, Upper-villus enterocytes, cDC1, Blood vascular endothelial cells, Goblet cells, CLU+ reserve stem cells* | Goblet cells, Fibroblasts, Macrophages, TA cells/early progenitors, Enteroendocrine cells, Plamsablasts, Upper-villus enterocytes, Mid-villus enterocytes, TA cells* | D:TA cells, Stem cells I:Stem cells, TA cells | 1.26 |
| Cdh1 | Igf1r | CLU+ reserve stem cells, Stem cells, TA cells, TA cells/early progenitors, Goblet cells, Upper-villus enterocytes, Enteroendocrine cells* | Stem cells, Upper-villus enterocytes, TA cells/early progenitors, TA cells, Goblet cells, Enteroendocrine cells, Mid-villus enterocytes* | Stem cells, TA cells | 1.08 |
| Lgals1 | Itgb1 | Fibroblasts, Blood vascular endothelial cells, Macrophages* | Fibroblasts, Macrophages* | TA cells, Stem cells | 1.05 |
| Fn1 | Itga6 | Fibroblasts, Blood vascular endothelial cells, Macrophages* | Fibroblasts, Blood vascular endothelial cells* | Stem cells, TA cells | 1.04 |
| Lama2 | Itga6_Itgb4 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | D:TA cells, Stem cells I:Stem cells, TA cells | 1.02 |
| Fbn1 | Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 0.97 |
| Tac1 | Dpp4 | Enteroendocrine cells | Enteroendocrine cells | TA cells, Stem cells | 0.94 |
| Cxcl12 | Dpp4 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 0.94 |
| Vcan | Itgb1 | Fibroblasts, Blood vascular endothelial cells* | Fibroblasts* | TA cells, Stem cells | 0.89 |
| Trf | Tfrc | Macrophages, cDC1, Fibroblasts* | Macrophages* | TA cells, Stem cells | 0.80 |
| Pyy | Dpp4 | Enteroendocrine cells | Enteroendocrine cells | D:Stem cells, TA cells I:TA cells, Stem cells | 0.78 |
| Fn1 | Dpp4 | Fibroblasts, Blood vascular endothelial cells, Macrophages* | Fibroblasts, Blood vascular endothelial cells* | TA cells, Stem cells | 0.77 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (3)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Hsp90b1 | Lrp1 | Macrophages, Fibroblasts | TA cells, Stem cells | 1.50 |
| Ltf | Tfrc | CLU+ reserve stem cells | Stem cells, TA cells | 0.50 |
| Spp1 | Itgav_Itgb6 | CLU+ reserve stem cells | TA cells, Stem cells | 0.46 |

### Ileum-only LR pairs (7)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Hsp90b1 | Tlr1 | Goblet cells, Fibroblasts, Macrophages, TA cells/early progenitors | TA cells | 1.23 |
| Fn1 | Cd79a | Fibroblasts, Blood vascular endothelial cells | TA cells | 0.87 |
| Vcan | Tlr1 | Blood vascular endothelial cells, Fibroblasts | TA cells | 0.79 |
| Trf | Hfe | Macrophages | TA cells | 0.77 |
| Tnr | Itgav_Itgb6 | Enteroendocrine cells | Stem cells, TA cells | 0.40 |
| Bdnf | Erbb2 | Enteroendocrine cells | Stem cells, TA cells | 0.25 |
| Nrg2 | Erbb2_Erbb4 | cDC1 | Stem cells, TA cells | 0.11 |

---

## Cell Cycle / Proliferation

**40 shared | 2 Duodenum-only | 2 Ileum-only**

### Biological Summary

Cell cycle signaling drives epithelial proliferation. The conserved core includes laminins (Lama2, Lamc1, Lamb1) and fibronectin (Fn1) from fibroblasts to dystroglycan (Dag1), CD44, and integrins, plus Mdk→Ncl. Regional differences: Ileum has more Mif→Cd44_Cd74 autocrine signaling from TA cells, while Duodenum has more laminin-dystroglycan adhesion from CLU+ reserve stem cells.

### Shared LR pairs (40)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Lama2 | Dag1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.32 |
| Mdk | Ncl | Fibroblasts, Blood vascular endothelial cells, Enteroendocrine cells, TA cells/early progenitors* | Fibroblasts, TA cells/early progenitors, Macrophages, Plamsablasts* | Stem cells, TA cells | 1.12 |
| Lamc1 | Cd44 | Fibroblasts, Blood vascular endothelial cells, CLU+ reserve stem cells* | Fibroblasts, Blood vascular endothelial cells* | Stem cells, TA cells | 1.04 |
| Fn1 | Cd44 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.01 |
| Lamb1 | Dag1 | Fibroblasts, Blood vascular endothelial cells, Paneth cells, Enteroendocrine cells* | Fibroblasts, Blood vascular endothelial cells, Paneth cells* | TA cells, Stem cells | 1.00 |
| Mif | Egfr | TA cells/early progenitors, TA cells, Stem cells | TA cells, TA cells/early progenitors, Stem cells | D:TA cells, Stem cells I:Stem cells, TA cells | 0.87 |
| Ccl11 | Dpp4 | Fibroblasts, Blood vascular endothelial cells* | Fibroblasts* | TA cells, Stem cells | 0.86 |
| Lamc1 | Itga6_Itgb1 | Fibroblasts, Blood vascular endothelial cells, CLU+ reserve stem cells, Plamsablasts* | Fibroblasts, Blood vascular endothelial cells* | TA cells, Stem cells | 0.85 |
| Lama4 | Dag1 | Fibroblasts, Blood vascular endothelial cells, CLU+ reserve stem cells* | Fibroblasts, Blood vascular endothelial cells* | TA cells, Stem cells | 0.83 |
| Mdk | Sdc4 | Fibroblasts, Blood vascular endothelial cells, Enteroendocrine cells, TA cells/early progenitors* | Fibroblasts, Plamsablasts, Macrophages, TA cells/early progenitors* | Stem cells, TA cells | 0.82 |
| Mif | Tnfrsf14 | TA cells/early progenitors, TA cells, Stem cells | TA cells, TA cells/early progenitors, Stem cells | TA cells | 0.77 |
| Hspg2 | Dag1 | Fibroblasts, Blood vascular endothelial cells, TA cells/early progenitors, Stem cells, TA cells, Enteroendocrine cells | Blood vascular endothelial cells, Fibroblasts, TA cells/early progenitors, Stem cells, TA cells, Enteroendocrine cells | TA cells, Stem cells | 0.69 |
| Lamc1 | Dag1 | Fibroblasts, Blood vascular endothelial cells, CLU+ reserve stem cells, Plamsablasts, Cd8aa IEL, Goblet cells, Enteroendocrine cells, Paneth cells, TA cells/early progenitors, Upper-villus enterocytes* | Fibroblasts, Blood vascular endothelial cells, Stem cells, TA cells/early progenitors, Goblet cells, Enteroendocrine cells, Plamsablasts, TA cells, Upper-villus enterocytes, Mid-villus enterocytes, Paneth cells* | TA cells, Stem cells | 0.64 |
| Gpc3 | Cd81 | Fibroblasts | Fibroblasts | TA cells, Stem cells | 0.64 |
| Fn1 | Sdc2 | Blood vascular endothelial cells, Fibroblasts, Macrophages* | Fibroblasts, Blood vascular endothelial cells* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.58 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (2)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Mdk | Lrp1 | Fibroblasts | TA cells, Stem cells | 0.54 |
| Gpc3 | Lrp1 | Fibroblasts | TA cells | 0.40 |

### Ileum-only LR pairs (2)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Mif | Cd44_Cd74 | TA cells, TA cells/early progenitors, Stem cells | Stem cells, TA cells | 1.38 |
| Has2 | Cd44 | Fibroblasts | Stem cells | 0.59 |

---

## Cell Adhesion & Junctions

**30 shared | 5 Duodenum-only | 3 Ileum-only**

### Biological Summary

Cell adhesion maintains epithelial integrity and tissue architecture. The conserved core includes Cdh1→Ptprm (E-cadherin), various integrins, and tight junction components. Regional differences: Duodenum has more cell adhesion signaling, particularly Cdh1→Ptprm from CLU+ reserve stem cells and Col1a1→Cd44 from fibroblasts, suggesting stronger adhesive support in the proximal intestine.

### Shared LR pairs (30)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Psap | Lrp1 | Macrophages, cDC1* | Macrophages* | TA cells, Stem cells | 2.19 |
| Psap | Sort1 | Macrophages, cDC1, Fibroblasts, Blood vascular endothelial cells* | Macrophages, cDC1* | Stem cells, TA cells | 2.01 |
| Cdh1 | Ptprm | CLU+ reserve stem cells, Stem cells, TA cells, TA cells/early progenitors, Goblet cells, Upper-villus enterocytes* | Goblet cells, TA cells, TA cells/early progenitors, Upper-villus enterocytes, Mid-villus enterocytes, Stem cells* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.88 |
| Efna5 | Ephb2 | Fibroblasts, CLU+ reserve stem cells, Blood vascular endothelial cells* | Fibroblasts, Blood vascular endothelial cells* | Stem cells, TA cells | 0.81 |
| Cxcl12 | Itgav | Blood vascular endothelial cells, Fibroblasts | Blood vascular endothelial cells, Fibroblasts | Stem cells, TA cells | 0.74 |
| Ncam1 | Ptpra | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | D:TA cells, Stem cells I:Stem cells, TA cells | 0.72 |
| Sptan1 | Ptpra | Fibroblasts, Enteroendocrine cells, Blood vascular endothelial cells, Activated/helper-like T cells, Plamsablasts, CLU+ reserve stem cells, TA cells/early progenitors, Upper-villus enterocytes* | Fibroblasts, Upper-villus enterocytes, Activated/helper-like T cells, Enteroendocrine cells, Mid-villus enterocytes, Blood vascular endothelial cells, TA cells/early progenitors* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.61 |
| Vegfa | Itgb1 | CLU+ reserve stem cells, Enteroendocrine cells, Fibroblasts* | Fibroblasts* | TA cells, Stem cells | 0.56 |
| Vegfa | Ephb2 | CLU+ reserve stem cells, Enteroendocrine cells, Paneth cells, TA cells/early progenitors, Goblet cells, Fibroblasts, Upper-villus enterocytes, Activated/helper-like T cells, cDC1, Macrophages, Blood vascular endothelial cells* | Stem cells, TA cells/early progenitors, Goblet cells, Fibroblasts, Enteroendocrine cells, cDC1, Upper-villus enterocytes, Paneth cells, TA cells* | Stem cells, TA cells | 0.53 |
| Icam1 | Egfr | Fibroblasts, Macrophages, Activated/helper-like T cells, Blood vascular endothelial cells, cDC1* | Fibroblasts, Macrophages, Activated/helper-like T cells, cDC1* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.52 |
| L1cam | Ephb2 | Enteroendocrine cells, Stem cells, Upper-villus enterocytes, Goblet cells, TA cells/early progenitors, CLU+ reserve stem cells, TA cells* | Cd8aa IEL, TA cells/early progenitors, Mid-villus enterocytes, Enteroendocrine cells, Upper-villus enterocytes, TA cells, Goblet cells, Stem cells* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.50 |
| Adam10 | Tspan15 | TA cells/early progenitors, Macrophages, CLU+ reserve stem cells, Stem cells, Fibroblasts, Upper-villus enterocytes, cDC1, Plamsablasts, TA cells, Enteroendocrine cells, Cd8aa IEL, Blood vascular endothelial cells, Goblet cells, Activated/helper-like T cells* | Mid-villus enterocytes, Plamsablasts, Goblet cells, TA cells/early progenitors, Stem cells, Macrophages, Enteroendocrine cells, Upper-villus enterocytes, Fibroblasts, cDC1, TA cells* | TA cells, Stem cells | 0.50 |
| Adam10 | Notch1 | TA cells, Stem cells, TA cells/early progenitors, CLU+ reserve stem cells, Blood vascular endothelial cells, Goblet cells, Cd8aa IEL* | Plamsablasts, Goblet cells, TA cells/early progenitors, TA cells, Upper-villus enterocytes* | D:TA cells, Stem cells I:Stem cells | 0.50 |
| Pcsk9 | Sort1 | Upper-villus enterocytes, Goblet cells, Fibroblasts, TA cells/early progenitors* | TA cells/early progenitors, Goblet cells, Stem cells, TA cells, Upper-villus enterocytes, Mid-villus enterocytes, Paneth cells* | Stem cells, TA cells | 0.49 |
| Cgn | Ocln | Enteroendocrine cells, Mid-villus enterocytes, Stem cells, CLU+ reserve stem cells, TA cells, Upper-villus enterocytes, TA cells/early progenitors, Goblet cells* | Upper-villus enterocytes, Stem cells, Enteroendocrine cells, TA cells/early progenitors, TA cells, Paneth cells, Goblet cells, Mid-villus enterocytes* | Stem cells, TA cells | 0.49 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (5)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Cx3cl1 | Itgav | CLU+ reserve stem cells, Upper-villus enterocytes, Goblet cells | TA cells, Stem cells | 0.42 |
| Vegfa | Tyro3 | Upper-villus enterocytes, CLU+ reserve stem cells, Macrophages, Blood vascular endothelial cells, Fibroblasts, Activated/helper-like T cells, Enteroendocrine cells, cDC1 | TA cells | 0.39 |
| Mfng | Notch1 | Cd8aa IEL, Enteroendocrine cells | Stem cells, TA cells | 0.30 |
| Mfng | Notch2 | Cd8aa IEL | Stem cells, TA cells | 0.22 |
| Fndc5 | Itgav | cDC1 | Stem cells, TA cells | 0.20 |

### Ileum-only LR pairs (3)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Adam10 | Tspan5 | Plamsablasts, Goblet cells, TA cells/early progenitors, Upper-villus enterocytes, TA cells | Stem cells, TA cells | 0.40 |
| Bdnf | Sort1 | Enteroendocrine cells | Stem cells, TA cells | 0.39 |
| Vegfa | Grin2b | Stem cells, TA cells/early progenitors, Upper-villus enterocytes, cDC1, Enteroendocrine cells, Fibroblasts | TA cells | 0.26 |

---

## ECM–Integrin

**39 shared | 7 Duodenum-only | 1 Ileum-only**

### Biological Summary

ECM-integrin signaling regulates cell-matrix interactions and mechanotransduction. The conserved core includes collagens (Col1a1, Col4a1, Col6a1), laminins, and fibronectin from fibroblasts to various integrins and CD44. Regional differences: Duodenum has more ECM signaling, suggesting stronger matrix support in the proximal intestine.

### Shared LR pairs (39)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Col1a2 | Cd44 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.74 |
| Col1a1 | Cd44 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.71 |
| Col1a1 | Itga1_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.57 |
| Col1a1 | Itga2_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.49 |
| Col6a2 | Cd44 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.45 |
| Col1a1 | Itga3_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.45 |
| S100a10 | Cftr | CLU+ reserve stem cells, Upper-villus enterocytes, TA cells, Goblet cells, Cd8aa IEL, Fibroblasts, Mid-villus enterocytes, Stem cells, TA cells/early progenitors, Blood vascular endothelial cells, Bottom-Villus enterocytes, Activated/helper-like T cells, Plamsablasts, cDC1, Macrophages* | Upper-villus enterocytes, Mid-villus enterocytes, Goblet cells, Bottom-Villus enterocytes, TA cells, TA cells/early progenitors, Fibroblasts, Cd8aa IEL, Stem cells, Enteroendocrine cells, Activated/helper-like T cells, Paneth cells, Blood vascular endothelial cells, Macrophages* | Stem cells, TA cells | 1.38 |
| Col6a2 | Sdc1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.33 |
| Col6a2 | Itga1_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.31 |
| Col6a2 | Itga2_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.23 |
| Col6a2 | Itga3_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.19 |
| Serping1 | Lrp1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.05 |
| Vcan | Cd44 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 0.97 |
| Nid1 | Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 0.90 |
| Igfbp4 | Lrp6 | Fibroblasts, Blood vascular endothelial cells, Stem cells | Fibroblasts, Blood vascular endothelial cells, Stem cells | Stem cells, TA cells | 0.88 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (7)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Gas6 | Tyro3 | CLU+ reserve stem cells, Fibroblasts, Macrophages, Stem cells | TA cells | 0.94 |
| Mmp13 | Lrp1 | Macrophages | TA cells, Stem cells | 0.74 |
| Pros1 | Tyro3 | Fibroblasts, Macrophages, Blood vascular endothelial cells | TA cells | 0.55 |
| Agrn | Lrp1 | CLU+ reserve stem cells | TA cells, Stem cells | 0.54 |
| Adam15 | Itgb1 | Fibroblasts, Blood vascular endothelial cells | TA cells | 0.45 |
| Col22a1 | Itga1_Itgb1 | Fibroblasts | TA cells, Stem cells | 0.23 |
| Col22a1 | Itga2_Itgb1 | Fibroblasts | TA cells, Stem cells | 0.14 |

### Ileum-only LR pairs (1)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Adam10 | Cd44 | Goblet cells, TA cells/early progenitors, Upper-villus enterocytes | Stem cells | 0.86 |

---

## Apoptosis / Cell Survival

**43 shared | 3 Duodenum-only | 6 Ileum-only**

### Biological Summary

Apoptosis signaling regulates cell death and survival. The conserved core includes various survival signals and death receptor ligands. Regional differences are relatively small, suggesting apoptosis regulation is a core feature of the intestinal niche.

### Shared LR pairs (43)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Pf4 | Fgfr2 | Macrophages, CLU+ reserve stem cells* | Macrophages, Plamsablasts* | TA cells, Stem cells | 1.79 |
| Mmp7 | Cd44 | Paneth cells, CLU+ reserve stem cells* | Paneth cells, Goblet cells* | Stem cells, TA cells | 1.36 |
| Col4a2 | Cd44 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.32 |
| Lama2 | Cd44 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.30 |
| Pf4 | Ldlr | Macrophages | Macrophages | TA cells, Stem cells | 1.30 |
| Pf4 | Lrp1 | Macrophages | Macrophages | TA cells, Stem cells | 1.28 |
| Col6a3 | Cd44 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.25 |
| Pf4 | Adra2a | Macrophages | Macrophages | Stem cells, TA cells | 1.20 |
| Pf4 | Sdc2 | Macrophages | Macrophages | Stem cells, TA cells | 1.19 |
| Pkm | Cd44 | Upper-villus enterocytes* | Upper-villus enterocytes, Macrophages* | D:Stem cells, TA cells I:Stem cells | 1.18 |
| Pf4 | Grm7 | Macrophages | Macrophages | TA cells | 1.15 |
| Sirpa | Cd47 | Macrophages | Macrophages | TA cells, Stem cells | 1.11 |
| Lamb1 | Cd44 | Fibroblasts, Blood vascular endothelial cells, Paneth cells* | Fibroblasts, Blood vascular endothelial cells* | Stem cells, TA cells | 1.08 |
| Spon1 | App | Fibroblasts, Blood vascular endothelial cells, Macrophages* | Fibroblasts, Blood vascular endothelial cells* | Stem cells, TA cells | 0.98 |
| Col14a1 | Cd44 | Fibroblasts* | Fibroblasts, Macrophages* | Stem cells, TA cells | 0.94 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (3)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Mmp9 | Lrp1 | Macrophages | TA cells, Stem cells | 0.87 |
| Spp1 | Cd44 | CLU+ reserve stem cells | Stem cells, TA cells | 0.73 |
| Hgf | Itgb1 | Fibroblasts | Stem cells, TA cells | 0.51 |

### Ileum-only LR pairs (6)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Psen1 | Cd44 | Upper-villus enterocytes | Stem cells | 0.80 |
| Lama3 | Cd44 | Upper-villus enterocytes, Blood vascular endothelial cells | Stem cells | 0.79 |
| Col4a5 | Cd44 | Fibroblasts, Stem cells | Stem cells | 0.72 |
| Col4a6 | Cd44 | Fibroblasts | Stem cells | 0.67 |
| Sostdc1 | Lrp5 | Cd8aa IEL | Stem cells, TA cells | 0.33 |
| Slit2 | Dcc | TA cells, Goblet cells, Mid-villus enterocytes, Stem cells, TA cells/early progenitors, Fibroblasts | TA cells, Stem cells | 0.28 |

---

## Retinoic acid

**45 shared | 4 Duodenum-only | 0 Ileum-only**

### Biological Summary

Retinoic acid signaling regulates differentiation and metabolism. Note: the module primarily captures metabolic/lipid-related signaling (Ybx1, Bsg, Angptl4, Apoc2, Lpl) rather than canonical retinoic acid ligands. Regional differences: Duodenum has more metabolic signaling (Ybx1→Notch1, Bsg→Slc16a1, Angptl4→Sdc4), suggesting stronger metabolic regulation in the proximal intestine.

### Shared LR pairs (45)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Lama1 | Rpsa | Fibroblasts | Fibroblasts | Stem cells, TA cells | 1.98 |
| Col4a1 | Cd44 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.51 |
| Col6a1 | Itga6 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.39 |
| Col4a1 | Cd47 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.39 |
| Ybx1 | Notch1 | TA cells, CLU+ reserve stem cells, TA cells/early progenitors, Stem cells* | TA cells, TA cells/early progenitors* | Stem cells, TA cells | 1.32 |
| Col6a1 | Cd44 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.19 |
| Lama2 | Itga1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.08 |
| Col6a1 | Sdc1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.07 |
| Col4a1 | Itga2_Itgb1 | Fibroblasts, Blood vascular endothelial cells* | Fibroblasts, Blood vascular endothelial cells, Macrophages* | TA cells, Stem cells | 1.06 |
| Col6a1 | Itga1_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.05 |
| Bsg | Slc16a1 | TA cells, Stem cells, CLU+ reserve stem cells, Upper-villus enterocytes, Enteroendocrine cells, Fibroblasts, TA cells/early progenitors* | TA cells, Stem cells, Upper-villus enterocytes, TA cells/early progenitors* | TA cells, Stem cells | 1.04 |
| Col4a1 | Itga3_Itgb1 | Fibroblasts, Blood vascular endothelial cells, Macrophages | Fibroblasts, Blood vascular endothelial cells, Macrophages | TA cells, Stem cells | 1.03 |
| Apoc2 | Lrp1 | Upper-villus enterocytes, Mid-villus enterocytes, Bottom-Villus enterocytes* | Upper-villus enterocytes* | TA cells, Stem cells | 1.02 |
| Col4a1 | Sdc1 | Fibroblasts, Blood vascular endothelial cells, Macrophages | Fibroblasts, Blood vascular endothelial cells, Macrophages | TA cells, Stem cells | 1.02 |
| Rspo3 | Sdc4 | Fibroblasts | Fibroblasts | Stem cells, TA cells | 1.00 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (4)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Rspo2 | Rnf43 | Fibroblasts | TA cells, Stem cells | 0.55 |
| Rspo2 | Lgr5 | Fibroblasts | Stem cells, TA cells | 0.43 |
| Rspo2 | Lgr4 | Fibroblasts | Stem cells, TA cells | 0.38 |
| Rspo2 | Znrf3 | Fibroblasts | Stem cells, TA cells | 0.37 |

### Ileum-only LR pairs (0)

*None*


---

## Axon Guidance

**21 shared | 0 Duodenum-only | 17 Ileum-only**

### Biological Summary

Axon guidance signaling regulates cell positioning and tissue architecture. The conserved core includes Efnb1→Ephb2 from multiple epithelial cell types and Sema4d→Plxnb2 from CD8aa IELs. Regional differences: Ileum has dramatically more axon guidance signaling (+73 pairs in stem cells), driven by ephrin→EphA4 signaling (Efna5, Efna1, Efnb1, Efnb2, Efnb3→Epha4) and semaphorin signaling (Sema4d→Plxnb1). This suggests ephrin-mediated cell positioning is more prominent in the ileal stem cell niche, potentially reflecting differences in crypt architecture or innervation.

### Shared LR pairs (21)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Efnb1 | Ephb2 | Mid-villus enterocytes, CLU+ reserve stem cells, TA cells, Goblet cells, Upper-villus enterocytes, TA cells/early progenitors, Stem cells, Enteroendocrine cells, Fibroblasts, Blood vascular endothelial cells* | Upper-villus enterocytes, Blood vascular endothelial cells, Stem cells, Mid-villus enterocytes, Goblet cells, TA cells, TA cells/early progenitors, Enteroendocrine cells, Fibroblasts* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.57 |
| Sema4d | Plxnb2 | Cd8aa IEL, TA cells/early progenitors, CLU+ reserve stem cells, Stem cells, TA cells, Plamsablasts, cDC1, Activated/helper-like T cells, Macrophages* | Macrophages, cDC1, Cd8aa IEL, Plamsablasts* | TA cells, Stem cells | 0.47 |
| Efna5 | Epha1 | Fibroblasts, CLU+ reserve stem cells, Blood vascular endothelial cells* | Fibroblasts, Blood vascular endothelial cells* | D:TA cells I:TA cells, Stem cells | 0.46 |
| Efnb1 | Ephb4 | Enteroendocrine cells, Mid-villus enterocytes, Blood vascular endothelial cells, Fibroblasts, CLU+ reserve stem cells, Stem cells, TA cells/early progenitors, Upper-villus enterocytes, TA cells, Goblet cells* | Blood vascular endothelial cells, Fibroblasts, Enteroendocrine cells, TA cells/early progenitors, Upper-villus enterocytes, TA cells, Goblet cells, Mid-villus enterocytes, Stem cells* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.45 |
| Efnb3 | Ephb2 | Enteroendocrine cells* | cDC1* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.42 |
| Sema4d | Met | Cd8aa IEL, Macrophages, Activated/helper-like T cells, cDC1, Plamsablasts* | Plamsablasts, Cd8aa IEL, cDC1, Macrophages* | TA cells, Stem cells | 0.41 |
| Efnb3 | Ephb4 | Enteroendocrine cells* | cDC1* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.30 |
| Efnb1 | Ephb3 | CLU+ reserve stem cells, TA cells, Goblet cells, Upper-villus enterocytes, TA cells/early progenitors, Blood vascular endothelial cells, Stem cells, Mid-villus enterocytes, Fibroblasts* | TA cells, Upper-villus enterocytes, Goblet cells, Mid-villus enterocytes, Stem cells, TA cells/early progenitors, Enteroendocrine cells, Fibroblasts, Blood vascular endothelial cells* | Stem cells, TA cells | 0.29 |
| Farp2 | Plxna2 | TA cells/early progenitors, TA cells, Upper-villus enterocytes, Stem cells, Fibroblasts* | Upper-villus enterocytes, TA cells/early progenitors, Goblet cells, TA cells, Stem cells, Fibroblasts, Mid-villus enterocytes* | Stem cells, TA cells | 0.25 |
| Efna1 | Epha1 | TA cells, Stem cells, Upper-villus enterocytes* | Stem cells, TA cells, Blood vascular endothelial cells, Upper-villus enterocytes* | D:TA cells I:Stem cells, TA cells | 0.25 |
| Farp2 | Plxna1 | Stem cells, TA cells, TA cells/early progenitors, Upper-villus enterocytes* | TA cells, Mid-villus enterocytes, Upper-villus enterocytes, Goblet cells, Stem cells, TA cells/early progenitors* | D:TA cells I:TA cells, Stem cells | 0.23 |
| Efna1 | Epha2 | TA cells, Stem cells, Upper-villus enterocytes | Upper-villus enterocytes, TA cells, Stem cells | TA cells | 0.23 |
| Sema6a | Plxna2 | Upper-villus enterocytes, CLU+ reserve stem cells, Blood vascular endothelial cells, Fibroblasts, Enteroendocrine cells* | Enteroendocrine cells, Upper-villus enterocytes, Blood vascular endothelial cells, Fibroblasts* | Stem cells, TA cells | 0.22 |
| Efna2 | Epha1 | Fibroblasts | Fibroblasts | D:TA cells I:TA cells, Stem cells | 0.18 |
| Efna4 | Epha1 | TA cells, Stem cells* | TA cells/early progenitors, TA cells, Stem cells* | D:TA cells I:TA cells, Stem cells | 0.17 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (0)

*None*


### Ileum-only LR pairs (17)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Efna5 | Epha4 | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 0.77 |
| Sema4a | Plxnb1 | Stem cells, TA cells, Upper-villus enterocytes, Goblet cells, TA cells/early progenitors, Enteroendocrine cells, Mid-villus enterocytes | Stem cells | 0.43 |
| Efna1 | Epha4 | Stem cells, TA cells, Blood vascular endothelial cells, Enteroendocrine cells, Upper-villus enterocytes, Mid-villus enterocytes | TA cells, Stem cells | 0.42 |
| Efna1 | Epha7 | Stem cells, Upper-villus enterocytes, TA cells, Blood vascular endothelial cells | Stem cells, TA cells | 0.39 |
| Efnb1 | Epha4 | Upper-villus enterocytes, Stem cells, Mid-villus enterocytes, Goblet cells, TA cells, TA cells/early progenitors, Fibroblasts | Stem cells, TA cells | 0.37 |
| Sema4d | Plxnb1 | cDC1, Cd8aa IEL, Macrophages, Plamsablasts | Stem cells | 0.36 |
| Efnb2 | Epha4 | TA cells, Upper-villus enterocytes, Fibroblasts, Goblet cells, TA cells/early progenitors, Enteroendocrine cells, Mid-villus enterocytes | TA cells, Stem cells | 0.33 |
| Efna4 | Epha4 | TA cells, Stem cells, TA cells/early progenitors | Stem cells, TA cells | 0.27 |
| Efna2 | Epha4 | Fibroblasts | TA cells, Stem cells | 0.23 |
| Efna4 | Epha7 | TA cells/early progenitors, TA cells, Stem cells | TA cells, Stem cells | 0.23 |
| Efna2 | Epha7 | Fibroblasts | TA cells, Stem cells | 0.19 |
| Fgfr3 | Epha4 | Paneth cells, TA cells, TA cells/early progenitors, Enteroendocrine cells, Stem cells, Goblet cells | TA cells, Stem cells | 0.18 |
| Fgfr4 | Epha4 | Goblet cells, Upper-villus enterocytes, Mid-villus enterocytes, TA cells, Stem cells, TA cells/early progenitors | TA cells, Stem cells | 0.18 |
| Efnb3 | Epha4 | cDC1 | TA cells, Stem cells | 0.13 |
| Efna3 | Epha4 | TA cells/early progenitors, TA cells | TA cells, Stem cells | 0.12 |

---

## Mitochondrial & Oxidative Metabolism

**31 shared | 2 Duodenum-only | 4 Ileum-only**

### Biological Summary

Mitochondrial signaling regulates energy metabolism and oxidative stress. The conserved core includes various metabolic enzymes and transporters. Regional differences are relatively small, suggesting metabolic regulation is a core feature of the intestinal niche.

### Shared LR pairs (31)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Col1a1 | Sdc1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.59 |
| Col1a1 | Ddr1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.49 |
| Agrp | Sdc1 | Stem cells, TA cells | Stem cells, TA cells | TA cells, Stem cells | 1.26 |
| Col4a2 | Sdc1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.21 |
| Apob | Lrp1 | Upper-villus enterocytes, Mid-villus enterocytes* | Upper-villus enterocytes* | TA cells, Stem cells | 1.15 |
| Col6a3 | Sdc1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.04 |
| Apoa4 | Lrp1 | Upper-villus enterocytes, Mid-villus enterocytes, Bottom-Villus enterocytes* | Upper-villus enterocytes* | TA cells, Stem cells | 1.03 |
| Apoa4 | Ldlr | Upper-villus enterocytes, Mid-villus enterocytes, Bottom-Villus enterocytes, TA cells* | Upper-villus enterocytes* | TA cells, Stem cells | 0.96 |
| Arpc5 | Ldlr | cDC1, Macrophages, Enteroendocrine cells, Upper-villus enterocytes, Cd8aa IEL, TA cells* | Upper-villus enterocytes, cDC1, Macrophages, Goblet cells, Mid-villus enterocytes, TA cells* | TA cells, Stem cells | 0.88 |
| Col5a2 | Ddr1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 0.78 |
| Actr2 | Ldlr | cDC1, Macrophages, Cd8aa IEL, Upper-villus enterocytes, TA cells/early progenitors, Goblet cells, Plamsablasts, TA cells* | cDC1, Upper-villus enterocytes, Macrophages, TA cells/early progenitors, Goblet cells, Mid-villus enterocytes* | TA cells, Stem cells | 0.76 |
| Hspg2 | Lrp1 | Fibroblasts, Blood vascular endothelial cells | Blood vascular endothelial cells, Fibroblasts | TA cells, Stem cells | 0.76 |
| Apob | Ldlr | Upper-villus enterocytes, Mid-villus enterocytes, Enteroendocrine cells, TA cells/early progenitors, Bottom-Villus enterocytes, TA cells, Stem cells | Upper-villus enterocytes, Bottom-Villus enterocytes, Mid-villus enterocytes, TA cells, Stem cells, Enteroendocrine cells, TA cells/early progenitors | TA cells, Stem cells | 0.71 |
| Ccl5 | Sdc1 | Cd8aa IEL, Activated/helper-like T cells, TA cells, Stem cells* | Cd8aa IEL, cDC1, Stem cells, TA cells* | TA cells, Stem cells | 0.69 |
| Mmp7 | Sdc1 | Paneth cells, CLU+ reserve stem cells, Enteroendocrine cells, Goblet cells* | Paneth cells, Goblet cells, Stem cells, TA cells, TA cells/early progenitors* | TA cells, Stem cells | 0.67 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (2)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Apoa2 | Ldlr | Upper-villus enterocytes, Enteroendocrine cells | TA cells | 0.31 |
| Col6a6 | Sdc1 | Enteroendocrine cells | Stem cells, TA cells | 0.24 |

### Ileum-only LR pairs (4)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Serpina1b | Lrp1 | Goblet cells, Enteroendocrine cells | TA cells, Stem cells | 0.66 |
| Serpine2 | Lrp1 | Fibroblasts | TA cells, Stem cells | 0.57 |
| Vwf | Lrp1 | Blood vascular endothelial cells | Stem cells, TA cells | 0.49 |
| Tnn | Sdc1 | Fibroblasts | TA cells, Stem cells | 0.30 |

---

## Antigen presentation

**19 shared | 0 Duodenum-only | 3 Ileum-only**

### Biological Summary

Antigen presentation regulates immune surveillance. The conserved core includes B2m→Tfrc (β2-microglobulin to transferrin receptor) and H2-K1→various receptors. Regional differences: Duodenum has more antigen presentation from CD8aa IELs and T helper cells, suggesting stronger immune surveillance in the proximal intestine.

### Shared LR pairs (19)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| B2m | Tfrc | Cd8aa IEL, Activated/helper-like T cells, Macrophages, Plamsablasts, cDC1, Fibroblasts, Blood vascular endothelial cells, Upper-villus enterocytes* | Macrophages, Plamsablasts, Cd8aa IEL, TA cells* | TA cells, Stem cells | 1.63 |
| Hsp90aa1 | Cftr | Activated/helper-like T cells, Macrophages, TA cells/early progenitors, Enteroendocrine cells, cDC1, Blood vascular endothelial cells, TA cells, Fibroblasts, Plamsablasts, Stem cells, Cd8aa IEL, Upper-villus enterocytes, CLU+ reserve stem cells, Mid-villus enterocytes* | TA cells/early progenitors, Macrophages, cDC1, Enteroendocrine cells, Fibroblasts, Plamsablasts, TA cells, Activated/helper-like T cells, Stem cells, Goblet cells, Blood vascular endothelial cells, Upper-villus enterocytes, Mid-villus enterocytes, Bottom-Villus enterocytes* | Stem cells, TA cells | 1.60 |
| Hspa8 | Ldlr | Activated/helper-like T cells, Macrophages, cDC1, TA cells, Stem cells* | Macrophages, TA cells/early progenitors, TA cells, Stem cells* | TA cells, Stem cells | 1.58 |
| Col3a1 | Itga1_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.55 |
| Col3a1 | Ddr1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | Stem cells, TA cells | 1.47 |
| Col3a1 | Itga2_Itgb1 | Fibroblasts, Blood vascular endothelial cells | Fibroblasts, Blood vascular endothelial cells | TA cells, Stem cells | 1.46 |
| Hsp90aa1 | Erbb2 | Activated/helper-like T cells, Macrophages, TA cells/early progenitors, cDC1, Blood vascular endothelial cells, TA cells, Fibroblasts, Plamsablasts* | TA cells/early progenitors, Macrophages, cDC1, Enteroendocrine cells, Fibroblasts, Plamsablasts, TA cells* | D:TA cells, Stem cells I:Stem cells, TA cells | 1.22 |
| Hsp90aa1 | Egfr | Activated/helper-like T cells, Macrophages, TA cells/early progenitors, cDC1, TA cells, Fibroblasts* | TA cells/early progenitors, Macrophages, cDC1, Fibroblasts, TA cells* | D:TA cells, Stem cells I:Stem cells, TA cells | 1.18 |
| Cd86 | Ctla4 | cDC1, Plamsablasts, Macrophages | cDC1, Macrophages, Plamsablasts | Stem cells, TA cells | 0.93 |
| Shank2 | Cftr | TA cells/early progenitors, CLU+ reserve stem cells, Paneth cells, TA cells, Stem cells, Enteroendocrine cells, Goblet cells, Upper-villus enterocytes* | TA cells/early progenitors, Goblet cells, Stem cells, TA cells, Paneth cells, Mid-villus enterocytes, Upper-villus enterocytes* | Stem cells, TA cells | 0.82 |
| Cd14 | Itgb1 | Macrophages | Macrophages | TA cells, Stem cells | 0.71 |
| Cd80 | Ctla4 | cDC1, Macrophages* | cDC1, Macrophages, Plamsablasts* | Stem cells, TA cells | 0.67 |
| Il1b | Sigirr | Macrophages, cDC1 | Macrophages, cDC1 | D:Stem cells, TA cells I:TA cells, Stem cells | 0.59 |
| Cd14 | Ripk1 | Macrophages | Macrophages | D:Stem cells, TA cells I:TA cells, Stem cells | 0.51 |
| Tnfsf10 | Ripk1 | Cd8aa IEL* | Cd8aa IEL, Stem cells* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.42 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (0)

*None*


### Ileum-only LR pairs (3)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| B2m | Cd3g | Macrophages, Plamsablasts, TA cells | TA cells | 1.45 |
| B2m | Hfe | Macrophages | TA cells | 1.44 |
| Cd14 | Tlr1 | Macrophages | TA cells | 0.44 |

---

## Neurotransmitter/serotonin

**7 shared | 1 Duodenum-only | 2 Ileum-only**

### Biological Summary

Neurotransmitter signaling regulates epithelial function and motility. The conserved core includes Tph1→Htr4 (serotonin) from enteroendocrine cells. Regional differences: Ileum has more neurotransmitter signaling, consistent with higher enteroendocrine cell density and serotonergic innervation in the distal intestine.

### Shared LR pairs (7)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Tph1 | Htr4 | Enteroendocrine cells | Enteroendocrine cells | Stem cells, TA cells | 1.17 |
| Gnai2 | Igf1r | cDC1, Macrophages, CLU+ reserve stem cells, Enteroendocrine cells, Fibroblasts, Cd8aa IEL, Activated/helper-like T cells, Blood vascular endothelial cells, Plamsablasts, TA cells* | cDC1, Macrophages, Fibroblasts, Blood vascular endothelial cells, Activated/helper-like T cells, Upper-villus enterocytes, Plamsablasts, Goblet cells, TA cells* | Stem cells, TA cells | 0.93 |
| Arf1 | Chrm3 | Upper-villus enterocytes, CLU+ reserve stem cells, Macrophages, Fibroblasts, cDC1, TA cells/early progenitors, Enteroendocrine cells, Goblet cells, TA cells, Activated/helper-like T cells, Plamsablasts, Cd8aa IEL, Mid-villus enterocytes* | Upper-villus enterocytes, Goblet cells, TA cells/early progenitors, Fibroblasts, Macrophages, Mid-villus enterocytes, TA cells, Enteroendocrine cells, cDC1, Blood vascular endothelial cells, Bottom-Villus enterocytes* | Stem cells, TA cells | 0.91 |
| Arf1 | Insr | Upper-villus enterocytes, CLU+ reserve stem cells, Macrophages, Fibroblasts, cDC1, TA cells/early progenitors, Goblet cells, TA cells* | Upper-villus enterocytes, Goblet cells, TA cells/early progenitors, Fibroblasts, Macrophages, Mid-villus enterocytes, TA cells* | Stem cells, TA cells | 0.87 |
| Gnai2 | Egfr | cDC1, Macrophages, CLU+ reserve stem cells, Enteroendocrine cells, Fibroblasts, Cd8aa IEL, Activated/helper-like T cells, Blood vascular endothelial cells* | cDC1, Macrophages, Fibroblasts, Blood vascular endothelial cells, Upper-villus enterocytes* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.80 |
| Gnai2 | Adcy9 | cDC1, Macrophages, CLU+ reserve stem cells, Fibroblasts, Cd8aa IEL, Activated/helper-like T cells, Blood vascular endothelial cells* | cDC1, Macrophages, Fibroblasts, Blood vascular endothelial cells, Upper-villus enterocytes* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.79 |
| Gnai2 | Adra2a | cDC1, Macrophages, CLU+ reserve stem cells, Enteroendocrine cells, Fibroblasts, Cd8aa IEL, Activated/helper-like T cells, Blood vascular endothelial cells, Plamsablasts* | Macrophages, Fibroblasts, cDC1, Upper-villus enterocytes, Blood vascular endothelial cells* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.75 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (1)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Arf1 | Pld2 | Upper-villus enterocytes, CLU+ reserve stem cells, Macrophages, Fibroblasts, cDC1 | TA cells | 0.89 |

### Ileum-only LR pairs (2)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Gnas | Adcy8 | Cd8aa IEL, Fibroblasts, Blood vascular endothelial cells, Enteroendocrine cells, cDC1, Goblet cells, TA cells, Upper-villus enterocytes, Stem cells, Plamsablasts, TA cells/early progenitors, Mid-villus enterocytes, Macrophages | Stem cells, TA cells | 1.31 |
| Gnai2 | Adcy8 | cDC1, Macrophages, Fibroblasts, Blood vascular endothelial cells, Upper-villus enterocytes | Stem cells, TA cells | 1.09 |

---

## Interferon

**10 shared | 0 Duodenum-only | 0 Ileum-only**

### Biological Summary

Interferon signaling regulates immune responses. The conserved core includes Cxcl10→Sdc4 from endothelial cells and macrophages. Regional differences: Duodenum has more interferon signaling from endothelial cells and T helper cells, suggesting stronger immune activation in the proximal intestine.

### Shared LR pairs (10)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Spon2 | Itgb1 | Fibroblasts, Blood vascular endothelial cells* | Fibroblasts* | TA cells, Stem cells | 0.94 |
| Cxcl10 | Sdc4 | Blood vascular endothelial cells, Activated/helper-like T cells, Fibroblasts, Plamsablasts, cDC1* | Plamsablasts, cDC1, Macrophages, Fibroblasts* | Stem cells, TA cells | 0.86 |
| Epo | Ephb4 | TA cells, Stem cells | TA cells, Stem cells | Stem cells, TA cells | 0.69 |
| Efnb2 | Ephb2 | Upper-villus enterocytes, TA cells/early progenitors, Blood vascular endothelial cells, Goblet cells, Enteroendocrine cells, CLU+ reserve stem cells, TA cells, Mid-villus enterocytes, Fibroblasts* | TA cells/early progenitors, Enteroendocrine cells, Upper-villus enterocytes, Fibroblasts, Mid-villus enterocytes, Goblet cells, cDC1, TA cells* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.54 |
| Efnb2 | Ephb4 | Mid-villus enterocytes, Fibroblasts, TA cells/early progenitors, Upper-villus enterocytes, Enteroendocrine cells, TA cells, Blood vascular endothelial cells, CLU+ reserve stem cells, Goblet cells* | TA cells/early progenitors, Enteroendocrine cells, Goblet cells, Mid-villus enterocytes, Upper-villus enterocytes, Fibroblasts, TA cells, cDC1* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.42 |
| Cxcl10 | Dpp4 | Plamsablasts, cDC1, Blood vascular endothelial cells, Fibroblasts, Activated/helper-like T cells* | Macrophages, Fibroblasts, Plamsablasts* | TA cells, Stem cells | 0.40 |
| Efnb2 | Ephb3 | Upper-villus enterocytes, Blood vascular endothelial cells, Goblet cells, TA cells/early progenitors, CLU+ reserve stem cells, TA cells, Mid-villus enterocytes, Fibroblasts* | TA cells, Mid-villus enterocytes, Goblet cells, Fibroblasts, Upper-villus enterocytes, TA cells/early progenitors, Enteroendocrine cells, cDC1* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.26 |
| Cxcl10 | Adra2a | Blood vascular endothelial cells, Activated/helper-like T cells, Fibroblasts, cDC1, Plamsablasts* | Fibroblasts, Macrophages, Plamsablasts* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.22 |
| Efnb2 | Rhbdl2 | TA cells, TA cells/early progenitors, Mid-villus enterocytes, Upper-villus enterocytes, CLU+ reserve stem cells, Blood vascular endothelial cells, Goblet cells, Fibroblasts* | TA cells/early progenitors, Goblet cells, Fibroblasts, Upper-villus enterocytes, Mid-villus enterocytes* | TA cells | 0.20 |
| Cxcl10 | Grm7 | cDC1, Plamsablasts, Blood vascular endothelial cells, Fibroblasts, Activated/helper-like T cells* | Fibroblasts, Macrophages, Plamsablasts* | TA cells | 0.17 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (0)

*None*


### Ileum-only LR pairs (0)

*None*


---

## Chemokine

**8 shared | 3 Duodenum-only | 0 Ileum-only**

### Biological Summary

Chemokine signaling regulates immune cell recruitment. The conserved core includes Calr→Lrp1/Itgav/Itga3 (calreticulin) from macrophages and fibroblasts. Regional differences: Duodenum has more chemokine signaling, suggesting stronger immune cell recruitment in the proximal intestine.

### Shared LR pairs (8)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Calr | Itgav | Macrophages, Fibroblasts* | Goblet cells* | D:TA cells, Stem cells I:Stem cells, TA cells | 1.15 |
| Calr | Itga3 | Macrophages, Fibroblasts, cDC1, Upper-villus enterocytes, TA cells* | Goblet cells, Fibroblasts, Macrophages, Upper-villus enterocytes* | TA cells, Stem cells | 1.07 |
| Fbln1 | Itgb1 | Fibroblasts, Blood vascular endothelial cells, Upper-villus enterocytes* | Fibroblasts* | TA cells, Stem cells | 1.00 |
| Col18a1 | Itga3 | Fibroblasts, Blood vascular endothelial cells | Blood vascular endothelial cells, Fibroblasts | D:TA cells, Stem cells I:Stem cells, TA cells | 0.65 |
| Timp2 | Itga3 | Fibroblasts, Blood vascular endothelial cells, CLU+ reserve stem cells, Cd8aa IEL, Activated/helper-like T cells* | Blood vascular endothelial cells, Fibroblasts, Macrophages* | TA cells, Stem cells | 0.50 |
| Sema4a | Plxnb2 | TA cells/early progenitors, TA cells, Blood vascular endothelial cells, Stem cells, Fibroblasts, Mid-villus enterocytes, Upper-villus enterocytes, Enteroendocrine cells, CLU+ reserve stem cells, Goblet cells* | Mid-villus enterocytes, TA cells/early progenitors, Activated/helper-like T cells, Upper-villus enterocytes, TA cells, Stem cells, Goblet cells, Enteroendocrine cells* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.41 |
| Adam9 | Itga3 | CLU+ reserve stem cells, Fibroblasts, cDC1, Macrophages, Blood vascular endothelial cells, Goblet cells, TA cells/early progenitors* | Fibroblasts, Macrophages* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.31 |
| Lgals8 | Itga3 | Macrophages, Enteroendocrine cells, Cd8aa IEL, Upper-villus enterocytes, CLU+ reserve stem cells, Fibroblasts, Plamsablasts* | Macrophages, Upper-villus enterocytes, Fibroblasts* | TA cells, Stem cells | 0.27 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (3)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Calr | Lrp1 | Macrophages, Fibroblasts | TA cells, Stem cells | 1.29 |
| Cxcl5 | Adra2a | Fibroblasts | TA cells, Stem cells | 0.17 |
| Cxcl5 | Grm7 | Fibroblasts | TA cells | 0.08 |

### Ileum-only LR pairs (0)

*None*


---

## Guanylate cyclase

**2 shared | 0 Duodenum-only | 0 Ileum-only**

### Biological Summary

Guanylate cyclase signaling regulates fluid secretion and barrier function. The conserved core includes Guca2a/Guca2b→Gucy2c from enterocytes and goblet cells. Regional differences: Ileum has more guanylate cyclase signaling, consistent with the known role of guanylin peptides in distal intestinal physiology.

### Shared LR pairs (2)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Guca2a | Gucy2c | Goblet cells, Paneth cells, Upper-villus enterocytes, CLU+ reserve stem cells* | Goblet cells, Upper-villus enterocytes, Mid-villus enterocytes, Paneth cells, Bottom-Villus enterocytes, Stem cells, TA cells* | D:TA cells, Stem cells I:Stem cells, TA cells | 1.13 |
| Guca2b | Gucy2c | Upper-villus enterocytes, Paneth cells, Mid-villus enterocytes, Goblet cells, CLU+ reserve stem cells, Bottom-Villus enterocytes, TA cells/early progenitors* | Upper-villus enterocytes, Paneth cells, Mid-villus enterocytes, TA cells, TA cells/early progenitors, Goblet cells, Stem cells, Bottom-Villus enterocytes* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.74 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (0)

*None*


### Ileum-only LR pairs (0)

*None*


---

## TNF/NF-kB

**5 shared | 0 Duodenum-only | 4 Ileum-only**

### Biological Summary

TNF/NF-κB signaling regulates inflammation and cell survival. The conserved core is limited. Regional differences: Ileum has more TNF signaling, suggesting stronger inflammatory signaling in the distal intestine.

### Shared LR pairs (5)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Il16 | Cd9 | Cd8aa IEL* | Cd8aa IEL, Macrophages, Plamsablasts, Activated/helper-like T cells* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.53 |
| Impg2 | Prlr | Upper-villus enterocytes, Enteroendocrine cells* | Cd8aa IEL, Upper-villus enterocytes* | D:Stem cells, TA cells I:TA cells, Stem cells | 0.44 |
| Cxcl1 | Dpp4 | Macrophages, Fibroblasts, Blood vascular endothelial cells* | Macrophages* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.43 |
| Cxcl1 | Adra2a | Blood vascular endothelial cells, Fibroblasts, Macrophages* | Macrophages* | Stem cells, TA cells | 0.25 |
| Cxcl1 | Grm7 | Macrophages, Blood vascular endothelial cells, Fibroblasts* | Macrophages* | TA cells | 0.20 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (0)

*None*


### Ileum-only LR pairs (4)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Spon2 | Itgam | Fibroblasts | TA cells | 0.82 |
| L1cam | Cd9 | TA cells/early progenitors, Upper-villus enterocytes, TA cells, Goblet cells, Stem cells, Cd8aa IEL, Mid-villus enterocytes | TA cells | 0.72 |
| C3 | Itgam | Fibroblasts | TA cells | 0.44 |
| Il16 | Grin2b | Macrophages, Activated/helper-like T cells, Plamsablasts, Cd8aa IEL | TA cells | 0.32 |

---

## PDGF

**2 shared | 0 Duodenum-only | 6 Ileum-only**

### Biological Summary

PDGF signaling regulates mesenchymal cell proliferation. The conserved core is limited. Regional differences: Ileum has more PDGF signaling (Psap→Celsr1 from macrophages and cDC1), suggesting stronger mesenchymal-epithelial cross-talk in the distal intestine.

### Shared LR pairs (2)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Vim | Cd44 | Fibroblasts, cDC1, Enteroendocrine cells, Macrophages, Blood vascular endothelial cells* | Fibroblasts, Macrophages, Blood vascular endothelial cells* | Stem cells, TA cells | 1.23 |
| Gas6 | Mertk | CLU+ reserve stem cells, Stem cells, Macrophages, Fibroblasts* | Stem cells* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.62 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (0)

*None*


### Ileum-only LR pairs (6)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| Psap | Celsr1 | Macrophages, cDC1 | Stem cells, TA cells | 2.32 |
| Apob | Itgam | Upper-villus enterocytes, Mid-villus enterocytes | TA cells | 1.17 |
| Selplg | Itgam | Cd8aa IEL, Activated/helper-like T cells | TA cells | 0.55 |
| Cfh | Itgam | Fibroblasts | TA cells | 0.47 |
| Mmp9 | Itgam | Macrophages | TA cells | 0.44 |
| Plat | Itgam | Blood vascular endothelial cells | TA cells | 0.22 |

---

## Granzyme/cytotoxicity

**2 shared | 1 Duodenum-only | 0 Ileum-only**

### Biological Summary

Granzyme signaling mediates cytotoxic lymphocyte activity. The conserved core includes Gzma→Pard3/F2rl1 from TA/stem cells. Regional differences: Duodenum has more granzyme signaling from CD8aa IELs, suggesting enhanced cytotoxic activity in the proximal intestine.

### Shared LR pairs (2)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Gzma | Pard3 | Cd8aa IEL, TA cells, Stem cells* | TA cells, Stem cells* | Stem cells, TA cells | 0.75 |
| Gzma | F2rl1 | Cd8aa IEL, Stem cells, TA cells* | TA cells, Stem cells* | D:TA cells, Stem cells I:Stem cells, TA cells | 0.54 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (1)

| Ligand | Receptor | Senders | Receivers | Max lr_means |
|--------|----------|---------|-----------|-------------|
| F2 | F2rl1 | Enteroendocrine cells | Stem cells, TA cells | 0.08 |

### Ileum-only LR pairs (0)

*None*


---

## Muc2-Agr2

**1 shared | 0 Duodenum-only | 0 Ileum-only**

### Biological Summary

Muc2-Agr2 signaling regulates mucus production and goblet cell function. The conserved core includes Muc2→Agr2 from goblet and Paneth cells. Regional differences: Ileum has slightly more Muc2-Agr2 signaling, consistent with higher goblet cell density in the distal intestine.

### Shared LR pairs (1)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| Muc2 | Agr2 | Goblet cells, Paneth cells, TA cells, Stem cells* | Goblet cells, Paneth cells, Stem cells, TA cells, TA cells/early progenitors, Plamsablasts* | Stem cells, TA cells | 1.20 |

*\* Sender differs between regions*

### Duodenum-only LR pairs (0)

*None*


### Ileum-only LR pairs (0)

*None*


---

## Complement

**2 shared | 0 Duodenum-only | 0 Ileum-only**

### Biological Summary

Complement signaling regulates innate immunity. The conserved core includes C1qb→C1qbp/Lrp1 from macrophages. This module is fully conserved (no region-unique pairs), suggesting complement signaling is a core feature of the intestinal immune niche.

### Shared LR pairs (2)

| Ligand | Receptor | Duo Senders | Ile Senders | Receivers | Avg lr_means |
|--------|----------|-------------|-------------|-----------|-------------|
| C1qb | C1qbp | Macrophages | Macrophages | TA cells, Stem cells | 2.18 |
| C1qb | Lrp1 | Macrophages | Macrophages | TA cells, Stem cells | 1.67 |

### Duodenum-only LR pairs (0)

*None*


### Ileum-only LR pairs (0)

*None*


---

