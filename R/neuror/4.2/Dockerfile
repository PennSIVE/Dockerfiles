FROM pennsive/neurodocker:buster
ARG R_VERSION_MAJOR=4
ARG R_VERSION_MINOR=2
ARG R_VERSION_PATCH=1
ARG CONFIGURE_OPTIONS="--with-cairo --with-jpeglib --enable-R-shlib --with-blas --with-lapack"
RUN apt-get update && apt-get install -y \
            gfortran \
            git \
            git-annex \
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
            python3-pip
RUN pip3 install numpy scipy nibabel h5py nipype pybids drmaa flywheel-sdk datalad datalad-neuroimaging datalad-container
#RUN wget https://files.pythonhosted.org/packages/6b/ec/8c6e99cbdce4c14c5dcead81b5f118c3b090240d1728b93162cb79324b04/SimpleITK-2.2.0-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl 
RUN wget https://cran.rstudio.com/src/base/R-${R_VERSION_MAJOR}/R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH}.tar.gz \
            && tar zxvf R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH}.tar.gz \
            && rm R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH}.tar.gz \
            && cd /R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH} \
            && ./configure ${CONFIGURE_OPTIONS} \ 
            && make \
            && make install
RUN echo 'options(repos = c(CRAN = "https://cran.rstudio.com/"), download.file.method = "libcurl")' >> /usr/local/lib/R/etc/Rprofile.site \
            && Rscript -e "\
            install.packages(c('devtools', 'BiocManager', 'argparser', 'reticulate', 'rlist', 'oro.nifti', 'oro.dicom', 'fslr', 'WhiteStripe', 'matrixStats', 'R.matlab', 'abind', 'R.utils', 'RNifti', 'stapler', 'testthat', 'hexSticker', 'dplyr', 'oasis', 'fslr', 'plyr', 'misc3d', 'pixmap', 'colormap', 'gifti', 'cifti', 'ROCR', 'freesurfer', 'freesurferformats', 'broom', 'broom.mixed', 'geepack', 'lme4', 'magrittr', 'neurobase', 'pbapply', 'purrr', 'readr', 'stringr', 'tibble', 'tidyr', 'voxel', 'forcats', 'gridExtra', 'RIA', 'Rfast', 'RJSONIO', 'pbmcapply', 'vesselr', 'tidyverse', 'caret', 'DMwR', 'openxlsx', 'acPCA', 'randomForest', 'RSpectra', 'doRNG', 'doParallel', 'doMC', 'doRedis', 'future.apply', 'badgecreatr'), repos='http://cran.rstudio.com'); \
            BiocManager::install(c('rhdf5', 'rhdf5filters', 'DelayedArray', 'DelayedMatrixStats', 'HDF5Array'));"

# Install latest version of cmake for ITKR (ANTsR dependency)
 RUN version=3.24 \
             && build=1 \
             && mkdir ~/temp \
             && cd ~/temp \
             && wget https://cmake.org/files/v$version/cmake-$version.$build.tar.gz \
             && tar -xzvf cmake-$version.$build.tar.gz \
             && cd cmake-$version.$build/ \
             && ./bootstrap \
             && make -j$(nproc) \
             && sudo make install \
             && alias cmake=$(which cmake) 
# RUN Rscript -e "remotes::install_github(c('ANTsX/ANTsRCore@v0.7.4.9', 'ANTsX/ANTsR@v0.5.7.4'))"
RUN git clone https://github.com/stnava/ITKR.git && R CMD INSTALL ITKR
RUN git clone https://github.com/ANTsX/ANTsRCore.git && R CMD INSTALL ANTsRCore
RUN git clone https://github.com/ANTsX/ANTsR.git && R CMD INSTALL ANTsR

RUN Rscript -e "remotes::install_github('muschellij2/oasis', upgrade=TRUE)"

# Install packages from source
RUN git clone https://github.com/muschellij2/extrantsr.git && Rscript -e "install.packages('./extrantsr', repos = NULL, type='source')" && rm -rf extrantsr \
            && git clone https://github.com/muschellij2/NiftiArray.git && Rscript -e "install.packages('./NiftiArray', repos = NULL, type='source')" && rm -rf NiftiArray \
            && git clone https://github.com/avalcarcel9/mimosa.git && Rscript -e "install.packages('./mimosa', repos = NULL, type='source')" && rm -rf mimosa \
            && git clone https://github.com/muschellij2/malf.templates.git && Rscript -e "install.packages('./malf.templates', repos = NULL, type='source')" && rm -rf malf.templates 
RUN Rscript -e "install.packages(c('ggExtra', 'neuroim'))" \
            &&  git clone https://github.com/avalcarcel9/rtapas.git && Rscript -e "install.packages('./rtapas', repos = NULL, type='source')" && rm -rf rtapas
# todo: figure out why installing lesiontools from github doesn't work
RUN git clone https://github.com/jdwor/lesiontools.git && Rscript -e "install.packages('./lesiontools', repos = NULL, type='source')" && rm -rf lesiontools
# todo: not sure whether to include this PCA library in main image
RUN git clone https://github.com/linzx06/AC-PCA.git && mv AC-PCA/R_package/acPCA_1.2.tar.gz . && R CMD INSTALL acPCA_1.2.tar.gz
#Rscript -e "chooseCRANmirror(graphics=FALSE, ind=60); install.packages('./AC-PCA/R_package/acPCA', repos = NULL, type='source')" && rm -rf AC-PCA && \
RUN git clone https://github.com/PennSIVE/freesurfer.git && cd freesurfer && git checkout mri_vol2surf && Rscript -e "install.packages('.', repos = NULL, type='source')" && cd .. && rm -rf freesurfer && \
ln -s bash /bin/sh.bash && mv /bin/sh.bash /bin/sh

# ANTsRNet
RUN Rscript -e "remotes::install_github('ANTsX/ANTsRNet', upgrade=TRUE)"

# kirby21 templates
RUN Rscript -e "install.packages(c('kirby21.base','kirby21.t1', 'kirby21.fmri'))" \
            -e "remotes::install_github('muschellij2/kirby21.flair')" 

# MNI template
RUN Rscript -e "remotes::install_github('Jfortin1/MNITemplate')"

# AnalyzeFMRI | Sublime
COPY AnalyzeFMRI_1.1-24.tar.gz .

RUN wget https://cran.r-project.org/src/contrib/fastICA_1.2-3.tar.gz && R CMD INSTALL fastICA_1.2-3.tar.gz \
    && wget https://cran.r-project.org/src/contrib/R.matlab_3.7.0.tar.gz && R CMD INSTALL R.matlab_3.7.0.tar.gz \
    && R CMD INSTALL AnalyzeFMRI_1.1-24.tar.gz \
    && Rscript -e "remotes::install_github('emsweene/SuBLIME_package', upgrade=TRUE)"


