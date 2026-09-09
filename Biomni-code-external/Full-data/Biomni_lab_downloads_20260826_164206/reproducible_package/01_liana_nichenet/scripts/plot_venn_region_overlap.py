import pandas as pd, numpy as np, os
import matplotlib
matplotlib.use("Agg")
matplotlib.rcParams['font.family'] = ['Liberation Sans', 'Arimo', 'DejaVu Sans']
matplotlib.rcParams['svg.fonttype'] = 'none'
import matplotlib.pyplot as plt
from matplotlib_venn import venn2, venn2_circles

RES = "/mnt/results"
OUT = os.path.join(RES, "figures", "venn_region_overlap")
os.makedirs(OUT, exist_ok=True)

# ---- Load data ----
EXCLUDE_SENDERS = {'Bottom-Villus enterocytes','Mid-villus enterocytes','Upper-villus enterocytes',
                   'Goblet cells','Enteroendocrine cells'}
sig_raw = {r: pd.read_csv(f"{RES}/liana/liana_{r}_st_ta_sig_noclu.csv") for r in ["duodenum","ileum"]}
# Exclude mature epithelia as senders (CLU+ already excluded in _noclu file)
sig = {r: df[~df['source'].isin(EXCLUDE_SENDERS)] for r, df in sig_raw.items()}
act = pd.read_csv(f"{RES}/nichenet/v2/nichenet_liana_combined_all.csv")
runmap = {("Duodenum","Stem cells"):"stem_de_duodenum", ("Ileum","Stem cells"):"stem_de_ileum",
          ("Duodenum","TA cells"):"ta_de_duodenum", ("Ileum","TA cells"):"ta_de_ileum"}
regmap = {"duodenum":"Duodenum","ileum":"Ileum"}
active = {k:set(act[act.run==r].query("pearson>0")["test_ligand"]) for k,r in runmap.items()}

def lr_set(region, receiver, evidence):
    """Return set of lr_ids for a given region/receiver/evidence.
    For 'liana': all LIANA-sig pairs for that receiver.
    For 'combined': LIANA-sig pairs that also have NicheNet activity (pearson > 0).
    Region-uniqueness is computed at the LIANA level (sig in one region but not the other)
    and 'combined' is a strict subset of 'liana' region-unique pairs with NN support."""
    df = sig[region]; df = df[df.target==receiver]
    if evidence == "combined":
        df = df[df["ligand.complex"].isin(active[(regmap[region],receiver)])]
    return set(df["lr_id"])

def region_unique_sets(recv, evidence):
    """Compute (duo_set, ile_set) where region-uniqueness is defined at the LIANA level.
    For 'liana': duo = sig_duo, ile = sig_ile (standard set difference for Venn).
    For 'combined': duo = (sig_duo - sig_ile) & nn_duo, ile = (sig_ile - sig_duo) & nn_ile,
                    shared = (sig_duo & sig_ile) & nn_duo & nn_ile.
    This ensures combined is a strict subset of liana region-unique."""
    liana_d = lr_set("duodenum", recv, "liana")
    liana_i = lr_set("ileum", recv, "liana")
    if evidence == "liana":
        return liana_d, liana_i
    elif evidence == "combined":
        nn_d = lr_set("duodenum", recv, "combined")  # LIANA-sig AND NN-active in Duo
        nn_i = lr_set("ileum", recv, "combined")      # LIANA-sig AND NN-active in Ile
        # Region-unique at LIANA level, then filter to NN-supported
        duo_only = (liana_d - liana_i) & nn_d
        ile_only = (liana_i - liana_d) & nn_i
        shared = (liana_d & liana_i) & nn_d & nn_i
        duo_set = duo_only | shared
        ile_set = ile_only | shared
        return duo_set, ile_set

