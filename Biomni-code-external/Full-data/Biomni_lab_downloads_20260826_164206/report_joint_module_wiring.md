# Joint Modules Wired Differently Between Duodenum and Ileum

**Question:** For signaling modules active in **both** regions (joint modules), does the same pathway use **different ligands or receptors** in Duodenum vs Ileum?

**Answer:** Yes — substantially. 13 of 14 curated modules are joint (active in both regions after combined filtering); most are **rewired**: the two regions engage the same pathway through partly non-overlapping ligand and receptor sets. The dominant pattern is **receptor diversification in Ileum** — Ileum engages a broader receptor repertoire for the same ligands, especially in WNT, Wnt-modulator, and BMP/TGFβ signaling. NicheNet activity filtering additionally reveals a **functional ligand switch** in the R-spondin module (Rspo2 in Duodenum → Rspo3 in Ileum) that was invisible in the LIANA-only analysis.

**Data:** all significant Stem/TA pairs requiring **both** LIANA RRA consensus significance (`aggregate_rank ≤ 0.05`) **and** NicheNet ligand activity (Pearson > 0 in the region-matched DE run, union of Stem and TA receivers). CLU+ reserve stem cells and mature epithelia (Mid/Upper/Bottom-villus enterocytes, Goblet cells, Enteroendocrine cells) excluded as senders; Paneth cells kept. After combined filtering: **314 unique LR pairs (Duodenum), 379 (Ileum)** — down from 394/473 LIANA-only (post-exclusion). A ligand/receptor is "shared" if it appears in that module's combined-supported pairs in both regions.

---

## 1. Most modules are rewired; Ileum broadens the receptor side

Shared fraction (shared ÷ union) per module, ligands vs receptors:

| Module | Ligands shared | Receptors shared | Interpretation |
|---|---|---|---|
| ECM-remodeling | 6/7 (86%) | 7/11 (64%) | ligands shared, receptors broaden in Ileum |
| Other (housekeeping) | 63/84 (75%) | 56/74 (76%) | largely shared, moderate rewiring |
| ECM–Integrin / Matrix | 12/19 (63%) | 27/32 (84%) | receptors mostly shared; Ileum adds ligands |
| Growth factors | 4/6 (67%) | 6/9 (67%) | moderate, symmetric |
| Lipid / iron transport | 3/7 (43%) | 10/15 (67%) | ligand rewired, receptors more shared |
| Immune / antigen | 7/15 (47%) | 11/22 (50%) | strongly rewired on both sides |
| Axon guidance | 4/8 (50%) | 4/13 (31%) | receptor-broadened in Ileum |
| BMP / TGFβ | 2/4 (50%) | 5/11 (45%) | Ileum receptor diversification |
| FGF | 2/5 (40%) | 2/2 (100%) | receptors fully shared; ligand differs |
| WNT | 1/2 (50%) | 2/10 (20%) | Ileum receptor diversification |
| Complement | 1/3 (33%) | 4/8 (50%) | small, rewired |
| Wnt modulators | 1/4 (25%) | 1/6 (17%) | most rewired module |
| R-spondin / Lgr5 | 0/2 (0%) | 1/5 (20%) | **ligand switch** (Rspo2→Rspo3) |
| Notch | 0/1 (0%) | 0/2 (0%) | **Ileum-only** after NicheNet filtering |

**Key patterns:**
- The generic "Other" module is still the most shared (75%/76%) — rewiring is concentrated in developmental signaling pathways, not a global artifact.
- **WNT, Wnt modulators, BMP/TGFβ, and axon guidance** show the strongest receptor diversification: Ileum engages markedly more receptors for overlapping ligands (WNT 2→10 receptors, Wnt modulators 1→6, BMP/TGFβ 5→11, axon guidance 4→13).
- **NicheNet filtering sharpened the rewiring signal.** Convergent ligands dropped from 60 (LIANA-only) to 35 (combined) — many ligands present in the LIANA-only analysis had no NicheNet activity and were removed, leaving a more functionally grounded set of rewired interactions.
- **Two modules changed joint status.** Notch became Ileum-only (Dll4→Notch1/2 absent from Duodenum after NicheNet filtering). R-spondin/Lgr5 became the most extreme ligand-switch case (0% shared ligands).

## 2. Convergent receptors — same receptor, different ligands per region

42 receptors are engaged in both regions but by **different ligand sets** (down from 44 in LIANA-only). Notable non-housekeeping cases:

- **Cd44** (ECM–Integrin): 2 ligands in Duodenum (Fn1, Vcan) → 8 in Ileum (adds Col4a5, Col4a6, Lama1, Lama3, Lama5, Lamb2). Ileum broadens the ECM ligand input to a shared signaling hub.
- **Itga2_Itgb1** (ECM–Integrin): 4 ligands in Duodenum → 5 in Ileum, only 1 shared — nearly complete ligand turnover.
- **Ephb2** (Axon guidance): 3 ligands in Duodenum → 4 in Ileum (adds Efnb3).
- **Fgfr2** (FGF): 4 ligands in Duodenum (Fgf10, Fgf13, Fgf2, Fgf7) → 3 in Ileum (Fgf10, Fgf2, Fgf9) — Duodenum retains Fgf7/Fgf13, Ileum adds Fgf9.

## 3. Convergent ligands — same ligand, different receptors per region

35 ligands act in both regions but through **different receptor sets** (down from 60 in LIANA-only — NicheNet filtering removed many non-functional ligands). The clearest cases of **Ileum receptor diversification**:

