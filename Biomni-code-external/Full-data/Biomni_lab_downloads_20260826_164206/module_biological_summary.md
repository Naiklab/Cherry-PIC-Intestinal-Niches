# Per-Module Biological Summary: Duodenum vs Ileum

Generated from the filtered pathway dataset (curated significant + FGSEA significant, 419 rows across 27 modules).
For each module, leading-edge genes from GSEA are aggregated per region and compared to identify biological differences between Duodenum and Ileum.

**NES convention:** NES < 0 = Duodenum-up; NES > 0 = Ileum-up (comparison is Ileum vs Duodenum).

---

## ECM–Integrin (Both regions)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 36 | 21 |
| Cell types | 2 (Endothelial, Fibroblasts) | 1 (Plasmablasts) |
| Shared pathways | 14 | 14 |

### Leading-edge gene overlap

- **Duodenum genes:** 509
- **Ileum genes:** 208
- **Shared genes:** 81 (12.7% of union)
- **Duodenum-only genes:** 428
- **Ileum-only genes:** 127

### Key signaling genes in leading-edge

| Gene family | Duodenum | Ileum |
|-------------|----------|-------|
| ligands | Thbs1, Col1a1, Col3a1, Fn1, Col1a2, Col6a1, Col5a1, Col4a1, Lama1, Lamc1, Spp1 | — |
| receptors | Itgb1, Itgb5, Itga5, Itgav, Itgb3 | Itgb5, Itga5, Itgb1, Itgav |
| effectors | Mmp9, Eln, Fbn1, Has1, Has2, Lox | Mmp14, Mmp9 |

### Curated ligand-receptor genes

- **Duodenum L-R genes (162):** Adam10, Agrn, Anxa1, Apoa4, C3, Ccl11, Col1a1, Col3a1, Col6a2, Cxcl1, Cxcl10, Cxcl2, Efna5, Efnb2, Ereg, Fbn1, Fn1, Icam1, Igfbp4, Jag1
- **Ileum L-R genes (57):** Adam17, Apoe, App, Ecm1, Gas6, Grn, Icam1, Il1b, Mmp13, Mmp9, Pdgfb, Pf4, Plau, Psap, Rtn4, S100a1, Spint1, Tnf, Vim, Adra2a

### Biological interpretation

The ECM–Integrin module shows **near-complete regional divergence** in leading-edge genes (only 12.7% overlap). Duodenum and Ileum activate largely distinct gene sets within this module.
Duodenum expresses ECM–Integrin **ligands** (Thbs1, Col1a1, Col3a1, Fn1, Col1a2, Col6a1, Col5a1, Col4a1, Lama1, Lamc1, Spp1) while Ileum expresses **receptors** (Itgb5, Itga5, Itgb1, Itgav), suggesting Duodenum sends and Ileum receives this signal.
Duodenum-exclusive cell types: Endothelial, Fibroblasts.
Ileum-exclusive cell types: Plasmablasts.

<details><summary>Duodenum-only leading-edge genes (428)</summary>

Adamts4, Il6, Stat3, Tgfb1, Mmp10, Ctsk, Tgfb2, Mmp19, Timp3, Cxcl2, Cxcl1, Acta2, Tpm2, Tpm1, Tnfaip3, Slit3, Basp1, Gem, Myl9, Flna, Fbln5, Gja1, Eln, Fas, Sfrp1, Fstl1, Cald1, Vegfa, Fbn1, Plod3, Slit2, Cd44, Cdh6, Bgn, Thbs1, Fbln2, Pvr, Col1a1, Lgals1, Vcan, Plod2, Col3a1, Col6a2, Thbs2, Vegfc, Tpm4, Fn1, Nid2, Igfbp4, Igfbp3, Loxl1, Calu, Htra1, Adamts2, Mmp16, Id1, Rgcc, Mfap4, Adamts9, Adamts1, Tll1, Col8a1, Lama5, Adam10, Cxcl13, Plpp3, Wnk1, Itga4, Swap70, Cyp1b1, Lyn, Ptpn11, Pde3b, Icam2, Jam3, Agrn, Adamtsl2, Ssc5d, Rock1, Tmbim1, S1pr1, Fabp1, Nfkb1, Epas1, Jag1, Pecam1, Jam2, Madcam1, Col28a1, Sntb2, P4ha2, Kdr, Lamb2, Sdc2, Dtna, Actg1, Cebpb, mt-Cytb, Gfap, Epha4, Apoa4, Jak2, Gap43, Tspo, Braf, Bcl9, Map1b, Yap1, Top1, Anxa1, Kpna1, Hspb1, Procr, Ereg, Foxf1, Lcp1, Fgf1, Pros1, Hmgb1, Plek, Selp, Prdx2, Thbd, Edn1, Hbb-bt, Arf4, Slc12a2, Zfp36l1, Enpp4, Lman1, Arhgap35, Cd24a, Kdm6b, S1pr3, Rad51b, C3, Msn, Maff, Mmrn2, Ipo7, Btg1, Cldn5, Plxna2, Efnb2, Iqgap1, Fzd4, Cxcl10, Il31ra, Pkd1, Rdx, Ccl11, Atf4, Xdh, Mib1, Bcl10, Socs3, Id3, Wwtr1, Hsd17b4, Rbbp6, Bmi1, Eda, Fzd1, Mafg, Fem1b, Skil, Efna5, Prkch, Pip5k1a, Heyl, Slc4a7, Arl13b, Tbx3, Ednrb, Stard13, Adm, Hs2st1, Gnas, Has1, Col1a2, Tnxb, Tgfbr3, Ltbp4, Has2, Lox, Ramp2, Col6a1, Pparg, Sparc, Ppib, Col14a1, Serpinh1, Lum, Pcolce, Nid1, Crtap, Pcolce2, Hsd17b12, Mfap5, Ltbp1, Mfap2, Spon1, Igfbp7, Col5a2, Col18a1, Tfpi2, Col5a1, Col4a1, Lama1, Thbs3, Col15a1, Col22a1, Grem1, Anxa2, Colgalt1, Bsg, Sh3pxd2a, Ncam1, Mmp3, P3h3, Sdc1, Tgfb3, Mmp8, Serpine1, Adamts8, Lrp6, Mia3, Bmp1, Ccl5, Emilin1, Ret, Emilin2, Rac3, Npnt, Itgb3, Igf1, Aldh1a3, Hhip, Hsd11b1, Aldh1a2, Fgf7, Thrb, Hmgcs2, Wnt2b, Rspo2, Pdpn, Rpl13a, Il13, Wnt11, Map2k1, Kras, Zfpm2, Ap3b1, Ywhaz, Gata6, Ccn2, Smpd3, Nfib, Ltbp3, Gpc3, Large1, Lamc1, Fkrp, Pxdn, Pomgnt1, Ntn4, Ccl2, Tnfaip6, S100a11, Tmsb4x, Hspa5, Hgf, Ntn1, Mdk, Rarres2, Il1r1, Rack1, Calr, Sdcbp, Pycard, Cd74, Tac1, Dock4, Egfr, Twist2, Bdkrb1, Dock5, Spag9, Prex1, Ptprc, Ptn, Ackr3, Sphk1, Rnf7, Gata3, Nr4a3, Akt3, Hspa8, Rras, Rhoc, Rras2, Pdgfd, Angpt1, Sema4a, Ripor2, Gpld1, Lgmn, Dock8, Wnt5b, Cul5, Atp5b, Fer, Pik3cb, Coro1a, Prkca, Ephb2, Abl2, Fbln1, Rac2, Thy1, Kit, Tjp1, Il16, Rpsa, Polr2a, Spp1, Fos, Myc, Bmpr1b, Fgf14, Egr1, Ntrk2, Atf3, Ddx5, Ptpn1, Sorl1, Gstp1, Gclm, Pmepa1, Apoa1, Usp9x, Fgf12, Nedd4, Ern1, Cyfip2, Mt3, Bdnf, Pak2, Eef2, Pin1, Hsp90ab1, Cav3, Runx3, Rbbp7, Angpt2, Cyfip1, Gfra1, Calca, Hfe, Stat5b, Tbc1d7, Adam23, Nrg1, Ppia, Cdh17, Adam15, Cxadr, Pde4d, Nfkbia, Ppp2r2a, Capns1, Serping1, Angptl4, Vkorc1, S100a10, Naca, Prkg1, Cd34, P2rx1, Il6st, F2rl3, F12, Dsp, Tfpi, Vav2, Itpk1, Vangl2, Trim72, Nme2, Rcc2, Sv2c, Sv2b, Dpysl3, Bax, Rtn4rl2, Fosl1, Slc1a3, Ednra, Kcnb1, Il1rl1, Ntrk1, Zfp36l2, Rspo3, Rps7, Osr1, Hoxa4, Hoxa2, Ugdh, Dlc1, Ets2, Ybx1, Zbtb16, Setd2, Txnrd1, Hand2, Dusp4, Atp8a2, Tmed2, Taf10, Myo3b, Ryr2, Prkar1a, Kcnq1, Psen1, Rest, Hoxb3, Hoxa3, Cdon

</details>

<details><summary>Ileum-only leading-edge genes (127)</summary>

Fcer1g, Plau, Hck, Nrp1, Mmp14, Pdgfb, Sdc3, App, Pdgfa, Plod1, Adam17, Adam19, Capn5, Actb, Capn2, P2rx7, Naglu, Tgfbi, Lrp1, Grn, Cx3cr1, Axl, Slc11a1, Trem2, Gnaq, P2ry12, Jaml, Gas6, Gna12, Ptprj, P2rx4, Rac1, Tnf, Gpx1, Bloc1s6, Ano6, Prcp, Sod1, Chmp2a, Vegfb, Pik3cg, C1galt1c1, Syt11, Xbp1, B4galt1, Bloc1s4, Gna13, Chmp4b, S1pr2, Nisch, Csf1r, Tnfrsf11a, Tpp1, Mitf, Lgals3, Rapgef2, Txnip, Zeb2, Mafb, Marcks, Plxnd1, Id2, Asah1, Maf, Slc40a1, Asb2, Rtn4, Elovl1, Gba, Sh3bp1, Rab1a, Bad, Rapgef3, Tubb5, Akt1, Spred1, Ece1, Orai1, Pls1, Prdm1, Ppp3r1, Triobp, Tsc2, Ift52, Pbx1, Tagln2, Mthfr, Ppp1ca, Tollip, Stab1, C3ar1, Sat1, C5ar1, Cd93, Spi1, Pgf, Sgpl1, C6, Cybb, S100a1, Pdgfc, Pacsin2, Glul, Aggf1, Mapk7, Man2a1, Srebf1, Anxa3, Pgk1, Aamp, Rdh10, Spata2, Cd47, Bmpr2, Il1b, Hes1, Brd2, Srpk2, Zc3h12a, Yipf6, Nup133, Scrib, Naxe, Hipk1, Mydgf, Nus1, Ilk

</details>

---

## Lipid signaling & transport (Both regions)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 14 | 40 |
| Cell types | 2 (Macrophages, Stem cells) | 4 (Bottom-villus EC, Endothelial, Macrophages, Plasmablasts) |
| Shared pathways | 6 | 6 |

### Leading-edge gene overlap

- **Duodenum genes:** 166
- **Ileum genes:** 302
- **Shared genes:** 44 (10.4% of union)
- **Duodenum-only genes:** 122
- **Ileum-only genes:** 258

### Key signaling genes in leading-edge

| Gene family | Duodenum | Ileum |
|-------------|----------|-------|
| effectors | Ldlr, Fdps, Sqle, Srebf2, Fasn, Hmgcs1, Hmgcr, Srebf1, Nr1h3 | Scd2, Hmgcs1, Sqle, Hmgcr, Fdps, Fasn, Srebf2, Abca1, Nr1h3, Ldlr, Srebf1, Acaca, Abcg1 |

### Curated ligand-receptor genes

- **Duodenum L-R genes (0):** none
- **Ileum L-R genes (53):** Adam17, Apoe, App, Ecm1, Grn, Il1b, Lgals3bp, Pdgfb, Pf4, Psap, Rtn4, S100a1, Spint1, Tnf, Adra2a, Aplp2, Cd74, Celsr2, Dcc, Egfr

### Biological interpretation

The Lipid signaling & transport module shows **near-complete regional divergence** in leading-edge genes (only 10.4% overlap). Duodenum and Ileum activate largely distinct gene sets within this module.
Shared cell types (Macrophages) drive the module in both regions, but with different pathways/genes.
Duodenum-exclusive cell types: Stem cells.
Ileum-exclusive cell types: Bottom-villus EC, Endothelial, Plasmablasts.

<details><summary>Duodenum-only leading-edge genes (122)</summary>

