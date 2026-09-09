# Regional Niche Signaling onto Intestinal Stem & TA Cells — A LIANA Consensus View

**Date:** 2026-08-06 · **Method:** LIANA 0.1.14 five-method consensus (Robust Rank Aggregation) · **Resource:** MouseConsensus · **Comparison:** Duodenum vs Ileum

---

## The question

The intestinal epithelium is renewed from Lgr5⁺ stem cells and their transit-amplifying (TA) progeny, but the stem-cell niche is not uniform along the gut's proximal–distal axis. Duodenum (proximal) and Ileum (distal) differ in Wnt/BMP tone, immune milieu, and mesenchymal composition. Here we ask: **which ligand–receptor signals, sent from the surrounding niche, are unique to each region's stem/TA compartment?** We infer these with the LIANA consensus framework, which integrates five independent ligand–receptor methods into a single robust ranking.

## Headline findings

### 1. The Ileum has a far larger region-unique signaling repertoire onto stem/TA than the Duodenum

Of the significant stem/TA-directed interactions, **143 ligand–receptor pairs are unique to Ileum versus only 59 unique to Duodenum** (202 total). The distal small intestine therefore maintains a substantially richer and more specialized set of niche signals onto its stem/progenitor compartment — consistent with the greater regional specialization of the ileal niche.

| Region | Significant stem/TA pairs (RRA ≤ 0.05) | Region-unique pairs |
|---|---|---|
| Duodenum | 457 | **59** |
| Ileum | 541 | **143** |

### 2. Different cell types dominate the region-unique signal in each region

The cellular origin of the region-unique crosstalk differs sharply between regions:

- **Duodenum** — the region-unique signal is led by **CLU⁺ reserve stem cells (24 pairs)** and **Fibroblasts (12)**, with contributions from Macrophages (7), Enteroendocrine cells (7), and Cd8αα IEL (5). The prominence of the quiescent CLU⁺ reserve population as a *sender* is notable: it suggests a proximal epithelial-intrinsic signaling loop in which reserve stem cells talk back to the active stem/TA pool.
- **Ileum** — the signal is overwhelmingly **stromal and immune**: **Fibroblasts (71 pairs)** dominate, followed by **Blood vascular endothelial cells (23)** and **Cd8αα intraepithelial lymphocytes (16)**, with Macrophages (9), cDC1 (9), and Enteroendocrine cells (9) contributing. The ileal stem/TA niche is thus shaped primarily by mesenchymal, vascular, and immune inputs rather than epithelial-intrinsic ones.

This is a coherent biological picture: **proximal signaling is more epithelial-autonomous, while distal signaling is more niche-driven (stromal/vascular/immune).**

### 3. The signaling modules tell a regionally patterned story

Grouping the 202 region-unique pairs into curated signaling modules reveals clean proximal–distal logic:

| Module | Duodenum | Ileum | Interpretation |
|---|---|---|---|
| ECM–Integrin / Matrix | 14 | 35 | Largest module overall; Ileum-enriched basement-membrane/matrix crosstalk |
| WNT signaling | 9 | 12 | Core stemness pathway, active in both |
| Immune / antigen & integrin-Itgam | 6 | 15 | Ileum-enriched immune→epithelial signaling |
| **BMP / TGFβ family** | **0** | **18** | **Entirely Ileum-specific** |
| Axon guidance (Ephrin/Sema/Netrin/Slit) | 3 | 14 | Markedly Ileum-enriched |
| Growth factors (EGF/HGF/VEGF/Nrg) | 5 | 7 | Present in both |
| **Wnt modulators (Sfrp/Sostdc1)** | **0** | **8** | **Entirely Ileum-specific** |
| ECM-remodeling / proteases & inhibitors | 2 | 6 | Ileum-enriched |
| FGF signaling | 1 | 6 | Ileum-enriched |
| Lipid / lipoprotein & iron transport | 4 | 3 | Balanced |
| Complement / coagulation | 1 | 4 | Ileum-enriched |
| **R-spondin / Lgr5 (Wnt amplifier)** | **2** | **0** | **Entirely Duodenum-specific** |
| Notch signaling | 0 | 2 | Ileum-specific |
| Other | 12 | 13 | Non-canonical/housekeeping ligands |

Three patterns stand out:

