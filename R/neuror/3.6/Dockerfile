FROM pennsive/neurodebian:buster
ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    FSLDIR="/usr/share/fsl/5.0" \
    LD_LIBRARY_PATH="/usr/lib/fsl/5.0:$LD_LIBRARY_PATH" \
    FSLOUTPUTTYPE="NIFTI_GZ" \
    FSLMULTIFILEQUIT="TRUE"
RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    locales \
    apt-transport-https && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG="en_US.UTF-8" && \
    apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF' && \
    add-apt-repository 'deb http://cloud.r-project.org/bin/linux/debian buster-cran35/' && \
    apt update && \
    apt install -y r-base && \
    Rscript -e "install.packages(c('devtools', 'argparser', 'oro.nifti', 'oro.dicom', 'fslr', 'WhiteStripe', 'matrixStats', 'R.matlab', 'abind', 'R.utils', 'RNifti', 'stapler', 'testthat', 'hexSticker', 'dplyr', 'oasis', 'fslr', 'plyr', 'misc3d', 'pixmap', 'colormap', 'gifti', 'cifti', 'ROCR', 'freesurferformats', 'broom', 'broom.mixed', 'geepack', 'lme4', 'magrittr', 'neurobase', 'pbapply', 'purrr', 'readr', 'rlist', 'stringr', 'tibble', 'tidyr', 'voxel', 'forcats', 'gridExtra'))" && \
    Rscript -e "BiocManager::install(c('rhdf5', 'rhdf5filters', 'DelayedArray', 'DelayedMatrixStats', 'HDF5Array'))" && \
    Rscript -e "devtools::install_github(c('ANTsX/ANTsR'))" && \
    Rscript -e "devtools::install_github(c('muschellij2/extrantsr', 'avalcarcel9/mimosa'), dependencies = FALSE)" && \
    Rscript -e "source('https://neuroconductor.org/neurocLite.R'); neuro_install('NiftiArray')"
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT [ "docker-entrypoint.sh" ]