Lpl, Alcam, Antxr2, Sc5d, Pdk3, Trib3, Aldoc, Ebp, Fabp1, Mdh2, Hsp90aa1, Aldoa, Odc1, Prdx6, Adh1, Mif, Hsph1, Ldha, Kmt5a, Pdhb, Psme1, Lgals1, Mdh1, Aco2, Ostc, Car2, Fh1, Pts, Pdha1, Acaa2, Metap1, Elovl5, Sdha, Idh3b, Gpd2, Gabarapl1, Ugdh, Sdhd, Dld, Auh, G0s2, Idh3g, Hccs, Adipor2, Acaa1a, Acads, Fabp2, Eci1, Cd1d1, Acadvl, Adsl, Etfdh, Thbs1, Eprs, Irs2, Fabp3, Slc2a1, Apoa4, Mttp, Apoa1, Apob, Sar1b, Anxa1, Ace, Slc25a20, Pla2g4a, Ran, Helz2, Kpnb1, Insig1, Mbtps1, Nme2, Ptgs2, Nme1, Ndufab1, Acot7, Angptl4, Apoc2, Ptges3, Apoc3, Brca1, Gstm2, Gstp1, Acly, Hsd17b12, Cyp2c65, Gpx4, Cyp3a11, Hacd1, Ptgis, Cyp2c66, Wdtc1, Ceacam1, Ubr4, Car4, Acsl1, Sdhc, Ephx1, Hmgcs2, Hsd17b4, Hmgcl, Cpt2, Rdh11, Retsat, Uros, Dlst, Cpt1a, Acot8, Ccdc58, Eci2, Echs1, Reep6, Acot2, Acsl4, H2az1, Decr1, Grhpr, Mlycd, Hsd17b10, Erp29, Crat, Suclg2

</details>

<details><summary>Ileum-only leading-edge genes (258)</summary>

Scd2, Acsl3, Mylip, Lss, Abca1, Tm7sf2, Cxcl16, Ethe1, Ctnnb1, Anxa5, Fbxo6, Tnfrsf12a, Acss2, Fabp6, Slc51b, Akr1c19, Slc10a2, Akr1c12, Vdr, Nr1h4, Akr1c13, Slc51a, Abcb1a, Sult2b1, Aldh1a1, Abcd3, Hras, Pex6, Atxn1, Ctbp1, Lonp2, Ide, Dhrs3, Dlg4, Cyp4f14, Gpx2, Acot13, Elovl7, Hadh, Acaca, Prkag2, Acot11, Aldh3a2, Rxra, Mid1ip1, Hadhb, Slc22a5, Dbi, Hacd2, Degs2, Agpat2, Pgp, Stard7, Bdh1, B4galnt1, Sptssa, B4galt6, Slc44a1, Cds1, Aacs, Lclat1, Tbl1xr1, Cyp2d22, Ptpn13, Plpp2, Lpcat3, Pik3c2b, Pi4ka, Pip5k1b, Ncoa2, Pnpla8, Fdx1, Pip4k2a, Dhcr7, Chkb, Galc, Pik3ca, Inppl1, Arf1, Apoe, Pltp, Abcg1, Lrp1, Trem2, Nfkb1, Apoc4, Ago3, Tnrc6a, Ep300, Ncoa1, Arl4c, Apoc1, Ago1, Nfkbia, Tnfrsf11a, Dab2, P2rx7, P2rx4, Fcer1g, Cd68, Txnip, App, Cd81, Itgb1, Adam17, Eepd1, Npc2, Lipa, Soat1, Msr1, Hmox1, Pla2g7, Nceh1, Ldlrap1, Psap, Ctsa, Hexa, Asah1, Gba, Gm2a, M6pr, Itgav, Commd1, Ctsd, Pla2g2d, Ucp2, Apobec1, Zdhhc3, Pf4, Grn, Stab1, C3ar1, Ecm1, Csf1r, Cx3cr1, Gpnmb, Sat1, Rapgef2, Zeb2, C5ar1, Cebpa, Mmp14, Itgax, Cd93, Ctsh, Spi1, Pgf, Pdgfb, Ctsz, Marcks, Plxnd1, Sgpl1, Id2, C6, Ext1, Cfl1, Asb2, Itga5, Rtn4, Nrp1, Cybb, Sdc4, Pdgfa, Ptprj, Rhob, Tgfbi, Atp6ap2, S100a1, Spint1, Vav3, Nfe2l2, Tgfbr1, Tnf, Gpx1, Bloc1s6, Naglu, Klf4, Adam8, Pdgfc, Prcp, Mmp12, Rapgef3, Pacsin2, Akt1, Glul, Pfn1, Spred1, Ece1, Aggf1, Mapk7, Man2a1, Vegfb, Prdm1, Ppp3r1, Nfia, Tsc2, Pik3cg, Rhoa, Ift52, Pbx1, Sav1, Rbpj, Mthfr, Xbp1, Anxa3, Ppp1ca, Notch1, B4galt1, Hs6st1, Gna13, Aamp, Rdh10, Spata2, Cd47, Bmpr2, Cdc42, Hes1, Brd2, Srpk2, Zc3h12a, Yipf6, Nup133, Scrib, Naxe, Hipk1, Mydgf, Nus1, Ilk, Ano6, Atg9a, Vat1, Scarb2, Atp8b4, Gltp, Kcnn4, Atp8b2, Mrc1, Lrp6, Mgl2, Lgals3bp, Cln3, Dennd1a, Itsn1, Clec10a, Rabgef1, Bcl2l1, Rab1a, Hip1, Dpysl2, Atp6v1h, Dnm2, Eea1, Fnbp1, Pip5k1c, Por, Daglb, Sirt2, Fbxw7

</details>

---

## Cell adhesion & junctions (Both regions)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 11 | 26 |
| Cell types | 1 (Endothelial) | 1 (Bottom-villus EC) |
| Shared pathways | 5 | 5 |

### Leading-edge gene overlap

- **Duodenum genes:** 239
- **Ileum genes:** 371
- **Shared genes:** 55 (9.9% of union)
- **Duodenum-only genes:** 184
- **Ileum-only genes:** 316

### Key signaling genes in leading-edge

| Gene family | Duodenum | Ileum |
|-------------|----------|-------|
| ligands | Cldn5 | Cldn4, Cldn7, Cldn2, Cdh17, Jup, Cdh1 |
| receptors | Msn, Ctnnb1, Iqgap1 | Ctnnb1, Msn, Pard3, Ctnna1 |
| effectors | Rock1 | Cdc42, Pak2, Rac1, Pak1 |

### Curated ligand-receptor genes

- **Duodenum L-R genes (31):** Adam10, Efna5, Ereg, Icam1, Jag1, Psap, Tgfb1, Tgfb2, Vegfa, Acvr1_Tgfbr1_Tgfbr2, Acvr1_Tgfbr2, Acvr1b_Tgfbr2, Acvr1c_Tgfbr2, Egfr, Egfr_Erbb2, Epha2, Ephb2, Erbb2_Erbb4, Erbb3, Itgav
- **Ileum L-R genes (0):** none

### Biological interpretation

The Cell adhesion & junctions module shows **near-complete regional divergence** in leading-edge genes (only 9.9% overlap). Duodenum and Ileum activate largely distinct gene sets within this module.
Both regions express Cell adhesion & junctions **ligands** (Duo: Cldn5; Ile: Cldn4, Cldn7, Cldn2, Cdh17, Jup, Cdh1), but through different ligand repertoires.
Duodenum-exclusive cell types: Endothelial.
Ileum-exclusive cell types: Bottom-villus EC.

<details><summary>Duodenum-only leading-edge genes (184)</summary>

Ccl2, Cebpb, Nr4a3, Il6, Cd24a, Ccr7, Igf2, Icam1, Epha4, Lyn, Pecam1, Apoa4, Efnb2, B2m, Jam2, Rock1, Fgl2, Hmgb1, Itgb1, Selp, Adam8, Tfrc, Vcam1, Prdx2, Peli1, Cd81, Madcam1, Itga4, Ets1, Cd44, Sdc4, Phf10, Nlrp3, Lgals1, Psmb9, Itgam, Runx3, Cxcl13, Plpp3, Swap70, Cyp1b1, Fbn1, Tgfb2, Pde3b, Itgax, Icam2, Jam3, Slc7a1, Itpkb, Map3k8, Dhps, Cd86, Il1b, Jak1, Jag1, Vegfa, Zfp703, Notch1, Mink1, Rgcc, Efna5, Hspb1, Foxf1, Sparcl1, Myl9, Flna, Cldn5, Pkd1, Plek, Emb, Hbb-bt, Cdh6, Pvr, Zfp36l1, Atp1b2, Tln1, Tpm1, Sfrp1, Braf, Tek, Col8a1, Fbln2, Rras, Cd36, Arhgef7, Kdr, Apoa1, Lamb2, Fn1, Cyth3, Smad3, Mmp12, Fzd4, Clasp2, S1pr1, Dusp1, Rnd1, Ppp1cb, Lama5, Peak1, Thbs1, Col1a1, Pkp4, Adam10, Zc3h12a, Rasa1, Cul5, Psmb8, Socs5, Cdh13, Ptpra, Prkg1, Acvrl1, Ppp3ca, Piezo1, Prkx, Acta2, Basp1, Kdm6b, Mmp9, S1pr3, Ipo7, Iqgap1, Bcr, Il31ra, Zfp36, Rdx, Tnfrsf1a, Xdh, Fstl1, Id3, Wwtr1, Edn1, Sav1, Plod3, Hsd17b4, Fzd1, Mafg, Fem1b, Prkch, Isg15, Lcp1, Ptprb, Bag3, Gfap, Fbln5, Fgf1, Mpp7, Hsp90ab1, Emd, Dnajb1, Slc3a2, Sh3gl1, Tnks1bp1, Mprip, Hspa5, Cpe, Picalm, Cald1, Mfge8, Trim25, Capza1, Eif4g2, Notch3, Mapre1, Ywhab, Ran, Rpl15, Tbc1d10a, Col3a1, Hspa1a, Ckap5, Baiap2, Epn2, Eno1, Hspa8, Dbn1, Park7, Apc, Rangap1, Lypla2, Rab11b, Uso1, Vapb

</details>

<details><summary>Ileum-only leading-edge genes (316)</summary>

Pmp22, Krt8, Ezr, Anxa2, Actb, Krt18, Dsg2, Dsp, Prkcz, Cldn4, Gjb3, Flrt3, Mpp1, Cd2ap, Ceacam1, Rap2b, Dsc2, Actr3, Cgn, Rap2c, Ubn1, F11r, Ywhah, Pkp3, Cdc42, Perp, Lsr, Arhgef2, Ank3, Pacsin2, Cldn7, Tjp1, Dnmbp, Nectin3, Cyth2, Cldn2, Src, Pak2, Fzd5, Wdr1, Scrib, Tiam1, Dlg1, Tgfbr1, Pdcd6ip, Pard6b, Prkcd, Epcam, Wasf2, Vasp, Nf2, Cdh17, Pak4, Twf1, Cxadr, Tmod3, Pard3, Atp2a2, Jup, Ctnna1, Cdh1, Ccnd1, Add1, Afdn, Cd53, Ptprk, Flot1, Smad7, Myl7, Myh14, Gnai2, Cttn, Myl12b, Nras, Csnk2a1, Myl12a, Kras, Csnk2a2, Prkcb, Hras, Actn4, Ppp2r1a, Plec, Hipk1, Limd1, Nr1h4, Rhoc, Srf, Myo1c, Prkaca, Fkrp, F2rl1, Rac1, Ephb2, Sirpa, Apoe, Ppfia3, Nbea, Rhod, Cx3cr1, Dlgap4, Camk1, Mmp14, Rtn4, Slc1a1, Map2k1, Arf6, Ptprd, Plxna2, Eef2k, Arf1, Itsn1, C1qa, Sh3gl2, Itgb4, Itga3, Rhou, Nf1, Itga6, Cast, Daam1, Map4k4, Als2, Wasl, Ankrd28, Rap1a, Agrn, Chd4, Cap1, Kif5b, Grn, L1cam, Rcc2, Dock4, Fyn, Rab11a, Gabarap, Traf6, Sacm1l, Selenop, Mapk6, Capn10, Capns1, Capn1, Capn2, Araf, Pik3r2, Capn5, Map2k3, Rac2, Lmo7, Nlk, Sfn, Tbc1d20, Pde4d, Ppp1r12a, Klf5, Arid4a, Hif1a, Fasn, Arntl, Cdk6, Spint2, Gsk3a, Nr5a2, C1galt1, Lgals3, Pla2g2d, Cd55, Itch, Il7r, Cd33, Igf1, Cd4, Reg3b, Foxo3, Myo10, Ccl28, Tnip1, Tnfrsf21, Socs6, Syk, Smarca4, Smarcb1, Brd2, Rela, Cited2, Smarce1, Smarcc1, Stk10, Adam9, Stxbp3, Adam19, Sox4, St3gal4, Efnb1, Lrp6, H2-DMb1, Dennd6a, Rab10, Eps8l2, Capzb, Asap1, Esyt2, Shtn1, Efhd2, Arhgap1, Ykt6, Pfkp, Mre11a, Puf60, Eif2s3x, Ehd1, Chmp2b, Snd1, Snx5, Chmp5, Eps15l1, Chmp4b, Lrp12, Snx9, P2rx4, Ccnd2, Pdgfa, Birc2, Arhgap5, Diaph1, Xiap, Pls1, Edn3, Cdc42ep2, Eps8, Dnm2, Hexa, Kalrn, Ablim1, Nbeal2, Xk, B4galt6, Sgk1, Triobp, Evl, Pitpna, Thoc2, Clec1b, Tnfrsf12a, Golga4, Vps54, Cdc42se2, Stk4, Auts2, Rab21, Smurf1, Bap1, C1galt1c1, Cux1, Usp9x, Cdc42ep5, Ulk1, Arl13b, Ush1c, Vdr, Rb1, Kdm1a, Psen1, Lpar1, Pak1, Afg3l2, Dbnl, Trio, Nptn, Dapk3, Fgd3, Abi1, Top2b, Spast, Pafah1b1, Ryk, Erbin, Arpc2, Zfhx3, Atxn3, Ccr1, Stab1, Dock5, Vamp3, Dab2, Adgre1, Pml, Smarcd1, Ddah1, Oma1, C3ar1, S100a1, Tnfsf12, Hmox1, Stat3, Lgr4, Pkn1, Cybb, Bmpr1a, Hgs, Slc12a2, Hnf4a, Foxp1, Krt20, Krt7, Krt19, Esrp1, Slc44a4, Reg3g, Tst, Irf6, Sult2b1, Tpp1, Slc9a2

