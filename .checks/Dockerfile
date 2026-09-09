# Exact analysis environment for Cherry-PIC.
#
# The lockfile pins 575 R packages, but package versions alone do not determine
# numerical output: the OS, compiler and BLAS/LAPACK do too. The analysis ran on
# Rocky Linux 9 with R's reference BLAS, so this image reproduces that rather than
# whatever BLAS the host happens to provide.
#
#   docker build -f .checks/Dockerfile -t cherry-pic:4.4.1 .
#   docker run --rm -v "$PWD":/work -w /work cherry-pic:4.4.1 \
#     Rscript Cherry-PIC-ST-data/final_figures/01_spatial_clusters/scripts/Fig3_VisiumHD_final.R
#
# On an HPC cluster, convert for Singularity/Apptainer:
#   singularity build cherry-pic.sif docker-daemon://cherry-pic:4.4.1
FROM rockylinux:9

# R 4.4.1 built against the reference BLAS/LAPACK, matching the analysis platform
RUN dnf -y install epel-release && dnf -y install dnf-plugins-core && \
    dnf config-manager --set-enabled crb && \
    dnf -y install R-core-4.4.1 R-core-devel-4.4.1 \
        libcurl-devel openssl-devel libxml2-devel fontconfig-devel \
        harfbuzz-devel fribidi-devel freetype-devel libpng-devel \
        libtiff-devel libjpeg-turbo-devel cairo-devel libgit2-devel \
        hdf5-devel gsl-devel geos-devel proj-devel gdal-devel \
        cmake gcc-c++ gcc-gfortran git && \
    dnf clean all

ENV RENV_CONFIG_REPOS_OVERRIDE=https://cloud.r-project.org \
    RENV_PATHS_LIBRARY=/opt/renv/library \
    OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 MKL_NUM_THREADS=1

RUN Rscript -e 'install.packages("renv", repos="https://cloud.r-project.org")'

COPY renv.lock /opt/renv.lock
RUN Rscript -e 'renv::restore(lockfile="/opt/renv.lock", library="/opt/renv/library", prompt=FALSE)'

RUN Rscript -e 'cat(R.version.string, "\n"); cat("Seurat", as.character(packageVersion("Seurat")), "\n"); print(sessionInfo()$BLAS)'
WORKDIR /work
