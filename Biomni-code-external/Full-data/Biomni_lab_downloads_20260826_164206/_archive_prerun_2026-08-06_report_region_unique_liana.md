# Biological Summary: LIANA-Only Region-Unique Interactions (Duodenum vs Ileum)

This report interprets the **region-unique ligand–receptor (LR) interactions detected by LIANA alone** — pairs significant in only one region, with **no NicheNet filter**. This is the broadest view of region-specific signaling onto Stem/TA cells (215 pairs: 100 Duodenum-only, 115 Ileum-only, across 15 curated modules). Because it is unfiltered, it captures more biology but with variable confidence; the NicheNet-filtered subset (separate report) is the higher-confidence core.

**Dataset:** 215 LR pairs (100 Duodenum / 115 Ileum), 15 curated modules. Receivers = Stem cells and TA cells; senders = niche populations. `max_lr_means` = LIANA expression-strength score. Modules ordered by total pair count.

**Module labels** are derived directly from the ligand genes (curated ligand→pathway map), so each label reflects the actual biology of its pairs.

**Direction:** ligand from **sender** → receptor on **receiver** (Stem/TA). "Region-unique" = significant in that region only.

---

## WNT signaling (Both regions: 18 Duodenum / 21 Ileum)

The largest and most regionally divergent module.

**Duodenum (18 pairs).** Top pair: **Wnt7b→Tmed5** (0.60, CLU+ reserve stem cells). Dominated by **Wnt7b→Fzd5/Fzd7_Lrp5/Lrp6** from **CLU+ reserve stem cells**, plus Upper-villus EC, Fibroblasts, Enteroendocrine.
- Senders: CLU+ reserve stem cells, Upper-villus EC, Fibroblasts, Enteroendocrine.

**Ileum (21 pairs).** Top pair: **Wnt11→Fzd2** (0.38, cDC1). Also **Wnt11→Fzd6**, **Wnt3→Fzd2_Lrp6**, and Wnt5a/Wnt4→Fzd pairs from fibroblasts.
- Senders: Fibroblasts, Endothelial, cDC1, Goblet, Enteroendocrine, Paneth.

**Interpretation.** WNT is the defining intestinal stem-cell pathway [2, 5, 21]. The regional split is striking: the **duodenum** is driven by **Wnt7b** from **CLU+ reserve stem cells** (an epithelial, injury-responsive reserve population), suggesting an epithelial-autonomous Wnt source proximally. The **ileum** uses a broader stromal Wnt repertoire (Wnt11, Wnt3, Wnt5a/Wnt4) from fibroblasts/immune senders. This is consistent with regionally graded Wnt/BMP balance along the proximal–distal axis [7]. (Ileal Wnt *modulation* via Sfrp1 is captured separately under "Wnt modulators" below.)

---

## ECM–Integrin / Matrix (Both regions: 18 Duodenum / 14 Ileum)

**Duodenum (18 pairs).** Top pair: **Thbs1→Lrp1** (0.90, Macrophages). Also **Thbs1→Ptprj**, **Lama5→Itga6_Itgb1**, and collagen/laminin→integrin pairs from CLU+ reserve stem, Endothelial, Enteroendocrine, Paneth.
**Ileum (14 pairs).** Top pair: **Bgn→Ly96** (1.42, Fibroblasts/Endothelial). Also **Bgn→Tlr1** (1.40), **Fn1→Cd79a**, and Col19a1/Lama3→integrins.

**Interpretation.** Basement-membrane and matricellular signaling couples the stromal/vascular niche to epithelial adhesion [24]. The duodenum leans on **Thbs1 (thrombospondin-1)→Lrp1/Ptprj** from macrophages (ECM remodeling, TGF-β activation) and **CLU+ reserve stem cell** ECM output. The ileum is dominated by **Bgn (biglycan)→TLR/Ly96** — a matricellular-inflammatory axis that reinforces the distal gut's innate-immune tone [5].

---

## Immune / antigen & integrin-Itgam (Both regions: 8 Duodenum / 16 Ileum)