</details>

---

## Cell cycle / Proliferation (Both regions)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 25 | 2 |
| Cell types | 3 (Fibroblasts, Plasmablasts, Stem cells) | 1 (Plasmablasts) |
| Shared pathways | 0 | 0 |

### Leading-edge gene overlap

- **Duodenum genes:** 537
- **Ileum genes:** 40
- **Shared genes:** 1 (0.2% of union)
- **Duodenum-only genes:** 536
- **Ileum-only genes:** 39

### Key signaling genes in leading-edge

| Gene family | Duodenum | Ileum |
|-------------|----------|-------|
| effectors | Cdk1, Cdk6, Cdk4, Top2a, E2f8, Mcm5, Mcm2, Ccne2, Cdc6, Cdk2, Aurka, Ccne1, Mcm3, Birc5, Mki67, Cdc20 | — |

### Curated ligand-receptor genes

- **Duodenum L-R genes (67):** Ang, Angpt1, Apoa1, Apoe, Areg, B2m, Btc, Ccl11, Col8a1, Ecm1, Ereg, Fgf7, Fn1, Gpc3, Has2, Hgf, Igf1, Lamc1, Mdk, Mif
- **Ileum L-R genes (0):** none

### Biological interpretation

The Cell cycle / Proliferation module shows **near-complete regional divergence** in leading-edge genes (only 0.2% overlap). Duodenum and Ileum activate largely distinct gene sets within this module.
Shared cell types (Plasmablasts) drive the module in both regions, but with different pathways/genes.
Duodenum-exclusive cell types: Fibroblasts, Stem cells.

<details><summary>Duodenum-only leading-edge genes (536)</summary>

Ereg, Igf1, Col3a1, Sfrp1, Fn1, Myc, Bax, Cdkn1a, Cd74, Gstp1, Egfr, Il13, Sphk1, Pdgfd, Mif, Anapc11, Nsmce2, Epgn, Smpd3, Anapc7, Ubb, Uba52, Psma3, Psma7, Ubc, Tubb4a, Rps27a, Psmb3, Tuba4a, Hsp90ab1, Psmb6, Tubb6, Tuba1c, Adrm1, Psmb5, Psmb1, Tuba1a, Psma4, Psmd8, Psmd7, Trp53, Psmb2, Psma1, Cdk1, Fkbpl, Psma5, Psmb7, Psmd2, Psmd3, Psma6, Psmd1, Psmd11, Fbxl7, Cdc27, Ube2s, Ube2e1, Mad2l1, Anapc2, Cdc23, Mcm10, H3f3a, Kpna6, Orc6, Cdt1, H3f3b, Pole2, Cdc7, Kpnb1, Orc5, Pole3, Kpna1, Ccl11, Ccl2, Il6, Sparc, Cebpb, Hmox1, Nme2, Aldh1a2, Osr1, Areg, Tgfbr1, Hgf, B2m, Mdk, Tgfbr3, Col8a1, Zfp36, Zfp36l1, Fgf7, Has2, Ecm1, Ccl5, Dab2, Cd34, Apoa1, Thbs1, Nme1, Ern1, Serpinb1a, Mydgf, Ptn, Gata3, Nr4a3, Akt3, Pparg, Cyba, Map2k1, Yap1, Cdc42, Apoe, Angpt1, Runx3, Prdm1, Gata6, Tnfaip3, Calca, Nfib, Psen1, Gpc3, Notch1, Pik3cb, Lamc1, Ednrb, Prkca, Ang, Vdr, Kit, Cdk6, Rps6ka1, Bcl11b, Agtr1a, Ngfr, Il17rb, Hmgb2, Sgpp2, Ncstn, Tgm1, Zfp385a, Mdm2, Cdc25a, Adamts1, Rhoa, Plcb1, Npm1, Eif4g1, Wnk1, Pkn2, Tmod3, Dynlrb1, Dynll1, Dtl, Cdk4, Plk4, Pkp3, Rcc2, Btc, Dync1i2, Rad51b, Gipc1, Ddr2, Rab11a, Phip, Dynlt1b, Cul4a, Cdc73, Ndc80, Prkce, Cul3, Chmp3, Tfdp1, Hnrnpu, Pbx1, Kif23, Rdx, Ier3, Calm1, Clasp2, Cacnb4, Itgb1, E2f3, Eif4ebp1, Smarcc2, Nfia, Gpr132, Rpl24, Phf10, Klf4, Taok1, Psme2, Taf10, Prpf4b, Tpd52l1, Cul2, Eps8, Cul5, Spc24, Bcl7c, Gspt1, Zfp36l2, Rhou, Zwilch, Acvr1b, Appl1, Zfp655, Atr, Tacc3, Bcat1, Psme1, Dusp1, Brd7, Ercc3, Rad17, Sde2, Uimc1, Ube2a, Dnm2, Ambra1, Psmg2, Cdc34, Tmsb4x, Ptprc, Fem1b, Atf5, Stk38, Clock, Rfc5, Rad51, Mdc1, Cdk5, Eme2, Fbxo4, Nipbl, Smc3, Hdac8, Smc5, Atrx, Esco2, Pds5a, Mau2, Rb1, Stag2, Tnks, Pds5b, Bod1, Smc1a, Esco1, Dck, Ilf3, Rrm2, Nup153, Top2a, Mre11a, Usp1, Pms2, Smc4, Smc6, Nop56, Prdx4, Ncapd2, Cenpe, Nudt21, Ezh2, Atad2, Mthfd2, Mcm7, Cdkn1b, Lmnb1, Slbp, Ctcf, E2f8, Cbx5, Dek, Mcm5, Ctps, Ranbp1, Prim2, Tmpo, Cdc25b, Mcm2, Pold3, Pnn, Pa2g4, Brca1, Psip1, Hells, Nup205, Asf1a, Srsf1, Ipo7, Rbbp7, Dut, Ube2b, Pten, Msh6, Atm, Knl1, Ncapd3, Fzr1, Fancm, Ing2, Fanca, Ncaph, Fbxo5, Top2b, Kif18a, Orc4, Ccne2, Foxj2, Ncaph2, Wapl, Taf1, Smarca5, Ncapg, Baz1b, Akap8l, Top3a, Tubgcp4, Anapc16, Sun2, Insr, Utp14a, Ythdc2, Ubr2, Numa1, Tubgcp2, Anapc5, Cenpc1, Clspn, Topbp1, Psmc4, Babam2, Trp53bp1, Sfn, Ywhaz, Rhno1, Rnf8, Babam1, Orc3, Cdc6, Ccna2, Dbf4, Nsd2, Brcc3, Smg1, Terf2ip, Hnrnpa1, Ino80d, Actr5, Xrn1, Tcp1, Hnrnpc, Cct5, Sirt1, Smarcb1, Ruvbl1, Apc, Ube2c, Arid1b, Arid1a, Nsmce1, Hnrnpa2b1, Parp1, Ep300, Dkc1, Usp7, Smarcd2, Actr8, Riok2, Cct6a, Acd, Smarca4, Ruvbl2, Pot1a, Anapc15, Arid2, Cdk2, Parn, Tpr, Dcp2, Ddx11, Stn1, Ripor2, Eml4, Prc1, Cenpa, Kif11, Kif15, Drg1, Mis12, Cep192, Clasp1, Uhrf1, Ppp1cc, Prkcb, Ccnd3, Jak2, Akt2, Nup35, Rps27, Plk3, Cep57, Ckap5, Lin9, Sumo1, Ankrd28, Dyrk1a, Ccnh, Itgb3bp, Prim1, Ppp1cb, Bora, Ppp6c, Ppp2r5d, Akap9, Cnep1r1, Gar1, Pom121, Pafah1b1, Ube2i, Haus2, Phlda1, Cep63, Set, Csnk2a1, Csnk2b, Sec13, Vrk2, Ppme1, Nup160, Tubb4b, Lemd3, Nde1, Lpin2, Pcm1, Rsf1, Tnpo1, Cdk7, Cenpp, Cenpw, Nek9, Lpin1, Optn, Cc2d1b, Nup210, Cep135, Nup93, Polr2d, Emd, Rab2a, Ahctf1, Rrm1, Cxcr5, Med1, Mta3, Lef1, Ect2, Ddx3x, Exoc7, Brd4, Ufl1, Setd2, Birc6, Rpl23, Bid, Pum1, Wac, Calm3, H2-Q7, Ptpn6, Mybbp1a, Zfp830, Triap1, Dot1l, Dlg1, Usp28, Ints7, Naa38, Dctpp1, Cit, Lyar, Ran, Cdca3, Nolc1, Phf5a, Spag5, Cks1b, Pold2, H2az1, Cks2, Rfc3, Aurka, Tipin, Cdca8, Rpa1, Asf1b, Nasp, Bard1, Ccne1, Cdkn2c, Psmc3ip, Tra2b, Eed, Ak2, Lig1, Mcm3, Tk1, Cdkn3, Gins3, Tcf19, Exosc8, Spc25, Nup107, Diaph3, Ung, Xpo1, Srsf2, Birc5, Mki67, H2ax, Tbrg4, Jpt1, Bub1b, Rpa3, Pttg1, Cdc20, Kif22, Rad1, Hmmr, Ddx39a, Orc2, Kpna2, Racgap1, Cnot9, Ube2t, Hus1

</details>

<details><summary>Ileum-only leading-edge genes (39)</summary>

Tyrobp, Lgals3, Csf1r, P2rx7, Gpnmb, Vcam1, Cadm1, Slc11a1, Fcgr4, Trem2, Ifi204, Tcirg1, Cd300a, Lipa, Cd4, Lgals9, Csf2ra, Cd81, Il7r, Card11, Pirb, Sdc4, Pla2g2d, Bst2, Gba, Vav3, Tnfrsf1b, Csf2rb2, Psmb10, Havcr2, Irf1, H2-DMb1, Cd180, Pcyt1a, Ebi3, Cd28, Fcgr2b, Cd1d1, Ticam1

</details>

---

## Chemokine signaling (Both regions)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 16 | 4 |
| Cell types | 2 (Endothelial, Fibroblasts) | 1 (Macrophages) |
| Shared pathways | 0 | 0 |

### Leading-edge gene overlap

- **Duodenum genes:** 169
- **Ileum genes:** 87
- **Shared genes:** 9 (3.6% of union)
- **Duodenum-only genes:** 160
- **Ileum-only genes:** 78

### Key signaling genes in leading-edge

| Gene family | Duodenum | Ileum |
|-------------|----------|-------|
| ligands | Ccl2, Cxcl10, Cxcl13, Cxcl2, Cxcl1, Ccl5 | Ccl7, Ccl3, Ccl9, Cxcl1, Ccl6, Cxcl16, Cxcl2, Ccl12, Cxcl10, Ccl4 |
| receptors | Ccr7, Ccr5, Ccr1 | Cx3cr1, Cxcr4, Cxcr3 |

### Curated ligand-receptor genes

- **Duodenum L-R genes (78):** B2m, Cd14, Cxcl10, Cxcl13, Efnb2, Pf4, Spon2, Angpt1, Bsg, C3, Calr, Ccl11, Cxcl5, Ecm1, Fbln1, Fgf7, Fn1, Has2, Hgf, Hspa8
- **Ileum L-R genes (0):** none

### Biological interpretation

The Chemokine signaling module shows **near-complete regional divergence** in leading-edge genes (only 3.6% overlap). Duodenum and Ileum activate largely distinct gene sets within this module.
Both regions express Chemokine signaling **ligands** (Duo: Ccl2, Cxcl10, Cxcl13, Cxcl2, Cxcl1, Ccl5; Ile: Ccl7, Ccl3, Ccl9, Cxcl1, Ccl6, Cxcl16, Cxcl2, Ccl12, Cxcl10, Ccl4), but through different ligand repertoires.
Duodenum-exclusive cell types: Endothelial, Fibroblasts.
Ileum-exclusive cell types: Macrophages.

<details><summary>Duodenum-only leading-edge genes (160)</summary>

