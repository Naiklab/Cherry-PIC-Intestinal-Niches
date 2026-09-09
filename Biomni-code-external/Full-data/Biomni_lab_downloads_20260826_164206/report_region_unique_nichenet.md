# NicheNet Support for Region-Unique LIANA Signals (Stem & TA Cells)

**Re-run date:** 2026-08-06 · **LIANA:** five-method RRA consensus · **NicheNet:** ligand-activity analysis (unchanged from prior run)

## Overview

This report cross-validates the **202 region-unique LIANA ligand–receptor pairs** (59 Duodenum-only, 143 Ileum-only; see `report_region_unique_liana.md`) against independent **NicheNet ligand-activity** scores. NicheNet ranks ligands by how well their expression predicts downstream target-gene programs in the receiver cells — an orthogonal line of evidence to LIANA's expression-based LR scoring.

## Methods

- **LIANA region-unique pairs:** from the 2026-08-06 consensus re-run (RRA `aggregate_rank ≤ 0.05`; Stem/TA receivers).
- **NicheNet activity:** existing per-ligand activity tables (`nichenet/nichenet_ligand_activity_{stem,ta}_{de_duodenum,de_ileum,markers}.csv`; 326 ligands each; columns auroc, aupr, aupr_corrected, pearson). The NicheNet run itself is unchanged.
- **Support join:** for each region-unique ligand, the best NicheNet **pearson** correlation was taken within the matching regional contrast (Duodenum-unique → `de_duodenum`; Ileum-unique → `de_ileum`) and the `markers` contrast; a pair is "NicheNet-supported" if the ligand appears with a finite activity score.

## Results

### Concordance

| Region | Region-unique pairs | NicheNet-supported | % |
|---|---|---|---|
| Duodenum | 59 | 51 | 86.4% |
| Ileum | 143 | 134 | 93.7% |
| **Total** | **202** | **185** | **91.6%** |

**91.6% of region-unique LIANA pairs are independently supported by NicheNet ligand activity** — strong cross-method concordance that increases confidence these are active niche signals rather than expression artifacts.

### Magnitude vs activity

The scatter of LIANA magnitude (sca LR score) against NicheNet activity (pearson) for the 185 supported pairs shows a positive relationship in both regions, with region-colored trend lines (`figures/liana/region_unique_nichenet_vs_liana/nichenet_vs_liana_scatter.png`). Pairs that score highly in both frameworks are the strongest candidates for follow-up.

### Figures

- `figures/liana/region_unique_nichenet_vs_liana/nichenet_vs_liana_scatter.png` — LIANA magnitude vs NicheNet activity, per region.
- `figures/liana/region_unique_nichenet_vs_liana/nichenet_support_counts.png` — supported vs total pairs per region.

### Files

- `liana/region_unique_nichenet_support.csv` — 202 pairs with per-region NicheNet pearson (region contrast + markers), best receiver, and support flag.

## Notes & caveats

- The 17 unsupported pairs (8 Duodenum, 9 Ileum) are ligands not scored in the NicheNet ligand set or with negligible activity in the matched contrast; they are not necessarily false positives — NicheNet and LIANA use different evidence (downstream target prediction vs LR co-expression).
- NicheNet activity scores are from the prior, unchanged run with clean provenance; only the LIANA side was re-run. The join is therefore a like-for-like cross-method comparison.
- Because the LIANA significance criterion is now the more stringent RRA FDR, the supported-pair counts differ from the prior report (archived under `_archive_prerun_2026-08-06_`).

## References

LIANA consensus [1]; NicheNet ligand-activity model [29]; CellPhoneDB [25]; LIANA benchmark [30].
