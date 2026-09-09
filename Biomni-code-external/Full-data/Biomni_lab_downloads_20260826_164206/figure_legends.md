# Figure Legends: Pathway/Module Analysis, Hub-Spoke Plots, and Venn Diagrams

*All cell-cell communication figures use Stem cells as the sole receiver.*

---

## A. Signaling Module Bar Plots

### Figure A1. LR pair counts per signaling module (lr_counts_per_module)

Bar plot showing the number of significant ligand-receptor (LR) pairs per curated signaling module for Duodenum and Ileum. LR pairs were identified by LIANA robust rank aggregation (RRA) at aggregate_rank ≤ 0.05, with Stem cells as receiver. CLU+ reserve stem cells and mature epithelia (Mid/Upper/Bottom-villus enterocytes, Goblet cells, Enteroendocrine cells) are excluded as senders; Paneth cells are retained. Stem cells and TA/early progenitors are included as senders (autocrine and paracrine signaling to Stem cells). Each bar represents the count of unique LR pairs assigned to one of 14 curated signaling modules (WNT, BMP/TGFβ, FGF, R-spondin/Lgr5, Notch, Wnt modulators, ECM-Integrin/Matrix, ECM-remodeling, Axon guidance, Growth factors, Immune/antigen, Lipid/iron transport, Complement/coagulation, Other). Bars are grouped by region to facilitate cross-regional comparison of module engagement. Duodenum has 584 significant LR pairs; Ileum has 703.

### Figure A2. LR pair counts per sender cell type (comparison_barplot_mergedtypes)

Bar plot comparing the number of significant LR pairs per sender cell type between Duodenum and Ileum, with Stem cells as receiver. Sender cell types reflect merged annotations (Fibroblasts = FOXL1+ and GREM1+ combined; Macrophages = Resident, Monocyte-derived, and Proliferating combined; TA / early progenitors = TA cells and TA cells/early progenitors combined). Bar height = number of significant LR pairs (aggregate_rank ≤ 0.05) from each sender to Stem cells. CLU+ reserve stem cells and mature epithelia (Mid/Upper/Bottom-villus enterocytes, Goblet cells, Enteroendocrine cells) are excluded as senders; Paneth cells are retained. Stem cells and TA/early progenitors are included as senders (autocrine and paracrine signaling to Stem cells). Sender cell types are color-coded.

### Figure A3. Combined region-unique LR pairs per module for Stem cells (stem_module_counts)

Horizontal stacked bar plot showing the number of combined region-unique LR pairs per signaling module for Stem cell receivers, faceted by region (Duodenum, Ileum). "Combined" requires both LIANA significance (aggregate_rank ≤ 0.05) and NicheNet ligand activity (Pearson > 0 in the region-matched Stem cell DE run). "Region-unique" denotes LR pairs LIANA-significant for Stem cells in one region but not the other. Each bar is split into dual-supported (LIANA + NicheNet, dark fill) and LIANA-only (lighter fill) segments. CLU+ reserve stem cells and mature epithelia (Mid/Upper/Bottom-villus enterocytes, Goblet cells, Enteroendocrine cells) are excluded as senders; Paneth cells are retained. Duodenum has 32 region-unique pairs (23 dual-supported, 9 LIANA-only); Ileum has 117 (84 dual-supported, 33 LIANA-only). Counts are consistent with the Venn diagram (Figure F1) and bubble plots (Figure E1).

---

## B. Pathway Enrichment Bar Plots and Dot Plots

### Figure B1. GSEA pathway enrichment bar plot for Stem cells (pathway_barplot_stem_cells_v2)

Bar plot showing Gene Set Enrichment Analysis (GSEA) results for Ileum vs Duodenum differentially expressed genes in Stem cells. Bar length = Normalized Enrichment Score (NES); positive NES indicates enrichment in Ileum, negative in Duodenum. Bar color indicates adjusted p-value significance (-log10(padj)). Gene set collections include Hallmark, KEGG, and Reactome. Only pathways with padj < 0.05 are shown.

### Figure B2. GSEA top-25 bar plots per gene set collection (gsea_barplot_top25_Hallmark, gsea_barplot_top25_KEGG, gsea_barplot_top25_GOBP, gsea_barplot_top25_Reactome)

