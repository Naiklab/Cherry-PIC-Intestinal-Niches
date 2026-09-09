# Exact analysis environment for Cherry-PIC.
#
#   docker build -f .checks/Dockerfile -t cherry-pic:4.4.1 .
#   docker run --rm -v "$PWD":/work -w /work cherry-pic:4.4.1 Rscript -e 'sessionInfo()'
#
# For an HPC cluster:
#   singularity build cherry-pic.sif docker-daemon://cherry-pic:4.4.1
#
# Why a container at all: package versions do not by themselves determine numerical
# output. The BLAS does, because it fixes floating-point summation order, and PCA,
# UMAP and clustering all depend on it. The analysis ran against R's reference
# BLAS/LAPACK (LAPACK 3.12.0). rocker/r-ver pins R itself to 4.4.1 and links the
# reference BLAS, which is what this reproduces; the build prints the linked BLAS at
# the end so it can be checked rather than assumed.
FROM rocker/r-ver:4.4.1

# System libraries the analysis packages compile against. hdf5 for Seurat's H5 I/O,
# gdal/geos/proj for sf, the font stack for svglite and ragg.
RUN apt-get update && apt-get install -y --no-install-recommends \
      libcurl4-openssl-dev libssl-dev libxml2-dev libgit2-dev \
      libfontconfig1-dev libharfbuzz-dev libfribidi-dev \
      libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev libcairo2-dev \
      libhdf5-dev libgsl-dev libglpk-dev \
      libgdal-dev libgeos-dev libproj-dev libudunits2-dev \
      cmake git patch && \
    rm -rf /var/lib/apt/lists/*

# One BLAS thread: the analysis ran single-threaded on the cluster, and thread count
# changes reduction order in parallel BLAS.
ENV OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 MKL_NUM_THREADS=1 \
    RENV_PATHS_LIBRARY=/opt/renv/library \
    RENV_CONFIG_REPOS_OVERRIDE=https://cloud.r-project.org

RUN Rscript -e 'install.packages("renv", repos="https://cloud.r-project.org")'

# Restore the 575-package closure. Layered separately so edits to the analysis code
# do not invalidate this cache.
COPY renv.lock /opt/renv.lock
RUN Rscript -e 'renv::restore(lockfile="/opt/renv.lock", library="/opt/renv/library", prompt=FALSE)'

# Fail the build if the environment is not what the analysis used.
RUN Rscript -e '\
  .libPaths("/opt/renv/library"); \
  stopifnot(getRversion() == "4.4.1"); \
  for (p in c("Seurat","SeuratObject","harmony","Matrix")) \
    cat(sprintf("%-14s %s\n", p, as.character(packageVersion(p)))); \
  stopifnot(packageVersion("Seurat") == "5.5.0"); \
  cat("BLAS: ", sessionInfo()$BLAS, "\n"); \
  cat("LAPACK:", sessionInfo()$LAPACK, "\n"); \
  cat("environment verified\n")'

ENV R_LIBS_USER=/opt/renv/library
WORKDIR /work
