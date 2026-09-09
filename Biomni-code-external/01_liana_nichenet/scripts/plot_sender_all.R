suppressPackageStartupMessages({library(data.table); library(ggplot2); library(circlize)})
set.seed(42)
.here <- local({a <- commandArgs(FALSE); f <- sub("^--file=", "", a[grep("^--file=", a)])
          if (length(f)) dirname(normalizePath(f)) else getwd()})
OUT <- normalizePath(file.path(.here, "..", "outputs", "sender_summary_circles"), mustWork = FALSE)
dir.create(OUT, showWarnings=FALSE, recursive=TRUE)
counts <- fread(file.path(OUT, "sender_summary_interaction_counts.csv"))
cdf <- as.data.frame(counts)

sender_colors <- c(
  "Fibroblasts"="#E64B35","Macrophages"="#3C5488","Blood vascular endothelial cells"="#00A087",
  "cDC1"="#4DBBD5","Activated/helper-like T cells"="#DC0000","Cd8aa IEL"="#7E6148",
  "Plamsablasts"="#8C8C00","Paneth cells"="#F39B7F",
  "Stem cells"="#6A3D9A","TA / early progenitors"="#33A02C")
receiver_color <- "#333333"
get_col <- function(n) ifelse(n %in% names(sender_colors), sender_colors[n], "#AAAAAA")
short_recv <- function(r) if (r=="Stem cells") "Stem" else "TA"
short_lab <- function(n, receiver) {
  rec <- c("Blood vascular endothelial cells"="Endothelial","Activated/helper-like T cells"="Helper T",
           "TA / early progenitors"="TA/early prog.","Paneth cells"="Paneth",
           "Stem cells"="Stem")
  base <- ifelse(n %in% names(rec), rec[n], n)
  out <- base
  # self (autocrine) only possible for Stem sender now (TA sender is merged, never a receiver label match)
  out[n == receiver] <- paste0(base[n == receiver], " (self)")
  # cross-talk: merged TA/early-prog sender signaling to Stem receiver
  out[(n == "TA / early progenitors") & (receiver == "Stem cells")] <- "TA/early prog.->Stem"
  out
}

get_data <- function(region, receiver, set) {
  valcol <- if (set=="liana") "n_liana" else "n_combined"
  d <- cdf[cdf$region==region & cdf$receiver==receiver, , drop=FALSE]
  d <- d[d[[valcol]] > 0, , drop=FALSE]
  d <- d[order(-d[[valcol]]), , drop=FALSE]
  d$val <- d[[valcol]]
  d
}

# ---------- HUB-AND-SPOKE ----------
make_hub <- function(region, receiver, set) {
  d <- get_data(region, receiver, set)
  if (nrow(d)==0) return(invisible(NULL))
  d$label <- short_lab(d$sender, receiver)
  n <- nrow(d)
  angles <- seq(0, 2*pi, length.out=n+1)[1:n] - pi/2
  R <- 0.5  # spoke radius (halved from 1.0)
  d$x <- R*cos(angles); d$y <- R*sin(angles)
  maxc <- max(d$val)
  d$lx <- 0.72*cos(angles); d$ly <- 0.72*sin(angles)  # labels just outside nodes
  d$hjust <- ifelse(d$lx > 0.1, 0, ifelse(d$lx < -0.1, 1, 0.5))
  hub <- data.frame(x=0, y=0)
  setlabel <- if (set=="liana") "LIANA" else "LIANA + NicheNet"
  fname <- sprintf("%s/hubspoke_%s_%s_%s", OUT, set, tolower(region), tolower(short_recv(receiver)))

  p <- ggplot(d) +
    geom_segment(aes(x=0, y=0, xend=x, yend=y, linewidth=val, color=sender), alpha=0.55) +
    geom_point(aes(x=x, y=y, size=val, fill=sender), shape=21, color="white", stroke=1.5) +
    geom_point(data=hub, aes(x=x, y=y), size=24, fill=receiver_color, shape=21, color="white", stroke=2) +
    geom_text(data=hub, aes(x=x, y=y, label=short_recv(receiver)), color="white", fontface="bold", size=5) +
    geom_text(aes(x=x, y=y, label=val), color="white", fontface="bold", size=3.4) +
    geom_text(aes(x=lx, y=ly, label=label, hjust=hjust), size=3.7) +
    scale_linewidth(range=c(0.5,7), guide="none") +
    scale_size(range=c(7,26), guide="none") +
    scale_color_manual(values=setNames(get_col(d$sender), d$sender), guide="none") +
    scale_fill_manual(values=setNames(get_col(d$sender), d$sender), guide="none") +
    coord_equal(clip="off", xlim=c(-0.95,0.95), ylim=c(-0.85,0.85)) +
    labs(title=sprintf("%s - %s receiver: %s significant interactions", region, receiver, setlabel),
         subtitle="Node size & spoke width = # significant L-R interactions (count in node). CLU+ & mature epithelia excluded.",
         caption="(self) = autocrine;  X->Stem/TA = cross-talk from the other epithelial compartment") +
    theme_void(base_family="Liberation Sans") +
    theme(plot.title=element_text(hjust=0.5, face="bold", size=13),
          plot.subtitle=element_text(hjust=0.5, size=9),
          plot.caption=element_text(hjust=0.5, size=8, color="grey40"),
          plot.margin=margin(24,24,24,24))
  ggsave(paste0(fname,".png"), p, width=9.5, height=9.5, dpi=200, bg="white")
  ggsave(paste0(fname,".svg"), p, width=9.5, height=9.5, bg="white")
  cat("Saved hub:", basename(fname), "senders=", n, "total=", sum(d$val), "\n")
}