Bar plots showing the top 25 gene sets ranked by absolute NES from GSEA of Stem cell differentially expressed genes (Ileum vs Duodenum), stratified by gene set collection (Hallmark, KEGG, Gene Ontology Biological Process, Reactome). Bar length = NES; bar color = -log10(padj). Dashed vertical line at NES = 0 separates Ileum-enriched (right) from Duodenum-enriched (left) pathways.

### Figure B3. GSEA dot plot for Stem cells (gsea_dotplot_Stem_cells)

Dot plot showing the top 15 significant gene sets (padj < 0.05) from GSEA of Stem cell differentially expressed genes (Ileum vs Duodenum), ranked by absolute NES. Dot position on x-axis = NES; dot size = gene set size; dot color = -log10(padj) (orange to red gradient). Gene set collection is indicated by a single-letter prefix (H = Hallmark, K = KEGG, R = Reactome). Dashed vertical line at NES = 0.

### Figure B4. ORA dot plot across cell types (ora_dotplot_all_celltypes)

Dot plot showing Over-Representation Analysis (ORA) results for Ileum-vs-Duodenum marker genes across all cell types. Each cell type contributes its top 5 enriched terms (ranked by adjusted p-value). Dot size = number of overlapping genes (Count); dot color = -log10(p.adjust) (green to red gradient). Cell types are on the x-axis, enriched terms on the y-axis. Gene sets are drawn from Hallmark and KEGG collections.

---

## C. Heatmaps

### Figure C1. LIANA LR pair score heatmaps (heatmap_duodenum_mergedtypes, heatmap_ileum_mergedtypes)

Heatmaps showing LIANA significance scores for the top 25 LR pairs across sender cell types for Duodenum and Ileum separately, with Stem cells as receiver. Cell color = -log10(aggregate_rank), scaled from cream (non-significant) through orange to red (highly significant). Sender cell types are annotated by color bars above the heatmap. LR pairs are ordered by maximum score across senders. Numerical values are printed in cells exceeding 60% of the maximum score. CLU+ reserve stem cells and mature epithelia (Mid/Upper/Bottom-villus enterocytes, Goblet cells, Enteroendocrine cells) are excluded as senders; Paneth cells are retained. Stem cells and TA/early progenitors are included as senders (autocrine and paracrine signaling). Duodenum top-25 pairs involve 3 sender types (Fibroblasts, Cd8aa IEL, Paneth cells); Ileum top-25 pairs involve 5 sender types (Fibroblasts, Blood vascular endothelial cells, Macrophages, Cd8aa IEL, Paneth cells).

### Figure C2. ORA pathway x cell-type heatmap (pathway_heatmap_celltypes)

Heatmap showing pathway enrichment scores from Over-Representation Analysis (ORA) of Ileum-vs-Duodenum marker genes, with pathways (rows) and cell types (columns). Cell color = -log10(p.adjust), scaled from cream (non-significant) through orange to red (highly significant). The top 25 pathways (by minimum p.adjust across cell types) are included. Both rows and columns are hierarchically clustered to reveal co-enriched pathway-cell-type blocks. Gene sets are drawn from Hallmark and KEGG collections.

### Figure C3. Module concordance heatmaps (spatial_pathway_heatmap, spatial_lr_heatmap)

Concordance heatmaps showing signaling module and LR pair activity across cell types and LIANA analysis contexts. Panel 1 (spatial_pathway_heatmap): curated signaling modules (rows) x cell types (columns), indicating which modules are active in which cell types based on LR pair membership. Panel 2: modules (rows) x 2 LIANA contexts (columns: Duodenum-Stem, Ileum-Stem), showing how module engagement varies by region for Stem cell receivers. Cell color indicates the number or proportion of active LR pairs per module per context.

*Note: These figures were generated at the module level (not individual LR-pair level) in an earlier analysis iteration. Sender exclusions (CLU+, mature epithelia) have less impact at the module aggregate level, but these figures have not been re-run with the current standardized exclusions. The generation scripts are no longer available.*

### Figure C4. Pathway module dendrogram (pathway_module_dendrogram)

Hierarchical clustering dendrogram of pathway modules, showing the relationships among curated signaling modules based on shared LR pair composition or pathway gene overlap. Modules that share more ligands, receptors, or pathway genes cluster more closely. This dendrogram defines the module groupings used throughout the signaling module analysis.