Ccl2, Ccr7, Slit3, Lyn, Ccr5, Cxcl13, Wnk1, Jak2, Ccl11, Dusp1, Edn1, Slit2, Slc12a2, Ccr1, C3, Stat3, Ccl17, Cebpb, Il6, Nfkb1, Gbp2, Nfkbia, Tnfaip3, Trib1, Mmp9, Vim, Cd14, Efnb2, B2m, Bcr, Pde4b, Hspa5, Irak2, Hmgb1, Tspo, Zfp36, Hmgcs2, Prdx2, Ptpn11, Bcl10, Spon2, Irf5, Mrc1, Tnfrsf1b, Paf1, Notch1, Rock1, Rap1b, Braf, Nras, Grk5, Cxcl5, Rhoa, Ccl5, Lox, Ackr3, Ackr1, Ackr4, Ripor2, Dock8, Tnfaip6, Ppib, Dpep1, Mdk, Bsg, Rarres2, Cd74, Ppia, Thbs1, Grem1, Calr, Ptn, Serpine1, Mif, Lgmn, Plcb1, Cd81, Pycard, Ecm1, Mia3, Pdgfd, P4hb, Emilin1, Itga9, Gbf1, Dock2, Gnb1, Gng5, Gng12, Akt3, Map2k1, Kras, Cdc42, Itk, Igf1, Col1a1, Sparc, Hmox1, Plpp3, Adamts1, S100a11, Fn1, Tgfbr1, Pfn1, Tmsb4x, Hgf, Ntn1, Tgfbr3, Pecam1, Fgf7, Cfl1, Il1r1, Rack1, Clasp2, Ctsh, Has2, Sdcbp, Dab2, Tac1, Dock4, Twist2, Bdkrb1, Pdpn, Dock5, Spag9, Ptprc, Sphk1, Fzd4, Rnf7, Gata3, Nr4a3, Hspa8, Rras, Rras2, Angpt1, Sema4a, Gpld1, Wnt5b, Cul5, Atp5b, Itgav, Nfe2l2, Fer, Pik3cb, Coro1a, Itgax, Prkca, Ret, Ephb2, Abl2, Fbln1, Rac2, Thy1, Kit, Tjp1, Il16, Arg2, Gstp1, Sirpa, Klf4

</details>

<details><summary>Ileum-only leading-edge genes (78)</summary>

Cx3cr1, Ccl7, C3ar1, P2ry6, Ccl3, Ccl9, Adrb2, C5ar1, P2ry12, Ccl6, P2ry13, Cxcl16, P2ry14, Ednrb, Ccl12, Hrh1, S1pr1, Ptafr, Lpar2, C5ar2, Ccl4, Cxcr4, Ptger4, Adra2b, App, Tbxa2r, Ffar1, Cmklr1, Cxcr3, Mc1r, Fpr1, Gpr183, Ccl27a, Adgre1, Vipr1, Gnb3, Adm, Cd55, Gna12, Itsn1, Pdpk1, Vav2, Itga5, Akap13, Hbegf, Daglb, Calm2, Abr, Vav1, Plekhg5, Arrb2, Pik3r6, Pde4c, Arhgef12, Adcy3, Pde4d, Gnaq, Gnai2, Plekhg2, Adcy9, Fgd4, Pik3r3, Dgkb, Adcy7, Abhd12, Prkch, Prkce, Dgkh, Itpr2, Pik3cg, Gpr84, Arhgef17, Arhgef18, Arhgef6, Prkacb, Fgd2, Rock2, Grb2

</details>

---

## TGFβ signaling (Both regions)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 14 | 2 |
| Cell types | 2 (Endothelial, Fibroblasts) | 1 (Bottom-villus EC) |
| Shared pathways | 0 | 0 |

### Leading-edge gene overlap

- **Duodenum genes:** 268
- **Ileum genes:** 160
- **Shared genes:** 15 (3.6% of union)
- **Duodenum-only genes:** 253
- **Ileum-only genes:** 145

### Key signaling genes in leading-edge

| Gene family | Duodenum | Ileum |
|-------------|----------|-------|
| ligands | Tgfb1, Tgfb2, Tgfb3 | Tgfb1 |
| receptors | Tgfbr1, Tgfbr3, Bmpr1b, Tgfbr2 | Bmpr1a |
| effectors | Smad1 | — |

### Curated ligand-receptor genes

- **Duodenum L-R genes (100):** C3, Ccl11, Cxcl10, Efna5, Efnb2, Ereg, Icam1, Jag1, Lama5, Lamb2, Psap, Slit2, Tgfb1, Tgfb2, Vegfa, Angpt1, Apoa1, Col1a2, Col6a1, Cxcl13
- **Ileum L-R genes (0):** none

### Biological interpretation

The TGFβ signaling module shows **near-complete regional divergence** in leading-edge genes (only 3.6% overlap). Duodenum and Ileum activate largely distinct gene sets within this module.
Both regions express TGFβ signaling **ligands** (Duo: Tgfb1, Tgfb2, Tgfb3; Ile: Tgfb1), but through different ligand repertoires.
Duodenum-exclusive cell types: Endothelial, Fibroblasts.
Ileum-exclusive cell types: Bottom-villus EC.

<details><summary>Duodenum-only leading-edge genes (253)</summary>

Acta2, Cebpb, Ereg, Cd24a, Cdkn1a, Basp1, Foxf1, Kdm6b, Mmp9, S1pr3, Vim, Icam1, Maff, Flna, Ipo7, Cldn5, Pecam1, Cd63, Jag1, Iqgap1, Fzd4, Bcr, Rock1, Il31ra, Rap1b, Zfp36, Rdx, Tnfrsf1a, Xdh, Fstl1, Vegfa, Id3, Zfp703, Wwtr1, S1pr1, Edn1, Sav1, Plod3, Hsd17b4, Psap, Tgfb2, Fzd1, Mafg, Ctsb, Fem1b, Notch1, Zfp36l1, Efna5, Prkch, Lcp1, Rad51b, C3, Adamtsl2, Mmrn2, Gja1, Epha4, Plxna2, Mmp12, Efnb2, Fgf1, Cxcl10, Sfrp1, Jak2, Pkd1, Itgb1, Ccl11, Mib1, Clasp2, Bcl10, Socs3, Slit2, Rbbp6, Bmi1, Eda, Lama5, Cd44, Sdc4, Map1b, Pip5k1a, Rhob, Arhgap35, Yap1, Heyl, Plaat3, Slc4a7, Tbx3, Ednrb, Stard13, Lipa, Adm, Kdr, Itgb5, Atp6ap2, Lamb2, Hs2st1, Gnas, Vegfc, Fbn1, Ubb, Ltbp1, Tgfbr1, Tgfbr3, Ltbp4, Uba52, Pmepa1, Ubc, Rps27a, Tgfb3, Ube2m, Itgav, Ltbp3, Ppp1cc, Nedd8, Ppp1cb, Col3a1, Lum, Thbs1, Il13ra2, Il13, Gata6, Tyrobp, Tmem219, Fn1, Wnt11, Fbln1, Col1a2, Junb, Myc, Rhoa, Ybx1, Cdk8, Serpine1, Ncor1, Igf1, Aldh1a3, Hhip, Hsd11b1, Adamts2, Aldh1a2, Fgf7, Thrb, Ctsh, Hmgcs2, Lama1, Wnt2b, Rspo2, Anxa2, Lox, Pdpn, Rpl13a, Col6a1, Kras, Cebpa, Zfpm2, Ap3b1, Ywhaz, Ctsz, Rbpj, Ccn2, Smpd3, Nfib, Hs6st1, Gpc3, Cxcl13, Ccl2, Col1a1, Tnfaip6, Has1, Grem1, Vcam1, Fos, Bmpr1b, Fgf14, Tnxb, Egr1, Ntrk2, Hspa5, Hgf, Atf3, Ddx5, Rack1, Ptpn1, Sorl1, Htra1, Has2, Sdcbp, Gstp1, Gclm, Ccl5, Dab2, Tac1, Apoa1, Egfr, Ramp2, Fgf12, Nedd4, Ern1, Cyfip2, Sphk1, Nfia, Gata3, Pparg, Mt3, Baiap2, Bdnf, Eef2, Spint1, Pin1, Hsp90ab1, Pdgfd, Angpt1, Cav3, Runx3, Rbbp7, Lgmn, Itga5, Angpt2, Cyfip1, Gfra1, Calca, Emilin1, Hfe, Stat5b, Tbc1d7, Fer, Pik3cb, Nfkb1, Jak1, Adamts10, Mapk9, Sparc, Tgfbr2, Ywhag, Drap1, Tcf12, Acvr1b, Fkbp1a, Ncstn, Gipc1, Smad1, Fst, E2f4, Itgb3, Mmp16, Ago3, Tfdp1, Ski, Mmp14, Tgif2, Timp2, Mapk3, Fgf2, Acvrl1

</details>

<details><summary>Ileum-only leading-edge genes (145)</summary>

Ezr, Pls1, Actb, Apoe, Edn3, Prkcz, Anxa1, Cldn4, Capzb, Flrt3, Cdc42ep2, Cd2ap, Eps8, Plec, Il7r, Ist1, Tbc1d20, Myh14, Rtn4, Cttn, Flnb, Myl12b, Dnm2, Shtn1, F11r, Ppp1r12a, Actg1, Ywhah, Hexa, Ptprd, Srf, Eef2k, Arhgef2, Ank3, Pacsin2, Coro1a, Kalrn, Ablim1, Myo10, Ctnnb1, Nbeal2, Dnmbp, Xk, B4galt6, Myh9, Src, Pdlim5, Sh3gl2, Wdr1, Sgk1, Scrib, Rhou, Tiam1, Triobp, Dlg1, Diaph1, Evl, Pitpna, Thoc2, Spint2, Clec1b, Pard6b, Map4k4, Tnfrsf12a, Als2, Golga4, Wasl, Rac1, Vps54, Cap1, Cdc42se2, Kif5b, Wasf2, Ptpn11, Vasp, Nf2, Cdh17, Stk4, Auts2, Rab21, L1cam, Smurf1, Pard3, Cdh1, Bap1, C1galt1c1, Cux1, Efnb1, Rac2, Flot1, Fyn, Ephb2, Cdc42ep5, Ulk1, Limd1, Rab10, Ush1c, Vdr, Rb1, Kdm1a, Lpar1, Pak1, Afg3l2, Dbnl, Trio, Nptn, Dapk3, Fgd3, Abi1, Top2b, Spast, Pafah1b1, Ryk, Ddah1, Dsg2, Ceacam1, Cx3cr1, Oma1, Wnk1, C3ar1, S100a1, Gpnmb, Tnfsf12, Tjp1, Pdgfa, Hmox1, Hif1a, Prkcb, Nf1, Rela, Cited2, Stat3, Hipk1, Lgr4, Stab1, Pkn1, Grn, Pak4, Cybb, Bmpr1a, Jup, Hgs, Slc12a2, Hnf4a, Foxp1

</details>

---

## TNF/NF-κB signaling (Both regions)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 8 | 5 |
| Cell types | 1 (Endothelial) | 4 (Bottom-villus EC, Macrophages, Plasmablasts, Stem cells) |
| Shared pathways | 2 | 2 |

### Leading-edge gene overlap

- **Duodenum genes:** 188
- **Ileum genes:** 211
- **Shared genes:** 59 (17.4% of union)
- **Duodenum-only genes:** 129
- **Ileum-only genes:** 152

### Key signaling genes in leading-edge

| Gene family | Duodenum | Ileum |
|-------------|----------|-------|
| ligands | — | Tnf |
| receptors | Tnfrsf1a, Tnfrsf1b | Tnfrsf1b, Tnfrsf1a |
| effectors | Nfkb1, Rel | Relb, Rela, Rel, Nfkb1, Nfkb2 |

### Curated ligand-receptor genes

- **Duodenum L-R genes (56):** Anxa1, B2m, C3, Cd14, Cd86, Col3a1, Cxcl10, Cxcl13, Efnb2, Ereg, Hsp90aa1, Hsp90b1, Hspa8, Il1b, Jag1, Lgals1, Pf4, Spon2, Tgfb1, Tgfb2
- **Ileum L-R genes (54):** App, Cxcl1, Cxcl10, Hbegf, Icam1, Igf1, Il16, Tnf, Il1b, Mmp9, Pdgfb, Psap, Vim, Adra2a, Aplp2, Cd44, Cd74, Cd82, Cd9, Celsr2

### Biological interpretation

The TNF/NF-κB signaling module shows **substantial regional divergence** (17.4% gene overlap), with each region activating a mostly distinct gene set.
Ileum expresses TNF/NF-κB signaling **ligands** (Tnf) while Duodenum expresses **receptors** (Tnfrsf1a, Tnfrsf1b), suggesting Ileum sends and Duodenum receives this signal.
Duodenum-exclusive cell types: Endothelial.
Ileum-exclusive cell types: Bottom-villus EC, Macrophages, Plasmablasts, Stem cells.

<details><summary>Duodenum-only leading-edge genes (129)</summary>

Nr4a3, Il6, Ier3, Gem, Sik1, Nr4a2, Jag1, Sphk1, Plk2, Plpp3, Pde4b, Nfe2l2, Tnfaip6, Dusp5, Dusp1, Nampt, Rhob, Vcam1, Ubb, Ngf, Ubc, Ripk1, Il1r1, Pf4, Gbp2, Lyn, Ccr5, Cd14, Efnb2, B2m, Cxcl13, Jak2, Hspa5, Irak2, Hmgb1, Tspo, Hmgcs2, Prdx2, Ptpn11, Bcl10, Spon2, Irf5, Mrc1, Paf1, mt-Co1, Mafg, Mafk, Ereg, Isg15, Cd24a, Ccr7, Hsp90aa1, Slc15a3, C3, Mmp12, Rbck1, Wnk1, Clec4n, Fgl2, Ptpn2, Rabgef1, Rps6ka3, Tgfb1, Btnl9, Clu, Ifi35, Adam8, Braf, Tfrc, Rsad2, Nlrc5, Peli1, C6, Cd81, Elf1, Prkar1a, Sppl2a, Pim1, Erap1, Clec4d, Cfh, Plekha1, Dusp3, Cyba, Trim25, Tgfb2, Sirt2, Adar, Rnf144a, Pvr, Hsp90b1, Rgcc, Prkch, Mapkapk2, Crebbp, H2-T23, H2-D1, Lgals1, Cd36, Itgam, Ywhag, Col3a1, Hspa1a, Ube2k, Spns2, Trim41, Alpk1, Plcg1, Sfpq, Gnas, Pcbp2, Traf3, Grb2, Ddx3x, Anxa1, Otulin, Mapkapk3, Map2k7, Hspa8, Irak1, Cd86, Park7, Ywhaz, Lamp2, Ufd1, Socs5, Ahr, Irak4, Cnot7

