# Ambient RNA Contamination Audit — Biological Summary

## Overview

- **Total pathways evaluated:** 419
- **Non-epithelial pathways evaluated:** 354
- **Pathways removed (REMOVE_FROM_INTERPRETATION):** 11
- **Pathways retained with caution (KEEP_WITH_CAUTION):** 1
- **Pathways retained (KEEP):** 407
- **Ambient gene panel:** 34 genes (Paneth/secretory, enterocyte, bile acid transport, xenobiotic/metabolic)
- **Non-epithelial populations evaluated:** Fibroblasts, Endothelial, Macrophages, cDC1, Plasmablasts

## 1. Removed Pathways (11)

All removed pathways are driven by ambient epithelial RNA — transcripts from highly abundant
Paneth cell defensins or enterocyte bile acid transporters that contaminate the droplet soup
and appear at low levels in non-epithelial cells. Cell-level validation confirms these genes
are either absent (<5% expressing) or present at trace levels (mean <1) in non-epithelial
populations, while being highly expressed (95-100%) in their canonical epithelial source.

**Initial removals (7)** — based on cell-level expression validation:

| # | Cell type | Pathway | Ambient fraction | Reason |
|---|-----------|---------|-----------------|--------|
| 1 | Fibroblasts | REACTOME_ANTIMICROBIAL_PEPTIDES | 93% | 13/14 LE genes are Paneth/secretory epithelial markers (Defa family, Reg3g, Reg3b, Itln1). Pathway identity is entirely  |
| 2 | Macrophages | REACTOME_DEFENSINS | 77% | 10/13 LE genes are Defa family genes. Defensins are Paneth-cell-specific in mouse; mouse myeloid cells lack functional a |
| 3 | Macrophages | REACTOME_ANTIMICROBIAL_PEPTIDES | 73% | 11/15 LE genes are Defa/Itln1 genes. Same rationale as REACTOME_DEFENSINS — Paneth-specific antimicrobial peptides misat |
| 4 | Endothelial | WP_DISORDERS_OF_BILE_ACID_SYNTHESIS_AND_BILIARY_TRANSPORT | 57% | 4/7 LE genes are ileal bile acid transport genes (Fabp6, Slc10a2, Slc51a, Slc51b). Endothelial cells have no biological  |
| 5 | Endothelial | GOBP_BILE_ACID_AND_BILE_SALT_TRANSPORT | 50% | 3/6 LE genes are bile acid transporters (Slc10a2, Slc51a, Slc51b). Endothelial cells do not transport bile acids. Nr1h4  |
| 6 | Fibroblasts | REACTOME_BILE_ACID_AND_BILE_SALT_METABOLISM | 33% | Cell-level validation resolved: Fabp6 is ambient (19% expr, mean=0.5, max=24 in Fibroblasts — low-level, not doublet). N |
| 7 | Macrophages | WP_DISORDERS_OF_BILE_ACID_SYNTHESIS_AND_BILIARY_TRANSPORT | 67% | 4/6 LE genes are ileal bile acid transport genes (Fabp6, Slc10a2, Slc51a, Slc51b). These are enterocyte-specific transpo |

**Additional removals (4)** — based on GSEA re-analysis without ambient genes:

These 4 pathways were initially classified as KEEP_WITH_CAUTION because they contained a
mixture of ambient and genuine genes. However, re-running GSEA with all 34 ambient genes
removed from the gene sets showed that none of these pathways remain statistically
significant (padj > 0.05). The significance was entirely driven by ambient contamination.

| # | Cell type | Pathway | Orig NES | Orig padj | Mod NES | Mod padj | Genuine core |
|---|-----------|---------|----------|-----------|---------|----------|-------------|
| 8 | Macrophages | REACTOME_RECYCLING_OF_BILE_ACIDS_AND_SALTS | 1.86 | 0.002 | 1.61 | 0.054 | FXR/RXR signaling (Abcc3, Stard5, Ncoa1, Rxra, Nr1h4) — trend only |
| 9 | Macrophages | REACTOME_BILE_ACID_AND_BILE_SALT_METABOLISM | 1.87 | 0.002 | 1.37 | 0.113 | FXR/RXR signaling + Cyp27a1 — weak trend |
| 10 | Macrophages | KEGG_RETINOL_METABOLISM | -1.81 | 0.002 | -1.41 | 0.087 | Lipid transport (Dgat1, Dgat2, Adh1, Adh5, Dhrs4, Dhrs9) — not retinoid-specific |
| 11 | Macrophages | GOBP_RETINOL_METABOLIC_PROCESS | -1.70 | 0.008 | -1.34 | 0.115 | Same lipid transport program — not retinoid-specific |