---

## D. Hub-Spoke Plots (LIANA + NicheNet Combined)

### Figure D1. Hub-and-spoke sender-receiver interaction plots for Stem cells (hubspoke_combined_duodenum_stem, hubspoke_combined_ileum_stem)

Hub-and-spoke plots summarizing the number of significant ligand-receptor interactions from each sender cell type to Stem cell receivers for Duodenum and Ileum, using the combined LIANA + NicheNet evidence filter. The central hub (dark grey) represents Stem cells; each spoke connects to a sender cell type positioned radially around the hub. Spoke width and sender node size are proportional to the number of significant LR pairs from that sender to Stem cells, with the exact count printed inside each node. Sender cell types are color-coded using a colorblind-friendly palette (Fibroblasts = red, Macrophages = navy, Blood vascular endothelial = teal, cDC1 = cyan, Activated/helper T = bright red, Cd8aa IEL = brown, Plasmablasts = olive, Paneth = salmon, Stem cells = purple, TA/early progenitors = green).

"Combined" requires both LIANA RRA consensus significance (aggregate_rank ≤ 0.05) and NicheNet ligand activity (Pearson correlation > 0 in the region-matched Stem cell DE run). CLU+ reserve stem cells and mature epithelia (Mid/Upper/Bottom-villus enterocytes, Goblet cells, Enteroendocrine cells) are excluded as senders; Paneth cells are retained. "(self)" denotes autocrine signaling (Stem cells signaling to themselves); "TA/early prog.->Stem" denotes cross-talk from the TA/early progenitor compartment.

Two panels are provided, one per region: Duodenum-Stem and Ileum-Stem. Comparing across panels reveals which sender cell types dominate the niche signal in each region.

---

## E. Module-Clustered Bubble Plots (LIANA + NicheNet Combined)

### Figure E1. Region-unique combined LR pairs by module for Stem cells (region_unique_combined_byreceiver/combined_{duodenum,ileum}_stem_top50_bymodule)

Bubble plots showing region-unique LR pairs for Stem cell receivers in each region, clustered by curated signaling module. Duodenum shows all 32 qualifying pairs; Ileum shows the top 50 of 117. Each point represents one LR pair; the y-axis lists pairs grouped into module blocks (separated by grey horizontal lines), with module labels on the right. The x-axis shows NicheNet ligand activity (Pearson correlation from the region-matched Stem cell DE run). Point size = -log10(LIANA RRA aggregate_rank); point color = signaling module; point opacity indicates NicheNet support (full opacity = dual-supported, i.e., both LIANA and NicheNet evidence; semi-transparent = LIANA-only). LR pairs without NicheNet activity are plotted at a leftward "gutter" position.

Pairs are ranked in two tiers: (1) dual-supported pairs (LIANA-significant AND NicheNet-active for Stem cells) first, ordered by combined_rank = (LIANA RRA rank + NicheNet activity rank) / 2; (2) LIANA-only pairs next, ordered by aggregate_rank. The top 50 are the first 50 rows of this ranking; Duodenum has fewer than 50 total, so all 32 are shown.

"Region-unique" denotes LR pairs that are LIANA-significant (aggregate_rank ≤ 0.05) for Stem cells in one region but not the other. NicheNet ligand activity (Pearson > 0 in the region-matched Stem cell DE run) is overlaid as a visual attribute — all pairs in the plot are LIANA-significant; opacity indicates which also have NicheNet support. CLU+ reserve stem cells and mature epithelia (Mid/Upper/Bottom-villus enterocytes, Goblet cells, Enteroendocrine cells) are excluded as senders; Paneth cells are retained. Two panels: Duodenum-Stem and Ileum-Stem.

The dual-supported subset (opaque points) corresponds exactly to the "combined" Venn diagram region-unique counts in Figure F1 (23 Duodenum-only, 84 Ileum-only). The total bubble counts (32 Duodenum, 117 Ileum) correspond to the "LIANA" Venn region-unique counts.

---

## F. Venn Diagrams: Shared vs Region-Unique LR Pairs for Stem Cells

### Figure F1. Two-way Venn diagrams of Duodenum vs Ileum LR pairs for Stem cells (venn_liana_stem, venn_combined_stem)

