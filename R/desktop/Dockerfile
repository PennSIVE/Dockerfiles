# from https://github.com/ANTsX/ANTsR/issues/265#issuecomment-547964145
FROM dorianps/antsr
RUN r -e "install.packages(c('oro.nifti', 'oro.dicom', 'fslr', 'WhiteStripe', 'matrixStats', 'R.matlab', 'abind', 'R.utils', 'RNifti', 'stapler', 'testthat', 'hexSticker', 'dplyr', 'oasis', 'fslr'))"
RUN r -e "source('https://neuroconductor.org/neurocLite.R'); neuro_install('neurobase')"
RUN r -e "devtools::install_github('muschellij2/extrantsr', dependencies = FALSE)"
RUN apt-get update && apt-get install -y libxkbcommon-x11-0 xorg libx11-dev libglu1-mesa-dev libfreetype6-dev && \
    wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.2.5033-amd64.deb && \
    dpkg -i rstudio-1.2.5033-amd64.deb
RUN apt-get update && apt-get install -y libnss3 libasound2 libstdc++6 software-properties-common gcc g++ gnupg2
# RUN apt-key adv --keyserver keys.gnupg.net --recv-key '1E9377A2BA9EF27F'
RUN add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade && apt-get install -y aptitude && aptitude install -y gcc-snapshot gcc-6 g++-6
ENV LD_LIBRARY_PATH=/usr/local/lib64/:/usr/lib/x86_64-linux-gnu/
CMD rstudio