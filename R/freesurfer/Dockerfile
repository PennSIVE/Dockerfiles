FROM pennsive/neuror:3.6.3
ENV FREESURFER_HOME=/usr/local/freesurfer
RUN R -e "install.packages('freesurfer')" && \
    curl -O https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.0/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz && \
    apt-get update && apt-get -y install bc binutils libgomp1 perl psmisc sudo tar tcsh unzip uuid-dev vim-common libjpeg62-turbo-dev && \
    tar -C /usr/local -xzvf freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz && \
    /usr/local/freesurfer/SetUpFreeSurfer.sh
RUN for file in /usr/local/freesurfer/bin/*.bin; do ln -s $file /bin/`basename $file .bin`; done && \
    ln -s bash /bin/sh.bash && mv /bin/sh.bash /bin/sh
    # ^freesurfer weirdly tries to call a bash script with sh, so replace sh with bash