</details>

<details><summary>Ileum-only leading-edge genes (152)</summary>

Pmepa1, Sat1, Il7r, Dennd5a, Areg, Tank, Tnip1, Marcks, Rnf19b, Ehd1, Relb, F2rl1, Atp2b1, Ldlr, Abca1, Rela, Cflar, Ccnd1, Map2k3, Tnf, Il1a, Cx3cr1, Sirpa, Gas6, Egr1, P2rx7, Cd33, Ccl3, Foxp1, Lilra5, Stat3, Igf1, Il10, Nod1, Tlr4, Arrb2, Trem2, Il16, Tyrobp, Mefv, Nlrc4, App, Ffar1, Casp1, Stab1, Ccl7, Tlr2, Irf1, Adgre1, Slc11a2, Itga5, Kif1b, Scn1b, Hbegf, Axl, Hpn, P2rx4, Hrh1, Tlr1, Ptafr, Ebi3, Abi1, Ptger4, Il10ra, Rnf144b, Csf3, Adm, Cmklr1, Il15, Cd48, Cd55, Lcp2, Tnfsf9, Id2, Hes1, Pfkfb3, Bcl6, Kynu, Tnfaip8, B4galt1, Ccn1, Ccl4, Serpinb8, Ctsb, Cd63, Psap, Lgals3, Dab2, Rapgef2, Txnip, Zeb2, Mafb, Pdgfb, Ext1, Asah1, Maf, Tpp1, Nrp1, Rac1, Rap1b, Gpx1, Sh3bp1, S1pr2, Rab1a, Bad, Sod1, Plaat3, Rapgef3, Tubb5, Akt1, Zfp703, Spred1, Pls1, Prdm1, Ppp3r1, Triobp, Rhoa, Sav1, Tagln2, Rbpj, Xbp1, Tollip, Pcna, Pgk1, Bmpr2, Cdc42, Yipf6, Sgpp1, Scrib, Pelo, Ackr3, Efna1, Tgif1, Nfat5, Klf6, Litaf, Cd83, Lamb3, Pnrc1, Nfkb2, Ccl20, Ptpre, Icosl, Dram1, Snn, Btg3, Tiparp, Csf1, Nfkbie, Spsb1, Btg2, Bcl2a1a

</details>

---

## WNT signaling (Both regions)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 8 | 5 |
| Cell types | 3 (Endothelial, Fibroblasts, cDC1) | 1 (Fibroblasts) |
| Shared pathways | 0 | 0 |

### Leading-edge gene overlap

- **Duodenum genes:** 254
- **Ileum genes:** 32
- **Shared genes:** 2 (0.7% of union)
- **Duodenum-only genes:** 252
- **Ileum-only genes:** 30

### Key signaling genes in leading-edge

| Gene family | Duodenum | Ileum |
|-------------|----------|-------|
| ligands | Wnt11, Wnt5b | Wnt5a, Wnt4 |
| receptors | Fzd4, Fzd1, Fzd7 | Fzd2, Fzd1 |
| antagonists | Sfrp1 | — |
| effectors | Axin1 | — |

### Curated ligand-receptor genes

- **Duodenum L-R genes (87):** Efna5, Ereg, Icam1, Jag1, Psap, Tgfb1, Tgfb2, Vegfa, Apoa1, Bsg, C3, Col4a1, Col6a1, Col8a1, Fbn1, Fgf7, Fn1, Gpc3, Igf1, Lama1
- **Ileum L-R genes (53):** Bmp2, Bmp4, Bmp7, Fgf10, Ntrk3, Sema5a, Slitrk6, Tgfb2, Wnt4, Wnt5a, Actr2, Acvr1, Acvr1_Acvr2a, Acvr1_Acvr2b, Acvr1_Bmpr2, Acvr1_Tgfbr1_Tgfbr2, Acvr1_Tgfbr2, Acvr1b, Acvr1b_Tgfbr2, Acvr1c_Tgfbr2

### Biological interpretation

The WNT signaling module shows **near-complete regional divergence** in leading-edge genes (only 0.7% overlap). Duodenum and Ileum activate largely distinct gene sets within this module.
Both regions express WNT signaling **ligands** (Duo: Wnt11, Wnt5b; Ile: Wnt5a, Wnt4), but through different ligand repertoires.
Shared cell types (Fibroblasts) drive the module in both regions, but with different pathways/genes.
Duodenum-exclusive cell types: Endothelial, cDC1.

<details><summary>Duodenum-only leading-edge genes (252)</summary>

Acta2, Cebpb, Ereg, Cd24a, Klf4, Cdkn1a, Basp1, Foxf1, Kdm6b, Mmp9, S1pr3, Vim, Icam1, Msn, Maff, Flna, Ipo7, Btg1, Cldn5, Pecam1, Cd63, Jag1, Iqgap1, Fzd4, Bcr, Rock1, Il31ra, Rap1b, Tgfb1, Zfp36, Rdx, Tnfrsf1a, Atf4, Xdh, Id1, Fstl1, Vegfa, Id3, Zfp703, Wwtr1, S1pr1, Edn1, Sav1, Plod3, Hsd17b4, Psap, Mafg, Ctsb, Ext1, Fem1b, Notch1, Skil, Zfp36l1, Efna5, Prkch, Igf1, Aldh1a3, Col3a1, Hhip, Hsd11b1, Fbn1, Adamts2, Aldh1a2, Adamtsl2, Fgf7, Thrb, Ctsh, Hmgcs2, Lama1, Wnt2b, Rspo2, Anxa2, Lox, Pdpn, Rpl13a, Il13, Tgfb3, Col6a1, Wnt11, Map2k1, Kras, Yap1, Cdc42, Cebpa, Zfpm2, Ap3b1, Ywhaz, Ctsz, Gata6, Rbpj, Ccn2, Smpd3, Nfib, Ltbp3, Hs6st1, Gpc3, Rspo3, Sparc, Mfap5, Sfrp1, Grem1, Plpp3, Mfap2, Col5a2, Rps7, Col5a1, Fn1, Osr1, Myc, Tgfbr1, Pfn1, Hoxa4, Ntn1, Col8a1, Hoxa2, Gja1, Ugdh, Cfl1, Rack1, Itgb1, Dlc1, Ets2, Ybx1, Bax, Zbtb16, Apoa1, Wnk1, Setd2, Mmp8, Gata3, Nr4a3, Txnrd1, Hand2, Spint1, Dusp4, Atp8a2, Tmed2, Taf10, Itga5, Myo3b, Ryr2, Prkar1a, Wnt5b, Itgav, Kcnq1, Psen1, Ednra, Vangl2, Rest, Hoxb3, Ret, Ephb2, Hoxa3, Cdon, Cebpd, Adamts9, C3, Fos, Bmpr1b, Ntrk2, Bsg, Rcn1, Cyp1b1, Slc4a7, Col4a1, Pfdn5, Egfr, Nfia, Gnb1, Trip11, Rpl24, Pafah1b1, Dtnbp1, Prdm1, Ift27, Atf6, Large1, Fkrp, Thy1, Tbc1d20, Fkbp8, Kit, Pxdn, Jag2, Bcl11b, Csnk2b, Psma7, Usp34, Psmb2, Psmd7, Psmd2, Psma4, Psmb6, Psma3, Psma2, Trrap, Smarca4, Psmc3, Dpy30, Psmb5, Axin1, Psmd3, Ctbp1, Rbx1, Hdac1, Gsk3b, Psmc5, Csnk2a1, Psma1, Cdc73, Psmb4, Psmd8, Tle3, Xpo1, Psmb3, Psmd14, Adrm1, Psmc2, H3f3a, Psmd1, Bcl9l, Tnks, Uba52, Usp8, Ppp2ca, Ruvbl1, Crebbp, Csnk1a1, Tle5, Calm1, Ap2s1, Rac2, Ap2a2, Clta, Ap2b1, Daam1, Gng5, Prkca, Gnb4, Gng4, Gng10, Gngt2, Fzd7, Pard6a, Gng2, Nfatc1, Psmd6, Rps27a, Rac1, Vps29, Snx3, Vps35

</details>

<details><summary>Ileum-only leading-edge genes (30)</summary>

Kcnk2, Ntrk3, Tbx2, Wnt5a, Hes1, Sox9, Fzd2, Hoxa1, Eya1, Slitrk6, Epha4, Nrp2, Bmp4, Gli1, Nr4a2, Fgf10, Wnt4, Ncoa1, Sema5a, Bmp2, Nrp1, Ccn1, Tbx3, Bmp7, Adamts19, Id2, Robo1, Rbp4, Tnni1, Myh10

</details>

---

## Mitochondrial & oxidative metabolism (Both regions)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 2 | 10 |
| Cell types | 2 (Endothelial, Stem cells) | 1 (Endothelial) |
| Shared pathways | 1 | 1 |

### Leading-edge gene overlap

- **Duodenum genes:** 172
- **Ileum genes:** 280
- **Shared genes:** 79 (21.2% of union)
- **Duodenum-only genes:** 93
- **Ileum-only genes:** 201

### Key signaling genes in leading-edge

| Gene family | Duodenum | Ileum |
|-------------|----------|-------|
| effectors | Uqcrc1, Acat1, Atp5g1, Cox6b1, Uqcrq, Ndufb8, Ndufa8, Dlat, Mgst3, Sdhb, Cyc1, Cox6a1, Sdhc, Idh3b, Pdhb | Idh3b, Uqcrc1, Cyc1, Uqcrq, Pdhb, Ndufa8, Mgst3, Cox6b1, Ndufb8, Atp5g1, Cox6a1, Sdhc, Sdhb |

### Curated ligand-receptor genes

- **Duodenum L-R genes (9):** Apoa4, Col1a1, Ddr1, Itga1_Itgb1, Itga2_Itgb1, Itga3_Itgb1, Ldlr, Lrp1, Sdc1
- **Ileum L-R genes (0):** none

### Biological interpretation

The Mitochondrial & oxidative metabolism module shows **substantial regional divergence** (21.2% gene overlap), with each region activating a mostly distinct gene set.
Shared cell types (Endothelial) drive the module in both regions, but with different pathways/genes.
Duodenum-exclusive cell types: Stem cells.

<details><summary>Duodenum-only leading-edge genes (93)</summary>

Fabp1, Nr4a3, Il6, Klf4, Tpm1, mt-Nd5, Tnfaip3, Cyp1b1, Kdm6b, Hba-a1, Hba-a2, Fbln5, Apoa4, Sphk1, Nfe2l2, Hmox1, Prdx2, Map1lc3a, Dusp1, Edn1, Plekha1, Hbb-bt, Ripk1, Col1a1, Sesn3, Prdx5, Cd36, Top2b, Rhob, Acadvl, Etfa, Acat1, Dlat, Phb2, Ndufb2, Cycs, Slc25a4, Cox5a, Ndufb4, Gpx4, Ndufs2, Ndufv2, Cox8a, Ndufa1, Acaa2, Atp5b, Sdha, Ndufb5, Ndufa7, Uqcrfs1, Atp5d, Ndufv1, Retsat, Got2, Dlst, Mrps22, Vdac3, Ndufc1, Etfdh, Sdhd, Mrps30, Ndufb1, Cyb5r3, Vdac1, Slc25a3, Ndufs3, Acadsb, Atp5g2, Mdh2, Ndufs1, Glud1, Supv3l1, Ndufa3, Alas1, Slc25a20, Mrpl15, Decr1, Pdhx, Bax, Dld, Maob, Pdk4, Timm10, Aifm1, Acaa1a, Atp6v1c1, Timm9, Cyb5a, Mrps11, Atp5pb, Hccs, Eci1, Isca1

</details>

<details><summary>Ileum-only leading-edge genes (201)</summary>