**Key insight:** The macrophage "retinol metabolism" pathways are actually lipid transport
programs (Dgat1/2, Adh1/5, Dhrs4/9) mislabeled by ambient Cyp/UGT genes. The macrophage
"bile acid" pathways contain a genuine FXR/RXR signaling core (Abcc3, Stard5, Ncoa1, Rxra,
Nr1h4) but this core alone does not reach statistical significance without the ambient
transporters.

### Key finding: Defensins are Paneth-specific in mouse

Mouse myeloid cells lack functional alpha-defensin genes (unlike human Paneth cells which express
HD5/HD6, mouse defensins are exclusively Paneth-derived). The REACTOME_DEFENSINS and
REACTOME_ANTIMICROBIAL_PEPTIDES pathways in Macrophages are entirely artifacts of ambient
Paneth RNA — Defa3/5/17/23/26/36 are <2% expressing in Macrophages vs 95-99% in Paneth cells.

## 2. Retained with Caution (1)

Only one pathway survives GSEA re-analysis without ambient genes:

### Fibroblasts KEGG_RETINOL_METABOLISM (58% ambient → KEEP_WITH_CAUTION)

**Genuine retinoid metabolism program confirmed.** GSEA re-analysis without ambient genes:
NES -1.68, padj 0.023 (still significant). The genuine core (Lrat, Aldh1a2) independently
drives significant enrichment. Cell-level validation shows robust expression of core retinoid
enzymes in Fibroblasts: Aldh1a2 (76% expressing, padj=4.9e-04), Aldh1a3 (69%),
Rbp1 (70%, padj=1.8e-05), Lrat (55%, padj=5.4e-14). These are significantly DE (Ileum vs Duodenum)
and represent a genuine stromal retinoid metabolism program. The 7 ambient genes are Cyp/UGT
xenobiotic metabolism enzymes (<5% expressing in Fibroblasts) — enterocyte-specific transcripts
that contaminate the pathway but do not affect the biological interpretation.

**Interpretation:** Fibroblasts maintain a region-specific retinoid metabolism program
(retinol uptake via Rbp1, esterification via Lrat, oxidation to retinoic acid via Aldh1a2/Aldh1a3).
This is biologically credible — intestinal fibroblasts are known to participate in retinoid
signaling. The pathway should be interpreted as a genuine Fibroblast retinoid program.

## 3. Fibroblasts REACTOME_BILE_ACID_AND_BILE_SALT_METABOLISM — Resolved

**Verdict: REMOVE_FROM_INTERPRETATION.** Cell-level validation resolved this pathway:
- Fabp6 (the ambient gene): 19% expressing in Fibroblasts, mean=0.5, max=24 — low-level ambient,
  not the doublet signature seen in Endothelial (max=1716)
- Ncoa1: baseMean=275 but padj=0.28 — present but NOT differentially expressed
- Cyp7b1: baseMean=349 but padj=0.28 — present but NOT differentially expressed

The pathway enrichment (NES, padj) is driven entirely by the ambient Fabp6 gene (log2FC=6.09,
padj=9.2e-55). The other two genes are not region-specific. This is an artifact.

## 4. Doublet vs. Ambient RNA Distinction

### Confirmed: Doublets were already removed

The Seurat object used for pseudobulk generation is the singlets-only object (all cells called
'Singlet', no NAs in doublet scores). Comparison of old vs new pseudobulk showed perfect
correlation (r=1.000) — the original pseudobulk was already generated from singlets.

### Remaining contamination is ambient RNA

The contamination pattern is consistent with ambient RNA (free-floating mRNA in droplet soup),
not doublets:
- **Widespread low-level expression** across all non-epithelial populations (not concentrated
  in a few cells as expected for doublets)