**Duodenum (8 pairs).** Top pair: **Calr→Lrp1** (1.29, Macrophages/Fibroblasts). Also **Cx3cl1→Itgav/Cx3cr1** (fractalkine).
**Ileum (16 pairs).** Top pair: **H2-K1→Cd3g** (1.62, Cd8aa IEL/T cells/cDC1/Macrophages/Plasmablasts). Also **B2m→Cd3g** (1.45), **B2m→Hfe** (1.44), **Il18→Il1rapl1**, and Selplg/Cfh/C3→Itgam.

**Interpretation.** This is the most regionally skewed immune module, strongly **ileum-biased**. The ileum is enriched for **MHC-I/antigen-presentation** crosstalk onto Stem/TA (H2-K1/B2m→Cd3g, i.e., MHC-I→TCR) and **integrin-Itgam (CD11b)** innate-immune adhesion — consistent with the ileum's dense immune compartment (Peyer's patches, IELs) [5]. The duodenum shows **Calr (calreticulin)→Lrp1** "eat-me"/clearance signaling and fractalkine adhesion instead.

---

## Axon guidance (Ephrin/Sema/Netrin/Slit) (Both regions: 2 Duodenum / 21 Ileum)

**Duodenum (2 pairs).** **Nxph3→Nrxn1**, **Nlgn3→Nrxn1** (neurexin-axis synaptic/adhesion cues).
**Ileum (21 pairs).** Top pair: **Efna5→Epha4** (0.77, Fibroblasts + Endothelial). Also **Efna5→Epha7**, **Ntn1→Dcc**, **Sema4a→Plxnb1**, and many Ephrin/Semaphorin pairs from a broad sender base.

**Interpretation.** Axon-guidance cues (Ephrins, Semaphorins, Netrins, Slits) are repurposed in adult epithelia to control **cell positioning, adhesion, and migration** along the crypt–villus axis [18, 20]. EphB/ephrin-B signaling in particular orders enterocyte migration and compartment boundaries [20]. The strong **ileal enrichment** (21 of 23 pairs) suggests a more prominent guidance-cue scaffold for epithelial organization in the distal gut, possibly reflecting the ileum's distinct villus architecture and turnover dynamics [7].

---

## Other (Both regions: 16 Duodenum / 7 Ileum)

**Duodenum (16 pairs).** Top pair: **Hsp90b1→Lrp1** (1.50, Macrophages + Fibroblasts). Also **Gas6→Tyro3** (0.94), **Arf1→Pld2**, **Spp1→Cd44**.
**Ileum (7 pairs).** Top pair: **Psap→Celsr1** (2.32 — the strongest pair in the entire LIANA-only unique set). Also **Mif→Cd44_Cd74** (1.38), **Gnas→Adcy8** (1.31).

**Interpretation.** A mixed set of pairs without a single clean pathway. Notable signals: duodenal **Gas6→Tyro3** (TAM-receptor efferocytosis/survival) and **Hsp90b1 (GRP94)→Lrp1**; ileal **Psap (prosaposin)→Celsr1** — the single strongest region-unique interaction, a lysosomal/sphingolipid-activator protein acting on a planar-cell-polarity adhesion GPCR — plus **Mif→Cd44/Cd74** (inflammatory/pro-survival) and **Gnas→Adcy8** (cAMP second-messenger tone).

---

## Growth factors (EGF/HGF/VEGF/Nrg) (Both regions: 8 Duodenum / 9 Ileum)

**Duodenum (8 pairs).** Top pair: **Mdk→Lrp1** (0.54, Fibroblasts). Also **Hgf→Itgb1**, **Vegfa→Tyro3**, **Egf→Pld2**.
**Ileum (9 pairs).** Top pair: **Grn→Tnfrsf1b** (1.25, Macrophages). Also **Ntrk3→Ptprf**, **Kitl→Kit**, **Bdnf→Sort1**.

**Interpretation.** Classic trophic/growth-factor signaling. The duodenum uses fibroblast **Mdk (midkine)→Lrp1** and **Hgf→Itgb1** (scatter/survival); the ileum uses macrophage **Grn (progranulin)→Tnfrsf1b** (immunometabolic) and **Kitl→Kit** (stem-cell factor) plus neurotrophin (Ntrk3/Bdnf) cues. EGFR is a core proliferative driver [5].

