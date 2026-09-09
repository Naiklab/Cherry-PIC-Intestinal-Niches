# Unique and shared cell–cell communication in the regional intestinal stem/TA niche — combined LIANA + NicheNet synthesis

## Overview

This report synthesizes the combined **LIANA + NicheNet** cell–cell communication results for the regional intestinal scRNA-seq data, with **Stem cells** and **TA (transit-amplifying) cells** as receivers. LIANA scores ligand–receptor (LR) interactions by consensus across five methods (NatMI, Connectome, logFC, SingleCellSignalR, CellPhoneDB) and aggregates them into a robust rank (RRA `aggregate_rank`) [8, 9]; NicheNet complements this by scoring whether a ligand's expression predicts downstream target-gene changes in the receiver (ligand activity, Pearson correlation) [17, 18]. We fuse the two by rank-averaging so that pairs corroborated by both expression-based significance and functional target-gene activity are promoted.

Interactions are partitioned along **three axes**:
- **Region** — pairs unique to the Duodenum, unique to the Ileum, or shared by both.
- **Receiver** — pairs reaching Stem cells only, TA cells only, or both.
- **Method** — pairs supported by both methods (dual), LIANA-only, or NicheNet-only.

Throughout, mature epithelial cell types (Mid/Upper/Bottom-villus enterocytes, Goblet, Enteroendocrine) are **excluded as senders** (Paneth cells retained), so the signaling described originates from the non-epithelial niche and reserve-stem compartments. LIANA significance is RRA `aggregate_rank ≤ 0.05`; NicheNet activity is ligand Pearson > 0.

**Set sizes.** The region-unique analysis covers **202 pairs** (59 Duodenum-unique, 143 Ileum-unique). Deriving the complement gives **351 pairs shared by both regions** (significant in both, not in the 202). The shared set is much larger than either unique set — most stem/TA-directed signaling is region-conserved, and regional identity is encoded by a smaller, specialized layer on top.

---

## 1. Region axis — Duodenum-unique vs Ileum-unique vs shared

### Module composition

| Module | Duodenum-unique (n=59) | Ileum-unique (n=143) | Shared (n=351) |
|---|---|---|---|
| ECM–Integrin / Matrix | 14 (24%) | 35 (24%) | 56 (16%) |
| Other | 12 (20%) | 13 (9%) | 212 (60%) |
| WNT signaling | 9 (15%) | 12 (8%) | 3 (1%) |
| BMP / TGFβ family | 0 | 18 (13%) | 7 (2%) |
| Immune / antigen & integrin-Itgam | 6 (10%) | 15 (10%) | 13 (4%) |
| Axon guidance (Ephrin/Sema/Netrin/Slit) | 3 (5%) | 14 (10%) | 12 (3%) |
| Growth factors (EGF/HGF/VEGF/Nrg) | 5 (8%) | 7 (5%) | 13 (4%) |
| Wnt modulators (Sfrp/Sostdc1) | 0 | 8 (6%) | 1 (<1%) |
| FGF signaling | 1 (2%) | 6 (4%) | 4 (1%) |

ECM–Integrin / Matrix is the largest curated module in both unique sets (~24% each), underscoring that basement-membrane / integrin crosstalk is a core, spatially organized feature of the intestinal niche [20, 21, 23]. The striking regional contrast is in morphogen signaling: the **Duodenum-unique set is enriched for WNT signaling (15%)**, whereas the **Ileum-unique set is enriched for BMP/TGFβ (13%) and Wnt modulators (6%)** and carries a larger axon-guidance contingent (10%). This is consistent with a proximal–distal rebalancing of the Wnt/BMP axis along the small intestine, in which mesenchymal-epithelial crosstalk via Wnt and Shh patterns regional villus architecture and BMP signaling is graded along the crypt–villus and proximal–distal axes [1, 4, 11, 15].

### Top pairs per region

**Duodenum-unique** (by combined rank): Wnt4→Fzd5_Lrp6, Ang→Plxnb2, Wnt4→Fzd5_Lrp5, Lamc2→Dag1, Nxph3→Nrxn1, Rspo2→Lgr5, Sema4d→Met, Lamc2→Itga6_Itgb4, Fgf7→Fgfr2, Ang→Egfr. The leading Duodenum signals are canonical **Wnt (Wnt4→Fzd5/Lrp5/6)** and the **Wnt amplifier R-spondin→Lgr5**, the defining trophic axis of the crypt-base Lgr5+ stem cell [5, 7, 39], together with laminin–integrin/dystroglycan matrix adhesion and growth-factor (Ang, Fgf7) input.