Atp1b1, Lrpprc, Suclg1, Uqcr10, Polr2f, Abcb7, Mfn2, Cox11, Pmpca, Hadhb, Aldh6a1, Idh2, Rhot1, Idh1, Bckdha, Afg3l2, Cox7a2l, Idh3g, Nqo2, Mrpl11, Mrpl17, Mrpl47, Mrpl38, Mrpl42, Mrpl27, Mrpl24, Mrpl14, Mrpl55, Mrpl53, Mrpl30, Mrpl52, Mrpl9, Mrpl21, Mrpl2, Mrpl20, Mrpl12, Mrpl39, Mrpl36, Mrpl33, Mrpl58, Mrpl51, Mrpl43, Mrpl13, Mrpl54, Chchd3, Mrps9, Chchd10, Samm50, Timm23, Mrps10, Mrps31, Mcu, Mrps7, Phb, Mrps28, Timm10b, Mrps24, Tomm5, Pnpt1, Mrps5, Smdt1, Mrps16, Mrps14, Mrps33, Tomm7, Dap3, Timm8a1, Micu1, Tomm40, Spg7, Pdss1, Dnajc19, Timm17b, Micos10, Mrps34, Gfm1, Tufm, Mrps36, Fdps, Acot13, Msra, Me2, Bdh1, Suox, Auh, Aldh1b1, Nsun4, Ndufaf8, Hadh, Ak3, Malsu1, Glrx5, Bckdk, Bckdhb, Wars2, Suclg2, Acot11, Mcee, Naxd, Hint2, Nudt13, Sdhaf2, Gars, Fahd1, Txn2, Rnasel, Nr3c1, Acadl, Gsr, Cps1, Dguok, Ndufa10, Bcl2l1, Qars, Trnt1, Arl2bp, Coa3, Iars2, Prkaa1, Chchd7, Coq2, Chchd4, Prnp, Prkn, Prkca, Stard7, Maoa, Ak2, Hkdc1, Acsl5, Ckmt1, Slc44a1, Trim14, Tmem223, Ndufb10, Calm3, Slc25a1, Ambra1, Ndufb11, 1190007I07Rik, Cox7a1, Ikbke, Pank2, Fkbp8, Casp8, Ndufaf3, Ndufa11, Pnpla8, Cox14, Atp5md, Sqor, Prelid1, Kras, Ndufv3, Sox10, Ndufaf4, Ndufb9, Raf1, Cox20, Bcl2, Rab5if, Ndufa13, Slc25a37, Pisd, Trak1, Pink1, Atad3a, Gabbr1, Canx, Ptrh2, Nln, Atp5mpl, Parl, Dmac1, Mgst1, Slc8b1, Cyb5b, Nbr1, Ucp2, Bak1, Cyp4f14, Mgst2, Gsto1, Cmbl, Nr1h4, Sult2b1, Aldh1a1, Cndp2, Cyp51, Gsta1, Mat2b, Cyp2d22, Slc35d1, Rxra, Ncoa2, Abhd14b, Bpnt1, Cyp26b1, Comt, Gstp1, Ugp2

</details>

---

## Notch signaling (Both regions)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 9 | 3 |
| Cell types | 2 (Endothelial, Fibroblasts) | 1 (Plasmablasts) |
| Shared pathways | 1 | 1 |

### Leading-edge gene overlap

- **Duodenum genes:** 217
- **Ileum genes:** 152
- **Shared genes:** 35 (10.5% of union)
- **Duodenum-only genes:** 182
- **Ileum-only genes:** 117

### Key signaling genes in leading-edge

| Gene family | Duodenum | Ileum |
|-------------|----------|-------|
| ligands | Jag1, Jag2 | — |
| receptors | Notch1 | Notch1 |
| effectors | Rbpj | Rbpj, Hes1 |

### Curated ligand-receptor genes

- **Duodenum L-R genes (80):** C3, Ccl11, Cxcl10, Efna5, Efnb2, Ereg, Icam1, Jag1, Lama5, Lamb2, Psap, Slit2, Tgfb1, Tgfb2, Vegfa, Bsg, Col4a1, Col8a1, Fbn1, Igf1
- **Ileum L-R genes (46):** Apoe, App, Ecm1, Grn, Icam1, Il1b, Mmp9, Pdgfb, Pf4, Psap, Rtn4, S100a1, Spint1, Tnf, Vim, Adra2a, Cd44, Celsr1, Celsr2, Egfr

### Biological interpretation

The Notch signaling module shows **near-complete regional divergence** in leading-edge genes (only 10.5% overlap). Duodenum and Ileum activate largely distinct gene sets within this module.
Duodenum expresses Notch signaling **ligands** (Jag1, Jag2) while Ileum expresses **receptors** (Notch1), suggesting Duodenum sends and Ileum receives this signal.
Duodenum-exclusive cell types: Endothelial, Fibroblasts.
Ileum-exclusive cell types: Plasmablasts.

<details><summary>Duodenum-only leading-edge genes (182)</summary>

Hspb1, Nfkb1, Sqstm1, Socs3, Ets1, Thbs1, Acta2, Ereg, Cd24a, Basp1, Foxf1, Kdm6b, S1pr3, Lcp1, Rad51b, C3, Msn, Adamtsl2, Maff, Flna, Mmrn2, Ipo7, Btg1, Cldn5, Gja1, Epha4, Plxna2, Pecam1, Jag1, Efnb2, Iqgap1, Fgf1, Fzd4, Cxcl10, Sfrp1, Rock1, Jak2, Il31ra, Pkd1, Tgfb1, Rdx, Ccl11, Atf4, Xdh, Mib1, Id1, Clasp2, Fstl1, Bcl10, Vegfa, Id3, Wwtr1, S1pr1, Edn1, Plod3, Hsd17b4, Slit2, Rbbp6, Bmi1, Tgfb2, Eda, Fzd1, Lama5, Mafg, Cd44, Fem1b, Skil, Zfp36l1, Efna5, Prkch, Map1b, Pip5k1a, Arhgap35, Yap1, Heyl, Slc4a7, Arl13b, Tbx3, Ednrb, Stard13, Adm, Kdr, Itgb5, Lamb2, Hs2st1, Gnas, Vegfc, Nrg1, Hspd1, Ern1, Traf1, Pak2, Cul5, Ubb, Uba52, Psma3, Psma7, Ubc, Rps27a, Psmb3, Psmb6, Ywhaz, Adrm1, Psmb5, Psmb1, Psma4, Psmd8, Psmd7, Psmb2, Psma1, Tacc3, Psma5, Psmb7, Psmd2, Psmd3, Psma6, Psmd1, Psmd11, Mdk, Cntn1, Psen1, Jag2, Ncstn, Dner, Ybx1, Egfr, Crebbp, Igf1, Aldh1a3, Cebpd, Fbn1, Sparc, Mfap5, Adamts9, Mfap2, Col5a2, Aldh1a2, Col5a1, Osr1, Fos, Myc, Bmpr1b, Ntrk2, Ntn1, Bsg, Col8a1, Hoxa2, Rcn1, Cyp1b1, Col4a1, Bax, Lama1, Wnt2b, Pfdn5, Gnb1, Trip11, Gata3, Nr4a3, Rpl24, Pafah1b1, Hand2, Dtnbp1, Atp8a2, Myo3b, Wnt5b, Nfib, Ift27, Kcnq1, Ednra, Atf6, Large1, Vangl2, Rest, Fkrp, Ephb2, Thy1, Tbc1d20, Cdon, Fkbp8, Kit, Pxdn, Bcl11b

</details>

<details><summary>Ileum-only leading-edge genes (117)</summary>

App, Vav3, Tnf, Akt1, Lgals3, Dab2, Rapgef2, Txnip, Zeb2, Mafb, Pdgfb, Id2, Asah1, Maf, Tpp1, Nrp1, Rac1, Gpx1, Sh3bp1, S1pr2, Rab1a, Bad, Sod1, Rapgef3, Tubb5, Spred1, Pls1, Ppp3r1, Triobp, Rhoa, Tagln2, Xbp1, Tollip, B4galt1, Pcna, Pgk1, Bmpr2, Il1b, Cdc42, Hes1, Yipf6, Sgpp1, Scrib, Pelo, Pf4, Grn, Stab1, C3ar1, Ecm1, Csf1r, Cx3cr1, Lrp1, Gpnmb, Sat1, C5ar1, Hmox1, Mmp14, Itgax, Cd93, Ctsh, Spi1, Pgf, Ctsz, Marcks, Plxnd1, Sgpl1, C6, Cfl1, Asb2, Itga5, Cd36, Rtn4, Cybb, Pdgfa, Ptprj, Tgfbi, S100a1, Spint1, Nfe2l2, Bloc1s6, Naglu, Adam8, Pdgfc, Prcp, Pacsin2, Glul, Pfn1, Itgav, Ece1, Aggf1, Mapk7, Tnfrsf12a, Man2a1, Vegfb, Tsc2, Pik3cg, Ift52, Pbx1, Srebf1, Mthfr, Anxa3, Ppp1ca, Hs6st1, Gna13, Aamp, Rdh10, Spata2, Cd47, Brd2, Srpk2, Zc3h12a, Nup133, Naxe, Hipk1, Mydgf, Nus1, Ilk

</details>

---

## BMP signaling (Both regions)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 3 | 8 |
| Cell types | 2 (Endothelial, Fibroblasts) | 1 (Fibroblasts) |
| Shared pathways | 0 | 0 |

### Leading-edge gene overlap

- **Duodenum genes:** 149
- **Ileum genes:** 32
- **Shared genes:** 2 (1.1% of union)
- **Duodenum-only genes:** 147
- **Ileum-only genes:** 30

### Key signaling genes in leading-edge

| Gene family | Duodenum | Ileum |
|-------------|----------|-------|
| ligands | — | Bmp4, Bmp7, Bmp2 |
| receptors | Bmpr1b | — |
| antagonists | Sfrp1, Grem1 | — |
| effectors | Id1, Id3 | Id2 |

### Curated ligand-receptor genes

- **Duodenum L-R genes (61):** Efna5, Ereg, Icam1, Jag1, Psap, Tgfb1, Tgfb2, Vegfa, Angpt1, Apoa1, Col1a2, Cxcl13, Fbn1, Fgf14, Fgf7, Gpc3, Has2, Hgf, Slit2, Tgfb3
- **Ileum L-R genes (49):** Bmp2, Bmp4, Bmp7, Fgf10, Sema5a, Tgfb2, Wnt4, Wnt5a, Actr2, Acvr1, Acvr1_Acvr2a, Acvr1_Acvr2b, Acvr1_Bmpr2, Acvr1_Tgfbr1_Tgfbr2, Acvr1_Tgfbr2, Acvr1b, Acvr1b_Tgfbr2, Acvr1c_Tgfbr2, Acvr2a_Bmpr1a, Acvr2b_Bmpr1a

### Biological interpretation

The BMP signaling module shows **near-complete regional divergence** in leading-edge genes (only 1.1% overlap). Duodenum and Ileum activate largely distinct gene sets within this module.
Ileum expresses BMP signaling **ligands** (Bmp4, Bmp7, Bmp2) while Duodenum expresses **receptors** (Bmpr1b), suggesting Ileum sends and Duodenum receives this signal.
Shared cell types (Fibroblasts) drive the module in both regions, but with different pathways/genes.
Duodenum-exclusive cell types: Endothelial.

<details><summary>Duodenum-only leading-edge genes (147)</summary>

Acta2, Cebpb, Ereg, Cd24a, Klf4, Cdkn1a, Basp1, Foxf1, Kdm6b, Mmp9, S1pr3, Vim, Icam1, Msn, Maff, Flna, Ipo7, Btg1, Cldn5, Pecam1, Cd63, Jag1, Iqgap1, Fzd4, Bcr, Rock1, Il31ra, Rap1b, Tgfb1, Zfp36, Rdx, Tnfrsf1a, Atf4, Xdh, Id1, Fstl1, Vegfa, Id3, Zfp703, Wwtr1, S1pr1, Edn1, Sav1, Plod3, Hsd17b4, Psap, Mafg, Ctsb, Ext1, Fem1b, Notch1, Skil, Zfp36l1, Efna5, Prkch, Cxcl13, Col3a1, Ccl2, Col1a1, Hhip, Tnfaip6, Fbn1, Has1, Sfrp1, Grem1, Col1a2, Ltbp1, Slit2, Vcam1, Fos, Myc, Bmpr1b, Fgf14, Tgfbr1, Tnxb, Egr1, Ntrk2, Hspa5, Hgf, Atf3, Adamtsl2, Tgfbr3, Ltbp4, Lum, Ddx5, Fgf7, Cfl1, Rack1, Ptpn1, Sorl1, Htra1, Slc4a7, Has2, Itgb1, Sdcbp, Gstp1, Gclm, Ccl5, Pmepa1, Dab2, Tac1, Apoa1, Egfr, Thbs1, Lox, Ramp2, Usp9x, Fgf12, Nedd4, Ern1, Cyfip2, Tgfb3, Sphk1, Nfia, Gata3, Pparg, Mt3, Baiap2, Bdnf, Pak2, Eef2, Spint1, Pin1, Hsp90ab1, Pdgfd, Angpt1, Cav3, Runx3, Rbbp7, Lgmn, Gata6, Rbpj, Ccn2, Itga5, Angpt2, Smpd3, Cyfip1, Gfra1, Calca, Emilin1, Hfe, Ltbp3, Stat5b, Gpc3, Tbc1d7, Fer, Pik3cb

</details>

<details><summary>Ileum-only leading-edge genes (30)</summary>

Bmp4, Tbx2, Tbx3, Bmp7, Snai2, Snai1, Robo1, Twist1, Bmp2, Sox9, Fgf10, Wnt5a, Ar, Gdnf, Wnt4, Nrp2, Gli1, Nr4a2, Ncoa1, Hes1, Sema5a, Nrp1, Ccn1, Adamts19, Id2, Fzd2, Kcnk2, Rbp4, Tnni1, Myh10

</details>

---

## EGFR signaling (Both regions)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 9 | 1 |
| Cell types | 1 (Fibroblasts) | 1 (Bottom-villus EC) |
| Shared pathways | 1 | 1 |