---

## FGF signaling (Both regions: 4 Duodenum / 8 Ileum)

**Duodenum (4 pairs).** Top pair: **Fgf7→Fgfr2** (1.24, Fibroblasts). Also **Fgf12→Fgfr2** (1.17, Enteroendocrine).
**Ileum (8 pairs).** Top pair: **Fgf15→Fgfr2** (1.23, Upper-villus enterocytes). Also **Fgf10→Fgfrl1**, **Fgf2→Fgfrl1** (Fibroblasts).

**Interpretation.** This module captures one of the clearest regional signatures: **ileal Fgf15→Fgfr2**. FGF15 is the canonical **ileal enterocyte hormone**, induced by bile-acid/FXR and acting on FGFR to regulate bile-acid and metabolic homeostasis [12, 14]. Its ileal specificity here is a strong positive control for the regional analysis. The duodenum instead uses **Fgf7 (KGF)→Fgfr2** (stromal→epithelial mitogen) and an unusual **Fgf12→Fgfr2** from Enteroendocrine cells [11].

---

## ECM-remodeling / proteases & inhibitors (Both regions: 6 Duodenum / 5 Ileum)

**Duodenum (6 pairs).** Top pair: **Mmp9→Lrp1** (0.87, Macrophages). Also **Timp1→Cd63**, **Mmp13→Lrp1**.
**Ileum (5 pairs).** Top pair: **Adam10→Cd44** (0.86, Goblet/TA-progenitors/Upper-villus EC). Also **Serpina1b→Lrp1**, **Serpine2→Lrp1**.

**Interpretation.** Matrix-remodeling proteases and their inhibitors shape the niche scaffold. The duodenum uses macrophage **Mmp9/Mmp13→Lrp1** (matrix turnover) and **Timp1→Cd63**; the ileum uses **Adam10→Cd44** (ADAM sheddase activity on a stem-cell marker receptor) and serpin→Lrp1 clearance pairs.

---

## BMP / TGFβ family (Both regions: 8 Duodenum / 2 Ileum)

**Duodenum (8 pairs).** Top pair: **Tgfb3→Tgfbr1_Tgfbr2** (0.27, Fibroblasts). Also **Tgfb3→Acvr1b**, **Gdf9→Bmpr1a/Acvr1b/Acvr2a**.
**Ileum (2 pairs).** **Gdf6→Bmpr1a_Bmpr2** (Fibroblasts), **Bmp8a→Bmpr1a_Bmpr2** (Goblet).

**Interpretation.** BMP/TGFβ opposes Wnt to drive differentiation and shapes villus length, with a gradient that intensifies toward the ileum [2, 7]. Here the region-unique ligands are **GDF-family** (Gdf9 proximally, Gdf6/Bmp8a distally) plus fibroblast **Tgfb3→TGFβ receptors** (duodenum-unique anti-proliferative/differentiation signal), suggesting region-specific BMP/TGFβ-family ligand usage onto Stem/TA receptors [5].

---

## Lipid / lipoprotein & iron transport (Both regions: 4 Duodenum / 4 Ileum)

**Duodenum (4 pairs).** Top pair: **Ltf→Tfrc** (0.50, CLU+ reserve stem). Also **Apoa2→Ldlr**, **Cp→Slc40a1**.
**Ileum (4 pairs).** Top pair: **Apob→Itgam** (1.17, Macrophages). Also **Trf→Hfe**, **Apoo→Il1rapl2**.

**Interpretation.** Reflects region-specific metabolic exchange — duodenal **Ltf (lactoferrin)→Tfrc** and **Apoa2→Ldlr** (lipoprotein) vs ileal **Apob→Itgam** and **Trf (transferrin)→Hfe** (iron handling) — consistent with differing absorptive/metabolic roles along the axis [12].

---

## Notch signaling (Both regions: 4 Duodenum / 1 Ileum)