# ---------- CHORD (circle) ----------
make_chord <- function(region, receiver, set) {
  d <- get_data(region, receiver, set)
  if (nrow(d)==0) return(invisible(NULL))
  senders <- d$sender
  true_vals <- d$val
  mat <- matrix(sqrt(true_vals), ncol=1, dimnames=list(senders, receiver))  # sqrt thickness
  sector_display <- c(setNames(short_lab(senders, receiver), senders), setNames(short_recv(receiver), receiver))
  grid_col <- c(setNames(get_col(senders), senders), setNames(receiver_color, receiver))
  setlabel <- if (set=="liana") "LIANA" else "LIANA + NicheNet"
  fname <- sprintf("%s/sendercircle_%s_%s_%s", OUT, set, tolower(region), tolower(short_recv(receiver)))
  total <- sum(d$val)

  for (ext in c("png","svg")) {
    if (ext=="png") {
      png(paste0(fname,".png"), width=9, height=9, units="in", res=200, family="Liberation Sans")
    } else {
      svglite::svglite(paste0(fname,".svg"), width=9, height=9, fix_text_size=FALSE)
    }
    circos.clear()
    opar <- par(mar=c(1,1,6,1))  # reserve top margin for the 3-line title
    circos.par(gap.after=4, start.degree=90, canvas.xlim=c(-1.35,1.35), canvas.ylim=c(-1.35,1.35))
    chordDiagram(mat, grid.col=grid_col, annotationTrack="grid",
                 preAllocateTracks=list(track.height=0.10), transparency=0.30,
                 directional=1, direction.type=c("diffHeight","arrows"),
                 diffHeight=-0.04, h.ratio=0.5,
                 link.arr.type="big.arrow", link.arr.length=0.08, link.arr.width=0.06)
    circos.trackPlotRegion(track.index=1, panel.fun=function(x,y){
      sec <- get.cell.meta.data("sector.index")
      xlim <- get.cell.meta.data("xlim")
      disp <- sector_display[sec]
      lab <- if (sec != receiver) paste0(disp, " (", true_vals[senders==sec], ")") else disp
      circos.text(mean(xlim), get.cell.meta.data("ylim")[1]+1.15, lab,
                  facing="clockwise", niceFacing=TRUE, adj=c(0,0.5),
                  cex=if(sec==receiver) 0.9 else 0.66, font=if(sec==receiver) 2 else 1)
    }, bg.border=NA)
    title(main=sprintf("%s - %s receiver\n%s significant interactions (n=%d senders, %d total)\nRibbon width = sqrt(count); numbers show exact counts. CLU+ & mature epithelia excluded",
                       region, receiver, setlabel, nrow(mat), total), cex.main=0.85)
    circos.clear()
    par(opar)
    dev.off()
  }
  cat("Saved chord:", basename(fname), "senders=", nrow(mat), "total=", total, "\n")
}

for (region in c("Duodenum","Ileum"))
  for (receiver in c("Stem cells","TA cells"))
    for (set in c("liana","combined")) {
      make_hub(region, receiver, set)
      make_chord(region, receiver, set)
    }
cat("\nAll hub-spoke + chord plots generated.\n")
