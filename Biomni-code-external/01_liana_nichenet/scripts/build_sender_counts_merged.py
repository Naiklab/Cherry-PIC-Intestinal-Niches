import pandas as pd, os, shutil

import os
_HERE = os.path.dirname(os.path.abspath(__file__))
DATA = os.path.normpath(os.path.join(_HERE, "..", "data"))
OUTS = os.path.normpath(os.path.join(_HERE, "..", "outputs"))
L = DATA
NN = DATA
OUTDIR = f"{OUTS}/sender_summary_circles"
os.makedirs(OUTDIR, exist_ok=True)  # outputs/ is gitignored; a fresh checkout has neither directory
CSV = f"{OUTDIR}/sender_summary_interaction_counts.csv"

# Back up original (separate TA) CSV
bak = f"{OUTDIR}/sender_summary_interaction_counts_separate_ta.csv"
if os.path.exists(CSV) and not os.path.exists(bak):
    shutil.copy(CSV, bak)
    print("Backed up original ->", os.path.basename(bak))

# NicheNet active ligands per region-matched DE run
act = pd.read_csv(f"{NN}/nichenet_liana_combined_all.csv")
runmap = {("Duodenum","Stem cells"):"stem_de_duodenum", ("Ileum","Stem cells"):"stem_de_ileum",
          ("Duodenum","TA cells"):"ta_de_duodenum", ("Ileum","TA cells"):"ta_de_ileum"}
active = {k:set(act[act.run==r].query("pearson>0")["test_ligand"]) for k,r in runmap.items()}

exclude_senders = {"Mid-villus enterocytes","Upper-villus enterocytes","Bottom-Villus enterocytes",
                   "Goblet cells","Enteroendocrine cells"}
MERGE = {"TA cells","TA cells/early progenitors"}
MERGED = "TA / early progenitors"

rows = []
for region in ["Duodenum","Ileum"]:
    sig = pd.read_csv(f"{L}/liana_{region.lower()}_st_ta_sig_noclu.csv")
    sig = sig[~sig.source.isin(exclude_senders)]
    # relabel merged senders
    sig["sender_merged"] = sig["source"].replace({s: MERGED for s in MERGE})
    for recv in ["Stem cells","TA cells"]:
        sub = sig[sig.target==recv]
        act_lig = active[(region,recv)]
        subc = sub[sub["ligand.complex"].isin(act_lig)]
        senders = sorted(sub["sender_merged"].unique())
        for s in senders:
            ss = sub[sub.sender_merged==s]
            sc = subc[subc.sender_merged==s]
            n_liana = ss["lr_id"].nunique()       # union of distinct pairs
            n_comb  = sc["lr_id"].nunique()       # union of combined-supported pairs
            rows.append({"region":region,"receiver":recv,"sender":s,
                         "n_liana":int(n_liana),"n_combined":int(n_comb)})

counts = pd.DataFrame(rows)
# sanity
bad = counts[counts.n_combined > counts.n_liana]
print("Rows where combined > liana (should be 0):", len(bad))
print("Senders per combo:", counts.groupby(['region','receiver'])['sender'].nunique().to_dict())
print("Total rows:", len(counts))

counts.to_csv(CSV, index=False)
print("\nWrote", CSV)

# Show merged rows
print("\n=== Merged TA / early progenitors rows ===")
print(counts[counts.sender==MERGED].to_string(index=False))
print("\n=== Totals per region x receiver ===")
print(counts.groupby(['region','receiver'])[['n_liana','n_combined']].sum())