**Ileum-unique**: Gnas→Adcy8, Fgf9→Fgfr2, Thbs2→Sdc1, Arf1→Chrm3, Bmp2→Actr2, Lama3→Itga6_Itgb4, Col27a1→Itga1_Itgb1, Lama3→Itga6_Itgb1, Col27a1→Itga2_Itgb1, Bmp2→Acvr2b_Bmpr1a. The leading Ileum signals are dominated by **ECM–integrin** (Thbs2, Lama3, Col27a1) and **BMP (Bmp2→multiple receptors)**, consistent with a more differentiation/gradient-oriented distal niche [1, 11].

**Shared** (top dual-supported): Bmp4→Rgmb, Fn1→Itga6, Ncam1→Fgfr2, Bmp4→Acvr2a_Bmpr1a, Bmp4→Acvr2b_Bmpr1a, Bmp4→Bmpr1a_Bmpr2, Bmp4→Lrp6, Pf4→Fgfr2. The conserved core is built around **Bmp4** (a central mesenchymal BMP that shapes the intestinal BMP gradient [1, 4]) and **fibronectin/ECM adhesion (Fn1→Itga6)** — the housekeeping scaffold both regions rely on.

### Senders

Post-exclusion, the dominant senders differ by region. **Duodenum-unique** pairs are driven by **CLU+ reserve stem cells (39)** and Fibroblasts (18), with Macrophages, Cd8aa IEL, and Paneth cells contributing. **Ileum-unique** pairs are dominated by **Fibroblasts (109)**, then Blood vascular endothelial cells (29), Cd8aa IEL (27), cDC1 (13), and Macrophages (12). The **shared** set is overwhelmingly **Fibroblast-driven (253)**, with vascular endothelium (151), Macrophages (54), and CLU+ reserve stem cells (52). This matches the established picture of PDGFRα+ mesenchymal populations (telocytes/trophocytes/fibroblasts) as the principal source of BMP and other niche signals [1, 6], with the Duodenum showing an unusually strong contribution from the CLU+ reserve-stem compartment itself.

---

## 2. Receiver axis — Stem vs TA, unique and shared

### Region-unique pairs by receiver

| Region | Stem-only | TA-only | Both receivers |
|---|---|---|---|
| Duodenum (59) | 7 | 22 | 30 |
| Ileum (143) | 48 | 23 | 72 |

The two regions differ in receiver targeting of their unique signals: **Duodenum-unique pairs skew toward TA** (22 TA-only vs 7 Stem-only), whereas **Ileum-unique pairs skew toward Stem** (48 Stem-only vs 23 TA-only). In both regions the largest fraction reaches **both** receivers, indicating that most region-unique signals are broadcast to the whole stem/progenitor compartment rather than restricted to one stage.

### Shared pairs by receiver

The shared set is even more strongly **both-receiver**: 316/351 (Duodenum) and 301/351 (Ileum) reach both Stem and TA cells, with only small Stem-only (13/32) and TA-only (22/18) minorities. Region-conserved signaling is thus largely **stage-agnostic**, hitting stem and progenitor cells together.

### Receiver module skew and senders

From the per-receiver combined analysis (post-exclusion): Duodenum Stem 50 / TA 48 pairs; Ileum Stem 137 / TA 124. Module composition is dominated by ECM–Integrin in both receivers and is largely balanced, with a **modest Stem tilt in the Ileum** in ECM–Integrin (+4), axon guidance (+3), and ECM-remodeling (+2). Top senders are the same for both receivers within a region (Duodenum: CLU+ reserve stem cells, Fibroblasts; Ileum: Fibroblasts, vascular endothelium, Cd8aa IEL). The top dual-supported pair is shared between receivers in both regions (Fgf7→Fgfr2 in Duodenum; Dkk2→Lrp5 in Ileum).

**Interpretation.** Receiver identity (stem vs progenitor) is a much weaker axis of variation than region. This is biologically reasonable: Lgr5+ stem cells and their TA daughters sit adjacent in the crypt and are bathed in the same niche signals, with fate differences driven more by intrinsic competence and Notch-mediated lateral inhibition than by wholly distinct extrinsic ligand sets [32, 33, 34]. The slight Ileum Stem enrichment for matrix and axon-guidance cues may reflect stronger adhesion/positional signaling in the distal stem compartment.