**Duodenum (4 pairs).** Top pair: **Mfng→Notch1** (0.30). Also **Dll3→Notch1/Notch2** (Paneth cells), **Mfng→Notch2**.
**Ileum (1 pair).** **Psen1→Cd44** (0.80, Upper-villus EC).

**Interpretation.** Notch drives absorptive vs secretory fate in the crypt [5, 19]. The duodenum shows **Paneth-cell Dll3→Notch** lateral-inhibition and **Mfng (Manic fringe)→Notch** glycosylation-based fate tuning — duodenum-unique fate cues to Stem/TA.

---

## Wnt modulators (Sfrp/Sostdc1) (Ileum-only: 5 pairs)

**Ileum (5 pairs).** Top pair: **Sfrp1→Fzd2** (1.28, Fibroblasts + Endothelial). Also **Sfrp1→Fzd6** (1.27), **Sostdc1→Lrp4/Lrp6**.

**Interpretation.** **Sfrp1 (secreted frizzled-related protein 1)** is a soluble Wnt antagonist/modulator, and **Sostdc1 (Wise/ectodin)** modulates both Wnt and BMP. Their **ileal specificity** indicates the distal niche leans toward stromal **modulation** of Wnt rather than pure activation — a counterpoint to the duodenum's epithelial Wnt7b drive [5, 24].

---

## R-spondin / Lgr5 (Wnt amplifier) (Duodenum-only: 4 pairs)

**Duodenum (4 pairs).** All **Rspo2** from Fibroblasts: **Rspo2→Rnf43** (0.55), Rspo2→Lgr5, Rspo2→Lgr4, Rspo2→Znrf3.

**Interpretation.** These are **R-spondin→Lgr5/Rnf43/Znrf3** Wnt-amplifying pairs — the core Lgr5+ stem-cell niche machinery [21, 23]. R-spondin potentiates Wnt signaling by neutralizing the Rnf43/Znrf3 ubiquitin ligases that degrade Frizzled. Their **duodenal specificity** indicates a proximal bias in stromal R-spondin support to the stem compartment.

---

## Complement / coagulation (Ileum-only: 1 pair)

**Ileum (1 pair).** **Vwf→Lrp1** (0.49, Endothelial→Stem/TA). Von Willebrand factor clearance/signaling via Lrp1.

---

## Hedgehog signaling (Ileum-only: 1 pair)

**Ileum (1 pair).** **Ihh→Boc** (0.183, broad epithelial→Stem/TA). Epithelial Ihh feeds back on the niche and modulates Wnt/BMP balance [19].

---

## Cross-cutting themes

1. **WNT is the most regionally divergent signaling axis**, but with opposite flavors: duodenum = epithelial **Wnt7b** (CLU+ reserve stem) + stromal **Rspo2→Lgr5** amplification; ileum = stromal **Sfrp1→Fzd** modulation + fibroblast Wnt11/Wnt5a/Wnt4 [2, 7, 21, 23].
2. **CLU+ reserve stem cells are a prominent duodenal sender** (Wnt7b, Lama5, Ltf), highlighting an epithelial reserve-cell niche role proximally.
3. **The ileum is enriched for immune/antigen-presentation and guidance-cue signaling**: H2-K1/B2m→CD3 (MHC-I), integrin-Itgam, and a large **axon-guidance (Ephrin/Semaphorin)** module [5, 18, 20].
4. **Fgf15→Fgfr2 is a clean ileal positive control** (canonical ileal enterocyte hormone) [12, 14]; **Psap→Celsr1** is the strongest single region-unique pair (ileum).
5. **The duodenum skews toward R-spondin/Wnt amplification, TAM (Gas6→Tyro3), and Notch/TGFβ fate cues**; the ileum toward innate-immune/antigen-presentation, Wnt modulation (Sfrp1), lipid/iron handling, and adhesion/PCP signaling.

*Caveat:* This LIANA-only set is unfiltered, so confidence varies per pair; cross-reference the NicheNet-filtered report for the higher-confidence core. `lr_means` is a relative expression-strength score. Module labels are derived from the ligand genes (curated map). Literature citations support general pathway/niche biology; specific pairs and regional patterns are from your data.