### Leading-edge gene overlap

- **Duodenum genes:** 104
- **Ileum genes:** 21
- **Shared genes:** 9 (7.8% of union)
- **Duodenum-only genes:** 95
- **Ileum-only genes:** 12

### Key signaling genes in leading-edge

| Gene family | Duodenum | Ileum |
|-------------|----------|-------|
| ligands | Ereg, Areg, Btc | Areg, Ereg, Btc |
| receptors | Egfr | — |
| effectors | Kras, Map2k1 | Map2k1, Kras |

### Curated ligand-receptor genes

- **Duodenum L-R genes (6):** Areg, Btc, Ereg, Egfr_Erbb2, Erbb2_Erbb4, Erbb3
- **Ileum L-R genes (0):** none

### Biological interpretation

The EGFR signaling module shows **near-complete regional divergence** in leading-edge genes (only 7.8% overlap). Duodenum and Ileum activate largely distinct gene sets within this module.
Both regions express EGFR signaling **ligands** (Duo: Ereg, Areg, Btc; Ile: Areg, Ereg, Btc), but through different ligand repertoires.
Duodenum-exclusive cell types: Fibroblasts.
Ileum-exclusive cell types: Bottom-villus EC.

<details><summary>Duodenum-only leading-edge genes (95)</summary>

Ubb, Uba52, Ubc, Egfr, Rps27a, Epgn, Nrg1, Cul5, Cdc42, Myc, Pak3, Akt3, Camk2b, Stat5b, Pik3cb, Mapk9, Prkca, Abl2, Trp53, Foxo1, Nfkb1, Ccl2, Adamts9, Igfbp7, Adamts1, Fn1, Eprs, Ssr4, Inpp4b, Tnxb, Egr1, Pfn1, Tmsb4x, Rpl5, Rpl10a, Hdac4, Pdia6, Bsg, Lman1, Rcn1, Gja1, Fgd5, Aldoa, Calu, Cfl1, Mmp10, Rack1, Calr, Rhoa, Ssr3, Ptpn1, Htra1, Plaur, Prdx2, Ascc3, Itgb1, Prkg1, Sdcbp, Nfkbia, Fas, Rpl7, Rps6, Eif4g1, Rps11, Ern1, Rpl13a, Ackr3, Slc7a1, Cltc, Nr4a3, Atp6v0d1, Cycs, Tmod3, Rhoc, Rplp2, Rap1b, Txndc5, Adrb2, Snd1, Rpl26, Pabpc1, P4hb, Tuba1c, Rpl18a, Ccn2, Ldha, Itgav, Vav2, Atf6, Hyou1, Epb41, Pgd, Chac1, Ephb2, Tead4

</details>

<details><summary>Ileum-only leading-edge genes (12)</summary>

Nras, Src, Araf, Prkcb, Hras, Pik3r2, Pak4, Map2k7, Pik3r3, Pak1, Sos2, Pik3r5

</details>

---

## Complement signaling (Both regions)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 3 | 6 |
| Cell types | 1 (Endothelial) | 1 (Macrophages) |
| Shared pathways | 0 | 0 |

### Leading-edge gene overlap

- **Duodenum genes:** 137
- **Ileum genes:** 29
- **Shared genes:** 5 (3.1% of union)
- **Duodenum-only genes:** 132
- **Ileum-only genes:** 24

### Key signaling genes in leading-edge

| Gene family | Duodenum | Ileum |
|-------------|----------|-------|
| ligands | C3 | C4b, C1qc, C1qa, C1qb |
| receptors | C5ar1, C3ar1 | C3ar1, C5ar1, C5ar2 |
| effectors | C3, Cfh | Cfh |

### Curated ligand-receptor genes

- **Duodenum L-R genes (43):** Anxa1, B2m, C3, Cd14, Cd86, Col3a1, Cxcl13, Ereg, Hsp90aa1, Hsp90b1, Hspa8, Il1b, Lgals1, Tgfb1, Tgfb2, Acvr1_Tgfbr1_Tgfbr2, Acvr1_Tgfbr2, Acvr1b_Tgfbr2, Acvr1c_Tgfbr2, Adra2a
- **Ileum L-R genes (24):** App, Grn, Tnf, Adra2a, Aplp2, Cd74, Celsr2, Dcc, Egfr, Grm7, Lrp1, Lrp10, Lrp6, Ncstn, Notch1, Notch2, Ptprs, Rpsa, Tnfrsf1a, Tnfrsf1b

### Biological interpretation

The Complement signaling module shows **near-complete regional divergence** in leading-edge genes (only 3.1% overlap). Duodenum and Ileum activate largely distinct gene sets within this module.
Both regions express Complement signaling **ligands** (Duo: C3; Ile: C4b, C1qc, C1qa, C1qb), but through different ligand repertoires.
Duodenum-exclusive cell types: Endothelial.
Ileum-exclusive cell types: Macrophages.

<details><summary>Duodenum-only leading-edge genes (132)</summary>

Cxcl2, Ccl2, Il6, Nfkb1, Rel, Cd14, Cxcl10, Irak2, Cxcl1, Cebpb, Casp4, Mmp13, Tnfaip3, Ctsl, C3, Maff, Plaur, Lyn, Apoa4, Mmp12, Jak2, Hspa5, Clu, Plek, Dusp5, Pla2g7, Usp16, Pim1, Ctsb, Psmb9, Cd36, Itgam, Atox1, Dock10, Hspa1a, Nr4a3, Ereg, Isg15, Cd24a, Ccr7, Gbp2, Nfkbia, Hsp90aa1, Junb, Slc15a3, Sqstm1, Rbck1, B2m, Plk2, Cxcl13, Bcr, Wnk1, Clec4n, Fgl2, Ptpn2, Pde4b, Rabgef1, Nfe2l2, Birc3, Rps6ka3, Tgfb1, Hmgb1, Btnl9, Ifi35, Adam8, Braf, Tfrc, Rsad2, Nlrc5, Peli1, Ptpn11, Bcl10, Birc2, Elf1, Prkar1a, Sppl2a, Erap1, Clec4d, Plekha1, Dusp3, Cyba, Irf5, Trim25, Tgfb2, Sirt2, Adar, Tnfrsf1b, Rnf144a, Pvr, Hsp90b1, Rgcc, Nlrp3, Prkch, Mapkapk2, Crebbp, H2-T23, H2-D1, Lgals1, Il1r1, Ywhag, Col3a1, Ube2k, Spns2, Trim41, Alpk1, Lipa, Plcg1, Sfpq, Gnas, Pcbp2, Traf3, Grb2, Ddx3x, Anxa1, Otulin, Mapkapk3, Map2k7, Hspa8, Irak1, Cd86, Zc3h12a, Il1b, Smad3, Park7, Ywhaz, Lamp2, Ufd1, Socs5, Ahr, Irak4, Cnot7, Ifih1

</details>

<details><summary>Ileum-only leading-edge genes (24)</summary>

C4b, C1qc, C1qa, C1qb, Cfp, C2, C5ar2, Pros1, Tnf, Grn, Lrp1, Zeb2, Tlr4, Trem2, Ifngr1, Cdk6, Naglu, App, Cx3cr1, Gas6, Axl, Mertk, F13a1, Serpinf2

</details>

---

## Bile acid signaling (Both regions)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 1 | 5 |
| Cell types | 1 (Bottom-villus EC) | 4 (Bottom-villus EC, Endothelial, Fibroblasts, Macrophages) |
| Shared pathways | 1 | 1 |

### Leading-edge gene overlap

- **Duodenum genes:** 24
- **Ileum genes:** 26
- **Shared genes:** 4 (8.7% of union)
- **Duodenum-only genes:** 20
- **Ileum-only genes:** 22

### Key signaling genes in leading-edge

| Gene family | Duodenum | Ileum |
|-------------|----------|-------|
| receptors | — | Nr1h4 |
| effectors | — | Fabp6, Slc10a2, Slc51b, Slc51a |

### Biological interpretation

The Bile acid signaling module shows **near-complete regional divergence** in leading-edge genes (only 8.7% overlap). Duodenum and Ileum activate largely distinct gene sets within this module.
Shared cell types (Bottom-villus EC) drive the module in both regions, but with different pathways/genes.
Ileum-exclusive cell types: Endothelial, Fibroblasts, Macrophages.

<details><summary>Duodenum-only leading-edge genes (20)</summary>

Slc27a2, Ephx2, Idh1, Gstk1, Hsd17b4, Gclm, Abcd1, Hsd17b6, Phyh, Retsat, Gnpat, Pex1, Crot, Cat, Slc23a2, Apoa1, Mlycd, Pex19, Abcg8, Paox

</details>

<details><summary>Ileum-only leading-edge genes (22)</summary>

Fabp6, Slc10a2, Slc51b, Slc51a, Abcb1a, Nr1h4, Abcd3, Atp8b1, Sult2b1, Aldh9a1, Idi1, Dhcr24, Optn, Slc22a18, Rxra, Lonp2, Fads2, Ncoa1, Cyp7b1, Abcc3, Stard5, Cyp27a1

</details>

---

## Hedgehog signaling (Both regions)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 4 | 1 |
| Cell types | 3 (Fibroblasts, Macrophages, cDC1) | 2 (Bottom-villus EC, Stem cells) |
| Shared pathways | 0 | 0 |

### Leading-edge gene overlap

- **Duodenum genes:** 55
- **Ileum genes:** 17
- **Shared genes:** 0 (0% of union)
- **Duodenum-only genes:** 55
- **Ileum-only genes:** 17

### Key signaling genes in leading-edge

| Gene family | Duodenum | Ileum |
|-------------|----------|-------|
| ligands | Dhh | — |

### Curated ligand-receptor genes

- **Duodenum L-R genes (5):** P4hb, Gnas, Mttp, Adcy9, Vipr1
- **Ileum L-R genes (0):** none

### Biological interpretation

The Hedgehog signaling module shows **near-complete regional divergence** in leading-edge genes (only 0% overlap). Duodenum and Ileum activate largely distinct gene sets within this module.
Duodenum-exclusive cell types: Fibroblasts, Macrophages, cDC1.
Ileum-exclusive cell types: Bottom-villus EC, Stem cells.

<details><summary>Duodenum-only leading-edge genes (55)</summary>

Ubb, Uba52, Psma3, Psma7, Ubc, Rps27a, Psmb3, Erlec1, Psmb6, P4hb, Os9, Adrm1, Psmb5, Psmb1, Psma4, Psmd8, Psmd7, Psmb2, Vcp, Psma1, Psma5, Psmb7, Psmd2, Psmd3, Psma6, Dhh, Psmd1, Psmd11, Derl2, Psmd14, Psmc6, Psma2, Psmc3, Psmb4, Psmc4, Psmd12, Psmc5, Psmd13, Psmc2, Psmc1, Rbx1, Gas1, Gnas, Numb, Cdc73, Itch, Csnk1a1, Psmd6, Ulk3, Tuba1b, Tuba1a, Prkar1a, Ofd1, Gsk3b, Prkaca

</details>

<details><summary>Ileum-only leading-edge genes (17)</summary>

Tle3, Dpysl2, Myh9, Nf1, Cdk6, Ets2, L1cam, Pml, Celsr1, Rtn1, Adgrg1, Vldlr, Vegfa, Amot, Thy1, Ophn1, Nrp2

</details>

---

## JAK/STAT signaling (Both regions)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 2 | 2 |
| Cell types | 1 (Endothelial) | 1 (Stem cells) |
| Shared pathways | 0 | 0 |

### Leading-edge gene overlap

- **Duodenum genes:** 134
- **Ileum genes:** 78
- **Shared genes:** 3 (1.4% of union)
- **Duodenum-only genes:** 131
- **Ileum-only genes:** 75

### Key signaling genes in leading-edge

| Gene family | Duodenum | Ileum |
|-------------|----------|-------|
| ligands | Il6 | — |
| receptors | Csf2ra | Ifngr1, Csf2ra |
| effectors | Stat3 | — |

### Curated ligand-receptor genes

- **Duodenum L-R genes (43):** Anxa1, B2m, C3, Cd14, Cd86, Col3a1, Cxcl13, Ereg, Hsp90aa1, Hsp90b1, Hspa8, Il1b, Lgals1, Tgfb1, Tgfb2, Acvr1_Tgfbr1_Tgfbr2, Acvr1_Tgfbr2, Acvr1b_Tgfbr2, Acvr1c_Tgfbr2, Adra2a
- **Ileum L-R genes (0):** none

### Biological interpretation

The JAK/STAT signaling module shows **near-complete regional divergence** in leading-edge genes (only 1.4% overlap). Duodenum and Ileum activate largely distinct gene sets within this module.
Duodenum expresses JAK/STAT signaling **ligands** (Il6) while Ileum expresses **receptors** (Ifngr1, Csf2ra), suggesting Duodenum sends and Ileum receives this signal.
Duodenum-exclusive cell types: Endothelial.
Ileum-exclusive cell types: Stem cells.

<details><summary>Duodenum-only leading-edge genes (131)</summary>