- **Mean expression <1 count** for most ambient genes in NE populations
- **Max counts are modest** (typically <50) except for a few outliers

### Possible doublet outliers (investigated, not systematic)

| Gene | Population | Evidence | Verdict |
|------|-----------|----------|---------|
| Fabp6 | Endothelial | 20% expr, mean=15.2, max=1716 | Possible residual doublet. The confirmed doublet cell was already removed; remaining high-Fabp6 signal may be another doublet or highly abundant ambient. |
| Defa24 | Fibroblasts | 20% expr, max=485 | Possible doublet or highly abundant ambient. Most defensins are <5% in NE. |
| Defa22 | Fibroblasts | 6% expr, max=243 | Same pattern as Defa24 but weaker. |
| Defa30 | Fibroblasts | 10% expr, max=120 | Same pattern, weaker still. |

### Doublet/annotation genes — all genuine myeloid programs

Genes appearing in pathway leading edges that could indicate doublets or misannotation
(Cd14, C5ar1, C3ar1, Itgam, Itgax, Tyrobp, etc.) were validated at cell level:
- **10/13 are MYEOID_GENUINE** — highly expressed in Macrophages/cDC1 (52-98%), low in
  Endothelial/Fibroblasts (1-16%). The low-level signal in non-myeloid cells is ambient.
- **2/13 are LOW_LEVEL** (Clec4d, Il7r) — low expression across all populations.
- **1/13 is AMBIENT** (Gzmb) — <1% expressing everywhere, max=23 in Fibroblasts.

**Conclusion:** No systematic doublet contamination or misannotation detected. The immune
genes in Fibroblast/Endothelial pathway leading edges represent ambient RNA from myeloid
cells, not doublets.

## 5. Plasmablasts Population Assessment

**Verdict: GENUINE PLASMABLASTS** (algorithmic AMBIGUOUS verdict overridden by biological reasoning)

| Marker | % expressing | Mean (all cells) | Max | Interpretation |
|--------|-------------|------------------|-----|----------------|
| Igkc | 89.8% | 561 | 6586 | Definitive B cell marker — kappa light chain |
| Igha | 21.2% | 1106 | 14942 | IgA heavy chain — class-switched, high expression |
| Jchain | 23.4% | 200 | 2569 | Joining chain — antibody-secreting cell marker |
| Iglv1 | 21.2% | 70 | 6205 | Lambda light chain variable |
| Iglc1 | 25.5% | 42 | 2458 | Lambda light chain constant |

Myeloid markers in Plasmablasts: mean 7.9% expressing, none >30%
(highest: Tyrobp 19%, Fcer1g 12.4%).

The low per-marker percentages for Igha/Jchain/Iglv1/Iglc1 are explained by immunoglobulin
biology: light chain restriction (kappa vs lambda), isotype switching, and clonal variability
mean not all B cells express all 5 markers. Igkc at 89.8% is definitive. The extremely high
expression levels in positive cells (Igha max=14,942) are characteristic of antibody-secreting
cells (plasmablasts/plasma cells), not ambient RNA or doublets.

## 6. Preserved Biologically Credible Genes

The following genes were explicitly preserved (NOT classified as ambient) based on cell-level
validation showing genuine expression in non-epithelial populations:

### Fibroblast retinoid program (GENUINE)
| Gene | % expr in Fibro | padj | Function |
|------|----------------|------|----------|
| Aldh1a2 | 76% | 4.9e-04 | Retinaldehyde dehydrogenase (RA synthesis) |
| Aldh1a3 | 69% | — | Retinaldehyde dehydrogenase (RA synthesis) |
| Rbp1 | 70% | 1.8e-05 | Retinol binding protein (retinol uptake) |
| Lrat | 55% | 5.4e-14 | Lecithin retinol acyltransferase (retinyl ester synthesis) |