Two-way Venn diagrams showing the overlap in significant ligand-receptor pairs between Duodenum (orange) and Ileum (blue) for Stem cell receivers, comparing LIANA-only evidence (left) with the combined LIANA + NicheNet filter (right). Each circle represents the set of unique LR pairs (by ligand-receptor identity, sender-agnostic) significant in that region; circle areas are drawn equal for visual clarity, with only the overlap proportion reflecting the true shared fraction. Zone labels show exact counts: Duodenum-only (left), shared (center), Ileum-only (right).

For the LIANA-only panel, a pair is included if LIANA RRA aggregate_rank ≤ 0.05 for Stem cells in that region. For the combined panel, region-uniqueness is first defined at the LIANA level (significant for Stem cells in one region but not the other), then the combined subset retains only those pairs whose ligand also has NicheNet activity (Pearson > 0 in the region-matched Stem cell DE run). This ensures the combined region-unique counts are a strict subset of the LIANA region-unique counts. CLU+ reserve stem cells and mature epithelia (Mid/Upper/Bottom-villus enterocytes, Goblet cells, Enteroendocrine cells) are excluded as senders; Paneth cells are retained. Counts are sender-agnostic (unique L-R pairs per region, de-duplicated across senders).

Ileum consistently engages more LR pairs than Duodenum (larger Ileum-only zone), reflecting broader signaling to Stem cells in the distal niche. NicheNet filtering reduces total counts (349 → 259 Duodenum, 434 → 320 Ileum) but preserves the shared core (317 → 236), indicating that the region-specific expansion is partly driven by ligands without detectable predictive activity. The combined region-unique counts (23 Duodenum-only, 84 Ileum-only) correspond to the dual-supported (opaque) points in the bubble plots (Figure E1); the LIANA region-unique counts (32 Duodenum-only, 117 Ileum-only) correspond to the total bubble counts.

---

## G. Per-Cell-Type Diverging Pathway Bar Plots

*These figures characterize each cell type's intrinsic pathway programs (GSEA of that cell type's own Ileum-vs-Duodenum differentially expressed genes), not LR-pair receiver activity. The Stem-cells-as-receiver constraint does not apply. Curated mechanistic modules and validated L-R pairs are drawn from the project Excel ("Mechanistic_Modules_ Final analysis july 25.xlsx", sheet "Curated Pathways").*

### Figure G1. Fibroblasts — diverging pathway enrichment bar plot (pathway_barplot_Fibroblasts)

Two-panel diverging bar plot showing GSEA pathway enrichment for Fibroblasts' own Ileum-vs-Duodenum differentially expressed genes, organized by curated mechanistic module. Bar length = Normalized Enrichment Score (NES); positive NES (right of zero) indicates Ileum enrichment, negative NES (left of zero) indicates Duodenum enrichment. After coord-flip, bars extend upward (Ileum-up) or downward (Duodenum-up) from the zero line, producing the double-sided layout.

