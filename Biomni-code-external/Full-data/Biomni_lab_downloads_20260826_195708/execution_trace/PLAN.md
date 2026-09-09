# Dot Plot Revision: Z-score + Log Transform, Pan-fibroblast Markers, Reversed Colors, Zero Handling

## Summary

Regenerate the 3 compartment dot plots (merged by Broad category, all 10 curated genes) with four changes:
1. **Two color scales per compartment**: z-score and log1p-transformed average expression (separate files)
2. **Pan-fibroblast markers added to Stroma x-axis**: Col1a1, Col1a2, Col3a1, Col5a1, Col6a1, Vim, Postn, Thy1, S100a4, Pdgfrb, Lrrc15, Ly6a (12 genes present in object; Fsp1 absent) — grouped at the beginning of the Stroma gene list, shown across all 5 stromal broad types
3. **Reversed inferno color scale**: bright yellow at low expression → dark purple/black at high expression
4. **Zero-expression dots hidden**: where avg expression = 0, no dot is drawn (white background shows through)

## Data Preparation

- Load Seurat object, join RNA layers, normalize (same as current v3 script)
- Read xlsx, use all 10 curated genes per cluster (no top-5 filter)
- Merge clusters by Broad category, pool all cells per Broad group
- Compute per-Broad-group avg expression and % expressing for all 301 curated genes
- **New**: Also compute avg expression and % expressing for the 12 pan-fibroblast markers (Col1a1, Col1a2, Col3a1, Col5a1, Col6a1, Vim, Postn, Thy1, S100a4, Pdgfrb, Lrrc15, Ly6a) across all 5 stromal broad types
- **New**: Compute two color variables:
  - `z_score`: per gene, z-score of avg expression across all broad groups in that compartment (mean=0, sd=1)
  - `log1p_exp`: log1p(avg_exp) — compresses dynamic range

## Dot Plot Construction

### Color scales (two versions per compartment)
- **Z-score version**: `scale_color_gradientn` on z-score values, reversed inferno palette (yellow → dark purple). Diverging around 0. Dots with avg_exp = 0 are hidden (NA color).
- **Log1p version**: `scale_color_gradientn` on log1p(avg_exp) values, reversed inferno palette. Dots with avg_exp = 0 are hidden.

### Reversed inferno palette
Colors from bright to dark: `#FCFFA4` (bright yellow, low) → `#F7D13D` → `#FB9A06` → `#ED6925` → `#CF4446` → `#A52C60` → `#781C6D` → `#4A0C6B` → `#1B0C42` → `#000004` (black, high)

### Zero-expression handling
- Filter `plot_df` to exclude rows where `avg_exp == 0` before plotting (no dot drawn)
- This means genes with zero expression in a given broad type show as blank space

### Pan-fibroblast markers in Stroma
- Add 12 pan-fibroblast genes at the beginning of the Stroma x-axis gene ordering
- These genes are NOT curated markers from the xlsx — they are added programmatically
- They appear across all 5 stromal broad types (Blood endothelial, Enteric glia, Fibroblasts, Lymphatic endothelial, Pericytes)
- Gene ordering: pan-fibroblast markers first (alphabetical), then curated markers in block-diagonal order

### Other unchanged elements
- Genes on x-axis, cell types (Broad) on y-axis
- Dot size = % expressing (unchanged)
- Separate files per compartment
- All three plots same dimensions (28 × 13 inches, 300 dpi)
- NA compartment excluded
- Liberation Sans font, theme_bw

## Outputs (saved to /mnt/results/)

| File | Description |
|------|-------------|
| `dotplot_<compartment>_zscore.png/.svg` | Z-score color scale (3 compartments × 2 formats = 6 files) |
| `dotplot_<compartment>_log1p.png/.svg` | Log1p color scale (3 compartments × 2 formats = 6 files) |
| `dotplot_marker_expression_data_merged.csv` | Updated CSV with z_score and log1p_exp columns, plus pan-fibroblast marker rows for Stroma |

Total: 12 image files + 1 CSV

## Compute / Resource Estimate

- **Machine**: `seurat-worker` (64 GB RAM) — already exists, restored from hibernation
- **Load + normalize**: ~3 min (measured: 1.1 min load + ~1 min join+normalize)
- **Pan-fibroblast marker computation**: trivial (12 genes × 5 broad types)
- **Plotting**: 6 plots (3 compartments × 2 scales) — seconds each
- **Total estimated runtime**: ~5 min
- **Peak memory**: ~20 GB (full Seurat object in RAM)

## Assumptions

1. Z-score is computed per gene across all broad groups within each compartment (not across all 25 broad groups globally). This keeps the scale compartment-specific.
2. Log1p transform applies to the raw average expression (not the z-score). `log1p(avg_exp)` where avg_exp is already log-normalized, so this is effectively a double-log compression.
3. Pan-fibroblast markers are only added to the Stroma plot (not Immune or Epithelia), since they are fibroblast identity markers.
4. Fsp1 is absent from the object (mouse gene nomenclature differs) — 12 of 13 pan-fibroblast markers will be included.
5. Zero-expression filtering removes dots where avg_exp is exactly 0. Genes with very low but nonzero expression will still show as small dots.
