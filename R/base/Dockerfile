# very similar to dorainps antsr container, but uses neurodebian as base image instead
# https://github.com/ANTsX/ANTsR/issues/265#issuecomment-547964145

FROM neurodebian:buster

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
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
    software-properties-common \
    apt-transport-https && \
    apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF' && \
    add-apt-repository 'deb http://cloud.r-project.org/bin/linux/debian buster-cran35/' && \
    apt update && \
    apt install -y r-base && \
    curl -LO https://github.com/Kitware/CMake/releases/download/v3.15.5/cmake-3.15.5-Linux-x86_64.sh && \
    sh cmake-3.15.5-Linux-x86_64.sh --skip-license && \
    rm -Rf cmake* && \
    Rscript -e "install.packages('devtools')" && \
    Rscript -e "install.packages(c('misc3d', 'pixmap', 'colormap'))" && \
    Rscript -e "devtools::install_github('ANTsX/ANTsR')"

RUN Rscript -e "install.packages(c('oro.nifti', 'oro.dicom', 'fslr', 'WhiteStripe', 'matrixStats', 'R.matlab', 'abind', 'R.utils', 'RNifti', 'stapler', 'testthat', 'hexSticker', 'dplyr', 'oasis', 'fslr', 'plyr'))"
RUN Rscript -e "source('https://neuroconductor.org/neurocLite.R'); neuro_install('neurobase')"
RUN Rscript -e "devtools::install_github('muschellij2/extrantsr', dependencies = FALSE)"
RUN apt-get update && apt-get install -y python && curl -LO https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py && chmod a+x fslinstaller.py && echo "" | ./fslinstaller.py