**Panel A (top) — Module-level summary:** One horizontal bar per mechanistic module, using the maximum |NES| across member pathways. Modules are sorted by |NES| (strongest first). Bar fill encodes region class: solid blue (#0279EE) = Duodenum-specific, solid red (#E74C3C) = Ileum-specific, lighter blue (#5BA3F0) = Shared (Duodenum-direction), lighter red (#F1948A) = Shared (Ileum-direction), and purple (#9B59B6) = shared module with pathways enriched in both regions (collapsed to the strongest direction). An asterisk (*) marks shared modules whose validated ligand-receptor pairs differ between Duodenum and Ileum. The y-axis range is fixed at -3.2 to 3.2 NES.

Fibroblasts show 15 unique modules across 131 curated pathway rows, overwhelmingly Duodenum-dominated (111 Duodenum-specific, 1 Ileum-specific, 5 Shared-Duodenum, 14 Shared-Ileum pathway rows). The strongest Duodenum-enriched modules are Chemokine signaling (mean NES = -2.10, 15 pathways, 14 with validated L-R pairs), Axon guidance (NES = -2.03, 4 pathways), FGF signaling (NES = -2.02), Hedgehog signaling (NES = -2.00), and ECM-Integrin (NES = -1.90, 29 pathways, all 29 with validated L-R pairs — the largest module). The sole Ileum-specific module is Bile acid signaling (NES = 1.83, no validated L-R pairs). Two modules are shared across regions: BMP signaling (Shared-Duodenum NES = -1.77, Shared-Ileum NES = 1.78) and WNT signaling (Shared-Duodenum NES = -1.61, Shared-Ileum NES = 1.74), both with validated L-R pairs in each region.

**Panel B (bottom) — Pathway-level detail within modules:** Individual pathway bars faceted by module (one facet per module, module name on the left strip). Each bar shows the NES for one specific curated pathway, colored by its region class (same blue/red palette as Panel A, without the purple collapse). Pathways within each module are ordered by |NES|. Figure height scales with the total number of pathway rows (27.6 inches for Fibroblasts).

### Figure G2. Endothelial — diverging pathway enrichment bar plot (pathway_barplot_Endothelial)

Two-panel diverging bar plot, identical structure to Figure G1, showing GSEA pathway enrichment for Blood vascular endothelial cells' own Ileum-vs-Duodenum differentially expressed genes, organized by curated mechanistic module.

**Panel A (top) — Module-level summary:** Same encoding as Figure G1 Panel A. Endothelial cells show 17 unique modules across 87 curated pathway rows, also predominantly Duodenum-dominated (74 Duodenum-specific, 3 Ileum-specific, 1 Shared-Duodenum, 9 Shared-Ileum pathway rows). The strongest Duodenum-enriched module is TNF/NF-κB signaling (mean NES = -2.14, 8 pathways, 3 with validated L-R pairs), followed by JAK/STAT signaling (NES = -2.06), Chemokine signaling (NES = -2.04, 6 pathways, all 6 with validated L-R pairs), Complement signaling (NES = -1.90), Interferon signaling (NES = -1.90, 9 pathways, 7 with validated L-R pairs), and ECM-Integrin (NES = -1.85, 15 pathways, 14 with validated L-R pairs). The Ileum-specific module is Bile acid signaling (NES = 2.01, 3 pathways, no validated L-R pairs). One module is shared across regions: Mitochondrial & oxidative metabolism (Shared-Duodenum NES = -1.62, 1 pathway with L-R; Shared-Ileum NES = 2.00, 9 pathways without L-R). Endothelial-specific modules not present in Fibroblasts include Antigen presentation, Cell adhesion & junctions, Complement signaling, Interferon signaling, JAK/STAT signaling, TNF/NF-κB signaling, and VEGF signaling.

**Panel B (bottom) — Pathway-level detail within modules:** Same structure as Figure G1 Panel B. Figure height is 19.7 inches for Endothelial cells.

### Figure G3. Macrophages — diverging pathway enrichment bar plot (pathway_barplot_Macrophages)

Two-panel diverging bar plot, identical structure to Figures G1-G2, showing GSEA pathway enrichment for Macrophages' own Ileum-vs-Duodenum differentially expressed genes, organized by curated mechanistic module.

**Panel A (top) — Module-level summary:** Same encoding as Figure G1 Panel A. Macrophages show 7 unique modules across 48 curated pathway rows, with a more balanced regional distribution than Fibroblasts or Endothelial (7 Duodenum-specific, 13 Ileum-specific, 21 Shared-Duodenum, 7 Shared-Ileum pathway rows). The strongest Duodenum-enriched module is Hedgehog signaling (mean NES = -2.13, 4 pathways, 3 with validated L-R pairs). The largest module is Lipid signaling & transport (Shared-Duodenum NES = -1.92, 16 pathways; Shared-Ileum NES = 1.90, 6 pathways — shared across both regions, no validated L-R pairs). Ileum-enriched modules include Bile acid signaling (NES = 1.86, 3 pathways), Complement signaling (NES = 1.83, 6 pathways, 1 with validated L-R), and TNF/NF-κB signaling (NES = 1.70, 4 pathways, all 4 with validated L-R pairs). Two modules are shared across regions: Apoptosis / Cell survival (Shared-Duodenum NES = -1.84, 5 pathways, 1 with L-R; Shared-Ileum NES = 1.50, 1 pathway) and Lipid signaling & transport. Retinoic acid signaling is Duodenum-specific (NES = -1.76, 3 pathways, 1 with validated L-R). Macrophages are the only cell type among those analyzed where Ileum-specific pathway rows (13) outnumber Duodenum-specific ones (7), reflecting the distinct immune programming of distal intestinal macrophages.

**Panel B (bottom) — Pathway-level detail within modules:** Same structure as Figure G1 Panel B. Figure height is 12.6 inches for Macrophages.

---

## H. Per-Module Pathway Enrichment Heatmaps

*These figures show pathway-level GSEA enrichment (NES) for each curated mechanistic module across cell types. Like section G, they characterize each cell type's intrinsic pathway programs (FGSEA of that cell type's own Ileum-vs-Duodenum differentially expressed genes), not LR-pair receiver activity. The Stem-cells-as-receiver constraint does not apply.*

