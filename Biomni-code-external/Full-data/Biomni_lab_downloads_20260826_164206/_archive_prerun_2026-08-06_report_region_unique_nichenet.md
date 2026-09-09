# Biological Summary: NicheNet-Filtered Region-Unique Interactions (Duodenum vs Ileum)

This report interprets the **region-unique ligand–receptor (LR) interactions that also pass the NicheNet active-ligand filter** — i.e., LR pairs that are (a) detected as significant by LIANA in only one region and (b) whose ligand is among the top NicheNet-predicted regulators of the regional gene program in Stem/TA cells. This is the highest-confidence subset: region-specific **and** linked to the downstream transcriptional response.

**Dataset:** 56 LR pairs (32 Duodenum-only, 24 Ileum-only) across 11 curated modules. Receivers are Stem cells and TA cells throughout; senders are the surrounding niche populations. `max_lr_means` is the LIANA expression-strength score (higher = stronger). Modules are ordered by total pair count.

**Module labels** are derived directly from the ligand genes (curated ligand→pathway map), so each label reflects the actual biology of its pairs.

**Reading the direction:** ligand is produced by the **sender** cell type(s); the receptor is on the **receiver** (Stem/TA). "Region-unique" means the pair was significant in that region only.

---

## ECM–Integrin / Matrix (Both regions: 9 Duodenum / 4 Ileum)

**Duodenum (9 pairs).** Top pair: **Cthrc1→Fzd5** (0.38, Enteroendocrine→Stem/TA). Also **Col13a1→Itga1_Itgb1**, **Col6a6→Sdc1/Itga1_Itgb1**, and collagen→integrin pairs from Endothelial and Enteroendocrine cells.
- Senders: Enteroendocrine cells, Blood vascular endothelial cells.

**Ileum (4 pairs).** Top pair: **Lama3→Cd44** (0.79, Upper-villus EC + Endothelial→Stem). Also **Lama3→Itga6_Itgb1** (0.57), **Col19a1→Itga1/Itga2_Itgb1** (TA cells, i.e., autocrine).
- Senders: Upper-villus EC, Endothelial, TA cells.

**Interpretation.** Basement-membrane and matricellular signaling couples the vascular niche, the epithelial basement membrane, and stem-cell adhesion [24]. The duodenum shows a broader **collagen→integrin** repertoire from a **vascular-endothelial** source, plus **Cthrc1→Fzd5** (a matricellular Wnt-modulating cue). The ileum is dominated by **Lama3→Itga6/Cd44**, the canonical epithelial laminin–integrin adhesion axis. This suggests the proximal niche leans on endothelial-derived ECM cues while the ileal niche relies more on epithelial laminin anchoring.

---

## Immune / antigen & integrin-Itgam (Both regions: 2 Duodenum / 5 Ileum)

**Duodenum (2 pairs).** **Cxcl5→Adra2a** (0.17) and **Cxcl5→Grm7** (Fibroblasts→Stem/TA).
- Senders: Fibroblasts.

**Ileum (5 pairs).** Top pair: **Il18→Il1rapl1** (0.54, Upper/Mid-villus enterocytes + Macrophages→Stem/TA). Also **Cfh→Itgam** (0.47), **Tnf→Tnfrsf1a/Tnfrsf1b**, and **Kitl→Kit**-adjacent immune cues.
- Senders: Upper/Mid-villus enterocytes, Macrophages, Fibroblasts.

**Interpretation.** The ileum is enriched for **innate-immune** signaling onto Stem/TA: **IL-18→Il1rapl1** is a hallmark of ileal epithelial–immune crosstalk (the ileum bears the greatest microbial/antigenic load and Paneth-cell-driven innate defense), and **Cfh/Tnf→Itgam/Tnfrsf** reflect complement and TNF-tone engagement [5, 8]. The duodenum shows only low-level **Cxcl5** chemokine tone. The ileal immune bias over the duodenum is a recurring theme across modules.

---

## Other (Both regions: 5 Duodenum / 2 Ileum)

**Duodenum (5 pairs).** Top pair: **Calca→Vipr1** and **Calca→Ramp2** (Activated/helper-like T cells→Stem/TA). Also **Hsp90b1→Lrp1** (1.50, Macrophages + Fibroblasts — the single strongest NicheNet-filtered pair in the duodenum), **Nlgn3→Nrxn1**, **Alb→B2m_Fcgrt**.
- Senders: Activated/helper-like T cells, Macrophages, Fibroblasts, Enteroendocrine cells.