- **BMP/TGFβ (18 pairs) and the Wnt antagonists Sfrp/Sostdc1 (8 pairs) are found only in Ileum.** This matches the well-established distal gradient of BMP signaling, which rises toward the ileum to counterbalance Wnt and promote stem-cell differentiation. The co-occurrence of secreted Wnt *inhibitors* in the same region reinforces a distal "Wnt-low / BMP-high" differentiation-promoting niche.
- **R-spondin→Lgr5 (2 pairs) is found only in Duodenum.** R-spondin is the obligate Wnt amplifier that potentiates Lgr5⁺ stem-cell self-renewal; its proximal restriction aligns with the higher Wnt tone and Lgr5⁺ stem activity of the proximal crypt.
- **Axon-guidance cues (ephrins, semaphorins, netrins, slits; 17 pairs) are strongly Ileum-enriched (14 vs 3).** These molecules are increasingly recognized as niche patterning cues beyond the nervous system, and their distal enrichment suggests a role in organizing the ileal stem-cell compartment.

### 4. The highest-magnitude region-unique axes

By interaction magnitude (SingleCellSignalR LRscore), the strongest region-unique signals are:

- **Duodenum:** B2m→Tfrc (immune/iron), Thbs1→Cd47, Spp1→Cd44, and Cdh1→Ptprm (ECM/adhesion). These point to immune–epithelial and matrix-adhesion crosstalk in the proximal niche.
- **Ileum:** Lamb3→Cd44, Mmp9→Cd44, Hbegf→Cd44 / Hbegf→Cd9, and Vegfa→Cd44. **CD44 recurs as a receptor hub** across multiple Ileum-unique interactions (laminin, matrix-remodeling, growth-factor, and angiogenic ligands all converging on CD44), highlighting it as a candidate integrator of distal niche signals on stem/TA cells.

## How to read the figures

- `figures/liana/region_unique_liana/region_unique_combined_magnitude.png` — back-to-back bubble plot, Duodenum (left) vs Ileum (right), top 50 region-unique pairs per region. Bubble color = signaling module; bubble size = statistical significance (larger = more significant).
- `figures/liana/region_unique_liana_byregion/{duodenum,ileum}_{magnitude,specificity}.png` — per-region views by interaction magnitude and by sender–receiver specificity.
- `figures/liana/nichenet_circle_plots_de_noee/circle_de_{region}_to_{stem,ta}.png` — sender-level chord diagrams; ribbon width = number of interactions per sender (mature epithelia excluded, Paneth retained).

## Methods (concise)

- **Input:** annotated scRNA-seq object (`nichenet_obj.rds`, 19,280 cells, 17 cell types; Duodenum 11,261 / Ileum 8,019). Receivers = Stem cells + TA cells; senders = the other 15 cell types.
- **LIANA:** `liana_wrap` (resource = MouseConsensus, required for mouse data) run per region, then `liana_aggregate()`. Five consensus methods: NatMi, Connectome, LogFC, SingleCellSignalR, CellPhoneDB (500 permutations).
- **Significance:** Robust Rank Aggregation `aggregate_rank ≤ 0.05` — a corrected p-value integrating all five methods (more stringent than any single method).
- **Region-unique:** a pair significant in one region's stem/TA set but not the other.
- **Magnitude** = max `sca.LRscore`; **specificity** = max `natmi.edge_specificity` across senders.

## Caveats

- **Counts differ from the prior report** (previously 100 Duodenum-only / 115 Ileum-only). This is expected: significance moved from a single-method CellPhoneDB p < 0.05 to the five-method RRA FDR ≤ 0.05, which is more conservative and robust. The prior outputs lacked recorded provenance and are archived under `liana/_archive_prerun_2026-08-06/`.
- **The "Other" module (25 pairs)** groups ligands without a canonical signaling-module assignment (cytoskeletal/metabolic/housekeeping genes such as Vim, Ybx1, P4hb) rather than a coherent pathway; these should not be over-interpreted as a single biological signal.
- LIANA infers *potential* communication from expression of ligand and receptor; it does not by itself establish functional signaling. Cross-method support for these pairs is provided in the companion NicheNet report.

## Data files

- `liana/liana_{duodenum,ileum}_full.csv` — full consensus output (all cell types).
- `liana/liana_{duodenum,ileum}_st_ta_sig.csv` — significant stem/TA pairs with modules.
- `liana/region_unique_lr_combos.csv` — the 202 region-unique pairs (modules, senders, magnitude, specificity, RRA FDR).
- `liana/curated_ligand_module_map.csv` — curated ligand→module map.

## References

LIANA consensus framework and RRA aggregation [1]; CellPhoneDB [25]; LIANA benchmark [30]; SingleCellSignalR [32]; intestinal BMP/Wnt regional patterning [2, 23]; R-spondin/Lgr5 Wnt amplification [23].
