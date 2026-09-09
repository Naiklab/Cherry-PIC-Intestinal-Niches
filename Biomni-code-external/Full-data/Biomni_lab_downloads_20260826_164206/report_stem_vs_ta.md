# Stem vs TA receivers — combined LIANA + NicheNet summary

**Question.** Among the region-unique ligand–receptor (LR) pairs (Duodenum-unique or Ileum-unique relative to the other region), which signaling modules and sender cell types preferentially target **Stem cells** versus **TA cells**, and does that preference differ between the two intestinal regions?

**Method.** For each region and receiver we built a combined per-receiver LR ranking as the **union** of the LIANA per-receiver set (pair significant for that receiver, RRA `aggregate_rank ≤ 0.05`) and the NicheNet per-receiver set (ligand with activity Pearson > 0 in that receiver's run). Pairs supported by **both** methods ("dual-supported") were ranked first by the **rank-average** of their per-receiver LIANA RRA rank and NicheNet activity rank; single-method pairs were appended after (LIANA-only by RRA, NicheNet-only by activity). Module labels come from the authoritative region-unique pair table.

**Sender exclusion.** Consistent with the rest of this project, mature epithelial cell types were **excluded as senders**: Mid-villus, Upper-villus and Bottom-Villus enterocytes, Goblet cells, and Enteroendocrine cells (Paneth cells retained). A pair is counted for a receiver only if at least one **non-excluded** sender reaches it; pairs whose only senders were excluded drop out of that receiver's set. This reduced the region-unique per-receiver sets from Duodenum Stem 37→**35**, TA 52→**47**; Ileum Stem 120→**100**, TA 95→**81** (LIANA side). Counts below are the number of combined region-unique pairs per module per receiver after this exclusion.

## Set overlap between receivers

The Stem and TA combined sets are largely overlapping within each region — most region-unique pairs signal to **both** stem and transit-amplifying cells:

| Region | Stem pairs | TA pairs | Shared | Stem-only | TA-only |
|---|---|---|---|---|---|
| Duodenum | 50 | 48 | 41 | 9 | 7 |
| Ileum | 137 | 124 | 120 | 17 | 4 |

## Module counts per receiver

**Duodenum** (50 Stem / 48 TA pairs). ECM–Integrin / Matrix dominates and is perfectly balanced (13 Stem / 13 TA). No module shows a meaningful receiver skew; nets range only from −1 (Other, Lipid/iron; slight TA) to +1 (WNT, Axon guidance, ECM-remodeling, R-spondin/Lgr5; slight Stem). Duodenum signaling to stem and TA cells is **quantitatively similar in module composition**.

| Module | Stem | TA | net (Stem−TA) |
|---|---|---|---|
| ECM–Integrin / Matrix | 13 | 13 | 0 |
| Other | 8 | 9 | −1 |
| WNT signaling | 8 | 7 | +1 |
| Immune / antigen & integrin-Itgam | 6 | 6 | 0 |
| Growth factors (EGF/HGF/VEGF/Nrg) | 4 | 4 | 0 |
| Axon guidance (Ephrin/Sema/Netrin/Slit) | 3 | 2 | +1 |
| Lipid / lipoprotein & iron transport | 2 | 3 | −1 |
| ECM-remodeling / proteases & inhibitors | 2 | 1 | +1 |
| R-spondin / Lgr5 (Wnt amplifier) | 2 | 1 | +1 |
| Complement / coagulation | 1 | 1 | 0 |
| FGF signaling | 1 | 1 | 0 |

**Ileum** (137 Stem / 124 TA pairs). ECM–Integrin / Matrix again dominates, with a modest **Stem skew** (+4; 33 Stem / 29 TA). Other consistent Stem tilts are in Axon guidance (+3), Other (+3), and ECM-remodeling (+2). BMP/TGFβ, Immune, WNT, Wnt modulators, Growth factors, FGF, Complement, and Lipid/iron are essentially balanced. As in the Duodenum, there is **no strongly receiver-specific module** — the same modules reach both stem and TA cells, with a slight Stem tilt in matrix and axon-guidance cues.

| Module | Stem | TA | net (Stem−TA) |
|---|---|---|---|
| ECM–Integrin / Matrix | 33 | 29 | +4 |
| BMP / TGFβ family | 17 | 17 | 0 |
| Immune / antigen & integrin-Itgam | 13 | 13 | 0 |
| Axon guidance (Ephrin/Sema/Netrin/Slit) | 14 | 11 | +3 |
| WNT signaling | 12 | 12 | 0 |
| Other | 12 | 9 | +3 |
| Wnt modulators (Sfrp/Sostdc1) | 8 | 8 | 0 |
| Growth factors (EGF/HGF/VEGF/Nrg) | 7 | 7 | 0 |
| FGF signaling | 6 | 6 | 0 |
| ECM-remodeling / proteases & inhibitors | 6 | 4 | +2 |
| Complement / coagulation | 4 | 4 | 0 |
| Lipid / lipoprotein & iron transport | 3 | 3 | 0 |
| Notch signaling | 2 | 1 | +1 |

## Top senders per receiver

Counting how many combined pairs each (non-excluded) sender cell type contributes (a pair may have several senders):

- **Duodenum → Stem:** CLU+ reserve stem cells (19), Fibroblasts (8), Cd8aa IEL (3)
- **Duodenum → TA:** CLU+ reserve stem cells (20), Fibroblasts (10), Macrophages (6)
- **Ileum → Stem:** Fibroblasts (61), Blood vascular endothelial cells (19), Cd8aa IEL (13)
- **Ileum → TA:** Fibroblasts (48), Cd8aa IEL (14), Blood vascular endothelial cells (10)

After the sender exclusion, the dominant senders are the **same for both receivers** within a region and are all non-epithelial niche / reserve-stem populations: CLU+ reserve stem cells and Fibroblasts in the Duodenum; Fibroblasts (by a wide margin) plus vascular endothelium and Cd8aa IEL in the Ileum. The earlier appearance of "Upper-villus enterocytes" as a top Ileum sender is now removed by the exclusion. Sender identity does not distinguish stem- from TA-directed signaling.

## Top dual-supported pairs per receiver

The highest-confidence pairs (supported by both LIANA and NicheNet, ranked by rank-average) per receiver:

- **Duodenum → Stem:** Fgf7→Fgfr2 (FGF), Gas6→Mertk, Ang→Plxnb2, Sema4d→Met, Ang→Egfr
- **Duodenum → TA:** Fgf7→Fgfr2 (FGF), Ang→Plxnb2, Gas6→Mertk, Ang→Egfr, Pf4→Grm7
- **Ileum → Stem:** Dkk2→Lrp5 (Wnt modulator), Wnt11→Fzd7 (WNT), Tnc→Itga2, Sfrp1→Fzd6 (Wnt modulator), Psap→Celsr1
- **Ileum → TA:** Dkk2→Lrp5 (Wnt modulator), Tnf→Tradd (Immune), Col27a1→Itga1_Itgb1, Col27a1→Itga2_Itgb1, Bmp2→Actr2 (BMP/TGFβ)

The top pair is shared between receivers in both regions (Fgf7→Fgfr2 in Duodenum; Dkk2→Lrp5 in Ileum), reinforcing that the strongest region-unique signals reach both stem and TA cells.

## Takeaway

Across both regions, region-unique signaling to **Stem** and **TA** cells is far more **similar than different**: the same ECM–Integrin-dominated module profile, the same dominant (non-epithelial) senders, and mostly the same top LR pairs. The only consistent receiver tilt is a modest **Stem bias in ECM–Integrin, axon-guidance, and matrix-remodeling cues in the Ileum**. Receiver identity (stem vs TA) is a much weaker axis of variation than **region** (Duodenum vs Ileum) in this dataset.

## Files

- Combined per-receiver tables: `liana/region_unique_combined_byreceiver_{duodenum,ileum}_{stem,ta}.csv`
- Module-count summary: `liana/stem_vs_ta_module_counts.csv`; top senders: `liana/stem_vs_ta_top_senders.csv`
- Figures: `figures/liana/region_unique_combined_byreceiver/` — 8 module-clustered bubble plots (`combined_{region}_{receiver}_top{50,100}_bymodule`) and `stem_vs_ta_module_counts.{png,svg}`