### Figure H1. WNT signaling — per-module pathway enrichment heatmap (module_heatmaps/module_heatmap_WNT_signaling)

Heatmap showing FGSEA Normalized Enrichment Scores (NES) for individual curated WNT signaling pathways (rows) across cell types (columns). Tile color: blue (#0279EE) = Duodenum-enriched (NES < 0), red (#E74C3C) = Ileum-enriched (NES > 0), light grey (#ECE9E2) = pathway not present in that cell type. Pathways are grouped by region block — Duodenum-enriched pathways stacked above Ileum-enriched pathways, separated by a horizontal divider line (this module spans both regions). Subtitle label: "Both regions".

The heatmap contains 13 pathway-cell-type rows across 3 cell types (Endothelial, Fibroblasts, cDC1). The Duodenum block (8 rows) includes canonical WNT pathway terms in cDC1 — REACTOME_TCF_DEPENDENT_SIGNALING_IN_RESPONSE_TO_WNT (NES = -1.78), REACTOME_DEGRADATION_OF_BETA_CATENIN_BY_THE_DESTRUCTION_COMPLEX (NES = -1.77), REACTOME_BETA_CATENIN_INDEPENDENT_WNT_SIGNALING (NES = -1.67), REACTOME_SIGNALING_BY_WNT (NES = -1.65) — plus developmental GOBP terms in Fibroblasts (respiratory system development, embryonic morphogenesis, sensory organ development; NES = -1.49 to -1.84) and GOBP_EPITHELIAL_CELL_DIFFERENTIATION in Endothelial (NES = -1.49). The Ileum block (5 rows) consists entirely of Fibroblast developmental GOBP terms (cochlea development, diencephalon development, cardiac septum/chamber morphogenesis; NES = 1.61 to 1.94), reflecting that Fibroblasts' WNT module is shared across regions (Shared-Duodenum and Shared-Ileum in the curated Excel). NES range: -1.84 to 1.94. Of 14 curated pathway rows, 9 have validated ligand-receptor pairs.

### Figure H2. Notch signaling — per-module pathway enrichment heatmap (module_heatmaps/module_heatmap_Notch_signaling)

Heatmap, identical structure to Figure H1, showing FGSEA NES for curated Notch signaling pathways across cell types. This module spans both regions (subtitle: "Both regions"), with a separator line between Duodenum (10 rows) and Ileum (3 rows) pathway groups.

The heatmap contains 13 pathway-cell-type rows across 3 cell types (Endothelial, Fibroblasts, Plasmablasts). The Duodenum block is dominated by Fibroblasts (8 pathways, NES = -1.49 to -1.99), including canonical Notch receptor terms: REACTOME_NOTCH2_ACTIVATION_AND_TRANSMISSION_OF_SIGNAL_TO_THE_NUCLEUS (NES = -1.94), REACTOME_NEGATIVE_REGULATION_OF_NOTCH4_SIGNALING (NES = -1.96), REACTOME_ACTIVATED_NOTCH1_TRANSMITS_SIGNAL_TO_THE_NUCLEUS (NES = -1.75), REACTOME_NOTCH3_ACTIVATION_AND_TRANSMISSION_OF_SIGNAL_TO_THE_NUCLEUS (NES = -1.74), REACTOME_SIGNALING_BY_NOTCH4 (NES = -1.63), and WP_APOPTOSISRELATED_NETWORK_DUE_TO_ALTERED_NOTCH3 (NES = -1.99). Endothelial contributes 2 Duodenum pathways (WP_APOPTOSISRELATED_NETWORK_DUE_TO_ALTERED_NOTCH3, NES = -1.66; GOBP_EPITHELIUM_DEVELOPMENT, NES = -1.39). The Ileum block consists entirely of Plasmablasts (3 pathways: WP_APOPTOSISRELATED_NETWORK_DUE_TO_ALTERED_NOTCH3, NES = 2.00; GOBP_EPITHELIAL_CELL_DIFFERENTIATION, NES = 1.73; GOBP_TUBE_DEVELOPMENT, NES = 1.73), indicating that Notch signaling is Duodenum-specific in mesenchymal/endothelial cells but Ileum-specific in Plasmablasts. NES range: -1.99 to 2.00. Of 13 curated pathway rows, 9 have validated ligand-receptor pairs.

### Figure H3. Retinoic acid signaling — per-module pathway enrichment heatmap (module_heatmaps/module_heatmap_Retinoic_acid_signaling)

Heatmap, identical structure to Figure H1, showing FGSEA NES for curated Retinoic acid signaling pathways across cell types. This module is Duodenum-specific (subtitle: "Duodenum-specific") — all 14 rows have NES < 0, so no separator line is present.

The heatmap contains 14 pathway-cell-type rows across 3 cell types (Bottom-villus EC, Fibroblasts, Macrophages), all Duodenum-enriched (NES range: -2.44 to -1.49). The strongest enrichment is KEGG_RETINOL_METABOLISM in Bottom-villus EC (NES = -2.44, padj = 3.28e-06), followed by GOBP_RETINOL_METABOLIC_PROCESS (NES = -2.37) and GOBP_RETINOIC_ACID_METABOLIC_PROCESS (NES = -2.12) in the same cell type. Fibroblasts show WP_VITAMIN_A_AND_CAROTENOID_METABOLISM (NES = -2.01), GOBP_RETINOIC_ACID_METABOLIC_PROCESS (NES = -1.94), and KEGG_RETINOL_METABOLISM (NES = -1.77), plus developmental terms (respiratory system development, embryonic morphogenesis, sensory organ development). Macrophages contribute WP_VITAMIN_A_AND_CAROTENOID_METABOLISM (NES = -1.79), KEGG_RETINOL_METABOLISM (NES = -1.77), and GOBP_RETINOL_METABOLIC_PROCESS (NES = -1.73). The consistent Duodenum-specific enrichment of retinol metabolism across all three cell types highlights retinoic acid signaling as a defining proximal intestinal program. Of 14 curated pathway rows, 5 have validated ligand-receptor pairs.

### Figure H4. Bile acid signaling — per-module pathway enrichment heatmap (module_heatmaps/module_heatmap_Bile_acid_signaling)

Heatmap, identical structure to Figure H1, showing FGSEA NES for curated Bile acid signaling pathways across cell types. This module is predominantly Ileum-specific (subtitle: "Both regions"), with 1 Duodenum row and 10 Ileum rows, separated by a divider line.

The heatmap contains 11 pathway-cell-type rows across 4 cell types (Bottom-villus EC, Endothelial, Fibroblasts, Macrophages). The single Duodenum row is HALLMARK_BILE_ACID_METABOLISM in Bottom-villus EC (NES = -1.57, padj = 0.043). The Ileum block (10 rows) spans all 4 cell types with strong positive NES values (1.75 to 2.21): WP_DISORDERS_OF_BILE_ACID_SYNTHESIS_AND_BILIARY_TRANSPORT in Bottom-villus EC (NES = 2.21) and Endothelial (NES = 2.18), REACTOME_RECYCLING_OF_BILE_ACIDS_AND_SALTS in Bottom-villus EC (NES = 2.16) and Macrophages (NES = 1.91), REACTOME_BILE_ACID_AND_BILE_SALT_METABOLISM in Bottom-villus EC (NES = 2.13), Endothelial (NES = 1.75 via HALLMARK), Fibroblasts (NES = 1.83), and Macrophages (NES = 1.86), and GOBP_BILE_ACID_AND_BILE_SALT_TRANSPORT in Endothelial (NES = 2.08). The overwhelming Ileum enrichment reflects the physiological role of bile acid reabsorption and recycling in the distal small intestine. Notably, none of the 11 curated pathway rows have validated ligand-receptor pairs, distinguishing this module as pathway-supported but L-R-unvalidated. NES range: -1.57 to 2.21.