- **Wnt5a** (WNT): **2 receptors in Duodenum (Fzd5, Ptprk) → 10 in Ileum** (adds Epha7, Fzd2/6/7, Lrp5, Ptk7, Ror2, Ryk). The single most rewired interaction — survives NicheNet filtering intact.
- **Bmp2** (BMP/TGFβ): 3 receptors in Duodenum → 7 in Ileum (adds Acvr1, Acvr2b_Bmpr1a, Acvr2, Smo).
- **Lama3** (ECM): 1 receptor in Duodenum → 6 in Ileum.
- **Efna5** (Axon guidance): 1 receptor (Ephb2) in Duodenum → 4 in Ileum (adds Epha1, Epha4, Epha7).
- **Lamb2, Hspg2, Col18a1, Tnc** (ECM): all show 1.5–2× receptor broadening in Ileum.

## 4. Biological interpretation

- **The regions share the same signaling *pathways* but not the same *wiring*.** Regional identity is encoded less in *which* modules are active (13 of 14 are joint) and more in *how* each module is connected. NicheNet filtering strengthens this conclusion by removing non-functional ligands that inflated the LIANA-only overlap.
- **Ileum shows receptor diversification.** For the core developmental pathways (WNT, BMP/TGFβ, axon guidance), Ileum engages a markedly broader receptor repertoire downstream of overlapping ligands. This is consistent with the Ileum niche driving more elaborate signaling integration onto stem/TA cells — matching earlier findings that Ileum signaling is niche-driven (stromal/vascular/immune) whereas Duodenum is more epithelial-autonomous.
- **Wnt5a is the flagship case.** The same Wnt5a ligand is received through only Fzd5/Ptprk in Duodenum but through a 10-receptor non-canonical array (Ror2, Ryk, Ptk7, multiple Fzd) in Ileum — suggesting region-specific routing of Wnt5a toward planar-cell-polarity / non-canonical outcomes in Ileum. This result is robust to NicheNet filtering.
- **R-spondin ligand switch (Rspo2→Rspo3) is a new finding from NicheNet integration.** In the LIANA-only analysis, both Rspo2 and Rspo3 appeared in both regions. NicheNet activity reveals that only Rspo2 is functionally active in Duodenum (Pearson = 0.004 for Stem receiver) while only Rspo3 is active in Ileum (Pearson = 0.006). This suggests region-specific tuning of the Wnt amplifier: Duodenum and Ileum use different R-spondin ligands to engage the Lgr4/5/Znrf3/Rnf43 complex, potentially reflecting distinct regulatory dynamics of the stem-cell niche along the proximal-distal axis.
- **Notch is Ileum-only after NicheNet filtering.** Dll4→Notch1/2 is significant in Ileum but has no NicheNet-supported counterpart in Duodenum, suggesting Notch signaling to stem/TA cells is a distal-specific input.
- **Convergent receptors (Cd44, integrins, Fgfr2)** act as shared signaling hubs that each region feeds with a different ligand mix — a mechanism for tuning the same receiver to regional inputs.

## 5. Outputs

**Note:** The CSV tables and figures listed below were generated from the prior LIANA-only analysis and have **not** been regenerated with the combined filter. The numbers in this report are computed fresh from the combined (LIANA+NicheNet) data. If you need the underlying tables updated to match, let me know.

- `liana/joint_module_wiring.csv` — per-module shared vs region-specific ligand/receptor counts + full gene lists (LIANA-only; pending combined refresh).
- `liana/joint_module_convergent_receptors.csv` — convergent receptors (LIANA-only; 44 rows vs 42 combined).
- `liana/joint_module_convergent_ligands.csv` — convergent ligands (LIANA-only; 60 rows vs 35 combined).
- `liana/joint_module_region_specific_lr.csv` — region-specific ligand/receptor entries (LIANA-only; 162 rows vs 145 combined).
- `figures/liana/joint_module_wiring/joint_module_wiring.{png,svg}` — per-module shared vs region-specific ligands/receptors (LIANA-only).
- `figures/liana/joint_module_wiring/joint_module_convergent_receptors.{png,svg}` — top convergent receptors (LIANA-only).

## 6. Caveats

- **Combined filter:** "Combined-supported" requires LIANA significance (aggregate_rank ≤ 0.05) AND NicheNet ligand activity (Pearson > 0 in the region-matched DE run, union of Stem and TA receivers). The Pearson > 0 threshold is lenient — it retains ligands with any positive predictive activity, so combined counts remain close to LIANA-only. A stricter threshold (e.g., Pearson > 0.05) would further reduce counts and sharpen the rewiring signal.
- **Significance-threshold distinction:** "Shared" requires the pair to be combined-supported in both regions; a ligand/receptor scored as region-specific may fall below the NicheNet activity threshold in one region rather than being truly absent.
- **Receptor/ligand counts are over distinct genes**, not weighted by expression magnitude; a region-specific receptor with low expression contributes equally to a high-expression one.
- **Convergence is assessed within a module**; cross-module receptor sharing is not captured.
- **Sender exclusions:** CLU+ reserve stem cells and mature epithelia (Mid/Upper/Bottom-villus enterocytes, Goblet cells, Enteroendocrine cells) are excluded as senders. Paneth cells, Stem cells, TA cells, TA/early progenitors, and all niche cell types (Fibroblasts, Macrophages, Endothelial, cDC1, Cd8aa IEL, Helper T, Plasmablasts) are retained.
- **NicheNet activity is per-ligand, not per-LR-pair.** A ligand is counted as active if it predicts the receiver's gene program in that region, regardless of which specific receptor it engages. This means a ligand's activity is not receptor-specific.