**Ileum (2 pairs).** **Hsp90b1→Tlr1** (1.23, Goblet/Fibroblasts/Macrophages/TA-progenitors→TA), **Gnas→Adcy8** (1.31, very broad sender base).

**Interpretation.** A heterogeneous set without a single clean pathway. Notable: **Hsp90b1 (GRP94)** signals strongly in both regions but through **different receptors** (Lrp1 proximally vs Tlr1 distally) and a broader ileal sender base, echoing the ileum's greater innate-immune/TLR engagement [5]. The duodenum also shows **Calca (calcitonin-gene-related peptide)→Vipr1/Ramp2** neuroendocrine peptide input, consistent with enteroendocrine cells acting as a paracrine niche signal source proximally [8]. Ileal **Gnas→Adcy8** reflects ubiquitous GPCR/cAMP second-messenger tone.

---

## WNT signaling (Ileum-only: 7 pairs)

**Ileum (7 pairs).** All from **Fibroblasts→Stem/TA**. Top pair: **Wnt5a→Epha7** (0.25); also **Wnt5a→Fzd2/Fzd6** and **Wnt4→Fzd2/Fzd6_Lrp5/Lrp6**.
- Senders: Fibroblasts.

**Interpretation.** WNT is the master driver of intestinal stem-cell identity, and mesenchymal (fibroblast/trophocyte) Wnt ligands are a defining feature of the crypt niche [2, 8, 21]. The ileal enrichment of fibroblast-derived **Wnt5a/Wnt4→Fzd** pairs is notable: Wnt5a typically signals through **non-canonical (planar cell polarity)** pathways that modulate — rather than simply activate — β-catenin, and is implicated in niche patterning and regeneration [5, 24]. That these pairs are **ileum-unique** (and NicheNet-supported) points to a regionally distinct, fibroblast-driven non-canonical WNT input to ileal Stem/TA cells, complementing the canonical R-spondin/Lgr5 axis (below) [21, 23].

---

## Growth factors (EGF/HGF/VEGF/Nrg) (Both regions: 4 Duodenum / 2 Ileum)

**Duodenum (4 pairs).** Top pair: **Mdk→Lrp1** (0.54, Fibroblasts→Stem/TA). Also **Fndc5→Itgav** (cDC1), **Egf→Pld2** (cDC1 + Paneth), **Csf2→Sdc2** (Upper-villus EC).
- Senders: Fibroblasts, cDC1, Paneth cells, Upper-villus EC.

**Ileum (2 pairs).** **Grn→Tnfrsf1b** (1.25, Macrophages→Stem/TA), **Kitl→Kit** (0.52, Endothelial/Fibroblasts/Macrophages).
- Senders: Macrophages, Blood vascular endothelial cells, Fibroblasts.

**Interpretation.** Classic trophic/growth-factor signaling. The duodenum uses fibroblast **Mdk (midkine)→Lrp1** (progenitor proliferation/survival) and a modest **Egf** input (EGFR is a core proliferative driver [5]). The ileum uses macrophage **Grn (progranulin)→Tnfrsf1b** (immunometabolic) and **Kitl (stem cell factor)→Kit**, which supports progenitor survival [5, 8].

---

## FGF signaling (Both regions: 3 Duodenum / 2 Ileum)

**Duodenum (3 pairs).** All **Fgf7** from Fibroblasts→Stem/TA: **Fgf7→Fgfr2** (1.24, the strongest FGF pair overall), Fgf7→Fgfr4, Fgf7→Fgfr3.
- Senders: Fibroblasts.

**Ileum (2 pairs).** **Fgf2→Fgfrl1** and **Fgf1→Fgfrl1** (Fibroblasts→Stem/TA).
- Senders: Fibroblasts.

**Interpretation.** FGF/FGFR signaling supports epithelial growth and repair [11]. The duodenum is dominated by **Fgf7 (KGF)→Fgfr2**, a classic mesenchyme-to-epithelium mitogenic axis. Notably, the ileal-unique **Fgf15→Fgfr2** seen in the broader (unfiltered) LIANA set is the well-established **ileal enterocyte hormone** FGF15 — produced almost exclusively by ileal enterocytes under bile-acid/FXR control [12, 14] — but it does **not** appear in this NicheNet-filtered subset, indicating it is region-unique by expression yet not among the top predicted drivers of the ileal Stem/TA gene program. The filtered ileal FGF signal instead runs through Fgf1/Fgf2→Fgfrl1.

