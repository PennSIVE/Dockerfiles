# very similar to dorainps antsr container, but uses neurodebian as base image instead
# https://github.com/ANTsX/ANTsR/issues/265#issuecomment-547964145

FROM neurodebian:buster

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    python \
    curl \
    git \
    zlib1g-dev \
    libxml2 \
    libxml2-dev \
    libssl-dev \
    libcurl4-gnutls-dev \
    libssh2-1-dev \
    libgit2-dev \
    libv8-dev \
    dirmngr \
    r-base && \
    curl -LO https://github.com/Kitware/CMake/releases/download/v3.15.5/cmake-3.15.5-Linux-x86_64.sh && \
    sh cmake-3.15.5-Linux-x86_64.sh --skip-license && \
    rm -Rf cmake* && \
    curl -LO https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py && chmod a+x fslinstaller.py && echo | ./fslinstaller.py
RUN Rscript -e "install.packages(c('devtools', 'oro.nifti', 'oro.dicom', 'fslr', 'WhiteStripe', 'matrixStats', 'R.matlab', 'abind', 'R.utils', 'RNifti', 'stapler', 'testthat', 'hexSticker', 'dplyr', 'oasis', 'fslr', 'plyr', 'misc3d', 'pixmap', 'colormap', 'gifti'))" && \
    Rscript -e "devtools::install_github('ANTsX/ANTsR')" && \
    Rscript -e "devtools::install_github('muschellij2/extrantsr', dependencies = FALSE)" && \
    Rscript -e "source('https://neuroconductor.org/neurocLite.R'); neuro_install('neurobase')"
