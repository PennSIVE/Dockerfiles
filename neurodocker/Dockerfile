FROM debian:buster

RUN apt-get update && apt-get install -y multiarch-support

ENV ANTSPATH="/opt/ants-2.3.1/" \
    PATH="/opt/ants-2.3.1:$PATH"

RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends \
        ca-certificates \
        curl \
        unzip \
        bc \
        binutils \
        dc \
        ed \
        file \
        gdebi-core \
        git \
        imagemagick \
        libc6 \
        libfontconfig1 \
        libfreetype6 \
        libgl1-mesa-dev \
        libgl1-mesa-dri \
        libglu1-mesa-dev \
        libgomp1 \
        libice6 \
        libjpeg62 \
        libopenblas-base \
        libsm6 \
        libstdc++6 \
        libxcursor1 \
        libxext6 \
        libxft2 \
        libx11-6 \
        libxinerama1 \
        libxmu6 \
        libxrandr2 \
        libxrender1 \
        libxt6 \
        nano \
        octave \
        perl \
        python3 \
        sudo \
        tcsh \
        wget \
        zlib1g-dev \
        pigz \
        cmake \
        g++ \
        gcc \
    && rm -rf /var/lib/apt/lists/*
RUN echo "Downloading ANTs ..." \
    && mkdir -p /opt/ants-2.3.1 \
    && curl -fsSL https://dl.dropbox.com/s/1xfhydsf4t4qoxg/ants-Linux-centos6_x86_64-v2.3.1.tar.gz \
    | tar -xz -C /opt/ants-2.3.1 --strip-components 1 
RUN echo "Downloading FSL ..." \
    && mkdir -p /opt/fsl-6.0.5 \
    && curl -fL https://fsl.fmrib.ox.ac.uk/fsldownloads/fsl-6.0.5-centos7_64.tar.gz \
    | tar -xz -C /opt/fsl-6.0.5 --strip-components 1 
RUN echo "Downloading MINC, BEASTLIB, and MODELS..." \
    && cd / \
    && curl https://packages.bic.mni.mcgill.ca/minc-toolkit/Debian/minc-toolkit-1.9.15-20170529-Ubuntu_16.04-x86_64.deb -o minc.deb && ar p minc.deb data.tar.gz | tar zx && rm minc.deb \
    && ln -s /opt/minc/1.9.15 /opt/minc-1.9.15 \
    && git clone https://github.com/CAIsr/volgenmodel-nipype.git /opt/minc-1.9.15/volgenmodel-nipype/ \
    && curl -fL http://packages.bic.mni.mcgill.ca/tgz/beast-library-1.1.tar.gz \
    | tar -xz -C /opt/minc-1.9.15/share \
    && curl -fL -o /tmp/mni_90a.zip http://www.bic.mni.mcgill.ca/~vfonov/icbm/2009/mni_icbm152_nlin_sym_09a_minc2.zip \
    && unzip /tmp/mni_90a.zip -d /opt/minc-1.9.15/share/icbm152_model_09a \
    && curl -fL -o /tmp/mni_90c.zip http://www.bic.mni.mcgill.ca/~vfonov/icbm/2009/mni_icbm152_nlin_sym_09c_minc2.zip \
    && unzip /tmp/mni_90c.zip -d /opt/minc-1.9.15/share/icbm152_model_09c \
    && rm -rf /tmp/mni* 
RUN echo "Downloading FreeSurfer ..." \
    && mkdir -p /opt/freesurfer-7.3.2 \
    && curl -fL https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/7.3.2/freesurfer-linux-centos7_x86_64-7.3.2.tar.gz \
    | tar -xz -C /opt/freesurfer-7.3.2 --owner root --group root --no-same-owner --strip-components 1 \
        --exclude='average/mult-comp-cor' \
        --exclude='lib/cuda' \
        --exclude='lib/qt' \
        --exclude='subjects/V1_average' \
        --exclude='subjects/bert' \
        --exclude='subjects/cvs_avg35' \
        --exclude='subjects/cvs_avg35_inMNI152' \
        --exclude='subjects/fsaverage3' \
        --exclude='subjects/fsaverage4' \
        --exclude='subjects/fsaverage5' \
        --exclude='subjects/fsaverage6' \
        --exclude='subjects/fsaverage_sym' \
        --exclude='trctrain'
RUN echo "Downloading Convert3D ..." \
    && mkdir -p /opt/convert3d-1.0.0 \
    && curl -fsSL https://sourceforge.net/projects/c3d/files/c3d/1.0.0/c3d-1.0.0-Linux-x86_64.tar.gz/download \
    | tar -xz -C /opt/convert3d-1.0.0 --strip-components 1 

RUN echo "Downloading dcm2niix ..." \
    && git clone https://github.com/rordenlab/dcm2niix /tmp/dcm2niix \
    && mkdir /tmp/dcm2niix/build \
    && cd /tmp/dcm2niix/build \
    && apt-get update -qq \
    && apt-get install -y -q --no-install-recommends \
           cmake \
           build-essential \
    && cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/dcm2niix-latest .. \
    && make -j1 \
    && make install \
    && rm -rf /tmp/dcm2niix
    
#RUN echo "Downloading dcm2niix ..." \
#    && git clone https://github.com/rordenlab/dcm2niix /tmp/dcm2niix \
#    && mkdir /tmp/dcm2niix/build \
#    && cd /tmp/dcm2niix/build \
#    && cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/dcm2niix-latest .. \
#    && make -j1 \
#    && make install \
#    && rm -rf /tmp/dcm2niix

ENV FSLDIR="/opt/fsl-6.0.5" \
    PATH="/opt/fsl-6.0.5/bin:$PATH" \
    FSLOUTPUTTYPE="NIFTI_GZ" \
    FSLMULTIFILEQUIT="TRUE" \
    FSLTCLSH="/opt/fsl-6.0.5/bin/fsltclsh" \
    FSLWISH="/opt/fsl-6.0.5/bin/fslwish" \
    FSLLOCKDIR="" \
    FSLMACHINELIST="" \
    FSLREMOTECALL="" \
    FSLGECUDAQ="cuda.q"

ENV MINC_TOOLKIT="/opt/minc-1.9.15" \
    MINC_TOOLKIT_VERSION="/opt/minc-1.9.15" \
    PATH="/opt/minc-1.9.15/bin:/opt/minc-1.9.15/volgenmodel-nipype/extra-scripts:/opt/minc-1.9.15/pipeline:$PATH" \
    PERL5LIB="/opt/minc-1.9.15/perl:/opt/minc-1.9.15/pipeline:${PERL5LIB}" \
    LD_LIBRARY_PATH="/opt/minc-1.9.15/lib:/opt/minc-1.9.15/lib/InsightToolkit:${LD_LIBRARY_PATH}" \
    MNI_DATAPATH="/opt/minc-1.9.15/share" \
    MINC_FORCE_V2="1" \
    MINC_COMPRESS="4" \
    VOLUME_CACHE_THRESHOLD="-1" \
    MANPATH="/opt/minc-1.9.15/man:${MANPATH}"

ENV OS="Linux" \
    PATH="/opt/freesurfer-7.3.2/bin:/opt/freesurfer-7.3.2/fsfast/bin:/opt/freesurfer-7.3.2/tktools:/opt/freesurfer-7.3.2/mni/bin:$PATH" \
    FREESURFER_HOME="/opt/freesurfer-7.3.2" \
    FREESURFER="/opt/freesurfer-7.3.2" \
    SUBJECTS_DIR="/opt/freesurfer-7.3.2/subjects" \
    LOCAL_DIR="/opt/freesurfer-7.3.2/local" \
    FSFAST_HOME="/opt/freesurfer-7.3.2/fsfast" \
    FMRI_ANALYSIS_DIR="/opt/freesurfer-7.3.2/fsfast" \
    FUNCTIONALS_DIR="/opt/freesurfer-7.3.2/sessions" \
    FS_OVERRIDE="0" \
    FIX_VERTEX_AREA="" \
    FSF_OUTPUT_FORMAT="nii.gz# mni env requirements" \
    MINC_BIN_DIR="/opt/freesurfer-7.3.2/mni/bin" \
    MINC_LIB_DIR="/opt/freesurfer-7.3.2/mni/lib" \
    MNI_DIR="/opt/freesurfer-7.3.2/mni" \
    MNI_DATAPATH="/opt/freesurfer-7.3.2/mni/data" \
    MNI_PERL5LIB="/opt/freesurfer-7.3.2/mni/share/perl5" \
    PERL5LIB="/opt/freesurfer-7.3.2/mni/share/perl5"

ENV C3DPATH="/opt/convert3d-1.0.0" \
    PATH="/opt/convert3d-1.0.0/bin:$PATH"

ENV PATH="/opt/dcm2niix-latest/bin:$PATH"

CMD ["bash"]
