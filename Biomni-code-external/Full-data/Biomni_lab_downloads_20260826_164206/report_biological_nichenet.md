# Ligands Driving the Regional & Stem/TA Transcriptional Programs — A NicheNet View (v2)

**Date:** 2026-08-06 · **Method:** NicheNet v2 ligand-activity analysis, restricted to the **new LIANA consensus** ligand space · **Networks:** NicheNet v2 mouse (Zenodo 7074291) · **Comparison:** Duodenum vs Ileum

> **v2 — what changed.** This re-run makes two improvements over the original: (1) the candidate ligand space is now the **newly computed LIANA consensus** significant ligands (239 union; 216 covered in the ligand–target matrix), replacing the prior Jul 31 ligand set; and (2) the regional DE gene sets are computed with **proper biological replicates** (6 Duodenum / 6 Ileum samples) rather than pooling all cells into one pseudoreplicate per region. The second change is material — it produces smaller, statistically valid DE sets and **changes the top-ranked Ileum ligand** (see below). The original run's outputs are preserved under `nichenet/` for comparison.

---

## The question

Where LIANA asks *which ligand–receptor pairs are expressed and significant*, NicheNet asks the complementary functional question: **which ligands best explain the genes actually turned on in the receiver cells?** Scoring each candidate ligand against an observed transcriptional response prioritizes ligands likely to be *driving* the regional and stem/TA programs — not merely present. The candidate space is anchored to ligands with evidence of real cell–cell communication in the same data (the LIANA consensus).

## Headline findings

### 1. Bmp4 — not Tgfb1 — is the top ligand behind the rigorous Ileum program

With proper biological replicates, the genes upregulated in Ileum are best explained by **Bmp4** in both Stem (Pearson 0.066) and TA (0.076) receivers, followed by **Postn, Angptl4, Fgf7, and Tgm2** (Stem) and **Fgf7, Tgm2, Tgfb1, Wnt5a** (TA). **Tgfb1 remains in the top five for TA (0.041) but is no longer the dominant signal.**

This is a meaningful correction: the original run's headline — "Tgfb1 is the dominant Ileum ligand (Pearson ~0.14–0.15)" — was inflated by pseudoreplication (pooling all cells into one sample per region, which overstates DE significance and, in turn, the ligand–target correlation). The rigorous result still points to **BMP/TGF-β–family signaling as the defining distal axis** (Bmp4, Bmp2, Tgfb1 all rank highly), which remains concordant with the LIANA finding that the BMP/TGFβ module is entirely Ileum-specific — but the single dominant driver is Bmp4, with a broader supporting cast.

### 2. The Duodenum program is led by Fgf7, with a diffuse supporting set

The genes upregulated in Duodenum are best explained by **Fgf7** (Stem 0.059 / TA 0.065), with **Bmp4, Tgfb1, Pf4, Bmp2** (Stem) and **Tgfb1, Bmp4, Wnt5a, Hgf** (TA) contributing. As in the original, the proximal activities are modest (~0.04–0.07), indicating a **more diffuse regulatory signal** — no single ligand dominates the proximal response. Fgf7 (a mesenchymal epithelial growth factor) leading both receivers is consistent with stromal–epithelial crosstalk in the proximal niche.

### 3. Marker-gene runs recover coherent niche signals (stable across versions)

When the response gene set is the cells' own identity markers, NicheNet recovers biologically sensible signals, consistent with the original run:

- **Stem identity** (Lgr5, Ascl2, Olfm4, …) is best predicted by **Fgf9 (0.172), Gnas (0.169), Grn (0.152)**, with Wif1 and Wnt4 also scoring — ligands supporting the stem-cell state.
- **TA / proliferative identity** (Mki67, Pcna, Top2a, …) is best predicted by **Angptl4 (0.160), Bmp2 (0.116), Fgf2 (0.114)**, with Lama4 and Slit1 — growth/matrix factors associated with the transit-amplifying state.

The marker results are robust to the ligand-space and DE changes, serving as an internal control.

### 4. Cross-method concordance is high and robust to the methodological correction

Joining the 202 region-unique LIANA pairs to the new NicheNet v2 activities shows **187 of 202 (92.6%) are NicheNet-active** (ligand Pearson > 0 in the matching region/receiver contrast):