---

## 3. Method axis — dual-supported vs single-method

| Set | Dual (LIANA+NicheNet) | LIANA-only | NicheNet-only |
|---|---|---|---|
| Duodenum-unique (59) | 52 (88%) | 7 | — |
| Ileum-unique (143) | 135 (94%) | 8 | — |
| Shared (351) | 311 (89%) | 40 | — |

(The region-unique and shared sets are LIANA-significant by construction, so they contain no NicheNet-only pairs; NicheNet-only pairs appear only in the per-receiver combined sets, where the union allows them.)

NicheNet corroboration is high across all sets (88–94%), meaning most LIANA-significant region-unique/shared ligands also show detectable target-gene activity in the receiver — a strong cross-method validation given that the two methods use orthogonal evidence (expression/significance vs functional gene-regulatory impact) [8, 17]. The **dual-supported pairs are the highest-confidence tier** and are promoted to the front of every ranking.

The per-receiver combined sets reveal the complementary contributions: e.g., Ileum TA has 53 dual, 28 LIANA-only, and 43 NicheNet-only pairs. **LIANA-only** pairs are well-expressed, specific interactions whose ligands do not measurably move target genes in that receiver (possibly structural/adhesive roles, e.g., ECM–integrin); **NicheNet-only** pairs have ligands with target-gene activity but did not reach LIANA significance (often lower-expression ligands). Both single-method tiers are biologically meaningful but carry lower cross-method confidence.

---

## 4. Module-by-module synthesis

**ECM–Integrin / Matrix** — the dominant curated module in every set (region-unique Duodenum/Ileum, shared, both receivers). Built on laminins (Lama/Lamb/Lamc), collagens (Col27a1, Col8a1), fibronectin (Fn1), thrombospondins (Thbs2), and tenascin (Tnc) engaging integrins (Itga2/Itga6/Itgav with Itgb1/Itgb4) and dystroglycan (Dag1). This reflects the laminin-rich basement membrane that scaffolds the crypt–villus axis and integrin signaling that maintains intestinal stem-cell adhesion, survival, and proliferation [19, 20, 21, 23]. Region-sharing of ligands is moderate (65%) and receptors are highly shared (74%), indicating the same integrin receptors are reused while the matrix ligand repertoire is region-tuned.

**WNT signaling & R-spondin/Lgr5** — Duodenum-skewed among unique pairs (Wnt4→Fzd5/Lrp5/6; Rspo2→Lgr5). Canonical Wnt plus R-spondin amplification of Lgr5 is the master trophic axis of the crypt-base stem cell [5, 7, 39]. The shared set retains little WNT (1%), so Wnt pathway activity is largely region-conserved at the pair level but region-*weighted* at the unique layer.

**BMP / TGFβ family** — Ileum-skewed among unique pairs (Bmp2/Bmp5/Bmp6→many receptors). BMP signaling forms a villus-directed, mesenchyme-derived gradient that opposes Wnt and drives differentiation [1, 4, 11]. The shared core includes Bmp4→Rgmb and Bmp4→type-I/II receptors — the conserved mesenchymal BMP engine [1].

**Wnt modulators (Sfrp/Sostdc1)** — almost entirely Ileum-unique (8 pairs; e.g., Dkk2→Lrp5, Sfrp1→Fzd6). Secreted Wnt antagonists fine-tune the pathway and are the **most regionally rewired** module (only ~14% shared receptors), consistent with distal-specific modulation of Wnt tone [15].

**Axon guidance (Ephrin/Sema/Netrin/Slit)** — larger in the Ileum-unique set (10%) and modestly Stem-tilted. These cues (Ephrin–Eph, Sema4d–Met/Plxnb2, Netrin–Dcc/Neo1, Slit–Sdc1) are repurposed in adult epithelium for spatial positioning and lineage organization along the crypt–villus axis, including EphB/EFN-driven cell sorting [27, 28]. Convergent receptors (Ephb2, Sdc1, Plxnb2) integrate multiple ligands, with the Ileum adding receptors (e.g., Efnb2/3→Ephb2/3/4).

**Growth factors (EGF/HGF/VEGF/Nrg)** — present in all sets; EGF-family/ErbB and neuregulin signaling drive intestinal stem-cell proliferation and regeneration [29, 30, 31]. Duodenum-unique top pairs include Ang→Plxnb2/Egfr and Fgf7→Fgfr2.

