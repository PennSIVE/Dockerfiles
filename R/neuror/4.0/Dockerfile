FROM pennsive/neurodocker:buster
ARG R_VERSION_MAJOR=4
ARG R_VERSION_MINOR=0
ARG R_VERSION_PATCH=2
ARG CONFIGURE_OPTIONS="--with-cairo --with-jpeglib --enable-R-shlib --with-blas --with-lapack"
RUN apt-get update && apt-get install -y \
            gfortran \
            git \
            g++ \
            libreadline-dev \
            libx11-dev \
            libxt-dev \
            libpng-dev \
            libjpeg-dev \
            libcairo2-dev \   
            libssl-dev \ 
            libxml2-dev \
            libudunits2-dev \
            libgdal-dev \
            libbz2-dev \
            libzstd-dev \
            liblzma-dev \
            libpcre2-dev \
            locales \
            screen \
            texinfo \
            texlive \
            texlive-fonts-extra \
            vim \
            wget \
            xvfb \
            tcl8.6-dev \
            tk8.6-dev \
            cmake \
            curl \
            unzip \
            libcurl4-gnutls-dev \
            libgsl-dev \
            libcgal-dev \
            libglu1-mesa-dev \
            libglu1-mesa-dev \
            libtiff5-dev \
            python3 \
            python3-pip \
            && pip3 install pybids pyradiomics flywheel-sdk \
            && wget https://cran.rstudio.com/src/base/R-${R_VERSION_MAJOR}/R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH}.tar.gz \
            && tar zxvf R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH}.tar.gz \
            && rm R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH}.tar.gz \
            && cd /R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH} \
            && ./configure ${CONFIGURE_OPTIONS} \ 
            && make \
            && make install \
            && Rscript -e "\
            chooseCRANmirror(graphics=FALSE, ind=57); \
            install.packages(c('devtools', 'BiocManager', 'argparser', 'reticulate', 'oro.nifti', 'oro.dicom', 'fslr', 'WhiteStripe', 'matrixStats', 'R.matlab', 'abind', 'R.utils', 'RNifti', 'stapler', 'testthat', 'hexSticker', 'dplyr', 'oasis', 'fslr', 'plyr', 'misc3d', 'pixmap', 'colormap', 'gifti', 'cifti', 'ROCR', 'freesurfer', 'freesurferformats', 'broom', 'broom.mixed', 'geepack', 'lme4', 'magrittr', 'neurobase', 'pbapply', 'purrr', 'readr', 'stringr', 'tibble', 'tidyr', 'voxel', 'forcats', 'gridExtra', 'RIA', 'Rfast', 'RJSONIO', 'pbmcapply', 'vesselr')); \
            BiocManager::install(c('rhdf5', 'rhdf5filters', 'DelayedArray', 'DelayedMatrixStats', 'HDF5Array')); \
            source('https://neuroconductor.org/neurocLite.R'); neuro_install(c('ANTsRCore', 'ANTsR', 'extrantsr', 'NiftiArray', 'rlist', 'mimosa')); \
            devtools::install_github('avalcarcel9/rtapas')"