| Region | Region-unique pairs | NicheNet-supported | Fraction |
|---|---|---|---|
| Duodenum | 59 | 52 | 88.1% |
| Ileum | 143 | 135 | 94.4% |
| **Total** | **202** | **187** | **92.6%** |

This is essentially unchanged from the original run (91.6%), so the strong LIANA–NicheNet agreement is **not** an artifact of the DE method — it reflects genuine regulatory potential behind the region-unique signals. The ileal BMP/TGF-β story remains the clearest point of convergence: **Bmp4 is the top NicheNet ligand for the Ileum program and a member of the entirely-Ileum-specific BMP/TGFβ module in LIANA.**

## How to read the figures

- `figures/liana/nichenet_circle_plots_de_noee/v2/circle_de_{region}_to_{stem,ta}.png` — sender-level chord diagrams of the LIANA ∩ NicheNet-v2-active interactions (ribbon width = number of interactions; mature epithelia excluded, Paneth retained). Interaction counts: Duodenum→Stem 513, Duodenum→TA 300, Ileum→Stem 537, Ileum→TA 384.
- `figures/liana/region_unique_nichenet_vs_liana/v2/nichenet_vs_liana_scatter_v2.png` — NicheNet v2 activity vs LIANA RRA rank for the 202 region-unique pairs.
- `figures/liana/region_unique_nichenet_vs_liana/v2/nichenet_support_counts_v2.png` — the 92.6% concordance by region.

## Methods (concise)

- **Candidate ligands:** 239 distinct significant ligands from the new LIANA RRA consensus (union across regions); **216** present in the NicheNet v2 mouse ligand–target matrix and used as `potential_ligands`.
- **Response gene sets (per receiver):** (a) regional DE — DESeq2 **pseudobulk by biological sample** (6 Duodenum / 6 Ileum), padj < 0.05 & |log2FC| > 0.5 → up-Ileum (234) / up-Duodenum (189); (b) curated Stem markers and TA markers.
- **Procedure:** for each receiver (Stem, TA) × gene set (up-Ileum, up-Duodenum, markers) — 6 runs — background = genes expressed in ≥10% of receiver cells ∩ matrix rows (Stem 7,962 / TA 9,494); `predict_ligand_activities` → Pearson/auroc/aupr; ligand–target and ligand–receptor inference for top ligands.
- **LIANA integration:** each ligand's Pearson joined to its best new-LIANA rank for that receiver; region-unique support = ligand Pearson > 0 in the matching contrast.
- **Networks:** NicheNet v2 mouse (ligand–target matrix 22,521 × 1,287; weighted lr_sig + gr networks; mouse lr/signaling networks), Zenodo record 7074291.

## Caveats

- **The v2 DE sets are smaller than the original** (234/189 vs 1,194/1,137) because they use real biological replicates rather than pseudoreplication. This is the statistically valid choice, but it means the v2 ligand rankings are not directly comparable to the original run's absolute Pearson values.
- **Duodenum-up Pearson activities are modest** (~0.04–0.07); rankings remain meaningful, but absolute regulatory confidence is lower than for the marker sets.
- **NicheNet ligand–target potentials derive from prior (largely non-intestinal) regulatory data**, and the direction of effect (activation vs repression) is not inferred. High Pearson activity indicates regulatory *potential*, not confirmed causation.
- The original run's outputs (v1 networks, pooled DE) are preserved under `nichenet/` for comparison; the v1 report's "Tgfb1-dominant" framing should be regarded as superseded by the rigorous v2 result.

## Data files

- `nichenet/v2/nichenet_ligand_activity_{run}.csv` — ranked v2 ligand activities (6 runs).
- `nichenet/v2/nichenet_ligand_target_links_{run}.csv` — ligand–target regulatory weights for top ligands.
- `nichenet/v2/nichenet_liana_combined_{run}.csv` + `_all.csv` — joined v2 activity + new-LIANA ranks.
- `liana/region_unique_nichenet_support_v2.csv` — the 202 region-unique pairs joined to v2 activity (the 92.6% concordance).
- `liana/nichenet_circle_lr_pairs_v2.csv` — the 1,734 LIANA ∩ NicheNet-v2-active pairs behind the chord diagrams.

## References

NicheNet method [29]; LIANA consensus framework [1]; intestinal BMP/TGF-β regional patterning [2, 23].