**FGF signaling** — Fgf7/Fgf9→Fgfr2 appear in both regions' unique sets and as a top shared receiver pair; FGF supports epithelial proliferation and repair.

**Notch signaling** — small in the unique sets (Ileum 2 pairs); Notch/Delta lateral inhibition is the core cell-fate switch between absorptive and secretory lineages and is largely region-conserved [32, 33, 34].

**Immune / antigen & integrin-Itgam, Complement/coagulation, Lipid/iron transport** — reflect the immune (Cd8aa IEL, cDC1, macrophage) and vascular/endothelial contributions to the niche and region-specific metabolic/immune tone, more prominent in the Ileum-unique set.

### Convergent signaling and Ileum receptor diversification

Across modules, the Ileum shows **receptor diversification**: the same ligand engages more receptors in the Ileum than in the Duodenum. Notable examples (convergent ligands, Duodenum→Ileum receptor counts): **Wnt5a 2→10** (adding Epha7, Fzd2/6/7, Lrp5, Ptk7, Ror2, Ryk), **Wnt11 1→4**, **Bmp2 3→7**, **Bmp6 3→6**. Non-canonical Wnt/PCP signaling (Wnt5a→Ror2/Ryk/Ptk7) regulates intestinal stem-cell lineage priming and crypt morphogenesis/regeneration [35, 37, 38], so this distal receptor broadening suggests more elaborate non-canonical Wnt and BMP control in the Ileum. Conversely, some receptors **converge** (many ligands→one receptor), e.g., Ephb2 and Sdc1 in axon guidance.

---

## 5. Integrated takeaway

The stem/TA niche in both regions rests on a large, **region-conserved scaffold** (351 shared pairs) dominated by fibroblast/endothelial ECM–integrin adhesion and a Bmp4-centered morphogen core, broadcast largely **equally to stem and TA cells**. Regional identity is written in a smaller **unique layer**: the **Duodenum** emphasizes canonical **Wnt/R-spondin–Lgr5** trophic signaling with a strong CLU+ reserve-stem sender contribution, while the **Ileum** emphasizes **BMP/TGFβ, Wnt modulation, axon-guidance, and matrix-remodeling** with broad fibroblast/immune/vascular senders and a distinctive **receptor-diversification** pattern. Receiver (stem vs TA) differences are subtle by comparison — a modest Ileum Stem tilt in matrix/axon-guidance — consistent with stem and progenitor cells sharing a common niche and diverging mainly through intrinsic fate machinery [32, 33]. Method agreement is high (88–94% NicheNet-supported), so the dual-supported pairs constitute a robust, high-confidence signaling core.

## Caveats

- **Rank-based aggregation:** LIANA's `aggregate_rank` is a rank, so ordering among top pairs is noisy; small rank differences are not large effect differences.
- **Expression floor:** all LIANA methods depend on ligand/receptor expression; low-abundance but potent ligands (e.g., some morphogens) may be under-ranked or missed.
- **Region-unique filter blind spot:** the 202 unique pairs exclude pairs strong in both regions by design; the shared set (351) derived here addresses that, but the two are analyzed under slightly different NicheNet-support rules.
- **Dual-first ordering:** in combined rankings, dual-supported pairs are promoted ahead of all single-method pairs, so a strong single-method signal can sit below weaker dual pairs.
- **Sender exclusion:** removing mature epithelia changes pair membership (pairs with only excluded senders drop out); results are specific to the non-epithelial/reserve-stem niche.
- **Module curation:** some ligands are curated under "Other" despite belonging to named pathways (e.g., Bmp4 is in "Other" in the shared set though it is a BMP ligand); module labels reflect the curated annotation, not always pathway membership.

## Files

- Region-unique combined: `liana/region_unique_combined_rank.csv` (202 pairs)
- Shared-both-regions combined: `liana/region_shared_combined.csv` (351 pairs)
- Per-receiver combined: `liana/region_unique_combined_byreceiver_{duodenum,ileum}_{stem,ta}.csv`
- Module wiring: `liana/joint_module_wiring.csv`, `joint_module_convergent_receptors.csv`, `joint_module_convergent_ligands.csv`, `joint_module_region_specific_lr.csv`
- Receiver summary: `liana/stem_vs_ta_module_counts.csv`, `stem_vs_ta_top_senders.csv`
- Figures: `figures/liana/region_unique_combined/`, `figures/liana/region_unique_combined_byreceiver/`, `figures/liana/joint_module_wiring/`
