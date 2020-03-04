# from https://github.com/ANTsX/ANTsR/issues/265#issuecomment-547964145
FROM dorianps/antsr
RUN r -e "install.packages(c('oro.nifti', 'oro.dicom', 'fslr', 'WhiteStripe', 'matrixStats', 'R.matlab', 'abind', 'R.utils', 'RNifti', 'stapler', 'testthat', 'hexSticker', 'dplyr', 'oasis', 'fslr'))"
RUN r -e "source('https://neuroconductor.org/neurocLite.R'); neuro_install('neurobase')"
RUN r -e "devtools::install_github('muschellij2/extrantsr', dependencies = FALSE)"