# ---- Compute overlaps ----
receivers = ["Stem cells","TA cells"]
evidences = ["liana","combined"]
rows = []
SETS = {}
for recv in receivers:
    for ev in evidences:
        d, i = region_unique_sets(recv, ev)
        SETS[(recv,ev)] = (d,i)
        shared = d & i
        rows += [
            {"receiver":recv,"evidence":ev,"region":"Duodenum","n_total":len(d),"shared":len(shared),"region_unique":len(d-i)},
            {"receiver":recv,"evidence":ev,"region":"Ileum","n_total":len(i),"shared":len(shared),"region_unique":len(i-d)},
        ]
        print(f"{recv:11s} {ev:9s} Duo={len(d):3d} Ileum={len(i):3d} Shared={len(shared):3d} DuoOnly={len(d-i):3d} IleumOnly={len(i-d):3d}")

counts = pd.DataFrame(rows)
counts.to_csv(os.path.join(OUT,"venn_region_overlap_counts.csv"), index=False)

# ---- Plotting ----
DUO_COL, ILE_COL = "#E69F00", "#0072B2"   # colorblind-friendly orange / blue
ev_label = {"liana":"LIANA", "combined":"LIANA + NicheNet"}

def draw_venn(ax, recv, ev):
    d,i = SETS[(recv,ev)]
    # Equal-size circles: pass subset sizes as (1,1,overlap_fraction) so both
    # circles have identical area; only the overlap region is meaningful.
    # We then relabel each zone with the TRUE counts.
    shared = len(d & i); duo_only = len(d - i); ile_only = len(i - d)
    # equal areas -> use equal nominal set sizes; overlap fraction = shared / max
    maxn = max(len(d), len(i))
    # nominal equal sets of size `maxn`; overlap scaled so geometry matches shared proportion of the larger set
    ov = shared / maxn  # fraction of each equal circle that overlaps
    v = venn2(subsets=(1, 1, ov), set_labels=("Duodenum","Ileum"), ax=ax,
              set_colors=(DUO_COL, ILE_COL), alpha=0.55)
    venn2_circles([1,1,ov], ax=ax, linewidth=1.0, color="grey")
    # relabel zones with true counts
    for tid, val in (("10",duo_only),("11",shared),("01",ile_only)):
        lbl = v.get_label_by_id(tid)
        if lbl: lbl.set_text(str(val))
    # style subset labels
    for tid in ("10","11","01"):
        lbl = v.get_label_by_id(tid)
        if lbl: lbl.set_fontsize(13); lbl.set_fontweight("bold")
    # Reposition set labels to sit clearly beside their own circle (top-left / top-right)
    for lbl, (lx, ly) in zip(v.set_labels, [(-0.62, 0.62), (0.62, 0.62)]):
        if lbl:
            lbl.set_fontsize(12); lbl.set_fontweight("bold")
            lbl.set_position((lx, ly)); lbl.set_ha("center"); lbl.set_va("center")
    ax.set_title(f"{recv} receiver - {ev_label[ev]}", fontsize=12, fontweight="bold", pad=8)

# Individual figures
for recv in receivers:
    for ev in evidences:
        fig, ax = plt.subplots(figsize=(5.5,5))
        draw_venn(ax, recv, ev)
        base = f"venn_{ev}_{'stem' if recv=='Stem cells' else 'ta'}"
        fig.savefig(os.path.join(OUT, base+".png"), dpi=200, bbox_inches="tight", facecolor="white")
        fig.savefig(os.path.join(OUT, base+".svg"), bbox_inches="tight", facecolor="white")
        plt.close(fig)
        print("saved", base)

# 2x2 panel: rows=receiver, cols=evidence
fig, axes = plt.subplots(2, 2, figsize=(11,10))
for r,recv in enumerate(receivers):
    for c,ev in enumerate(evidences):
        draw_venn(axes[r,c], recv, ev)
fig.suptitle("Shared vs region-unique L-R interactions (Duodenum vs Ileum)\nCLU+ & mature epithelia excluded",
             fontsize=14, fontweight="bold", y=0.995)
fig.tight_layout(rect=[0,0,1,0.96])
fig.savefig(os.path.join(OUT,"venn_region_overlap_panel.png"), dpi=200, bbox_inches="tight", facecolor="white")
fig.savefig(os.path.join(OUT,"venn_region_overlap_panel.svg"), bbox_inches="tight", facecolor="white")
plt.close(fig)
print("saved panel")
print("\nCounts CSV written.")
