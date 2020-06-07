FROM pennsive/neurodebian:buster

RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    apt-transport-https && \
    apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF' && \
    add-apt-repository 'deb http://cloud.r-project.org/bin/linux/debian buster-cran35/' && \
    apt update && \
    apt install -y r-base
RUN Rscript -e "install.packages(c('devtools', 'oro.nifti', 'oro.dicom', 'fslr', 'WhiteStripe', 'matrixStats', 'R.matlab', 'abind', 'R.utils', 'RNifti', 'stapler', 'testthat', 'hexSticker', 'dplyr', 'oasis', 'fslr', 'plyr', 'misc3d', 'pixmap', 'colormap', 'gifti', 'cifti', 'ROCR', 'freesurferformats'))" && \
    Rscript -e "devtools::install_github('ANTsX/ANTsR')" && \
    Rscript -e "devtools::install_github('muschellij2/extrantsr', dependencies = FALSE)" && \
    Rscript -e "source('https://neuroconductor.org/neurocLite.R'); neuro_install('neurobase')"