---

## R-spondin / Lgr5 (Wnt amplifier) (Duodenum-only: 4 pairs)

**Duodenum (4 pairs).** All **Rspo2** from Fibroblasts→Stem/TA: **Rspo2→Rnf43** (0.55), Rspo2→Lgr5, Rspo2→Lgr4, Rspo2→Znrf3.
- Senders: Fibroblasts.

**Interpretation.** These pairs are the **R-spondin→Lgr5/Rnf43/Znrf3** module — the core Wnt-amplifying machinery of the Lgr5+ stem-cell niche. R-spondins potentiate Wnt signaling by neutralizing the Rnf43/Znrf3 E3 ligases that otherwise degrade Frizzled receptors, and Rspo–Lgr5 signaling is essential for intestinal stem-cell self-renewal [21, 23]. The **duodenal specificity** of fibroblast Rspo2 is striking and suggests a proximal bias in stromal R-spondin support to the stem compartment, distinct from the ileum's fibroblast Wnt5a/Wnt4 input (above).

---

## ECM-remodeling / proteases & inhibitors (Duodenum-only: 3 pairs)

**Duodenum (3 pairs).** Top pair: **Timp1→Cd63** (0.83, Fibroblasts→TA). Also **F2→Gp1bb** (0.38) and **F2→F2rl1** (Enteroendocrine→Stem/TA).
- Senders: Fibroblasts, Enteroendocrine cells.

**Interpretation.** **Timp1→Cd63** (TIMP-1, a matrix-metalloprotease inhibitor, engaging the tetraspanin CD63) is a duodenum-unique matrix-remodeling/pro-survival signal. **F2 (thrombin)→Gp1bb/F2rl1** reflects protease-activated signaling from Enteroendocrine cells.

---

## Axon guidance (Ephrin/Sema/Netrin/Slit) (Both regions: 1 Duodenum / 1 Ileum)

**Duodenum (1 pair).** **Nlgn3→Nrxn1** (0.06, Fibroblasts→TA).
**Ileum (1 pair).** **Slitrk6→Ptprs** (0.16, Fibroblasts→Stem/TA).

**Interpretation.** Guidance-cue-family adhesion pairs (neuroligin–neurexin proximally, Slitrk–PTPRS distally) appear at low strength in both regions; axon-guidance molecules also regulate epithelial cell positioning and adhesion [18, 20].

---

## Lipid / lipoprotein & iron transport (Duodenum-only: 1 pair)

**Duodenum (1 pair).** **Alb→B2m_Fcgrt** (0.16, Enteroendocrine→Stem/TA). Albumin engaging the neonatal Fc receptor (FcRn) complex — a transport/recycling cue.

---

## Hedgehog signaling (Ileum-only: 1 pair)

**Ileum (1 pair).** **Ihh→Boc** (0.18, broad epithelial senders→Stem/TA). Indian hedgehog from epithelial cells feeds back on the mesenchyme and modulates Wnt/BMP balance along the crypt–villus axis [19].

---

## Cross-cutting themes

1. **Fibroblasts are the dominant NicheNet-supported sender in both regions**, but the *ligand repertoire* differs: duodenum → **Rspo2, Fgf7, Mdk** (Wnt-amplifying/mitogenic); ileum → **Wnt5a/Wnt4** (non-canonical Wnt). This points to regionally distinct stromal programs converging on the same Stem/TA receivers [2, 8, 21].
2. **The ileum skews toward innate-immune/TLR and trophic signaling** (Il18→Il1rapl1, Kitl→Kit, Hsp90b1→Tlr1, Cfh/Tnf→Itgam/Tnfrsf), consistent with its higher microbial/antigenic burden and Paneth-cell-driven defense [5].
3. **The duodenum skews toward R-spondin/Lgr5 Wnt amplification and neuroendocrine paracrine input** (Rspo2→Lgr5/Rnf43, Calca/Cthrc1 from Enteroendocrine cells) [21, 23].
4. **Adhesion/ECM cues are region-specific**: duodenum leans on endothelial collagen→integrin, ileum on epithelial **Lama3→Itga6/Cd44** anchoring [24].

*Caveat:* Expression-strength values are LIANA `lr_means` (relative, not absolute). Module labels are derived from the ligand genes (curated map). Literature citations support general pathway/niche biology; the specific pairs and regional patterns are from your data.