Cxcl2, Cxcl1, Il6, Pf4, Cd14, Fas, Cxcl10, Cxcl13, Reg1, Ptpn2, Osmr, Stat3, Tgfb1, Hmox1, Tnfrsf12a, Tnfrsf1a, Ptpn11, Socs3, Pim1, Itga4, Tnfrsf1b, Il1r2, Ccr1, Cd36, Il1r1, Cd9, Csf2rb2, Nr4a3, Nfkb1, Isg15, Cd24a, Ccr7, Gbp2, Nfkbia, Hsp90aa1, Junb, Tnfaip3, Slc15a3, C3, Sqstm1, C5ar1, Lyn, Mmp12, Rbck1, B2m, Plk2, Bcr, Wnk1, Clec4n, Fgl2, Pde4b, Rabgef1, Nfe2l2, Birc3, Rps6ka3, Irak2, Hmgb1, Btnl9, Clu, Ifi35, Adam8, Braf, Tfrc, Rsad2, Nlrc5, Peli1, C6, Bcl10, Birc2, Cd81, Elf1, Prkar1a, Sppl2a, Erap1, Clec4d, Cfh, Plekha1, Dusp3, Cyba, Irf5, Trim25, Tgfb2, Sirt2, Adar, C3ar1, Rnf144a, Pvr, Hsp90b1, Rgcc, Nlrp3, Prkch, Mapkapk2, Crebbp, H2-T23, H2-D1, Lgals1, Itgam, Ywhag, Col3a1, Hspa1a, Ube2k, Spns2, Trim41, Alpk1, Lipa, Plcg1, Sfpq, Gnas, Pcbp2, Traf3, Grb2, Ddx3x, Anxa1, Otulin, Mapkapk3, Map2k7, Hspa8, Irak1, Cd86, Zc3h12a, Il1b, Smad3, Park7, Ywhaz, Lamp2, Ufd1, Socs5, Ahr, Irak4, Cnot7, Ifih1

</details>

<details><summary>Ileum-only leading-edge genes (75)</summary>

Abcb1a, Slc1a5, Dennd5a, Myo1e, Phlda1, Lrig1, Anxa4, Hopx, Klf6, Igf1r, Etfbkmt, Ltb, Tnfsf10, Nfkbiz, Il10, Arl4a, Ctla4, Wls, Adam19, Plscr1, Il4ra, Cd83, Sh3bgrl2, Rora, Cd79b, Pou2f1, Maff, Gabarapl1, Lclat1, Serpinb6a, Ckap4, Car2, Ikzf2, Swap70, Ifngr1, Map6, Cdc42se2, Ccnd3, Socs1, Plec, Irf6, Prnp, Ttc39b, Tspan1, Tfpi, St6gal1, Cfb, F2rl1, Klf4, Nr1h4, Ctss, Sox9, Dnmbp, Ccl20, Gng11, Id2, Itga2, Reln, Cxcr4, Trib2, Tmem176b, Trib1, Plaur, Ptprr, Ptbp2, Itgbl1, Avl9, Etv5, Evi5, Tmem158, Il2rg, Itgb2, Hbegf, Ano1, Satb1

</details>

---

## Antigen presentation (Both regions)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 1 | 1 |
| Cell types | 1 (Endothelial) | 1 (Macrophages) |
| Shared pathways | 0 | 0 |

### Leading-edge gene overlap

- **Duodenum genes:** 115
- **Ileum genes:** 13
- **Shared genes:** 1 (0.8% of union)
- **Duodenum-only genes:** 114
- **Ileum-only genes:** 12

### Key signaling genes in leading-edge

| Gene family | Duodenum | Ileum |
|-------------|----------|-------|
| receptors | B2m, H2-D1 | — |

### Curated ligand-receptor genes

- **Duodenum L-R genes (43):** Anxa1, B2m, C3, Cd14, Cd86, Col3a1, Cxcl13, Ereg, Hsp90aa1, Hsp90b1, Hspa8, Il1b, Lgals1, Tgfb1, Tgfb2, Acvr1_Tgfbr1_Tgfbr2, Acvr1_Tgfbr2, Acvr1b_Tgfbr2, Acvr1c_Tgfbr2, Adra2a
- **Ileum L-R genes (0):** none

### Biological interpretation

The Antigen presentation module shows **near-complete regional divergence** in leading-edge genes (only 0.8% overlap). Duodenum and Ileum activate largely distinct gene sets within this module.
Duodenum-exclusive cell types: Endothelial.
Ileum-exclusive cell types: Macrophages.

<details><summary>Duodenum-only leading-edge genes (114)</summary>

Nr4a3, Ereg, Il6, Nfkb1, Isg15, Cd24a, Ccr7, Gbp2, Nfkbia, Hsp90aa1, Junb, Tnfaip3, Slc15a3, C3, Sqstm1, C5ar1, Lyn, Cd14, Mmp12, Rbck1, B2m, Plk2, Cxcl13, Bcr, Wnk1, Clec4n, Fgl2, Ptpn2, Pde4b, Rabgef1, Nfe2l2, Birc3, Rps6ka3, Tgfb1, Irak2, Hmgb1, Btnl9, Clu, Ifi35, Adam8, Braf, Tfrc, Rsad2, Nlrc5, Peli1, C6, Ptpn11, Bcl10, Birc2, Cd81, Elf1, Prkar1a, Sppl2a, Pim1, Erap1, Clec4d, Cfh, Plekha1, Dusp3, Cyba, Irf5, Trim25, Tgfb2, Sirt2, Adar, C3ar1, Tnfrsf1b, Rnf144a, Pvr, Hsp90b1, Rgcc, Nlrp3, Prkch, Mapkapk2, Crebbp, H2-T23, H2-D1, Lgals1, Cd36, Itgam, Il1r1, Ywhag, Col3a1, Hspa1a, Ube2k, Spns2, Trim41, Alpk1, Lipa, Plcg1, Sfpq, Gnas, Pcbp2, Traf3, Ddx3x, Anxa1, Otulin, Mapkapk3, Map2k7, Hspa8, Irak1, Cd86, Zc3h12a, Il1b, Smad3, Park7, Ywhaz, Lamp2, Ufd1, Socs5, Ahr, Irak4, Cnot7, Ifih1

</details>

<details><summary>Ileum-only leading-edge genes (12)</summary>

Blnk, Cd22, Pik3ap1, Vav1, Cd79b, Pik3cd, Dapp1, Sh3kbp1, Itpr2, Syk, Ptpn6, Btk

</details>

---

## Apoptosis / Cell survival (Duodenum-only)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 13 | 0 |
| Cell types | 3 (Endothelial, Fibroblasts, Macrophages) | 0 () |
| Shared pathways | 0 | 0 |

### Leading-edge genes

- **Duodenum genes:** 367

### Key signaling genes in leading-edge

- **receptors:** Fas, Tnfrsf1a, Tnfrsf1b, Tnfrsf10b
- **effectors:** Mcl1, Bax, Bak1, Bcl2, Casp3, Parp1

### Biological interpretation

This module is **Duodenum-specific** — no significant pathways pass the filter in the other region. 
Key receptors in Duodenum: Fas, Tnfrsf1a, Tnfrsf1b, Tnfrsf10b.
Key effectors in Duodenum: Mcl1, Bax, Bak1, Bcl2, Casp3, Parp1.
Driven by: Endothelial, Fibroblasts, Macrophages.

---

## Xenobiotic metabolism (Duodenum-only)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 10 | 0 |
| Cell types | 2 (Bottom-villus EC, Stem cells) | 0 () |
| Shared pathways | 0 | 0 |

### Leading-edge genes

- **Duodenum genes:** 117

### Key signaling genes in leading-edge

- **effectors:** Gstm1, Adh1, Cyp3a11, Gstm2, Gsto1, Gsta1, Mgst3, Ugt1a1, Cyp2e1, Ephx1, Gstm7, Adh5, Gstt2

### Biological interpretation

This module is **Duodenum-specific** — no significant pathways pass the filter in the other region. 
Key effectors in Duodenum: Gstm1, Adh1, Cyp3a11, Gstm2, Gsto1, Gsta1, Mgst3, Ugt1a1, Cyp2e1, Ephx1, Gstm7, Adh5, Gstt2.
Driven by: Bottom-villus EC, Stem cells.

---

## Interferon signaling (Duodenum-only)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 9 | 0 |
| Cell types | 1 (Endothelial) | 0 () |
| Shared pathways | 0 | 0 |

### Leading-edge genes

- **Duodenum genes:** 198

### Key signaling genes in leading-edge

- **receptors:** Ifnar2, Ifnar1
- **effectors:** Irf9

### Biological interpretation

This module is **Duodenum-specific** — no significant pathways pass the filter in the other region. 
Key receptors in Duodenum: Ifnar2, Ifnar1.
Key effectors in Duodenum: Irf9.
Driven by: Endothelial.

---

## Retinoic acid signaling (Duodenum-only)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 8 | 0 |
| Cell types | 3 (Bottom-villus EC, Fibroblasts, Macrophages) | 0 () |
| Shared pathways | 0 | 0 |

### Leading-edge genes

- **Duodenum genes:** 208

### Key signaling genes in leading-edge

- **ligands:** Bco2, Aldh1a3, Aldh1a2
- **effectors:** Rbp1

### Biological interpretation

This module is **Duodenum-specific** — no significant pathways pass the filter in the other region. 
Key ligands in Duodenum: Bco2, Aldh1a3, Aldh1a2.
Key effectors in Duodenum: Rbp1.
Driven by: Bottom-villus EC, Fibroblasts, Macrophages.

---

## Axon guidance (Netrin / Slit / Semaphorin / Ephrin) (Duodenum-only)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 5 | 0 |
| Cell types | 2 (Endothelial, Fibroblasts) | 0 () |
| Shared pathways | 0 | 0 |

### Leading-edge genes

- **Duodenum genes:** 307

### Key signaling genes in leading-edge

- **ligands:** Efnb2, Slit2, Efna5, Ntn1, Ntn4, Sema4a
- **receptors:** Epha4, Plxna2, Ephb2
- **effectors:** Rock1, Rhoa, Cdc42, Pak2, Rac1

### Biological interpretation

This module is **Duodenum-specific** — no significant pathways pass the filter in the other region. 
Key ligands in Duodenum: Efnb2, Slit2, Efna5, Ntn1, Ntn4, Sema4a.
Key receptors in Duodenum: Epha4, Plxna2, Ephb2.
Key effectors in Duodenum: Rock1, Rhoa, Cdc42, Pak2, Rac1.
Driven by: Endothelial, Fibroblasts.

---

## VEGF signaling (Duodenum-only)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 4 | 0 |
| Cell types | 1 (Endothelial) | 0 () |
| Shared pathways | 0 | 0 |

### Leading-edge genes

- **Duodenum genes:** 120

### Key signaling genes in leading-edge

- **ligands:** Vegfa, Vegfc
- **receptors:** Flt1, Kdr

### Biological interpretation

This module is **Duodenum-specific** — no significant pathways pass the filter in the other region. 
Key ligands in Duodenum: Vegfa, Vegfc.
Key receptors in Duodenum: Flt1, Kdr.
Driven by: Endothelial.

---

## FGF signaling (Duodenum-only)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 2 | 0 |
| Cell types | 1 (Fibroblasts) | 0 () |
| Shared pathways | 0 | 0 |

### Leading-edge genes

- **Duodenum genes:** 17

### Key signaling genes in leading-edge

- **ligands:** Fgf14, Fgf7

### Biological interpretation

This module is **Duodenum-specific** — no significant pathways pass the filter in the other region. 
Key ligands in Duodenum: Fgf14, Fgf7.
Driven by: Fibroblasts.

---

## IGF signaling (Duodenum-only)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 1 | 0 |
| Cell types | 1 (Fibroblasts) | 0 () |
| Shared pathways | 0 | 0 |

### Leading-edge genes

- **Duodenum genes:** 24

### Key signaling genes in leading-edge

- **ligands:** Igf1

### Biological interpretation

This module is **Duodenum-specific** — no significant pathways pass the filter in the other region. 
Key ligands in Duodenum: Igf1.
Driven by: Fibroblasts.

---

## PDGF signaling (Ileum-only)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 0 | 6 |
| Cell types | 0 () | 1 (Plasmablasts) |
| Shared pathways | 0 | 0 |

### Leading-edge genes

- **Ileum genes:** 167

### Key signaling genes in leading-edge

- **ligands:** Pdgfb, Pdgfa, Pdgfc
- **effectors:** Akt1

### Biological interpretation

This module is **Ileum-specific** — no significant pathways pass the filter in the other region. 
Key ligands in Ileum: Pdgfb, Pdgfa, Pdgfc.
Key effectors in Ileum: Akt1.
Driven by: Plasmablasts.

---

## Antimicrobial peptides (Ileum-only)

| Metric | Duodenum | Ileum |
|--------|----------|-------|
| Pathways | 0 | 2 |
| Cell types | 0 () | 2 (Fibroblasts, Macrophages) |
| Shared pathways | 0 | 0 |

### Leading-edge genes

- **Ileum genes:** 18

### Key signaling genes in leading-edge

- **ligands:** Defa29, Defa22, Defa21, Defa30, Defa24, Defa36, Defa17, Reg3g, Defa3, Reg3b, Defa5

### Biological interpretation

This module is **Ileum-specific** — no significant pathways pass the filter in the other region. 
Key ligands in Ileum: Defa29, Defa22, Defa21, Defa30, Defa24, Defa36, Defa17, Reg3g, Defa3, Reg3b, Defa5.
Driven by: Fibroblasts, Macrophages.

---

