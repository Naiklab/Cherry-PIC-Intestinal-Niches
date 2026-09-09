# Exact analysis environment for Cherry-PIC.
#
#   docker build --platform=linux/amd64 -f .checks/Dockerfile -t cherry-pic:4.4.1 .
#   docker run --rm --platform=linux/amd64 -v "$PWD":/work -w /work cherry-pic:4.4.1 \
#     Rscript -e 'sessionInfo()'
#
# HPC:
#   singularity build cherry-pic.sif docker-daemon://cherry-pic:4.4.1
#
# Package versions alone do not fix numerical output. The BLAS does, because it sets
# floating-point summation order, and PCA, UMAP and clustering all depend on it. The
# analysis ran on x86_64 Linux against R's REFERENCE BLAS/LAPACK — not OpenBLAS.
# rocker/r-ver ships OpenBLAS as the default alternative, so this image switches it
# back and asserts the result rather than assuming it.
FROM --platform=linux/amd64 rocker/r-ver:4.4.1

RUN apt-get update && apt-get install -y --no-install-recommends \
      libcurl4-openssl-dev libssl-dev libxml2-dev libgit2-dev \
      libfontconfig1-dev libharfbuzz-dev libfribidi-dev \
      libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev libcairo2-dev \
      libhdf5-dev libgsl-dev libglpk-dev \
      libgdal-dev libgeos-dev libproj-dev libudunits2-dev \
      libblas3 liblapack3 cmake git patch && \
    rm -rf /var/lib/apt/lists/*

# Select reference BLAS/LAPACK over the OpenBLAS default.
RUN A=x86_64-linux-gnu && \
    update-alternatives --set libblas.so.3-$A   /usr/lib/$A/blas/libblas.so.3 && \
    update-alternatives --set liblapack.so.3-$A /usr/lib/$A/lapack/liblapack.so.3

# The analysis ran single-threaded; thread count changes reduction order in parallel BLAS.
ENV OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 MKL_NUM_THREADS=1 \
    RENV_PATHS_LIBRARY=/opt/renv/library \
    RENV_CONFIG_REPOS_OVERRIDE=https://cloud.r-project.org

RUN Rscript -e 'install.packages("renv", repos="https://cloud.r-project.org")'

# Layered separately so edits to analysis code do not invalidate this cache.
COPY renv.lock /opt/renv.lock
RUN Rscript -e 'renv::restore(lockfile="/opt/renv.lock", library="/opt/renv/library", prompt=FALSE)'

# Fail the build if the environment is not the one the analysis used. Version checks
# alone are not enough: an image can carry the right Seurat and the wrong BLAS.
RUN Rscript -e '\
  .libPaths("/opt/renv/library"); si <- sessionInfo(); \
  cat("R      :", as.character(getRversion()), "\n"); \
  cat("platform:", R.version$platform, "\n"); \
  cat("BLAS   :", si$BLAS, "\n"); \
  cat("LAPACK :", si$LAPACK, "\n"); \
  cat("La_ver :", La_version(), "\n"); \
  for (p in c("Seurat","SeuratObject","harmony","Matrix")) \
    cat(sprintf("%-13s %s\n", p, as.character(packageVersion(p)))); \
  stopifnot(getRversion() == "4.4.1"); \
  stopifnot(grepl("x86_64", R.version$platform)); \
  stopifnot(!grepl("openblas", si$BLAS, ignore.case = TRUE)); \
  stopifnot(packageVersion("Seurat") == "5.5.0"); \
  cat("\nenvironment verified\n")'

ENV R_LIBS_USER=/opt/renv/library
WORKDIR /work