### Macrophage lipid transport program (GENUINE)
| Gene | % expr in Macro | padj | Function |
|------|----------------|------|----------|
| Apoe | 99% | 1.9e-97 | Apolipoprotein E (lipid efflux) |
| Abca1 | 66% | 6.2e-67 | Cholesterol efflux transporter |
| Fabp5 | 46% | 3.9e-22 | Fatty acid binding protein |
| Abcg1 | 35% | 4.2e-24 | Cholesterol efflux transporter |
| Cd36 | 37% | 2.3e-08 | Fatty acid/scavenger receptor |
| Abcc3 | 55% | 5.9e-08 | Multidrug resistance-associated protein |
| Stard5 | 30% | 4.1e-06 | Steroidogenic acute regulatory transfer |

### Shared retinoid/lipid genes (GENUINE in both)
| Gene | % expr Fibro | % expr Macro | Function |
|------|-------------|-------------|----------|
| Cyp27a1 | 32% | 27% | Sterol 27-hydroxylase (bile acid synthesis) |
| Rxra | 36% | 20% | Retinoid X receptor alpha |
| Lpl | 46% | 14% | Lipoprotein lipase |

### Moderate expression (preserved but weaker)
| Gene | Best population | % expr | Note |
|------|----------------|--------|------|
| Dhrs9 | cDC1 | 13% | Retinol dehydrogenase — low but specific to cDC1 |
| Rxra | Fibroblasts | 36% | Below 20% threshold in Macro (20%) |

## 7. Affected Modules Summary

### Modules with removed pathways:
- Antimicrobial peptides
- Bile acid signaling
- Retinoic acid signaling

### Modules with caution pathways:
- Retinoic acid signaling

### Impact on CCC interpretation

The removed pathways do not affect the LIANA + NicheNet CCC analysis directly — they are
pathway enrichment results from FGSEA, not ligand-receptor interactions. However, they would
have misled biological interpretation if taken at face value:
- Antimicrobial peptide pathways in Macrophages/Fibroblasts would have suggested active
  defensin production — actually ambient Paneth RNA
- Bile acid transport pathways in Endothelial would have suggested endothelial bile acid
  handling — actually ambient enterocyte RNA

The retained-with-caution pathway contains genuine biology underneath the ambient contamination:
- **Fibroblast retinoid metabolism** is genuine and should be interpreted as a real
  region-specific stromal program

The removed macrophage pathways contained genuine biology that did not reach statistical
significance without ambient genes:
- **Macrophage lipid transport** (Dgat1/2, Adh1/5, Dhrs4/9) is genuine but the 'retinol
  metabolism' label was misleading — these are lipid/lipoprotein genes, not retinoid enzymes
- **Macrophage FXR/RXR signaling** (Abcc3, Stard5, Ncoa1, Rxra, Nr1h4) shows a trend
  (NES 1.4-1.6) but does not reach significance without ambient bile acid transporters

## Methodology

1. **Ambient gene panel (34 genes):** Paneth/secretory (14), enterocyte (8), bile acid
   transport (3), xenobiotic/metabolic (9)
2. **Per-pathway quantification:** ambient_fraction = n_ambient_genes / n_le_genes for each
   non-epithelial pathway. Status: Strong ≥50%, Borderline ≥25%, Low >0%, None 0%
3. **Cell-level validation:** For each ambient gene, computed % expressing, mean expression,
   and max counts across all non-epithelial and epithelial populations using the singlets-only
   Seurat object
4. **Classification logic:** AMBIENT (<5% in NE, >50% in epithelial source), LIKELY_AMBIENT
   (low-level widespread), POSSIBLE_DOUBLET (>10% in NE with high max), POSSIBLE_GENUINE
   (>30% in NE with moderate max), GENUINE (>20% with mean >0.5)
5. **NES/padj preserved:** Original FGSEA values retained; audit used only for exclusion
   (REMOVE) or caution (KEEP_WITH_CAUTION) flags

## Files Generated

| Output | File | Description |
|--------|------|-------------|
| A | ambient_annotated_pathway_table.csv | Complete 419-row table with 6 audit columns |
| B | pathway_table_cleaned.csv | Pathways excluding 11 REMOVE_FROM_INTERPRETATION rows |
| C | ambient_rna_audit.csv | All non-KEEP pathways with biological rationale and cell-level evidence |
| D | doublet_annotation_audit.csv | Doublet/misannotation investigation + Plasmablasts assessment |
| E | ambient_rna_summary.md | This biological summary |

