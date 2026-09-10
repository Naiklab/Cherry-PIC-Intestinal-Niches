#!/bin/bash
#BSUB -P <project_account>        # site-specific: your allocation
#BSUB -q <queue>                  # site-specific: a queue allowing 24 h
#BSUB -n 2
#BSUB -W 24:00
#BSUB -R "rusage[mem=50000]"
#BSUB -R "span[hosts=1]"
#BSUB -J "fig6_deconv_stemniche"
#BSUB -oo fig6_deconv_stemniche.bsub.out
#BSUB -eo fig6_deconv_stemniche.bsub.err

# =============================================================================
# Figure 6 — Stem Cell Niche RCTD Deconvolution, Hi-Res (FINAL)
# =============================================================================
#
# Example batch script, written for LSF. The directives above are scheduler- and
# site-specific; translate them for Slurm (#SBATCH) or whatever your cluster runs.
# The resources below are what this job needs, and are the portable part.
#
# Self-contained: reads only from ../data (frozen RCTD object + hi-res PNGs),
# writes only to ../outputs. Does not touch the working analysis notebooks.
#
# Resource Allocation:
# - 2 CPU cores
# - 50 GB RAM per core (100 GB total) -- ~1.6GB RCTD object + 4 hi-res
#   rasters (~0.75GB each) + large PDF rendering headroom
# - 24 hours walltime
#
# To submit (from this scripts/ folder): bsub < submit_Fig6_Deconvolution_StemNiche_final.sh
# To check:  bjobs -l <JOBID>
# =============================================================================

echo "========================================================================"
echo "Figure 6 — Stem Cell Niche RCTD Deconvolution, Hi-Res"
echo "========================================================================"
echo "Job ID: $LSB_JOBID"
echo "Host: $(hostname)"
echo "Start time: $(date)"
echo ""

module purge
module load R/4.4.1

export OMP_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
export MKL_NUM_THREADS=1
export BLAS_NUM_THREADS=1

echo "Working directory: $(pwd)"
echo "Running Fig6_Deconvolution_StemNiche_final.R..."
echo ""

Rscript Fig6_Deconvolution_StemNiche_final.R

EXIT_CODE=$?

echo ""
echo "========================================================================"
echo "Job completed"
echo "Exit code: $EXIT_CODE"
echo "End time: $(date)"
echo "========================================================================"

exit $EXIT_CODE
