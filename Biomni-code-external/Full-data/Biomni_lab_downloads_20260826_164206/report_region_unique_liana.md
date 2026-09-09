# Region-Unique Cell–Cell Communication to Intestinal Stem & TA Cells (LIANA Consensus)

**Re-run date:** 2026-08-06 · **Method:** LIANA 0.1.14 five-method consensus with Robust Rank Aggregation · **Resource:** MouseConsensus

## Overview

This report summarizes region-unique ligand–receptor (LR) signaling onto **Stem cells** and **TA cells** (the intestinal stem/progenitor compartment) comparing **Duodenum** vs **Ileum**, inferred with the LIANA consensus framework. This is a fully documented re-run from the annotated Seurat object (`nichenet_obj.rds`, 19,280 cells, 17 cell types), replacing a prior set of outputs that had no recorded provenance.

## Methods

- **Input:** `nichenet_obj.rds` — Duodenum 11,261 cells / Ileum 8,019 cells; 17 cell types. Receivers = Stem cells + TA cells; senders = the other 15 cell types.
- **Conversion:** Seurat → SingleCellExperiment (`as.SingleCellExperiment`, assay `logcounts`) to bypass a SeuratObject-v5 incompatibility in LIANA 0.1.14.
- **LIANA:** `liana_wrap(idents_col = "cell_type", resource = "MouseConsensus")` run per region, then `liana_aggregate()`. The MouseConsensus resource (3,998 mouse LR pairs) is required — the default human-symbol resource returned only 40 rows because the data are mouse.
- **Consensus methods (5):** NatMi, Connectome, LogFC, SingleCellSignalR (sca), CellPhoneDB. CellPhoneDB run with 500 permutations, single-threaded (memory-safe).
- **Significance:** Robust Rank Aggregation (RRA) `aggregate_rank ≤ 0.05`. The RRA score is already a corrected p-value integrating all five methods — this is more stringent than the prior single-method CellPhoneDB p < 0.05 criterion.
- **Region-unique:** an LR pair significant (RRA ≤ 0.05) in one region's Stem/TA set but not the other.
- **Magnitude** = max `sca.LRscore`; **specificity** = max `natmi.edge_specificity` across senders.

## Results

### Consensus output

| Region | Consensus rows (all types) | Stem/TA rows | Significant Stem/TA pairs (RRA ≤ 0.05) |
|---|---|---|---|
| Duodenum | 72,926 | 9,396 | **457** |
| Ileum | 63,930 | 9,500 | **541** |

### Region-unique pairs

| Region | Region-unique pairs |
|---|---|
| Duodenum-only | **59** |
| Ileum-only | **143** |
| **Total** | **202** |

The Ileum shows a substantially larger region-unique signaling repertoire onto the stem/TA compartment (143 vs 59 pairs), consistent with greater regional specialization of niche signals in the distal small intestine.

### Curated signaling modules (202 pairs)

| Module | Duodenum | Ileum | Total |
|---|---|---|---|
| ECM–Integrin / Matrix | 14 | 35 | 49 |
| Other | 12 | 13 | 25 |
| Immune / antigen & integrin-Itgam | 6 | 15 | 21 |
| WNT signaling | 9 | 12 | 21 |
| BMP / TGFβ family | 0 | 18 | 18 |
| Axon guidance (Ephrin/Sema/Netrin/Slit) | 3 | 14 | 17 |
| Growth factors (EGF/HGF/VEGF/Nrg) | 5 | 7 | 12 |
| ECM-remodeling / proteases & inhibitors | 2 | 6 | 8 |
| Wnt modulators (Sfrp/Sostdc1) | 0 | 8 | 8 |
| FGF signaling | 1 | 6 | 7 |
| Lipid / lipoprotein & iron transport | 4 | 3 | 7 |
| Complement / coagulation | 1 | 4 | 5 |
| Notch signaling | 0 | 2 | 2 |
| R-spondin / Lgr5 (Wnt amplifier) | 2 | 0 | 2 |
| **Total** | **59** | **143** | **202** |

**Key regional patterns:**
- **ECM–Integrin / Matrix** dominates both regions and is the largest module overall (49 pairs), enriched in Ileum (35 vs 14).
- **BMP / TGFβ family** (18) and **Wnt modulators** (8) are **entirely Ileum-specific** — consistent with the known distal gradient of BMP signaling that shapes stem-cell differentiation along the proximal–distal axis.
- **R-spondin / Lgr5** (Rspo-driven Wnt amplification) is **Duodenum-specific** (2 pairs), aligning with the higher Wnt tone and Lgr5+ stem activity of the proximal crypt.
- **Axon guidance** cues (17) are markedly Ileum-enriched (14 vs 3).

### Top region-unique pairs by magnitude

**Duodenum:** B2m→Tfrc (Immune), Gzma→Pard3 (Immune), Apoe→Lrp1 and Psap→Lrp1 (Lipid transport).
**Ileum:** Lamb3→Cd44 (ECM), Mmp9→Cd44 (ECM-remodeling), plus high-magnitude ECM/integrin interactions.

## Figures

- `figures/liana/region_unique_liana/region_unique_combined_magnitude.png` — back-to-back bubble plot (Duodenum ← → Ileum), top 50 pairs/region.
- `figures/liana/region_unique_liana_byregion/{duodenum,ileum}_{magnitude,specificity}.png` — per-region bubble plots.
- Bubble color = curated module; bubble size = RRA FDR (larger = more significant).

## Files

- `liana/liana_{duodenum,ileum}_full.csv` — full consensus output (all cell types, all 5 method columns + `aggregate_rank`).
- `liana/liana_{duodenum,ileum}_st_ta_sig.csv` — significant Stem/TA pairs with curated modules.
- `liana/region_unique_lr_combos.csv` — 202 region-unique pairs with modules, senders, magnitude, specificity, RRA FDR.
- `liana/curated_ligand_module_map.csv` — 208-ligand curated module map.

## Notes & caveats

- **Counts differ from the prior report** (previously 100 Duodenum-only / 115 Ileum-only). This is expected: the significance criterion changed from a single-method CellPhoneDB p < 0.05 to the five-method RRA FDR ≤ 0.05, which is more conservative and robust. The prior outputs also lacked recorded provenance; they are preserved under `liana/_archive_prerun_2026-08-06/`.
- **"Other" module (25 pairs)** contains ligands without a canonical signaling-module assignment (cytoskeletal/metabolic/housekeeping genes such as Vim, Ybx1, P4hb) rather than a coherent pathway.
- CellPhoneDB was run with 500 permutations (p-value resolution 0.002); this affects only the CellPhoneDB component p-value, not the RRA consensus used for significance.

## References

LIANA consensus framework and RRA aggregation [1]; CellPhoneDB [25]; LIANA benchmark [30]; SingleCellSignalR [32]; intestinal BMP/Wnt regional patterning [2, 23]; R-spondin/Lgr5 Wnt amplification [23].
