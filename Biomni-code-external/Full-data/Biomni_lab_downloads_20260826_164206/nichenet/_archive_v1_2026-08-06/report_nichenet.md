# LIANA + NicheNet Combined Analysis — Regional Intestinal Data (Duodenum vs Ileum)

## Overview
This analysis applies the **LIANA–NicheNet combined vignette** to the regional intestinal scRNA-seq data. NicheNet predicts which ligands are most likely to drive an observed transcriptional response in a receiver cell population, and infers the downstream target genes. The defining feature of the *combined* approach is that the candidate ligand space is restricted to **LIANA-prioritized ligands** — ligands already found in significant ligand–receptor interactions in the completed LIANA analysis of the same data — rather than all expressed ligands. This anchors NicheNet's regulatory-activity ranking to ligands with evidence of actual cell–cell communication in these samples.

## Methods

### Input data
- **Senders:** DR26001 scRNA-seq (11,338 cells, 17 cell types). Fibroblasts (FOXL1+ + GREM1+) and Macrophages (Monocyte-derived + Proliferating resident + Resident) were merged, matching the prior LIANA analysis.
- **Receivers:** EP.CTRL Stem cells (1,583 Duodenum / 1,324 Ileum) and TA cells (3,326 / 1,710), run as **independent receivers**. (DR26001 lacks a true Stem-cell cluster, so SC/TA come from EP.CTRL — identical to the LIANA setup.)
- **Candidate ligands:** union of significant ligands from the Duodenum and Ileum LIANA results; **326 of 366** were present in the NicheNet mouse ligand–target matrix and used as `potential_ligands`.
- **NicheNet mouse networks** (Zenodo record 7074291): ligand–target matrix (22,521 targets × 1,287 ligands), ligand–receptor network, weighted signaling networks.

### Response gene sets (run independently)
1. **Regional DE genes** — DESeq2 pseudobulk Ileum-vs-Duodenum, padj < 0.05 & |log2FC| > 0.5, split by direction:
   - *Up-in-Ileum* (1,194 genes)
   - *Up-in-Duodenum* (1,137 genes)
2. **Stem/TA markers** — curated Stem markers (Lgr5, Ascl2, Olfm4, …) for the Stem receiver; TA markers (Mki67, Pcna, Top2a, …) for the TA receiver.

### Procedure
For each receiver × gene set (6 runs):
- **Background genes:** genes expressed in ≥10% of receiver cells, intersected with ligand–target matrix rows (Stem: 7,962; TA: 9,494).
- `predict_ligand_activities` → per-ligand Pearson correlation / aupr (regulatory potential vs. gene-set membership).
- `get_weighted_ligand_target_links` (top 20 ligands, top 200 targets) → ligand–target regulatory weights.
- Ligand–receptor inference: receptors expressed in ≥10% of receiver cells, linked to top ligands via the ligand–receptor network.
- **LIANA integration:** joined each ligand's NicheNet Pearson score with its best LIANA specificity/magnitude rank for that receiver.

## Results

### Top ligands per run (by NicheNet Pearson activity)

| Run | Receiver | Gene set | Top 5 ligands (Pearson) |
|---|---|---|---|
| stem_de_ileum | Stem | up-Ileum DE | **Tgfb1** (0.148), Efemp1 (0.126), Ihh (0.124), Cfh (0.121), Ncam1 (0.120) |
| stem_de_duodenum | Stem | up-Duodenum DE | **Lrig2** (0.060), Csf1 (0.057), Nlgn3 (0.040), Wnt5a (0.040), Epo (0.038) |
| stem_markers | Stem | Stem markers | **Fgf9** (0.165), Gnas (0.155), Grn (0.142), Alb (0.140), Plat (0.135) |
| ta_de_ileum | TA | up-Ileum DE | **Tgfb1** (0.138), Ihh (0.115), Efemp1 (0.113), Ncam1 (0.110), Edil3 (0.109) |
| ta_de_duodenum | TA | up-Duodenum DE | **Lrig2** (0.071), Csf1 (0.051), Tgfb1 (0.048), Postn (0.046), Nlgn3 (0.034) |
| ta_markers | TA | TA markers | **Mdk** (0.218), Fgf2 (0.149), Angptl4 (0.119), Cklf (0.109), Col16a1 (0.098) |

### Key observations
- **Tgfb1 is the dominant ligand for the Ileum-up DE program in both Stem and TA receivers** (Pearson ~0.14–0.15), consistent with a region-specific TGF-β signaling axis in the ileum. Ihh, Efemp1, Ncam1, and Cfh recur across both epithelial receivers for the same gene set.
- **The Duodenum-up DE program is driven by a distinct, weaker ligand set** — Lrig2 and Csf1 lead in both receivers, with lower Pearson values (~0.05–0.07), indicating a more diffuse regulatory signal.
- **Marker-gene runs recover biologically coherent niche signals:** Fgf9/Gnas/Grn for Stem identity and Mdk/Fgf2/Angptl4 for TA/proliferative identity — these ligands best predict the stem/progenitor transcriptional signatures themselves.
- **LIANA concordance:** 310 (Stem) and 325 (TA) of the 326 candidate ligands had a LIANA specificity rank for the corresponding receiver, confirming the prioritized ligand space is well supported by the communication analysis.

## Outputs
All in the `nichenet/` results folder:
- `nichenet_ligand_activity_{run}.csv` — ranked ligand activities (6 files)
- `nichenet_ligand_target_links_{run}.csv` — ligand–target regulatory weights for top ligands
- `nichenet_ligand_receptor_{run}.csv` — ligand–receptor links
- `nichenet_liana_combined_{run}.csv` + `_all.csv` — joined NicheNet activity + LIANA ranks
- `figures/` — top-ligand Pearson barplots (fig1), LIANA-vs-NicheNet scatter (fig2), and per-run ligand–target heatmaps (PNG + SVG)

## Caveats
- **The regional DE gene set is bulk pseudobulk** (all cells combined), not receiver-specific. The DE-driven runs therefore reflect the regional program as a whole rather than a Stem- or TA-specific DE signature; the marker-driven runs are the receiver-specific complement.
- Pearson activities for the Duodenum-up set are modest; rankings are still meaningful but absolute regulatory confidence is lower than for the Ileum-up and marker sets.
- NicheNet ligand–target potentials derive from prior (largely non-intestinal) regulatory data; direction of effect (activation vs. repression) is not inferred.
